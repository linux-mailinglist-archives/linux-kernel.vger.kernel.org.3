Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC1058CBD3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243528AbiHHQFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbiHHQFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:05:33 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E70526E2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 09:05:29 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id l4so11380656wrm.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 09:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=gPDJCQ+/+JYAyn+AV32OXx+aicgVt78ltXIsXvtdYI0=;
        b=hHjqa7CWQnJmlq9C0LRUEWpy//g3+jRrI7vwiSxL4wWAi/xzNGF67o732BviYDz3fm
         VJARwD8l9V70K5yLkUFCEhmxFeelu1FLb79qDiy1T93JxZRK19PTN7NqObMv1yiCFYZN
         vOZr2kUpEIpm7lllh7L1Ct0E5dgt2Pt8ZMOwCkWtYZ8am3n0HVGCvFywPUJybjQvE3AT
         bR/vuMBaaYEVi74aOCH9kX/3wZl4lJWVE/9lXwS7A7r7C5NbyL95IzYpHC/BxDHnCzyZ
         cGFyiUTKWP2tlD7OBnw/zkumKey0IipPAyCPZrIXWIlU12+0NeXD/ADfUlAwbiYmRTqj
         bg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=gPDJCQ+/+JYAyn+AV32OXx+aicgVt78ltXIsXvtdYI0=;
        b=Melv8nTacVOXrmhB6Z7ZkodkvDWKjpwsd8WJtVvZKk0hkqnZmZu3RM+wVjv4OjNDWL
         puFg7fJn6yD1fbVDx9UOf2ezWJOfELiIMZ/FCCIp5gjrfRdnVrICOtQCqYUE9uGt7fo5
         LqHu0KtPPOeO8d2ebNy5avmyKANKV3oQWG8/GjgjPJ7lUicshEDzwE1gJWIKLe6/ZwZ4
         zSpBWPkqMLFGucre/aAdbEgrV5SP6AEiQmovyeuDSFRF4PI8u4WzvmABejeLe1w5Ygr1
         AS1/g3D51bSiBEQBV++yjySXLMGXWaXiiLSPPQFGFOtZ7I/MYEHe8aPXWMf24P6fWS48
         OyAw==
X-Gm-Message-State: ACgBeo22S7r+G+vbk6MI6f68NFgAWyzLJKxUrkUIa8Qcaq//YVyA3QiX
        w/gSnZ3M9At4zR+GICU7z1LfGg==
X-Google-Smtp-Source: AA6agR6V9z9uQSFg7xriL0KBIph5BN8jTtlLaNXFsxB3tId1ba0oLbdVh0gKvT9xDTTv3i19sqReng==
X-Received: by 2002:a05:6000:1f08:b0:21f:bbe:252c with SMTP id bv8-20020a0560001f0800b0021f0bbe252cmr11710248wrb.340.1659974727955;
        Mon, 08 Aug 2022 09:05:27 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id d15-20020adfe84f000000b00220628ef654sm11344866wrn.24.2022.08.08.09.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 09:05:27 -0700 (PDT)
Date:   Mon, 8 Aug 2022 17:05:25 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jerome Neanne <jneanne@baylibre.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org, khilman@baylibre.com,
        narmstrong@baylibre.com, msp@baylibre.com, j-keerthy@ti.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v2 08/11] mfd: tps65219: Add power-button support
Message-ID: <YvE0RclZipE+PyRn@google.com>
References: <20220726103355.17684-1-jneanne@baylibre.com>
 <20220726103355.17684-9-jneanne@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726103355.17684-9-jneanne@baylibre.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022, Jerome Neanne wrote:

> From: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> Using a power-button on the EN/PB/VSENSE pin of TPS65219 is optional, so
> this driver adds the mfd cell for tps65219-pwrbutton only if needed. Two
> interrupts are passed to the driver.

Power button support was already added in the previous patch.

> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
> ---
>  drivers/mfd/tps65219.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mfd/tps65219.c b/drivers/mfd/tps65219.c
> index 7366f251c21d..e1c30a49bf08 100644
> --- a/drivers/mfd/tps65219.c
> +++ b/drivers/mfd/tps65219.c
> @@ -335,7 +335,10 @@ static int tps65219_probe(struct i2c_client *client,
>  	struct tps65219 *tps;
>  	int ret;
>  	unsigned int chipid;
> +	bool pwr_button;
>  	bool sys_pwr;
> +	struct mfd_cell cells[TPS65219_MAX_CELLS];
> +	int nr_cells = 0;
>  
>  	tps = devm_kzalloc(&client->dev, sizeof(*tps), GFP_KERNEL);
>  	if (!tps)
> @@ -364,9 +367,16 @@ static int tps65219_probe(struct i2c_client *client,
>  		return ret;
>  	}
>  
> -	ret = devm_mfd_add_devices(tps->dev, PLATFORM_DEVID_AUTO, tps65219_cells,
> -				   ARRAY_SIZE(tps65219_cells), NULL, 0,
> -				   NULL);
> +	memcpy(&cells[nr_cells++], &tps65219_regulator_cell,
> +	       sizeof(tps65219_regulator_cell));
> +	pwr_button = of_property_read_bool(tps->dev->of_node, "power-button");
> +	if (pwr_button)
> +		memcpy(&cells[nr_cells++], &tps65219_pwrbutton_cell,
> +		       sizeof(tps65219_pwrbutton_cell));

Gross, no way.

Please call devm_mfd_add_devices() twice.

> +	ret = devm_mfd_add_devices(tps->dev, PLATFORM_DEVID_AUTO, cells,
> +				   nr_cells, NULL, 0,
> +				   regmap_irq_get_domain(tps->irq_data));
>  	if (ret) {
>  		dev_err(tps->dev, "mfd_add_devices failed: %d\n", ret);
>  		return ret;

-- 
DEPRECATED: Please use lee@kernel.org
