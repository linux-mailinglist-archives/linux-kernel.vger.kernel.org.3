Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5F7512184
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiD0Su2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 14:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiD0SuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 14:50:03 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D18913A2C0;
        Wed, 27 Apr 2022 11:32:56 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id i27so5086982ejd.9;
        Wed, 27 Apr 2022 11:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1ykLgsZ2QlE1M7OwXCk5WzQH9ZVlust3l+kbAqWy/V0=;
        b=eazrrzFemQukZR+kzqWVGV9QkujKB62L2LH7gA7suk0eQH04G1Lb9QyMlUYPNi/M3Q
         QWBpyViQOe+Rdi4oaKO7Rk1bOWXXMllDhtR3NokDZWndrD6OVerGMkTIPEYPEG2jQfzJ
         qMKLMblIqHjVrOk93Hf+xh6WGnzCc6eyogEdf9W31QN0H7p/c6r+FcEOJQHp3EsDn8Sq
         jM2spyG0FqYQDHRkR53co9d9ZTCFMvvQ1Hm8oF654+xl5CjpVSg5mBLxKglYvgyAQRRE
         AQPV5em/r0rGvR7PXH6Id+Vs6YUKrIhGhU5W0KdnqKxt3nUoXCtMjc33Q3EJdev8MZt1
         pulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1ykLgsZ2QlE1M7OwXCk5WzQH9ZVlust3l+kbAqWy/V0=;
        b=IUetGjAoisTdM7+a+VK/LjaS7lmF90/h6QfwxuC5+n3WH5smKI/bvSgrydeoFIpnlp
         Mu2D2Q/LGuPfbwWJq90lcK2pz1KfQHQ5sZ0Vxrgcj3+WTi3VNbSdjd5BpJqVQKUCJbIo
         yDTVzZY3IJmZzKREGAjeeioz+9LLBRU1/N1yKKG6cF0pPJ3f37DHuTaalqxVYAZi540l
         V7nyMSL5/2F57wB8PLMoRQy7sm8L67F6RpnlbT8bqm78GWHQoVPxa10BcDziJSt0eIly
         lRQOxRSXR1p78Yy988RU2bB73U7Y0PJW0YhOB4B66jpJ2rVIOfHmBY929WjO5/j6KhLL
         tD0A==
X-Gm-Message-State: AOAM531pk0fuElyu4a7HKj69GlV+2Fnya1sSogWDmLfFxl8x1jnplski
        euQEPM38YEh84wgs14U2/mg/y8yJsUjsfw==
X-Google-Smtp-Source: ABdhPJxVXR6+zaLC+fJtfU/oZaqR14NMUWhuS5XKtR5VqDK78U8hcwb8xay7XMkmuAvdo4EsASj1+Q==
X-Received: by 2002:a17:906:4408:b0:6da:bec1:2808 with SMTP id x8-20020a170906440800b006dabec12808mr27582935ejo.543.1651084374856;
        Wed, 27 Apr 2022 11:32:54 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id c4-20020a170906170400b006e87c7b8ffasm7256447eje.32.2022.04.27.11.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:32:54 -0700 (PDT)
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
Subject: Re: [PATCH v4 07/45] media: sun6i-csi: Tidy up Kconfig
Date:   Wed, 27 Apr 2022 20:32:52 +0200
Message-ID: <5560019.DvuYhMxLoT@jernej-laptop>
In-Reply-To: <20220415152811.636419-8-paul.kocialkowski@bootlin.com>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com> <20220415152811.636419-8-paul.kocialkowski@bootlin.com>
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

Dne petek, 15. april 2022 ob 17:27:33 CEST je Paul Kocialkowski napisal(a):
> Update the option title and help, group related options together,
> add dependency on VIDEO_DEV since the driver uses it and update the
> description.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/media/platform/sunxi/sun6i-csi/Kconfig | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/Kconfig
> b/drivers/media/platform/sunxi/sun6i-csi/Kconfig index
> 965fbd937841..fe50f9bb8fd1 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/Kconfig
> +++ b/drivers/media/platform/sunxi/sun6i-csi/Kconfig
> @@ -1,13 +1,15 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config VIDEO_SUN6I_CSI
> -	tristate "Allwinner V3s Camera Sensor Interface driver"
> -	depends on V4L_PLATFORM_DRIVERS
> -	depends on VIDEO_DEV && COMMON_CLK  && HAS_DMA && PM
> +	tristate "Allwinner A31 Camera Sensor Interface (CSI) Driver"
> +	depends on V4L_PLATFORM_DRIVERS && VIDEO_DEV
>  	depends on ARCH_SUNXI || COMPILE_TEST
> +	depends on PM && COMMON_CLK && HAS_DMA
>  	select MEDIA_CONTROLLER
>  	select VIDEO_V4L2_SUBDEV_API
>  	select VIDEOBUF2_DMA_CONTIG
> -	select REGMAP_MMIO
>  	select V4L2_FWNODE
> +	select REGMAP_MMIO
>  	help
> -	   Support for the Allwinner Camera Sensor Interface Controller on 
V3s.
> +	   Support for the Allwinner A31 Camera Sensor Interface (CSI)
> +	   controller, also found on other platforms such as the A83T, H3,
> +	   V3/V3s or A64.




