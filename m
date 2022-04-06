Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0434F634E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236075AbiDFPb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236188AbiDFPbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:31:18 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06BB692AD9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 05:41:52 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z1so3039566wrg.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 05:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=sp1pvHf/9GF7gJYZD0BVuhj9+/tx5WJjCJQ53j0Lu7s=;
        b=CNVpTJbhqsEeENw5+USf7Rl0d5mTwNAvQDQNL9QQi15IQlxfRFAz+ft+7SEV2AIrhv
         bmNLIuREdym2cduh84Ur8R2uCV7YH/AVP9SxvWhSpXWV5YCNfo21+DFYhh46eQ0y+GmD
         3NYXDTDTY3ujiRAEUSoa4MT1OBQM3MJ2eDHanHM6mS45FrXsF+pS3wN5s8tLBHhRN3+W
         XJu/raMsMszzEJeQTgm2CPz4+djxlqqc8a8rYHhB80ZDvoCCLRegd7joKLdoUMA8v4wO
         e434PzIyWHxfsl/PPcGL2JUD4kKUtMsJN7cXhb2JD7KtE8BynBkLX2K9KPKM6wEydwtP
         4xIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=sp1pvHf/9GF7gJYZD0BVuhj9+/tx5WJjCJQ53j0Lu7s=;
        b=J0vjqfohIe6tLmiMtN7khlndYBZ9UmURvXMWdzuXMxugcctqzUkrfy03wEpHv2j//a
         +msSGEbHYnp4fWXYef64MMiK+iX7Bj7V3UXT1OFiTJGS4ZJHi1NpMPmZBsMYG/BYp2Yw
         8QxIoqR0IYKVndEmheACJGEao/Yfn1nK0WTYsrVBdFJVy12vyQobeFYJ06zFXEiMPTHA
         S+K+jpmt+aE7mGnxxsRQofhQiF+XmJTqK6FNclUH+AxPn1xhyISJ35nORxEsLJPylwH8
         lmGi4JilqW5DCd9fz8CC7tv50SFKW/On7TQ3Pe1rdJghX0za/o/icxteTfmyVtxfbdqa
         Ivcg==
X-Gm-Message-State: AOAM531XbaVuYkaUNTS9TteqBgLWePUSKPceuRFZyQGehYo8ruUzEGRS
        pWfyqC2GqkAunGm4AEuo+m5ALrjSsbBzNQ==
X-Google-Smtp-Source: ABdhPJzFvjsdL3HC5zlQzmL/PVvEFPrNgN95+P6H/z2UKiAeU+m2PSi7y0zSFSeoqHGV+qL8vEhVEg==
X-Received: by 2002:adf:d214:0:b0:204:2a98:a166 with SMTP id j20-20020adfd214000000b002042a98a166mr6564739wrh.406.1649248877966;
        Wed, 06 Apr 2022 05:41:17 -0700 (PDT)
Received: from localhost ([2a01:cb19:826e:8e00:6c64:eb3a:6739:d25])
        by smtp.gmail.com with ESMTPSA id 3-20020a5d47a3000000b0020412ba45f6sm17475132wrb.8.2022.04.06.05.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 05:41:17 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dmitry.torokhov@gmail.com
Cc:     matthias.bgg@gmail.com, lv.ruyi@zte.com.cn,
        m.felsch@pengutronix.de, angelogioacchino.delregno@collabora.com,
        fengping.yu@mediatek.com, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: mt6779-keypad: Move iomem pointer to probe function
In-Reply-To: <20220406115654.115093-1-angelogioacchino.delregno@collabora.com>
References: <20220406115654.115093-1-angelogioacchino.delregno@collabora.com>
Date:   Wed, 06 Apr 2022 14:41:16 +0200
Message-ID: <87czhu2xlf.fsf@baylibre.com>
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

On mer., avril 06, 2022 at 13:56, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:

> The mmio base address is used for the only purpose of initializing
> regmap for this driver, hence it's not necessary to have it in the
> main driver structure, as it is used only in the probe() callback.
> Move it local to function mt6779_keypad_pdrv_probe().
>
> This commit brings no functional changes.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Thank you Angelo,

I planned to do this myself but I've been too slow :)

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/input/keyboard/mt6779-keypad.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/input/keyboard/mt6779-keypad.c b/drivers/input/keyboard/mt6779-keypad.c
> index 0dbbddc7f298..2e7c9187c10f 100644
> --- a/drivers/input/keyboard/mt6779-keypad.c
> +++ b/drivers/input/keyboard/mt6779-keypad.c
> @@ -24,7 +24,6 @@ struct mt6779_keypad {
>  	struct regmap *regmap;
>  	struct input_dev *input_dev;
>  	struct clk *clk;
> -	void __iomem *base;
>  	u32 n_rows;
>  	u32 n_cols;
>  	DECLARE_BITMAP(keymap_state, MTK_KPD_NUM_BITS);
> @@ -91,6 +90,7 @@ static void mt6779_keypad_clk_disable(void *data)
>  static int mt6779_keypad_pdrv_probe(struct platform_device *pdev)
>  {
>  	struct mt6779_keypad *keypad;
> +	void __iomem *base;
>  	int irq;
>  	u32 debounce;
>  	bool wakeup;
> @@ -100,11 +100,11 @@ static int mt6779_keypad_pdrv_probe(struct platform_device *pdev)
>  	if (!keypad)
>  		return -ENOMEM;
>  
> -	keypad->base = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(keypad->base))
> -		return PTR_ERR(keypad->base);
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
>  
> -	keypad->regmap = devm_regmap_init_mmio(&pdev->dev, keypad->base,
> +	keypad->regmap = devm_regmap_init_mmio(&pdev->dev, base,
>  					       &mt6779_keypad_regmap_cfg);
>  	if (IS_ERR(keypad->regmap)) {
>  		dev_err(&pdev->dev,
> -- 
> 2.35.1
