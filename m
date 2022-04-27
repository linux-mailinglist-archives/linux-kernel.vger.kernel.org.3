Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AEA512323
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbiD0Tz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbiD0Tzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:55:45 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4848662BE9;
        Wed, 27 Apr 2022 12:52:25 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g23so3137919edy.13;
        Wed, 27 Apr 2022 12:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=raaDFFrcCGJx4BjUQiZ33LAZA2tAaSchP/oiKff0LFo=;
        b=mBfMA5ennm0eqStm8gsXmriVXxW6bwZMEHA7hyl/NXaLZq1WK5m6yJkjvDJODSsxgq
         pAfAMaLp1EVQyB9s4QmfA4WcL79NSsg+kdKMCckB4WvVAWMluH31XfCSajIiUw5P9y1D
         bDE+cmB5MA7PWHjCC/vbgnMqENdyPcd88QG3mWhsp/Gwb0w/8W36uDJhyqsp1AbYDUVV
         Lw9710jnygGjOB1+uCUa2if6kpJzV7uyef6n7RMU5JthrIk6iEWNm3Hil0ugbV8iLFZR
         STci1lTS/fkTwbh3jidkcT3B0EHvS7s0dqPZfRCe3b8zda+ZeXR68VF2gyVjWpU5c03u
         q4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=raaDFFrcCGJx4BjUQiZ33LAZA2tAaSchP/oiKff0LFo=;
        b=nx3Hc9XODwGzuuHveYXdR2+WCLDszZ9PMYyN2O6YZXQBPf3EmHHSo8jdFcMhXornLt
         Isz3ODooLHT4jReLsSIXpEyT+wu5WmEPsgXWa4uRALGFr68C1xDIp3RsI7k/YZh3QTs8
         Pu/5Bgbl1T4+0qmjggmLio6PaDY3gW3LPdXevcKxjqruRkUXzYavmYLpCtGt4ulS9dvk
         Ah2tFu8RpLwiK9cOiCjo5h9naCTuJsMrR34/xhJNGFh+F5MPkaYs7pXztiRmpPTWzaWc
         ruSikYlxtyIUPw91z4VP2tJfmyMbdIPLrluu1LCy2Op3ywJg5J4k/pPEc3RUBwrsCPq2
         T+/g==
X-Gm-Message-State: AOAM530UYpDKyz48pek09wHnzepMQEd2dmxEFa4LPicsuHiy9NAsvrs/
        fv6uz7BpNcv3zUr7t4EGVG80Qrz/+S1OJQ==
X-Google-Smtp-Source: ABdhPJyaHhiQPHbBDsazEv+z+wxrmRg4LeZEEozM4E20LE6khcKaC6GdZk4/CDLHVNc/o6EsUE9iBw==
X-Received: by 2002:a05:6402:d2:b0:413:2e50:d6fd with SMTP id i18-20020a05640200d200b004132e50d6fdmr32263726edu.171.1651089143874;
        Wed, 27 Apr 2022 12:52:23 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id r2-20020aa7c142000000b0042617ba63c5sm109134edp.79.2022.04.27.12.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 12:52:23 -0700 (PDT)
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
Subject: Re: [PATCH v4 38/45] media: sun6i-csi: Cleanup headers and includes, update copyright lines
Date:   Wed, 27 Apr 2022 21:52:22 +0200
Message-ID: <2576615.BddDVKsqQX@jernej-laptop>
In-Reply-To: <20220415152811.636419-39-paul.kocialkowski@bootlin.com>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com> <20220415152811.636419-39-paul.kocialkowski@bootlin.com>
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

