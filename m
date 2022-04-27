Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEB55122D6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiD0Tjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbiD0Tik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:38:40 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD9ABF7E;
        Wed, 27 Apr 2022 12:35:21 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bv19so5402284ejb.6;
        Wed, 27 Apr 2022 12:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c1hQv1E1lzP+Sj0MxqWdgoz4tkp5x1wNwVs+1dx8jM0=;
        b=RRoWG8f5L6uXcSI3/ocbx5lXwInd3Uw2HgO902cpXxh8k6eIqtYZ1H2qzfNOgMzGNY
         M//jirFdK05MSjzFtSWvgiTrBO9Pp8ApWEnI7isU/v7l9YiNDmsanevYXOCPL2N3cEdc
         h7/XPEYMszWm3k7IUPn+QYhd+OPP/oz1MxbxOmCwtS1zV1j1Tr12Bf/uBJPZ/6OzWjVS
         6yidGAddb2aZqZVXPUc+7rUmaQhbyQLQ7N6lGBTvUpMyiYtgJriS0rPxNWiWw3Up7ix9
         J9ezYgSQ+7qumkOGg4qtkUobRpt1hD+b83FAvyKBhO16TV7JyNlCVyB/Fr2cksZ6dvb+
         C36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c1hQv1E1lzP+Sj0MxqWdgoz4tkp5x1wNwVs+1dx8jM0=;
        b=p4zVqe+nKBaSBuSWgByYnWTghJGEx/GGiy7Pjs6sG495MRcxJtKDoAkBNEeq6IDl+O
         PyqggRopImhYbhc0jHveYJe7DSLQHpZWL/AdkYM/VGu2BXdn9HVPbTMHbRcrrNpZl/S5
         lVf+pt6vfzVdQHHe4iTjmcZ4YAypUNleznF0S33HYa5JG9jvEtvKSU5Z1XAXjb4sGpkw
         4I/lTxgDpFi8IC1uV4Tz3v93AW8fk84V0YIdPPyqWEMTohO4nb59by04ovwSvykOhLXZ
         cM7xMHtlcWGrbUptEmNqopC+4epBNra5OyQv98Wk2jhcQjo/iWFAQjCJztGhBMQeoSIP
         B3/Q==
X-Gm-Message-State: AOAM531wFYbAJKuRevEqkvRZu/MPHOT2E6mJYFmy5BUunpCKnp99IVGc
        u1AKEQEi5m+fryJ36UsiHX6OWF7o97QHrQ==
X-Google-Smtp-Source: ABdhPJwmPv6ZiRZMHwiNbeHtGKvok44OrPhhhgp0FRSYfzHW1L1FPgGl2hcZV4pCOIfDB/2Rql/N1g==
X-Received: by 2002:a17:906:4fcb:b0:6f3:b716:ee5d with SMTP id i11-20020a1709064fcb00b006f3b716ee5dmr8769572ejw.382.1651088120134;
        Wed, 27 Apr 2022 12:35:20 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id d19-20020a170906c21300b006e7f0730353sm7196594ejz.101.2022.04.27.12.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 12:35:19 -0700 (PDT)
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
Subject: Re: [PATCH v4 29/45] media: sun6i-csi: Tidy capture configure code
Date:   Wed, 27 Apr 2022 21:35:18 +0200
Message-ID: <3605808.MHq7AAxBmi@jernej-laptop>
In-Reply-To: <20220415152811.636419-30-paul.kocialkowski@bootlin.com>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com> <20220415152811.636419-30-paul.kocialkowski@bootlin.com>
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

