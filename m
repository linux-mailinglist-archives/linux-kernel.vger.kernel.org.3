Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE53E4DA37D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346018AbiCOTwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbiCOTwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:52:40 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8631275C;
        Tue, 15 Mar 2022 12:51:28 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id d10so43826334eje.10;
        Tue, 15 Mar 2022 12:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c4mW0RIi6ae0ro8RnphpYWbFSmPVIVZ/Yq/iQ15Ckcc=;
        b=VkovmwjNTFIcCmhapNNDEz0ANIJtO1Eo5FmGf1ZyJKNtWOiVrrHj45CObw+UwQSV4e
         wJeQfjsGyrHMPS+WUN2mHLED6ydXQsFVwKIo8O5k6PjN/M8OONaxc6/WrTwplNxlLGNt
         sru4h639itvUkezFz+Lgu9hOsiV+gkhfdPZUoLyPnNQwMki3e1wcteL4BhebPdQExLYr
         KgCWH8kcA+t6q6AsBvADshjq6otkargoJsCXmJAeGXpCzf4n58Qbt8lzFhrgSq8STi1o
         lHrmIE7G67hZvJzXPvmTbzDhZ6PYnG9b2tmYqUC0yC/jP2HwdIIRYNgHq1YJ6YfRM91a
         S+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c4mW0RIi6ae0ro8RnphpYWbFSmPVIVZ/Yq/iQ15Ckcc=;
        b=IXI+AzuA8e3kc0xVu75g7RvBqqBH+m2yw7amw32bZZ+21kR1itQuWcaMc3TOybGWYz
         gHtcKMElve09b/9E1Utkce1mRs4RaWXbeAHcsTT0dGTGiQk1O5N46q2d7W3GfeK+gmWz
         iEDBaVwEvoDpmtYTFAlr8/PeLonsM9I3MU8xyPbJJFkbLPGhqOHSfCcXHZLfbuqKg5iK
         pXJpEJhPntkXHMa1sXNvASAINNKIn2r3DK3EIe6X2qbmLrcRyKaigdGsyoll2gTQn2tK
         pEP8gonuGLwQ7F/TiQJm55FeTT1nhrkJgBcSLhOGaLBkpMtf2KzX4Q8IZiWGBZsLgBlr
         3oMg==
X-Gm-Message-State: AOAM532r2+K86w9ThlC6xNaGJzPiejBpEvi4wQslFAhok4LGqCzqZSvU
        ioMz+usqOa+IQgZ+PVEPVvwfBYbCFW/Zlw==
X-Google-Smtp-Source: ABdhPJwxOJVNfqcyOw+90b/wsi8sy2CbO7R38IKLMwGLeMuVFc+KW08b442TMAY+dr+jgagXCOtN2A==
X-Received: by 2002:a17:906:53c7:b0:6ce:6f32:ce53 with SMTP id p7-20020a17090653c700b006ce6f32ce53mr24232089ejo.352.1647373886996;
        Tue, 15 Mar 2022 12:51:26 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id w6-20020a170906d20600b006ca00cb99e0sm6019ejz.34.2022.03.15.12.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 12:51:26 -0700 (PDT)
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
Subject: Re: [PATCH v3 08/46] media: sun6i-csi: Tidy up Kconfig
Date:   Tue, 15 Mar 2022 20:51:25 +0100
Message-ID: <1737020.TLkxdtWsSY@kista>
In-Reply-To: <20220311143532.265091-9-paul.kocialkowski@bootlin.com>
References: <20220311143532.265091-1-paul.kocialkowski@bootlin.com> <20220311143532.265091-9-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 11. marec 2022 ob 15:34:54 CET je Paul Kocialkowski napisal(a):
> Update the option title and help, group related options together,
> add dependency on VIDEO_DEV since the driver uses it.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/media/platform/sunxi/sun6i-csi/Kconfig | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/Kconfig b/drivers/media/
platform/sunxi/sun6i-csi/Kconfig
> index fd03e48f0c8a..a88978eba455 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/Kconfig
> +++ b/drivers/media/platform/sunxi/sun6i-csi/Kconfig
> @@ -1,12 +1,13 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config VIDEO_SUN6I_CSI
> -	tristate "Allwinner V3s Camera Sensor Interface driver"
> -	depends on PM && VIDEO_V4L2 && COMMON_CLK  && HAS_DMA
> +	tristate "Allwinner A31 Camera Sensor Interface (CSI) Driver"
>  	depends on ARCH_SUNXI || COMPILE_TEST
> +	depends on PM && COMMON_CLK && HAS_DMA
> +	depends on VIDEO_DEV && VIDEO_V4L2
> +	select REGMAP_MMIO
>  	select MEDIA_CONTROLLER
>  	select VIDEO_V4L2_SUBDEV_API
>  	select VIDEOBUF2_DMA_CONTIG
> -	select REGMAP_MMIO
>  	select V4L2_FWNODE
>  	help
> -	   Support for the Allwinner Camera Sensor Interface Controller on 
V3s.
> +	   Support for the Allwinner A31 Camera Sensor Interface (CSI) 
controller.

While at it, it would be nice to somehow indicate that it's compatible with 
more than one SoC.

Best regards,
Jernej

> -- 
> 2.35.1
> 
> 


