Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D899483070
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 12:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbiACLYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 06:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbiACLYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 06:24:04 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED91C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 03:24:03 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id s1so69370698wrg.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 03:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2dv9Hcmjjw1FzIuVQIEUrbWYPOhjppSzFw4j3ji+cvw=;
        b=p1A8zhsW34Y6hfKcU3Cl6FKoAaCWBqChoRCCXmx02JjKsR37084KYg2ghbLSYQqzCO
         zfl5V4ZgDlIW+vSMlPCHHP2mMf/Q9f75sh968W4crfS3Ycausn9uUZyInMD+C9Y4uaoy
         vx5c9pTDm0IXYIBkWyK5Y1v98e5B54/hLx5FeH5r7eZQY0Um8nNbeJGg1RDAlWDG6+MW
         MReiqHK4O2qSrt5dJ7vepMhMDd94Nk+dL8hl0PYuSA59WXLyIbTSS5ya8Zk+viqKdEPw
         GAHOYHjzBP2whw7jlIdXm5AtPCbkwWM49VMVQMGo4v/ob01dc/ZRXuKICdK1RWKsZua2
         oHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2dv9Hcmjjw1FzIuVQIEUrbWYPOhjppSzFw4j3ji+cvw=;
        b=tBOSYIvU7R/q9/EQuAxOPJ1fbkKz1YC15xY+yNuaamFtCVcTyxkPMM/ObR/9u//YnB
         GH4BgOifhskC/lIhqSjz5+7sv7FqMuGTuAMbmsQReaA1Befy7zO/680yYbnnSbe0oRul
         W6xGxtSCQv9M0zachvyEscRDetIBpHsSlavrWPJ9lDfkKdIkzEYxvEvga6uDinVE5gYW
         2z2yVm5aTpCJmW+Vc4TjVCv400TJxXDlfnuKxmjoQ6mFhx+XC8t9O+IHz9ypjfIWRnVx
         nGCsuvnXv65nJwJFMs4Z/7Nk+mz0rzjZxx2TI6zkMFgKTpKq3XAyzBkwYjRwC+p62+ua
         WyRw==
X-Gm-Message-State: AOAM533wl9ptfRrB1kPhlxH1K/WW7pddyHkOP3Se4HAyPnYJ5b5jPEF5
        SYDTPq4/pIreZrzwFI9v8KlOqsIU84/o6Q==
X-Google-Smtp-Source: ABdhPJxqIDs6Gfcxd5z3nw52PWsAzBuULElaTR3XlFu5xQkEIITr8wmCYJ5y4bKPzOY3ZSaSYrpN+Q==
X-Received: by 2002:a5d:648b:: with SMTP id o11mr36907792wri.227.1641209041965;
        Mon, 03 Jan 2022 03:24:01 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:7c9d:a967:38e2:5220? ([2001:861:44c0:66c0:7c9d:a967:38e2:5220])
        by smtp.gmail.com with ESMTPSA id z5sm33695129wru.87.2022.01.03.03.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jan 2022 03:24:01 -0800 (PST)
Subject: Re: [PATCH 1/2] drm/meson: osd_afbcd: Add an exit callback to struct
 meson_afbcd_ops
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211230235515.1627522-1-martin.blumenstingl@googlemail.com>
 <20211230235515.1627522-2-martin.blumenstingl@googlemail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <4a4b40fd-b9d7-b38d-b4d4-4aaaf03693f2@baylibre.com>
