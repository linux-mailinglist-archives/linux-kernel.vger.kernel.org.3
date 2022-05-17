Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0832B529AD9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbiEQHcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiEQHcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:32:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00416186DC
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:32:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D55460B49
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:32:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A38C34100;
        Tue, 17 May 2022 07:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652772762;
        bh=oYBMRWypwUlY+I18dy7jJamOgc3MRE83oGpSjY67/Pc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1hSa10/16k78Z+PxemJ+EjyDgvmoRwDlDW7/zPt2BNrO5KGxfEWRgBwcjiwgq+GEr
         +tQWvIplSMKfCT7nRBmH3SqDHhbePoNkxzeYjAwVRuv+Y1bFlwmCIoH6HrIT04+EO+
         gLsqKEcEFkYZT/kQxMeLPSd2r22i4Jx6h7A6K6Zc=
Date:   Tue, 17 May 2022 09:32:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Guixin Liu <kanie@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uio: Replace mutex info_lock with percpu_ref
Message-ID: <YoNPlgoUIzduNXih@kroah.com>
References: <1652161831-77791-1-git-send-email-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652161831-77791-1-git-send-email-kanie@linux.alibaba.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 01:50:31PM +0800, Guixin Liu wrote:
> If the underlying driver works in parallel, the mutex info_lock in uio 
> will force driver to work sequentially, so that become performance 
> bottleneck. Lets replace it with percpu_ref for better performance. 
> 
> Use tcm_loop and tcmu(backstore is file, and I did some work to make tcmu
> work in parallel at uio_write() path) to evaluate performance,
> fio job: fio -filename=/dev/sdb  -direct=1 -size=2G -name=1 -thread
> -runtime=60 -time_based  -rw=randread -numjobs=16 -iodepth=16 -bs=128k
> 
> Without this patch:
> 	READ: bw=2828MiB/s (2965MB/s), 176MiB/s-177MiB/s (185MB/s-186MB/s), 
> io=166GiB (178GB), run=60000-60001msec
> 
> With this patch:
> 	READ: bw=3382MiB/s (3546MB/s), 211MiB/s-212MiB/s (221MB/s-222MB/s), 
> io=198GiB (213GB), run=60001-60001msec
> 
> Reviewed-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

Why is UIO being used for a block device?  Why not use a real block
driver instead that can properly handle the locking issues involved
here?



> ---
>  drivers/uio/uio.c          | 95 ++++++++++++++++++++++++++++++++++------------
>  include/linux/uio_driver.h |  5 ++-
>  2 files changed, 75 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
> index 43afbb7..72c16ba 100644
> --- a/drivers/uio/uio.c
> +++ b/drivers/uio/uio.c
> @@ -24,6 +24,8 @@
>  #include <linux/kobject.h>
>  #include <linux/cdev.h>
>  #include <linux/uio_driver.h>
> +#include <linux/completion.h>
> +#include <linux/percpu-refcount.h>
>  
>  #define UIO_MAX_DEVICES		(1U << MINORBITS)
>  
> @@ -218,7 +220,9 @@ static ssize_t name_show(struct device *dev,
>  	struct uio_device *idev = dev_get_drvdata(dev);
>  	int ret;
>  
> -	mutex_lock(&idev->info_lock);
> +	if (!percpu_ref_tryget_live(&idev->info_ref))
> +		return -EINVAL;
> +

You are now just putting the contention to a per-cpu lock, so any
single-cpu load will have the same issue, right?  And your example above
is a single-cpu load, so how is this any faster?  Is the mutex going
across all cpus to sync such a load that moving this to a percpu thing
that much better?

And as you have now split this into one-lock-per-cpu instead of
one-lock-per-device, you just broke the situation where multiple threads
are accessing the same device at the same time, right?

You have also changed the functionality of the driver to force userspace
to handle when the lock can not be taken as previously it would always
work and just delay until it did happen.  What workflow does that now
affect that always assumed that these code paths would succeed?

Also the kernel test bot found problems with the patch :(

thanks,

greg k-h
