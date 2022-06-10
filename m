Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4453546104
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347830AbiFJJHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348469AbiFJJGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:06:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44D0279E74;
        Fri, 10 Jun 2022 02:06:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED4E561D06;
        Fri, 10 Jun 2022 09:06:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3747C34114;
        Fri, 10 Jun 2022 09:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654851975;
        bh=qnjskA552I2coALjaymQCmvodpBLR9FnaHH38d9QCew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZdcQNgIKZYKLb6iw0PxYrvfn1VNI7knQb/FCZUCtk02XjQWbbHR+rM/ECO3J18hsD
         sPB641MiighRTq3SXYoKJqq328rdhKuSadpKSBJFKwNdqxES0FO93i26vs8G3SDY+p
         3lwH0md5NS5WTolN7qpu5t2akiFDFlcyOklOLK0M=
Date:   Fri, 10 Jun 2022 11:06:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cgel.zte@gmail.com
Cc:     oneukum@suse.com, olebowle@gmx.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] usb: core: Remove redundant NULL checks before kfree
Message-ID: <YqMJhNr1noPX92Yz@kroah.com>
References: <20220606014352.290600-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606014352.290600-1-chi.minghao@zte.com.cn>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 01:43:52AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Checking a pointer for NULL before calling kfree() on it is redundant,
> kfree() deals with NULL pointers just fine.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/usb/core/quirks.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index f99a65a64588..7e918e4a95f2 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -56,10 +56,8 @@ static int quirks_param_set(const char *value, const struct kernel_param *kp)
>  		if (val[i] == ',')
>  			quirk_count++;
>  
> -	if (quirk_list) {
> -		kfree(quirk_list);
> -		quirk_list = NULL;
> -	}
> +	kfree(quirk_list);
> +	quirk_list = NULL;

Why are you setting this to NULL right before you assign it again:

>  	quirk_list = kcalloc(quirk_count, sizeof(struct quirk_entry),
>  			     GFP_KERNEL);

Please just free and move on.

thanks,

greg k-h