Date:   Mon, 3 Jan 2022 12:24:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211230235515.1627522-2-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/12/2021 00:55, Martin Blumenstingl wrote:
> Use this to simplify the driver shutdown. It will also come handy when
> fixing the error handling in meson_drv_bind_master().
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/gpu/drm/meson/meson_drv.c       |  6 ++--
>  drivers/gpu/drm/meson/meson_osd_afbcd.c | 41 ++++++++++++++++---------
>  drivers/gpu/drm/meson/meson_osd_afbcd.h |  1 +
>  3 files changed, 30 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
> index 80f1d439841a..b919271a6e50 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -385,10 +385,8 @@ static void meson_drv_unbind(struct device *dev)
>  	free_irq(priv->vsync_irq, drm);
>  	drm_dev_put(drm);
>  
> -	if (priv->afbcd.ops) {
> -		priv->afbcd.ops->reset(priv);
> -		meson_rdma_free(priv);
> -	}
> +	if (priv->afbcd.ops)
> +		priv->afbcd.ops->exit(priv);
>  }
>  
>  static const struct component_master_ops meson_drv_master_ops = {
> diff --git a/drivers/gpu/drm/meson/meson_osd_afbcd.c b/drivers/gpu/drm/meson/meson_osd_afbcd.c
> index ffc6b584dbf8..0cdbe899402f 100644
> --- a/drivers/gpu/drm/meson/meson_osd_afbcd.c
> +++ b/drivers/gpu/drm/meson/meson_osd_afbcd.c
> @@ -79,11 +79,6 @@ static bool meson_gxm_afbcd_supported_fmt(u64 modifier, uint32_t format)
>  	return meson_gxm_afbcd_pixel_fmt(modifier, format) >= 0;
>  }
>  
> -static int meson_gxm_afbcd_init(struct meson_drm *priv)
> -{
> -	return 0;
> -}
> -
>  static int meson_gxm_afbcd_reset(struct meson_drm *priv)
>  {
>  	writel_relaxed(VIU_SW_RESET_OSD1_AFBCD,
> @@ -93,6 +88,16 @@ static int meson_gxm_afbcd_reset(struct meson_drm *priv)
>  	return 0;
>  }
>  
> +static int meson_gxm_afbcd_init(struct meson_drm *priv)
> +{
> +	return 0;
> +}
> +
> +static void meson_gxm_afbcd_exit(struct meson_drm *priv)
> +{
> +	meson_gxm_afbcd_reset(priv);
> +}
> +
>  static int meson_gxm_afbcd_enable(struct meson_drm *priv)
>  {
>  	writel_relaxed(FIELD_PREP(OSD1_AFBCD_ID_FIFO_THRD, 0x40) |
> @@ -172,6 +177,7 @@ static int meson_gxm_afbcd_setup(struct meson_drm *priv)
>  
>  struct meson_afbcd_ops meson_afbcd_gxm_ops = {
>  	.init = meson_gxm_afbcd_init,
> +	.exit = meson_gxm_afbcd_exit,
>  	.reset = meson_gxm_afbcd_reset,
>  	.enable = meson_gxm_afbcd_enable,
>  	.disable = meson_gxm_afbcd_disable,
> @@ -269,6 +275,18 @@ static bool meson_g12a_afbcd_supported_fmt(u64 modifier, uint32_t format)
>  	return meson_g12a_afbcd_pixel_fmt(modifier, format) >= 0;
>  }
>  
> +static int meson_g12a_afbcd_reset(struct meson_drm *priv)
> +{
> +	meson_rdma_reset(priv);
> +
> +	meson_rdma_writel_sync(priv, VIU_SW_RESET_G12A_AFBC_ARB |
> +			       VIU_SW_RESET_G12A_OSD1_AFBCD,
> +			       VIU_SW_RESET);
> +	meson_rdma_writel_sync(priv, 0, VIU_SW_RESET);
> +
> +	return 0;
> +}
> +
>  static int meson_g12a_afbcd_init(struct meson_drm *priv)
>  {
>  	int ret;
> @@ -286,16 +304,10 @@ static int meson_g12a_afbcd_init(struct meson_drm *priv)
>  	return 0;
>  }
>  
> -static int meson_g12a_afbcd_reset(struct meson_drm *priv)
> +static void meson_g12a_afbcd_exit(struct meson_drm *priv)
>  {
> -	meson_rdma_reset(priv);
> -
> -	meson_rdma_writel_sync(priv, VIU_SW_RESET_G12A_AFBC_ARB |
> -			       VIU_SW_RESET_G12A_OSD1_AFBCD,
> -			       VIU_SW_RESET);
> -	meson_rdma_writel_sync(priv, 0, VIU_SW_RESET);
> -
> -	return 0;
> +	meson_g12a_afbcd_reset(priv);
> +	meson_rdma_free(priv);
>  }
>  
>  static int meson_g12a_afbcd_enable(struct meson_drm *priv)
> @@ -380,6 +392,7 @@ static int meson_g12a_afbcd_setup(struct meson_drm *priv)
>  
>  struct meson_afbcd_ops meson_afbcd_g12a_ops = {
>  	.init = meson_g12a_afbcd_init,
> +	.exit = meson_g12a_afbcd_exit,
>  	.reset = meson_g12a_afbcd_reset,
>  	.enable = meson_g12a_afbcd_enable,
>  	.disable = meson_g12a_afbcd_disable,
> diff --git a/drivers/gpu/drm/meson/meson_osd_afbcd.h b/drivers/gpu/drm/meson/meson_osd_afbcd.h
> index 5e5523304f42..e77ddeb6416f 100644
> --- a/drivers/gpu/drm/meson/meson_osd_afbcd.h
> +++ b/drivers/gpu/drm/meson/meson_osd_afbcd.h
> @@ -14,6 +14,7 @@
>  
>  struct meson_afbcd_ops {
>  	int (*init)(struct meson_drm *priv);
> +	void (*exit)(struct meson_drm *priv);
>  	int (*reset)(struct meson_drm *priv);
>  	int (*enable)(struct meson_drm *priv);
>  	int (*disable)(struct meson_drm *priv);
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks for fixing this

Neil

