Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A77B532A05
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 14:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbiEXMFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 08:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbiEXMFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 08:05:19 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5216563517
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 05:05:14 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e28so24785122wra.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 05:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=wy4ZBZCaSdrsU5jRaIpcsRShq90JZ9rF2FAY+TUamBY=;
        b=pdOIf90iqOc5vCBASR+8KMfefSm4+3KhcjgvQr8O+xQKxZo6yK+0c8CdpvgNsA6rA4
         fuvpVBYr2Ll8/JCxCAqJFIbOGXSax+/0YgDrHdS2gsY3Gwle+9y2YDYAusvZtVMtsrP/
         wRxOWGh0hxrIg6cjCu5oNlhtOUo4xDPzDxrRHGPKpH57wDgYbOGRwwJFswDrDEsPAbp9
         jGKMqGScdAf4MZZLYppBbo/s2RZlOw3U23WaKSx71+rfg9FRuyHm5ntqI8JFLzzXmJJy
         kDimSt6qAtKKbPdGI/rABeuseTHvfs36B4QRQFa4Sj/rnMl0X1PPUQLFb4qscRJIWM+u
         altg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=wy4ZBZCaSdrsU5jRaIpcsRShq90JZ9rF2FAY+TUamBY=;
        b=cwfdX9DvOL29wPTh/oHBWjhLb/OceXEdurlfO73YOq8P4Bs4WQACK9PzeGXwpTPA5E
         uUbEeyiXsABMSnyxOgzwoB/QDprKkCCC8llXauKN6IS0KVHVbJYp2WAuOqgp47Iznp27
         /vn9LP80QoVzAqTll1R63Pe+OLPRafXKY/R5+khOh3BrTlukEkUjyZS3TfDJUHvvXyIl
         73hY1nnJGLAMV1q03++vLNTPCJUouSBR/NAXrmGu1R6HiXC/+igIcbilwamLnucctR1Z
         pzq4bJiJlGms4olUCwPdDskXyJxdAOQqjjXIpZSZWuZz1FT2EZHVaTgAunfAE7eqMBPC
         Nl3g==
X-Gm-Message-State: AOAM5312anjRYTpZKgYDzY22wIoFrE8rj6jH0rl1FjjCyxMMZjF1tsOA
        IjKWOVHmpcaPpQ2CR+NNfIBAPw==
X-Google-Smtp-Source: ABdhPJy2An/d0qo4OXlYbmyJz+ZqHqkMDOvETSRBTXAjKN9NaaVOlLdg/CTVwij/FeBgqIM0WS4s2Q==
X-Received: by 2002:a05:6000:162b:b0:20f:fb06:ba97 with SMTP id v11-20020a056000162b00b0020ffb06ba97mr146654wrb.158.1653393912695;
        Tue, 24 May 2022 05:05:12 -0700 (PDT)
Received: from localhost ([2a01:cb19:85e6:1900:d9b6:6217:ea92:4fe0])
        by smtp.gmail.com with ESMTPSA id az37-20020a05600c602500b0039746638d6esm1996761wmb.33.2022.05.24.05.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 05:05:12 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dmitry.torokhov@gmail.com
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] Input: mtk-pmic-keys - Transfer per-key bit in
 mtk_pmic_keys_regs
In-Reply-To: <20220524093505.85438-2-angelogioacchino.delregno@collabora.com>
References: <20220524093505.85438-1-angelogioacchino.delregno@collabora.com>
 <20220524093505.85438-2-angelogioacchino.delregno@collabora.com>
Date:   Tue, 24 May 2022 14:05:11 +0200
Message-ID: <87leurdtl4.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On mar., mai 24, 2022 at 11:35, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:

