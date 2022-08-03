Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C604158873C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 08:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236618AbiHCGQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 02:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbiHCGQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:16:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7494A1C130;
        Tue,  2 Aug 2022 23:16:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2AFF9B82197;
        Wed,  3 Aug 2022 06:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FC6C433C1;
        Wed,  3 Aug 2022 06:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659507401;
        bh=HScOH3UGb4E4YqbwFuL19XJwaHdNHFNtNhfCfn0YD38=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XAWyM1EqXArnCvB4ZdFoWbPupTUZTq9BIAuwVsRvjZ9T1eyVo5DkywtFseUzLtgyz
         XREuyQChz9TKSA6Q8uJ/0syw2Ng8kHZt7b1ekBdK1po29XonmKxm2+sU3JfNQIbg5x
         x7g7pIGjnHJmUGWlw4lOWRP/ZWdbnDQLI+x/nPZc=
Date:   Wed, 3 Aug 2022 08:16:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cgel.zte@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] USB: apple-mfi-fastcharge:using the
 pm_runtime_resume_and_get to  simplify the code
Message-ID: <YuoSx2Te30HxATlE@kroah.com>
References: <20220803061452.1650472-1-ye.xingchen@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803061452.1650472-1-ye.xingchen@zte.com.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 06:14:52AM +0000, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Using pm_runtime_resume_and_get() to instade of  pm_runtime_get_sync
> and pm_runtime_put_noidle.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/usb/misc/apple-mfi-fastcharge.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/misc/apple-mfi-fastcharge.c b/drivers/usb/misc/apple-mfi-fastcharge.c
> index ac8695195c13..1bf9a67f4cca 100644
> --- a/drivers/usb/misc/apple-mfi-fastcharge.c
> +++ b/drivers/usb/misc/apple-mfi-fastcharge.c
> @@ -119,9 +119,8 @@ static int apple_mfi_fc_set_property(struct power_supply *psy,
>  
>  	dev_dbg(&mfi->udev->dev, "prop: %d\n", psp);
>  
> -	ret = pm_runtime_get_sync(&mfi->udev->dev);
> +	ret = pm_runtime_resume_and_get(&mfi->udev->dev);
>  	if (ret < 0) {
> -		pm_runtime_put_noidle(&mfi->udev->dev);
>  		return ret;
>  	}
>  
> -- 
> 2.25.1

For some reason you ignored my request in:
	https://lore.kernel.org/r/YujeLEMsIrVD2tGn@kroah.com 
so I'll just add your email to my discard list for a while, sorry.

greg k-h
