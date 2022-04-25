Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0BC50D8EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 07:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241336AbiDYFrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 01:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235447AbiDYFpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 01:45:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FF1167DB
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 22:42:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0F94B81056
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 05:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC2EC385A9;
        Mon, 25 Apr 2022 05:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650865321;
        bh=T9+MBuMTNpr9JFwAQ6LYoWsbsniZT5XNIj9InLV87fc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xlOAWvvbsm5qII+RIpNQfzN/p1pxzWueC42v2bWmPqQFLSTyIdnlGKoghNvPkAMzk
         1bVGPooqB+Jp3lgxmzdHDwIAODLZsjwhC3EJbY3Z+b5hz8Yp9wWRZqt1RUSgT0J8/C
         x3TyEhslJipgSWZ7PLccmBS5QAZOIeAgiWJIHRtY=
Date:   Mon, 25 Apr 2022 07:41:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ren Zhijie <renzhijie2@huawei.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] base: topology: fix unused variable compile error
Message-ID: <YmY0pSEEYhwNizck@kroah.com>
References: <20220425024149.259189-1-renzhijie2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220425024149.259189-1-renzhijie2@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 10:41:49AM +0800, Ren Zhijie wrote:
> compile error:
> drivers/base/topology.c: In function ‘topology_is_visible’:
> drivers/base/topology.c:158:17: error: unused variable ‘dev’ [-Werror=unused-variable]
>   struct device *dev = kobj_to_dev(kobj);
>                  ^~~
> cc1: all warnings being treated as errors
> 
> If CONFIG_SMP is N, the macro 'topology_ppin()'expands as follows.
> "topology_ppin(dev->id) -> boot_cpu_data.ppin"
> This cause an unused variable warning for 'dev' which used in the
> topology_is_visible().
> 
> To fix build warning unused attribute added to the 'dev' variable.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes:aa63a74d4535("topology/sysfs: Hide PPIN on systems that do not support it.")
> Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
> ---
>  drivers/base/topology.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/topology.c b/drivers/base/topology.c
> index 706dbf8bf249..70962a4bcb1f 100644
> --- a/drivers/base/topology.c
> +++ b/drivers/base/topology.c
> @@ -155,7 +155,8 @@ static struct attribute *default_attrs[] = {
>  static umode_t topology_is_visible(struct kobject *kobj,
>  				   struct attribute *attr, int unused)
>  {
> -	struct device *dev = kobj_to_dev(kobj);
> +	struct device *dev __maybe_unused;
> 
> +	dev = kobj_to_dev(kobj);
>  
>  	if (attr == &dev_attr_ppin.attr && !topology_ppin(dev->id))
>  		return 0;
> -- 
> 2.17.1
> 

Thanks for this, but I've already queued up the commit here:
	https://lore.kernel.org/r/20220422062653.3899972-1-gregkh@linuxfoundation.org
which is simpler and smaller and it should show up in the next
linux-next release.

greg k-h
