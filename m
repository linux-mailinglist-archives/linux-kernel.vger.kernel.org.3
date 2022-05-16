Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6FC527D4B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240001AbiEPGAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240090AbiEPGAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:00:32 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22271BE87
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:00:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0065ACE0FF9
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020F3C385AA;
        Mon, 16 May 2022 06:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652680826;
        bh=kC6JtpL/OsFrf+rK+YhUY+p/3WyAjtnqLR8KhpklnNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WHFHQMSD/DeUEBZeTzVnWWByHt5S0FjnZGyG3c72mpuifPfAi7RsrMdlD135xvZ29
         uaj5R5m9EkM+0Esb20vu4lYbvJ09Jj5L+3uxqt5N/jArUM0V6n4dxb8ZIUR8k705iY
         JcJvdcm/85isTw4UhhLjoTzR3iaMCvS60x0a5ck4=
Date:   Mon, 16 May 2022 08:00:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Guixin Liu <kanie@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] uio: replace mutex info_lock with percpu_ref
Message-ID: <YoHodPODc/1Ghj5O@kroah.com>
References: <1652669831-104542-1-git-send-email-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652669831-104542-1-git-send-email-kanie@linux.alibaba.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 10:57:11AM +0800, Guixin Liu wrote:
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
> ---
>  drivers/uio/uio.c          | 97 ++++++++++++++++++++++++++++++++++------------
>  include/linux/uio_driver.h |  5 ++-
>  2 files changed, 76 insertions(+), 26 deletions(-)
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