Dne petek, 15. april 2022 ob 17:28:04 CEST je Paul Kocialkowski napisal(a):
> Cleanup includes, update copyright lines and some cosmetic changes.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 16 ++++++--------
>  .../platform/sunxi/sun6i-csi/sun6i_csi.h      | 10 ++++-----
>  .../sunxi/sun6i-csi/sun6i_csi_capture.c       |  4 ++--
>  .../sunxi/sun6i-csi/sun6i_csi_capture.h       | 22 ++++++++++++++-----
>  .../platform/sunxi/sun6i-csi/sun6i_csi_reg.h  |  9 ++++----
>  5 files changed, 35 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c index
> 0ae10a11373c..43b6557b3207 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> @@ -1,18 +1,14 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Copyright (c) 2011-2018 Magewell Electronics Co., Ltd. (Nanjing)
> - * All rights reserved.
>   * Author: Yong Deng <yong.deng@magewell.com>
> + * Copyright 2021-2022 Bootlin
> + * Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>   */
> 
>  #include <linux/clk.h>
> -#include <linux/delay.h>
> -#include <linux/dma-mapping.h>
>  #include <linux/err.h>
> -#include <linux/fs.h>
>  #include <linux/interrupt.h>
> -#include <linux/io.h>
> -#include <linux/ioctl.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> @@ -20,12 +16,13 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/reset.h>
> -#include <linux/sched.h>
> -#include <linux/sizes.h>
> -#include <linux/slab.h>
> +#include <media/v4l2-ctrls.h>
> +#include <media/v4l2-device.h>
>  #include <media/v4l2-mc.h>
> 
>  #include "sun6i_csi.h"
> +#include "sun6i_csi_bridge.h"
> +#include "sun6i_csi_capture.h"
>  #include "sun6i_csi_reg.h"
> 
>  /* Media */
> @@ -390,4 +387,5 @@ module_platform_driver(sun6i_csi_platform_driver);
> 
>  MODULE_DESCRIPTION("Allwinner A31 Camera Sensor Interface driver");
>  MODULE_AUTHOR("Yong Deng <yong.deng@magewell.com>");
> +MODULE_AUTHOR("Paul Kocialkowski <paul.kocialkowski@bootlin.com>");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h index
> 68611c147996..1aeaef84abba 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> @@ -1,16 +1,16 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
>  /*
>   * Copyright (c) 2011-2018 Magewell Electronics Co., Ltd. (Nanjing)
> - * All rights reserved.
>   * Author: Yong Deng <yong.deng@magewell.com>
> + * Copyright 2021-2022 Bootlin
> + * Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>   */
> 
> -#ifndef __SUN6I_CSI_H__
> -#define __SUN6I_CSI_H__
> +#ifndef _SUN6I_CSI_H_
> +#define _SUN6I_CSI_H_
> 
>  #include <media/v4l2-ctrls.h>
>  #include <media/v4l2-device.h>
> -#include <media/v4l2-fwnode.h>
>  #include <media/videobuf2-v4l2.h>
> 
>  #include "sun6i_csi_bridge.h"
> @@ -51,4 +51,4 @@ struct sun6i_csi_variant {
>  	unsigned long	clock_mod_rate;
>  };
> 
> -#endif /* __SUN6I_CSI_H__ */
> +#endif
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c index
> c3b1e1411da4..f1581b877819 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> @@ -1,13 +1,13 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Copyright (c) 2011-2018 Magewell Electronics Co., Ltd. (Nanjing)
> - * All rights reserved.
>   * Author: Yong Deng <yong.deng@magewell.com>
> + * Copyright 2021-2022 Bootlin
> + * Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>   */
> 
>  #include <linux/of.h>
>  #include <linux/regmap.h>
> -
>  #include <media/v4l2-device.h>
>  #include <media/v4l2-event.h>
>  #include <media/v4l2-ioctl.h>
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h index
> 59c57bcefeec..ceceb030aef6 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
> @@ -1,15 +1,15 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
>  /*
>   * Copyright (c) 2011-2018 Magewell Electronics Co., Ltd. (Nanjing)
> - * All rights reserved.
>   * Author: Yong Deng <yong.deng@magewell.com>
> + * Copyright 2021-2022 Bootlin
> + * Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>   */
> 
> -#ifndef __SUN6I_CAPTURE_H__
> -#define __SUN6I_CAPTURE_H__
> +#ifndef _SUN6I_CAPTURE_H_
> +#define _SUN6I_CAPTURE_H_
> 
> -#include <media/v4l2-dev.h>
> -#include <media/videobuf2-core.h>
> +#include <media/v4l2-device.h>
> 
>  #define SUN6I_CSI_CAPTURE_NAME	"sun6i-csi-capture"
> 
> @@ -57,21 +57,31 @@ struct sun6i_csi_capture {
>  	struct v4l2_format		format;
>  };
> 
> +/* Helpers */
> +
>  void sun6i_csi_capture_dimensions(struct sun6i_csi_device *csi_dev,
>  				  unsigned int *width, unsigned 
int *height);
>  void sun6i_csi_capture_format(struct sun6i_csi_device *csi_dev,
>  			      u32 *pixelformat, u32 *field);
> 
> +/* Format */
> +
>  const
>  struct sun6i_csi_capture_format *sun6i_csi_capture_format_find(u32
> pixelformat);
> 
> +/* Capture */
> +
>  void sun6i_csi_capture_configure(struct sun6i_csi_device *csi_dev);
>  void sun6i_csi_capture_state_update(struct sun6i_csi_device *csi_dev);
> 
> +/* State */
> +
>  void sun6i_csi_capture_sync(struct sun6i_csi_device *csi_dev);
>  void sun6i_csi_capture_frame_done(struct sun6i_csi_device *csi_dev);
> 
> +/* Capture */
> +
>  int sun6i_csi_capture_setup(struct sun6i_csi_device *csi_dev);
>  void sun6i_csi_capture_cleanup(struct sun6i_csi_device *csi_dev);
> 
> -#endif /* __SUN6I_CAPTURE_H__ */
> +#endif
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_reg.h
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_reg.h index
> 1e4a07f26d1d..e01c5b9c2d60 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_reg.h
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_reg.h
> @@ -1,12 +1,13 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
>  /*
>   * Copyright (c) 2011-2018 Magewell Electronics Co., Ltd. (Nanjing)
> - * All rights reserved.
>   * Author: Yong Deng <yong.deng@magewell.com>
> + * Copyright 2021-2022 Bootlin
> + * Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>   */
> 
> -#ifndef __SUN6I_CSI_REG_H__
> -#define __SUN6I_CSI_REG_H__
> +#ifndef _SUN6I_CSI_REG_H_
> +#define _SUN6I_CSI_REG_H_
> 
>  #include <linux/kernel.h>
> 
> @@ -180,4 +181,4 @@
>  #define SUN6I_CSI_CH_FIFO_STAT_REG		0x98
>  #define SUN6I_CSI_CH_PCLK_STAT_REG		0x9c
> 
> -#endif /* __SUN6I_CSI_REG_H__ */
> +#endif




