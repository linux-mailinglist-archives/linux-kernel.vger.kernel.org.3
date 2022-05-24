Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1422F532A07
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 14:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237137AbiEXMFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 08:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237126AbiEXMFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 08:05:19 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52A4644D8
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 05:05:17 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u3so25420213wrg.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 05:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=YHbf01JoDsojhLj2/S6FKhSPRlY6LzPLJ9ENwzyOdpo=;
        b=rioiPkD7x119qEICbx6yUaJLCZg+w8s7FAfTSMngo4hzEia3J5zdwt+Ig98NCm2HF7
         TD5rs7+gdL00jvmlB37lmdUqwsCBwlppYpX9pIMP9Ubj/bD9PhS5zgQHauPwZDUfhhqx
         yPIpRSnmW7cU5E8gJUaTcKC4O9x9kbpW+uttrATZAzu6gfKXt9vxNd4Drbt+jorQ3LmP
         lvLfGb+zw/LkSDhcYa3b/1RYXTGvlhlmmNweQEL3Lngp5YWQ/aRvTTwib3iRWSEMc+Mc
         7YQNnOw6u8AEAyIOgkQMHOG19AT6pRbMTc9grrZPYXXdma6As+H1xofPaTuduSpmRfB+
         +0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=YHbf01JoDsojhLj2/S6FKhSPRlY6LzPLJ9ENwzyOdpo=;
        b=75kPEf7cCquhr4Z0dEhPoNzIApUBIZwOEdNcDN+CPeJujHrFTnWeWyhg79EjOK+rIx
         rXHf5j/VfVdu8Kz1599AozpYuaJna0tZ05qNrPWykleG5wJZsQDXG56cbun7v6PkVlL5
         3bulIKzfYLDjLiMd7K8Yrq1zE9Pw/tTd2/uFUhpuP2Zk3D0GSjazHRjg6UhHauWs3lx1
         7RetufALohoXSLYCMzBptY+feEQSJdQJqsYQ+ktQYYO6dwr+zjIxyv7/zx6EsO6q/HSQ
         2aUz60yA5UGif95hrK3LPEpbS//i0o+GZpIbVvDCE7+KjtVJp29Va5tGwvj8alUUAsOL
         GhgQ==
X-Gm-Message-State: AOAM531XZka50HfFG/R0KHGRNorTNKZQuMrvt7VIehgNhDETgcCL5j9G
        daxE+5TDt1MY64LWXk+b42AYjg==
X-Google-Smtp-Source: ABdhPJyYWIdU0PzySYlNPn09EsDClOuvRe1mdcxB0/PdjPGc3cKgvpmKJiKf9uMzWzv9joNnsPC0RQ==
X-Received: by 2002:adf:e58e:0:b0:20e:640d:494c with SMTP id l14-20020adfe58e000000b0020e640d494cmr23511528wrm.68.1653393916202;
        Tue, 24 May 2022 05:05:16 -0700 (PDT)
Received: from localhost ([2a01:cb19:85e6:1900:d9b6:6217:ea92:4fe0])
        by smtp.gmail.com with ESMTPSA id m7-20020adfa3c7000000b0020d0cdbf7eesm12818548wrb.111.2022.05.24.05.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 05:05:15 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dmitry.torokhov@gmail.com
Cc:     matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] Input: mtk-pmic-keys - Move long press debounce
 mask to mtk_pmic_regs
In-Reply-To: <20220524093505.85438-3-angelogioacchino.delregno@collabora.com>
References: <20220524093505.85438-1-angelogioacchino.delregno@collabora.com>
 <20220524093505.85438-3-angelogioacchino.delregno@collabora.com>
Date:   Tue, 24 May 2022 14:05:14 +0200
Message-ID: <87k0abdtl1.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On mar., mai 24, 2022 at 11:35, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:

