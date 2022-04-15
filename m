Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F369502EAF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 20:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345997AbiDOSYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 14:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbiDOSY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 14:24:27 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95EF8D6BF;
        Fri, 15 Apr 2022 11:21:58 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g20so10712564edw.6;
        Fri, 15 Apr 2022 11:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2PQVWiHx93icOlykBtTVU6fhMCvfEE9ajlxw/JbX9tk=;
        b=nDqMmCrzZ/RJYcFVEehDawcwyUKWiH7DEZvbU5N0jebFmEqRQf0rbPjEu4ebEtONk7
         K3iPP9ZOy5uj5oWfmo3F+j4CzZxs7JWsRCnQMVKn+w4yDlC+bfIEueBxsSGZpdqfpviK
         EkFXXpyCL/OpaFBD5ruViZx4MTlckcKR1dvLTEGQ9zJDDn6tF0MXYbMUxCk9fHkIPZ+5
         J4uWgxH8I9TTjHtWJePoAVit+ZtekXYotjkod3pkmYv5ywhCgBfa3aL/XqnqCNh5LAdf
         D+udtgOtC2AgyXC0GUAVunAQxQrF5UqrSdObWxhiTR5NOWb5Glr2LabFvOMritXNpejw
         hGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2PQVWiHx93icOlykBtTVU6fhMCvfEE9ajlxw/JbX9tk=;
        b=WtDUeBCubtX9b3RVg5e8RTfJy+PDXnqUUL1KW2obmwcoJ9o5x9bLBgJ8E77569tQbx
         y5r2q5eWUiHYzrxNsTCFh21UtaYyfHOI9preUAgqQCJmuc+r/g4PUl89JVj5FU1M7UTv
         hUcKPVZBHoteWs5R9lR9DJrV/xLc7ADNa3SuZl1pyGmNHC+TnEBL9GPu3lK1ZLJbZJ+L
         16YrL+RND5N5zLzmKbJMKPFXrFJL9gPnZ7NkFzccJG9uatoPiRrZi9Hx79n/Y0e0YnUG
         ySZwYdgozdgU/jj/RgZ/HznGufNyQEi4Yvq5E7sXm+M2zMWOPNWz6eO+Ubzh7PMoM2QD
         acaQ==
X-Gm-Message-State: AOAM531a6B3CQYWI32tpOjY3EQW88ptoy8cwFMbM9Rfjru7SvbtZVm/q
        EMOnf8dO+poV5cXxdnBB8Do=
X-Google-Smtp-Source: ABdhPJx3tAA1b57FqowvswLdUaAFlwRzKdSzq0UpYQtBvXK4epBT4qXR+T91BRr8Zrxb06jm5WM4rw==
X-Received: by 2002:a05:6402:3318:b0:41d:893e:4d6 with SMTP id e24-20020a056402331800b0041d893e04d6mr437242eda.225.1650046917267;
        Fri, 15 Apr 2022 11:21:57 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709064a0100b006e89334f5dfsm1910230eju.136.2022.04.15.11.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 11:21:56 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2 2/3] Input: sun4i-lradc-keys: Add optional clock/reset support
