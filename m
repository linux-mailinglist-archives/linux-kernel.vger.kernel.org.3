Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC4E5122C8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbiD0Te3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbiD0TeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:34:06 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E901261C;
        Wed, 27 Apr 2022 12:30:51 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id a1so3113116edt.3;
        Wed, 27 Apr 2022 12:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=piMSvjwkeZ0nhfn9L0hEiy466navA71gRsgoGJRVmX8=;
        b=gvqMViz1jFk1SBFg27Ndd81xhaWDy6a5g4oiitZHCp+deLsjF/WBhs1c0jZW9tycJz
         XMlRZKbyc5WxR0YNtgus02Xq6UJ6/Y1qcMIB1FOv+vFdDCNL/nq80Xbk+zjWSC804hRw
         6Oishuu5CWRXU/ditXpeufNYF/n0n3Xy9a6BL/IfEMZNER6KYjzQFM+yg52pZE+4kOof
         j3mWpe+4zKKfqwh+P6IAgjbQ4No+Gfva3KgYRGbxQHbR/mhnNey7fDHKns4QNRGJST8C
         +kOnogvP7LKjGYJLZHLU65wz5myGluRntWljj9HW4yOpZAApfrKFmWKwRUVJ0yXTKsrN
         c8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=piMSvjwkeZ0nhfn9L0hEiy466navA71gRsgoGJRVmX8=;
        b=0Ob6/hPhRsY+/EsdIEta1B+IbkH1QjonF+W1+vw5cHSfZnNVGZNbhOM5Rt64T40o35
         sB0yUbI1EgK6DK1VSPTP007umEgwGHs/OvG187JMOR2He8AzL9ol2h5BO4JoM5M+DcNP
         1PPgtMnrZ6aGecA2ZmGjZgOglTS2kLHp1j6FFMRvHpzbXlL/asY1AHaLusoUGDEj9nQK
         t6XWVwAD+pbYUETtjQytXERP1MLYb4b2etQNOP/y06xVUMPEHzhkzFjS4TnqkWH2TrW3
         WJ8oGr+DSohqnCZeFKDYNgPFPIzGfHqnyrwEQLXUNHShw4SIUP7aBpaN0jh9BFEE+uDm
         irXA==
X-Gm-Message-State: AOAM533MVgop/1u6UnXmJHVCL9KpYox5K3erGytbaG8Ot9zGG/ZhruPW
        8FVikN0gt80pQB06Tt7f2pFGB4+k59EX4Q==
X-Google-Smtp-Source: ABdhPJxuZ1R1o4WDg8MNMs2EldDJiORw1uR54FBa1ILTCASJzOzteyrRkwrVnKarThxPWeqwJPs26g==
X-Received: by 2002:a05:6402:ca9:b0:425:ff4d:f6fd with SMTP id cn9-20020a0564020ca900b00425ff4df6fdmr9740737edb.405.1651087849664;
        Wed, 27 Apr 2022 12:30:49 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id g12-20020a170906c18c00b006f3b99d29e0sm2835262ejz.223.2022.04.27.12.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 12:30:49 -0700 (PDT)
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
Subject: Re: [PATCH v4 26/45] media: sun6i-csi: Remove custom format helper and rework configure
Date:   Wed, 27 Apr 2022 21:30:48 +0200
Message-ID: <1817191.CQOukoFCf9@jernej-laptop>
In-Reply-To: <20220415152811.636419-27-paul.kocialkowski@bootlin.com>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com> <20220415152811.636419-27-paul.kocialkowski@bootlin.com>
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

