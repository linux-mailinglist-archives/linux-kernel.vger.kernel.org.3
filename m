Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB3751232F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbiD0UAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 16:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiD0UAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 16:00:43 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA79C101C6;
        Wed, 27 Apr 2022 12:57:30 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id i19so5461892eja.11;
        Wed, 27 Apr 2022 12:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gObXNMCeL04pRkzfUrbEYNuGnSmsJApWDHwj3r0JiVQ=;
        b=UdY39AZqXiBKog7jwIYOkFGgB82bNvFxD9+bmmpgska5kaiJ7XZnl9oe4Y+reIg0S1
         /WOTLuZWF9bQvqXWykCHQJDM1d1hu40iXT3ovjpJYFBe2bsh4RJfrgSBjGrN5l021hOk
         maLFCmTUJld/O1DScaRp5rwECpSy1m0sgS2i9IkHShThIJHlgEWAB83jz/eOEoVYff97
         Us2UeuV/qri6x5zvMMZTsvBtj/sVfEHKCqoXVBLLx5DsxiVCZBI21P428Cs33wupzajM
         cjxEMYET2sz/6T6Pz09zlL4SZ/UlpMTXxS9/Bg92nr1VmTjrUjm1j2XAGleVU+x2c0c8
         70jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gObXNMCeL04pRkzfUrbEYNuGnSmsJApWDHwj3r0JiVQ=;
        b=gDXfV4B3gdLNP6jzojX/qU1RgI2RKvaRgfX0NYeLa8cg7nM46fQdEmrqjWb3BUVjA1
         1YYS4ujJFXmMcPlR+H8rhpYqeGx333Sl9Bn1Gmx5iDOj6UqF9uTnW7D19rBCeWh9Etpq
         30K8ucJsspqgVKO04wUklUj1Ng7mLauefBKFizzpGBwowNiwV004FrjEis0RYT48fXxb
         ietlYJiaArdOJVsrl7ZJZPtMRunYOPXAA1WH4HR1DacUvrNC/8fgAH18I3kcvd8KsqGh
         hmkBDvzWt4y5dB8Ry4DnWlUXq/oOVg2LoF/LTSb8CEwdUCtZyr9roYLPDyb8oC1Ko5vf
         W9hA==
X-Gm-Message-State: AOAM530UgweAYkMCa1624GPlLdcRKIXlaAXze7rYjZtFgo2qbwnwP4+y
        1RY4FltH0SA7E+fKdseyyBNAu8IF69Ja/g==
X-Google-Smtp-Source: ABdhPJyahhPKGQI9V4wIt3BeD3AWHWuyBXHzhGlMuwxN95ZpKY4Vz62RU2CJ1vXMM5iTv5qm5kULDA==
X-Received: by 2002:a17:907:7e8c:b0:6e8:92df:1656 with SMTP id qb12-20020a1709077e8c00b006e892df1656mr30370481ejc.386.1651089449246;
        Wed, 27 Apr 2022 12:57:29 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id t12-20020a1709067c0c00b006e86db76851sm7217728ejo.193.2022.04.27.12.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 12:57:28 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 41/45] media: sun6i-csi: Add extra checks to the interrupt routine
Date:   Wed, 27 Apr 2022 21:57:27 +0200
Message-ID: <2580640.X9hSmTKtgW@jernej-laptop>
In-Reply-To: <20220415152811.636419-42-paul.kocialkowski@bootlin.com>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com> <20220415152811.636419-42-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 15. april 2022 ob 17:28:07 CEST je Paul Kocialkowski napisal(a):
> Check against the enabled bits and make sure capture is running before
> serving an interrupt, to add extra safety in the process.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c index
> 43b6557b3207..3963a88a2e0b 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> @@ -105,13 +105,17 @@ static void sun6i_csi_v4l2_cleanup(struct
> sun6i_csi_device *csi_dev) static irqreturn_t sun6i_csi_interrupt(int irq,
> void *private)
>  {
>  	struct sun6i_csi_device *csi_dev = private;
> +	bool capture_streaming = csi_dev->capture.state.streaming;
>  	struct regmap *regmap = csi_dev->regmap;
> -	u32 status;
> +	u32 status = 0, enable = 0;
> 
>  	regmap_read(regmap, SUN6I_CSI_CH_INT_STA_REG, &status);
> +	regmap_read(regmap, SUN6I_CSI_CH_INT_EN_REG, &enable);
> 
> -	if (!(status & 0xFF))
> +	if (!status)
>  		return IRQ_NONE;
> +	else if (!(status & enable) || !capture_streaming)
> +		goto complete;
> 
>  	if ((status & SUN6I_CSI_CH_INT_STA_FIFO0_OF) ||
>  	    (status & SUN6I_CSI_CH_INT_STA_FIFO1_OF) ||
> @@ -132,6 +136,7 @@ static irqreturn_t sun6i_csi_interrupt(int irq, void
> *private) if (status & SUN6I_CSI_CH_INT_STA_VS)
>  		sun6i_csi_capture_sync(csi_dev);
> 
> +complete:
>  	regmap_write(regmap, SUN6I_CSI_CH_INT_STA_REG, status);
> 
>  	return IRQ_HANDLED;