Date:   Fri, 15 Apr 2022 20:21:55 +0200
Message-ID: <2821426.e9J7NaK4W3@jernej-laptop>
In-Reply-To: <20220414002349.24332-2-samuel@sholland.org>
References: <20220414002349.24332-1-samuel@sholland.org> <20220414002349.24332-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 14. april 2022 ob 02:23:47 CEST je Samuel Holland napisal=
(a):
> Until the R329, the LRADC hardware was always active. Now it requires
> enabling a clock gate and deasserting a reset line. Add support for this
> variant of the hardware.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>=20
> Changes in v2:
>  - Guard the code with a flag instead of using "_optional" variants.
>=20
>  drivers/input/keyboard/sun4i-lradc-keys.c | 33 +++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>=20
> diff --git a/drivers/input/keyboard/sun4i-lradc-keys.c
> b/drivers/input/keyboard/sun4i-lradc-keys.c index
> 4a796bed48ac..5630334a6c09 100644
> --- a/drivers/input/keyboard/sun4i-lradc-keys.c
> +++ b/drivers/input/keyboard/sun4i-lradc-keys.c
> @@ -14,6 +14,7 @@
>   * there are no boards known to use channel 1.
>   */
>=20
> +#include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/init.h>
>  #include <linux/input.h>
> @@ -23,6 +24,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
>  #include <linux/slab.h>
>=20
>  #define LRADC_CTRL		0x00
> @@ -58,10 +60,12 @@
>  /* struct lradc_variant - Describe sun4i-a10-lradc-keys hardware variant
>   * @divisor_numerator:		The numerator of lradc Vref internally=20
divisor
>   * @divisor_denominator:	The denominator of lradc Vref internally=20
divisor
> + * @has_clock_reset:		If the binding requires a clock and reset
>   */
>  struct lradc_variant {
>  	u8 divisor_numerator;
>  	u8 divisor_denominator;
> +	bool has_clock_reset;
>  };
>=20
>  static const struct lradc_variant lradc_variant_a10 =3D {
> @@ -83,6 +87,8 @@ struct sun4i_lradc_data {
>  	struct device *dev;
>  	struct input_dev *input;
>  	void __iomem *base;
> +	struct clk *clk;
> +	struct reset_control *reset;
>  	struct regulator *vref_supply;
>  	struct sun4i_lradc_keymap *chan0_map;
>  	const struct lradc_variant *variant;
> @@ -140,6 +146,14 @@ static int sun4i_lradc_open(struct input_dev *dev)
>  	if (error)
>  		return error;
>=20
> +	error =3D reset_control_deassert(lradc->reset);
> +	if (error)
> +		goto err_disable_reg;
> +
> +	error =3D clk_prepare_enable(lradc->clk);
> +	if (error)
> +		goto err_assert_reset;
> +
>  	lradc->vref =3D regulator_get_voltage(lradc->vref_supply) *
>  		      lradc->variant->divisor_numerator /
>  		      lradc->variant->divisor_denominator;
> @@ -153,6 +167,13 @@ static int sun4i_lradc_open(struct input_dev *dev)
>  	writel(CHAN0_KEYUP_IRQ | CHAN0_KEYDOWN_IRQ, lradc->base +=20
LRADC_INTC);
>=20
>  	return 0;
> +
> +err_assert_reset:
> +	reset_control_assert(lradc->reset);
> +err_disable_reg:
> +	regulator_disable(lradc->vref_supply);
> +
> +	return error;
>  }
>=20
>  static void sun4i_lradc_close(struct input_dev *dev)
> @@ -164,6 +185,8 @@ static void sun4i_lradc_close(struct input_dev *dev)
>  		SAMPLE_RATE(2), lradc->base + LRADC_CTRL);
>  	writel(0, lradc->base + LRADC_INTC);
>=20
> +	clk_disable_unprepare(lradc->clk);
> +	reset_control_assert(lradc->reset);
>  	regulator_disable(lradc->vref_supply);
>  }
>=20
> @@ -243,6 +266,16 @@ static int sun4i_lradc_probe(struct platform_device
> *pdev) return -EINVAL;
>  	}
>=20
> +	if (lradc->variant->has_clock_reset) {
> +		lradc->clk =3D devm_clk_get(dev, NULL);
> +		if (IS_ERR(lradc->clk))
> +			return PTR_ERR(lradc->clk);
> +
> +		lradc->reset =3D devm_reset_control_get_exclusive(dev,=20
NULL);
> +		if (IS_ERR(lradc->reset))
> +			return PTR_ERR(lradc->reset);
> +	}
> +
>  	lradc->vref_supply =3D devm_regulator_get(dev, "vref");
>  	if (IS_ERR(lradc->vref_supply))
>  		return PTR_ERR(lradc->vref_supply);