Dne petek, 15. april 2022 ob 17:27:55 CEST je Paul Kocialkowski napisal(a):
> Some misc code cleanups and preparation for upcoming changes.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 105 ++++++++----------
>  1 file changed, 46 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c index
> e2070353f93f..9488c7c26f13 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> @@ -353,133 +353,120 @@ static enum csi_input_seq get_csi_input_seq(struct
> sun6i_csi_device *csi_dev, static void
>  sun6i_csi_capture_configure_interface(struct sun6i_csi_device *csi_dev)
>  {
> +	struct device *dev = csi_dev->dev;
> +	struct regmap *regmap = csi_dev->regmap;
>  	struct v4l2_fwnode_endpoint *endpoint =
>  		&csi_dev->bridge.source_parallel.endpoint;
> +	unsigned char bus_width = endpoint->bus.parallel.bus_width;
> +	unsigned int flags = endpoint->bus.parallel.flags;
>  	u32 pixelformat, field;
> -	unsigned char bus_width;
> -	u32 flags;
> -	u32 cfg = 0;
> -	bool input_interlaced = false;
> +	u32 value = SUN6I_CSI_IF_CFG_IF_CSI;
> 
>  	sun6i_csi_capture_format(csi_dev, &pixelformat, &field);
> 
>  	if (field == V4L2_FIELD_INTERLACED ||
>  	    field == V4L2_FIELD_INTERLACED_TB ||
>  	    field == V4L2_FIELD_INTERLACED_BT)
> -		input_interlaced = true;
> -
> -	bus_width = endpoint->bus.parallel.bus_width;
> -
> -	if (input_interlaced)
> -		cfg |= SUN6I_CSI_IF_CFG_SRC_TYPE_INTERLACED |
> -		       SUN6I_CSI_IF_CFG_FIELD_DT_PCLK_SHIFT(1) |
> -		       SUN6I_CSI_IF_CFG_FIELD_DT_FIELD_VSYNC;
> +		value |= SUN6I_CSI_IF_CFG_SRC_TYPE_INTERLACED |
> +			 SUN6I_CSI_IF_CFG_FIELD_DT_PCLK_SHIFT(1) |
> +			 SUN6I_CSI_IF_CFG_FIELD_DT_FIELD_VSYNC;
>  	else
> -		cfg |= SUN6I_CSI_IF_CFG_SRC_TYPE_PROGRESSIVE;
> +		value |= SUN6I_CSI_IF_CFG_SRC_TYPE_PROGRESSIVE;
> 
>  	switch (endpoint->bus_type) {
>  	case V4L2_MBUS_PARALLEL:
> -		cfg |= SUN6I_CSI_IF_CFG_IF_CSI;
> -
> -		flags = endpoint->bus.parallel.flags;
> -
>  		if (bus_width == 16)
> -			cfg |= SUN6I_CSI_IF_CFG_IF_CSI_YUV_COMBINED;
> +			value |= 
SUN6I_CSI_IF_CFG_IF_CSI_YUV_COMBINED;
>  		else
> -			cfg |= SUN6I_CSI_IF_CFG_IF_CSI_YUV_RAW;
> +			value |= SUN6I_CSI_IF_CFG_IF_CSI_YUV_RAW;
> 
>  		if (flags & V4L2_MBUS_FIELD_EVEN_LOW)
> -			cfg |= SUN6I_CSI_IF_CFG_FIELD_NEGATIVE;
> +			value |= SUN6I_CSI_IF_CFG_FIELD_NEGATIVE;
>  		else
> -			cfg |= SUN6I_CSI_IF_CFG_FIELD_POSITIVE;
> +			value |= SUN6I_CSI_IF_CFG_FIELD_POSITIVE;
> 
>  		if (flags & V4L2_MBUS_VSYNC_ACTIVE_LOW)
> -			cfg |= SUN6I_CSI_IF_CFG_VREF_POL_NEGATIVE;
> +			value |= SUN6I_CSI_IF_CFG_VREF_POL_NEGATIVE;
>  		else
> -			cfg |= SUN6I_CSI_IF_CFG_VREF_POL_POSITIVE;
> +			value |= SUN6I_CSI_IF_CFG_VREF_POL_POSITIVE;
> 
>  		if (flags & V4L2_MBUS_HSYNC_ACTIVE_LOW)
> -			cfg |= SUN6I_CSI_IF_CFG_HREF_POL_NEGATIVE;
> +			value |= SUN6I_CSI_IF_CFG_HREF_POL_NEGATIVE;
>  		else
> -			cfg |= SUN6I_CSI_IF_CFG_HREF_POL_POSITIVE;
> +			value |= SUN6I_CSI_IF_CFG_HREF_POL_POSITIVE;
> 
>  		if (flags & V4L2_MBUS_PCLK_SAMPLE_RISING)
> -			cfg |= SUN6I_CSI_IF_CFG_CLK_POL_RISING;
> +			value |= SUN6I_CSI_IF_CFG_CLK_POL_RISING;
>  		else
> -			cfg |= SUN6I_CSI_IF_CFG_CLK_POL_FALLING;
> +			value |= SUN6I_CSI_IF_CFG_CLK_POL_FALLING;
>  		break;
>  	case V4L2_MBUS_BT656:
> -		cfg |= SUN6I_CSI_IF_CFG_IF_CSI;
> -
> -		flags = endpoint->bus.parallel.flags;
> -
>  		if (bus_width == 16)
> -			cfg |= SUN6I_CSI_IF_CFG_IF_CSI_BT1120;
> +			value |= SUN6I_CSI_IF_CFG_IF_CSI_BT1120;
>  		else
> -			cfg |= SUN6I_CSI_IF_CFG_IF_CSI_BT656;
> +			value |= SUN6I_CSI_IF_CFG_IF_CSI_BT656;
> 
>  		if (flags & V4L2_MBUS_FIELD_EVEN_LOW)
> -			cfg |= SUN6I_CSI_IF_CFG_FIELD_NEGATIVE;
> +			value |= SUN6I_CSI_IF_CFG_FIELD_NEGATIVE;
>  		else
> -			cfg |= SUN6I_CSI_IF_CFG_FIELD_POSITIVE;
> +			value |= SUN6I_CSI_IF_CFG_FIELD_POSITIVE;
> 
>  		if (flags & V4L2_MBUS_PCLK_SAMPLE_FALLING)
> -			cfg |= SUN6I_CSI_IF_CFG_CLK_POL_RISING;
> +			value |= SUN6I_CSI_IF_CFG_CLK_POL_RISING;
>  		else
> -			cfg |= SUN6I_CSI_IF_CFG_CLK_POL_FALLING;
> +			value |= SUN6I_CSI_IF_CFG_CLK_POL_FALLING;
>  		break;
>  	default:
> -		dev_warn(csi_dev->dev, "Unsupported bus type: %d\n",
> -			 endpoint->bus_type);
> +		dev_warn(dev, "unsupported bus type: %d\n", endpoint-
>bus_type);
>  		break;
>  	}
> 
>  	switch (bus_width) {
>  	case 8:
> -		cfg |= SUN6I_CSI_IF_CFG_DATA_WIDTH_8;
> +	/* 16-bit YUV formats use a doubled width in 8-bit mode. */
> +	case 16:
> +		value |= SUN6I_CSI_IF_CFG_DATA_WIDTH_8;
>  		break;
>  	case 10:
> -		cfg |= SUN6I_CSI_IF_CFG_DATA_WIDTH_10;
> +		value |= SUN6I_CSI_IF_CFG_DATA_WIDTH_10;
>  		break;
>  	case 12:
> -		cfg |= SUN6I_CSI_IF_CFG_DATA_WIDTH_12;
> -		break;
> -	case 16: /* No need to configure DATA_WIDTH for 16bit */
> +		value |= SUN6I_CSI_IF_CFG_DATA_WIDTH_12;
>  		break;
>  	default:
> -		dev_warn(csi_dev->dev, "Unsupported bus width: %u\n", 
bus_width);
> +		dev_warn(dev, "unsupported bus width: %u\n", bus_width);
>  		break;
>  	}
> 
> -	regmap_write(csi_dev->regmap, SUN6I_CSI_IF_CFG_REG, cfg);
> +	regmap_write(regmap, SUN6I_CSI_IF_CFG_REG, value);
>  }
> 
>  static void sun6i_csi_capture_configure_format(struct sun6i_csi_device
> *csi_dev) {
> +	struct regmap *regmap = csi_dev->regmap;
>  	u32 mbus_code, pixelformat, field;
> -	u32 cfg = 0;
> -	u32 val;
> +	u8 input_format, input_yuv_seq, output_format;
> +	u32 value = 0;
> 
>  	sun6i_csi_capture_format(csi_dev, &pixelformat, &field);
>  	sun6i_csi_bridge_format(csi_dev, &mbus_code, NULL);
> 
> -	val = get_csi_input_format(csi_dev, mbus_code, pixelformat);
> -	cfg |= SUN6I_CSI_CH_CFG_INPUT_FMT(val);
> -
> -	val = get_csi_output_format(csi_dev, pixelformat, field);
> -	cfg |= SUN6I_CSI_CH_CFG_OUTPUT_FMT(val);
> +	input_format = get_csi_input_format(csi_dev, mbus_code, 
pixelformat);
> +	input_yuv_seq = get_csi_input_seq(csi_dev, mbus_code, pixelformat);
> +	output_format = get_csi_output_format(csi_dev, pixelformat, field);
> 
> -	val = get_csi_input_seq(csi_dev, mbus_code, pixelformat);
> -	cfg |= SUN6I_CSI_CH_CFG_INPUT_YUV_SEQ(val);
> +	value |= SUN6I_CSI_CH_CFG_OUTPUT_FMT(output_format);
> +	value |= SUN6I_CSI_CH_CFG_INPUT_FMT(input_format);
> +	value |= SUN6I_CSI_CH_CFG_INPUT_YUV_SEQ(input_yuv_seq);
> 
>  	if (field == V4L2_FIELD_TOP)
> -		cfg |= SUN6I_CSI_CH_CFG_FIELD_SEL_FIELD0;
> +		value |= SUN6I_CSI_CH_CFG_FIELD_SEL_FIELD0;
>  	else if (field == V4L2_FIELD_BOTTOM)
> -		cfg |= SUN6I_CSI_CH_CFG_FIELD_SEL_FIELD1;
> +		value |= SUN6I_CSI_CH_CFG_FIELD_SEL_FIELD1;
>  	else
> -		cfg |= SUN6I_CSI_CH_CFG_FIELD_SEL_EITHER;
> +		value |= SUN6I_CSI_CH_CFG_FIELD_SEL_EITHER;
> 
> -	regmap_write(csi_dev->regmap, SUN6I_CSI_CH_CFG_REG, cfg);
> +	regmap_write(regmap, SUN6I_CSI_CH_CFG_REG, value);
>  }
> 
>  static void sun6i_csi_capture_configure_window(struct sun6i_csi_device
> *csi_dev)