Dne petek, 15. april 2022 ob 17:27:52 CEST je Paul Kocialkowski napisal(a):
> Remove the custom sun6i_csi_get_bpp helper in favor of common v4l2
> infrastructure and rework the related window configuration code.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  .../platform/sunxi/sun6i-csi/sun6i_csi.h      | 49 -------------
>  .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 70 +++++++++----------
>  2 files changed, 35 insertions(+), 84 deletions(-)
> 
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h index
> f54ad2f438f8..dd90ffdae5d5 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> @@ -60,53 +60,4 @@ struct sun6i_csi_variant {
>  bool sun6i_csi_is_format_supported(struct sun6i_csi_device *csi_dev,
>  				   u32 pixformat, u32 mbus_code);
> 
> -/* get bpp form v4l2 pixformat */
> -static inline int sun6i_csi_get_bpp(unsigned int pixformat)
> -{
> -	switch (pixformat) {
> -	case V4L2_PIX_FMT_SBGGR8:
> -	case V4L2_PIX_FMT_SGBRG8:
> -	case V4L2_PIX_FMT_SGRBG8:
> -	case V4L2_PIX_FMT_SRGGB8:
> -	case V4L2_PIX_FMT_JPEG:
> -		return 8;
> -	case V4L2_PIX_FMT_SBGGR10:
> -	case V4L2_PIX_FMT_SGBRG10:
> -	case V4L2_PIX_FMT_SGRBG10:
> -	case V4L2_PIX_FMT_SRGGB10:
> -		return 10;
> -	case V4L2_PIX_FMT_SBGGR12:
> -	case V4L2_PIX_FMT_SGBRG12:
> -	case V4L2_PIX_FMT_SGRBG12:
> -	case V4L2_PIX_FMT_SRGGB12:
> -	case V4L2_PIX_FMT_NV12_16L16:
> -	case V4L2_PIX_FMT_NV12:
> -	case V4L2_PIX_FMT_NV21:
> -	case V4L2_PIX_FMT_YUV420:
> -	case V4L2_PIX_FMT_YVU420:
> -		return 12;
> -	case V4L2_PIX_FMT_YUYV:
> -	case V4L2_PIX_FMT_YVYU:
> -	case V4L2_PIX_FMT_UYVY:
> -	case V4L2_PIX_FMT_VYUY:
> -	case V4L2_PIX_FMT_NV16:
> -	case V4L2_PIX_FMT_NV61:
> -	case V4L2_PIX_FMT_YUV422P:
> -	case V4L2_PIX_FMT_RGB565:
> -	case V4L2_PIX_FMT_RGB565X:
> -		return 16;
> -	case V4L2_PIX_FMT_RGB24:
> -	case V4L2_PIX_FMT_BGR24:
> -		return 24;
> -	case V4L2_PIX_FMT_RGB32:
> -	case V4L2_PIX_FMT_BGR32:
> -		return 32;
> -	default:
> -		WARN(1, "Unsupported pixformat: 0x%x\n", pixformat);
> -		break;
> -	}
> -
> -	return 0;
> -}
> -
>  #endif /* __SUN6I_CSI_H__ */
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c index
> 2aa65a4ddb85..c4e803a38851 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> @@ -483,68 +483,68 @@ static void sun6i_csi_capture_configure_format(struct
> sun6i_csi_device *csi_dev)
> 
>  static void sun6i_csi_capture_configure_window(struct sun6i_csi_device
> *csi_dev) {
> +	struct regmap *regmap = csi_dev->regmap;
> +	const struct v4l2_format_info *info;
> +	u32 hsize_len, vsize_len;
> +	u32 luma_line, chroma_line = 0;
>  	u32 pixelformat, field;
>  	u32 width, height;
> -	u32 bytesperline_y;
> -	u32 bytesperline_c;
> -	u32 hor_len;
> 
>  	sun6i_csi_capture_dimensions(csi_dev, &width, &height);
>  	sun6i_csi_capture_format(csi_dev, &pixelformat, &field);
> 
> -	hor_len = width;
> +	hsize_len = width;
> +	vsize_len = height;
> 
>  	switch (pixelformat) {
>  	case V4L2_PIX_FMT_YUYV:
>  	case V4L2_PIX_FMT_YVYU:
>  	case V4L2_PIX_FMT_UYVY:
>  	case V4L2_PIX_FMT_VYUY:
> -		dev_dbg(csi_dev->dev,
> -			"Horizontal length should be 2 times of 
width for packed YUV
> formats!\n"); -		hor_len = width * 2;
> +		/*
> +		 * Horizontal length should be 2 times of width for 
packed
> +		 * YUV formats.
> +		 */
> +		hsize_len *= 2;
>  		break;
>  	default:
>  		break;
>  	}
> 
> -	regmap_write(csi_dev->regmap, SUN6I_CSI_CH_HSIZE_REG,
> -		     SUN6I_CSI_CH_HSIZE_LEN(hor_len) |
> +	regmap_write(regmap, SUN6I_CSI_CH_HSIZE_REG,
> +		     SUN6I_CSI_CH_HSIZE_LEN(hsize_len) |
>  		     SUN6I_CSI_CH_HSIZE_START(0));
> -	regmap_write(csi_dev->regmap, SUN6I_CSI_CH_VSIZE_REG,
> -		     SUN6I_CSI_CH_VSIZE_LEN(height) |
> +
> +	regmap_write(regmap, SUN6I_CSI_CH_VSIZE_REG,
> +		     SUN6I_CSI_CH_VSIZE_LEN(vsize_len) |
>  		     SUN6I_CSI_CH_VSIZE_START(0));
> 
>  	switch (pixelformat) {
> -	case V4L2_PIX_FMT_NV12_16L16:
> -	case V4L2_PIX_FMT_NV12:
> -	case V4L2_PIX_FMT_NV21:
> -	case V4L2_PIX_FMT_NV16:
> -	case V4L2_PIX_FMT_NV61:
> -		bytesperline_y = width;
> -		bytesperline_c = width;
> +	case V4L2_PIX_FMT_RGB565X:
> +		luma_line = width * 2;
>  		break;
> -	case V4L2_PIX_FMT_YUV420:
> -	case V4L2_PIX_FMT_YVU420:
> -		bytesperline_y = width;
> -		bytesperline_c = width / 2;
> +	case V4L2_PIX_FMT_NV12_16L16:
> +		luma_line = width;
> +		chroma_line = width;
>  		break;
> -	case V4L2_PIX_FMT_YUV422P:
> -		bytesperline_y = width;
> -		bytesperline_c = width / 2;
> +	case V4L2_PIX_FMT_JPEG:
> +		luma_line = width;
>  		break;
> -	default: /* raw */
> -		dev_dbg(csi_dev->dev,
> -			"Calculating pixelformat(0x%x)'s 
bytesperline as a packed format\n",
> -			pixelformat);
> -		bytesperline_y = (sun6i_csi_get_bpp(pixelformat) *
> -				  width) / 8;
> -		bytesperline_c = 0;
> +	default:
> +		info = v4l2_format_info(pixelformat);
> +		if (WARN_ON(!info))
> +			return;
> +
> +		luma_line = width * info->bpp[0];
> +
> +		if (info->comp_planes > 1)
> +			chroma_line = width * info->bpp[1] / info-
>hdiv;
>  		break;
>  	}
> 
> -	regmap_write(csi_dev->regmap, SUN6I_CSI_CH_BUF_LEN_REG,
> -		     SUN6I_CSI_CH_BUF_LEN_CHROMA_LINE(bytesperline_c) |
> -		     SUN6I_CSI_CH_BUF_LEN_LUMA_LINE(bytesperline_y));
> +	regmap_write(regmap, SUN6I_CSI_CH_BUF_LEN_REG,
> +		     SUN6I_CSI_CH_BUF_LEN_CHROMA_LINE(chroma_line) |
> +		     SUN6I_CSI_CH_BUF_LEN_LUMA_LINE(luma_line));
>  }
> 
>  static void sun6i_csi_capture_configure(struct sun6i_csi_device *csi_dev)