> As the second and last step of preparation to add support for more
> PMICs in this driver, move the long press debounce mask to struct
> mtk_pmic_regs and use that in mtk_pmic_keys_lp_reset_setup() instead
> of directly using the definition.
>
> While at it, remove the definition for MTK_PMIC_RST_DU_SHIFT as we
> are able to calculate it dynamically and spares us some unnecessary
> new definitions around for future per-PMIC variations of RST_DU_MASK.
>
> Lastly, it was necessary to change the function signature of
> mtk_pmic_keys_lp_reset_setup() to now pass a pointer to the main
> mtk_pmic_regs structure, since that's where the reset debounce
> mask now resides.
>
> This commit brings no functional changes.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/input/keyboard/mtk-pmic-keys.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
> index 2509a349a173..6404081253ea 100644
> --- a/drivers/input/keyboard/mtk-pmic-keys.c
> +++ b/drivers/input/keyboard/mtk-pmic-keys.c
> @@ -19,7 +19,6 @@
>  #include <linux/regmap.h>
>  
>  #define MTK_PMIC_RST_DU_MASK	GENMASK(9, 8)
> -#define MTK_PMIC_RST_DU_SHIFT	8
>  #define MTK_PMIC_PWRKEY_RST	BIT(6)
>  #define MTK_PMIC_HOMEKEY_RST	BIT(5)
>  
> @@ -48,6 +47,7 @@ struct mtk_pmic_keys_regs {
>  struct mtk_pmic_regs {
>  	const struct mtk_pmic_keys_regs keys_regs[MTK_PMIC_MAX_KEY_COUNT];
>  	u32 pmic_rst_reg;
> +	u32 rst_lprst_mask; /* Long-press reset timeout bitmask */
>  };
>  
>  static const struct mtk_pmic_regs mt6397_regs = {
> @@ -58,6 +58,7 @@ static const struct mtk_pmic_regs mt6397_regs = {
>  		MTK_PMIC_KEYS_REGS(MT6397_OCSTATUS2,
>  		0x10, MT6397_INT_RSV, 0x8, MTK_PMIC_HOMEKEY_RST),
>  	.pmic_rst_reg = MT6397_TOP_RST_MISC,
> +	.rst_lprst_mask = MTK_PMIC_RST_DU_MASK,
>  };
>  
>  static const struct mtk_pmic_regs mt6323_regs = {
> @@ -68,6 +69,7 @@ static const struct mtk_pmic_regs mt6323_regs = {
>  		MTK_PMIC_KEYS_REGS(MT6323_CHRSTATUS,
>  		0x4, MT6323_INT_MISC_CON, 0x8, MTK_PMIC_HOMEKEY_RST),
>  	.pmic_rst_reg = MT6323_TOP_RST_MISC,
> +	.rst_lprst_mask = MTK_PMIC_RST_DU_MASK,
>  };
>  
>  static const struct mtk_pmic_regs mt6358_regs = {
> @@ -80,6 +82,7 @@ static const struct mtk_pmic_regs mt6358_regs = {
>  				   0x8, MT6358_PSC_TOP_INT_CON0, 0xa,
>  				   MTK_PMIC_HOMEKEY_RST),
>  	.pmic_rst_reg = MT6358_TOP_RST_MISC,
> +	.rst_lprst_mask = MTK_PMIC_RST_DU_MASK,
>  };
>  
>  struct mtk_pmic_keys_info {
> @@ -105,7 +108,7 @@ enum mtk_pmic_keys_lp_mode {
>  };
>  
>  static void mtk_pmic_keys_lp_reset_setup(struct mtk_pmic_keys *keys,
> -					 u32 pmic_rst_reg)
> +					 const struct mtk_pmic_regs *regs)
>  {
>  	const struct mtk_pmic_keys_regs *kregs_home, *kregs_pwr;
>  	u32 long_press_mode, long_press_debounce;
> @@ -120,8 +123,8 @@ static void mtk_pmic_keys_lp_reset_setup(struct mtk_pmic_keys *keys,
>  	if (error)
>  		long_press_debounce = 0;
>  
> -	mask = MTK_PMIC_RST_DU_MASK;
> -	value = long_press_debounce << MTK_PMIC_RST_DU_SHIFT;
> +	mask = regs->rst_lprst_mask;
> +	value = long_press_debounce << (ffs(regs->rst_lprst_mask) - 1);
>  
>  	error  = of_property_read_u32(keys->dev->of_node,
>  				      "mediatek,long-press-mode",
> @@ -147,7 +150,7 @@ static void mtk_pmic_keys_lp_reset_setup(struct mtk_pmic_keys *keys,
>  		break;
>  	}
>  
> -	regmap_update_bits(keys->regmap, pmic_rst_reg, mask, value);
> +	regmap_update_bits(keys->regmap, regs->pmic_rst_reg, mask, value);
>  }
>  
>  static irqreturn_t mtk_pmic_keys_irq_handler_thread(int irq, void *data)
> @@ -351,7 +354,7 @@ static int mtk_pmic_keys_probe(struct platform_device *pdev)
>  		return error;
>  	}
>  
> -	mtk_pmic_keys_lp_reset_setup(keys, mtk_pmic_regs->pmic_rst_reg);
> +	mtk_pmic_keys_lp_reset_setup(keys, mtk_pmic_regs);
>  
>  	platform_set_drvdata(pdev, keys);
>  
> -- 
> 2.35.1