> Place the key bit in struct mtk_pmic_keys_regs to enhance this
> driver's flexibility, in preparation for adding support for more
> PMICs.
>
> While at it, remove the definition of MTK_PMIC_RST_KEY_MASK as
> we are now dynamically setting the keymask relatively to the keys
> that are defined in the newly added rst_en_mask variable, on a
> per-key basis.
>
> This commit brings no functional changes.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/input/keyboard/mtk-pmic-keys.c | 30 ++++++++++++++++----------
>  1 file changed, 19 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
> index d2f0db245ff6..2509a349a173 100644
> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> @@ -20,7 +20,6 @@
>  
>  #define MTK_PMIC_RST_DU_MASK	GENMASK(9, 8)
>  #define MTK_PMIC_RST_DU_SHIFT	8
> -#define MTK_PMIC_RST_KEY_MASK	GENMASK(6, 5)
>  #define MTK_PMIC_PWRKEY_RST	BIT(6)
>  #define MTK_PMIC_HOMEKEY_RST	BIT(5)
>  
> @@ -33,15 +32,17 @@ struct mtk_pmic_keys_regs {
>  	u32 deb_mask;
>  	u32 intsel_reg;
>  	u32 intsel_mask;
> +	u32 rst_en_mask;
>  };
>  
>  #define MTK_PMIC_KEYS_REGS(_deb_reg, _deb_mask,		\
> -	_intsel_reg, _intsel_mask)			\
> +	_intsel_reg, _intsel_mask, _rst_mask)		\
>  {							\
>  	.deb_reg		= _deb_reg,		\
>  	.deb_mask		= _deb_mask,		\
>  	.intsel_reg		= _intsel_reg,		\
>  	.intsel_mask		= _intsel_mask,		\
> +	.rst_en_mask		= _rst_mask,		\
>  }
>  
>  struct mtk_pmic_regs {
> @@ -52,30 +53,32 @@ struct mtk_pmic_regs {
>  static const struct mtk_pmic_regs mt6397_regs = {
>  	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
>  		MTK_PMIC_KEYS_REGS(MT6397_CHRSTATUS,
> -		0x8, MT6397_INT_RSV, 0x10),
> +		0x8, MT6397_INT_RSV, 0x10, MTK_PMIC_PWRKEY_RST),
>  	.keys_regs[MTK_PMIC_HOMEKEY_INDEX] =
>  		MTK_PMIC_KEYS_REGS(MT6397_OCSTATUS2,
> -		0x10, MT6397_INT_RSV, 0x8),
> +		0x10, MT6397_INT_RSV, 0x8, MTK_PMIC_HOMEKEY_RST),
>  	.pmic_rst_reg = MT6397_TOP_RST_MISC,
>  };
>  
>  static const struct mtk_pmic_regs mt6323_regs = {
>  	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
>  		MTK_PMIC_KEYS_REGS(MT6323_CHRSTATUS,
> -		0x2, MT6323_INT_MISC_CON, 0x10),
> +		0x2, MT6323_INT_MISC_CON, 0x10, MTK_PMIC_PWRKEY_RST),
>  	.keys_regs[MTK_PMIC_HOMEKEY_INDEX] =
>  		MTK_PMIC_KEYS_REGS(MT6323_CHRSTATUS,
> -		0x4, MT6323_INT_MISC_CON, 0x8),
> +		0x4, MT6323_INT_MISC_CON, 0x8, MTK_PMIC_HOMEKEY_RST),
>  	.pmic_rst_reg = MT6323_TOP_RST_MISC,
>  };
>  
>  static const struct mtk_pmic_regs mt6358_regs = {
>  	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
>  		MTK_PMIC_KEYS_REGS(MT6358_TOPSTATUS,
> -				   0x2, MT6358_PSC_TOP_INT_CON0, 0x5),
> +				   0x2, MT6358_PSC_TOP_INT_CON0, 0x5,
> +				   MTK_PMIC_PWRKEY_RST),
>  	.keys_regs[MTK_PMIC_HOMEKEY_INDEX] =
>  		MTK_PMIC_KEYS_REGS(MT6358_TOPSTATUS,
> -				   0x8, MT6358_PSC_TOP_INT_CON0, 0xa),
> +				   0x8, MT6358_PSC_TOP_INT_CON0, 0xa,
> +				   MTK_PMIC_HOMEKEY_RST),
>  	.pmic_rst_reg = MT6358_TOP_RST_MISC,
>  };
>  
> @@ -104,10 +107,14 @@ enum mtk_pmic_keys_lp_mode {
>  static void mtk_pmic_keys_lp_reset_setup(struct mtk_pmic_keys *keys,
>  					 u32 pmic_rst_reg)
>  {
> +	const struct mtk_pmic_keys_regs *kregs_home, *kregs_pwr;
>  	u32 long_press_mode, long_press_debounce;
>  	u32 value, mask;
>  	int error;
>  
> +	kregs_home = keys->keys[MTK_PMIC_HOMEKEY_INDEX].regs;
> +	kregs_pwr = keys->keys[MTK_PMIC_PWRKEY_INDEX].regs;
> +
>  	error = of_property_read_u32(keys->dev->of_node, "power-off-time-sec",
>  				     &long_press_debounce);
>  	if (error)
> @@ -124,15 +131,16 @@ static void mtk_pmic_keys_lp_reset_setup(struct mtk_pmic_keys *keys,
>  
>  	switch (long_press_mode) {
>  	case LP_TWOKEY:
> -		value |= MTK_PMIC_HOMEKEY_RST;
> +		value |= kregs_home->rst_en_mask;
>  		fallthrough;
>  
>  	case LP_ONEKEY:
> -		value |= MTK_PMIC_PWRKEY_RST;
> +		value |= kregs_pwr->rst_en_mask;
>  		fallthrough;
>  
>  	case LP_DISABLE:
> -		mask |= MTK_PMIC_RST_KEY_MASK;
> +		mask |= kregs_home->rst_en_mask;
> +		mask |= kregs_pwr->rst_en_mask;
>  		break;
>  
>  	default:
> -- 
> 2.35.1
