Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A752F4BA47A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242554AbiBQPgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:36:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiBQPgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:36:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF79D2B2C6F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:36:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83672B8233C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 15:36:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94420C340E8;
        Thu, 17 Feb 2022 15:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645112166;
        bh=Zx+rgR2hkDkUpjC2HrW0GPCmiJR+q3mTUymGonHF0Kg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yJOBxsu+z07yoINNUn7hTlhwrQx5S2OlmjLojEN1iNHSjTvb1OedtTRc/vf/JKU2a
         fybEj/ZyQodudhdIEAXMOH9ilkmqHFoYKXblPRC3ZUhOwUk+Sbd3RGXuDKa61e1aaJ
         0LsjrY/87AevrE2eakIbiGMMcKoZQzCoD1OWqUtM=
Date:   Thu, 17 Feb 2022 16:36:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     xkernel.wang@foxmail.com
Cc:     jerome.pouiller@silabs.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wfx: fix the error handling in wfx_init_common()
Message-ID: <Yg5rY3Qo7dPHbLI0@kroah.com>
References: <tencent_A552D77F0E081BB36EAE11C720455D78BD06@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_A552D77F0E081BB36EAE11C720455D78BD06@qq.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 11:29:06PM +0800, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> All the error handlers of wfx_init_common() return without calling
> ieee80211_free_hw(hw), which may result in memory leak. So I add
> one err label to unify the error handlers.
> 
> Suggested-by: Jérôme Pouiller <jerome.pouiller@silabs.com>
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
>  drivers/staging/wfx/main.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/wfx/main.c b/drivers/staging/wfx/main.c
> index 4b9fdf9..f83df9f 100644
> --- a/drivers/staging/wfx/main.c
> +++ b/drivers/staging/wfx/main.c
> @@ -309,7 +309,8 @@ struct wfx_dev *wfx_init_common(struct device *dev,
>  	wdev->pdata.gpio_wakeup = devm_gpiod_get_optional(dev, "wakeup",
>  							  GPIOD_OUT_LOW);
>  	if (IS_ERR(wdev->pdata.gpio_wakeup))
> -		return NULL;
> +		goto err;
> +
>  	if (wdev->pdata.gpio_wakeup)
>  		gpiod_set_consumer_name(wdev->pdata.gpio_wakeup, "wfx wakeup");
>  
> @@ -325,9 +326,13 @@ struct wfx_dev *wfx_init_common(struct device *dev,
>  	wdev->force_ps_timeout = -1;
>  
>  	if (devm_add_action_or_reset(dev, wfx_free_common, wdev))
> -		return NULL;
> +		goto err;
>  
>  	return wdev;
> +
> +err:
> +	ieee80211_free_hw(hw);
> +	return NULL;
>  }
>  
>  int wfx_probe(struct wfx_dev *wdev)
> -- 

Please make this a patch series, properly numbered, and not 2 individual
and separate patches as the second one relies on this one, yet that it
not conveyed to anyone at all :(

thanks,

greg k-h
