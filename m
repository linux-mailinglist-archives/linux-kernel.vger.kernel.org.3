Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C30512326
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbiD0T50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234734AbiD0T5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:57:23 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3934E6F9F8;
        Wed, 27 Apr 2022 12:54:10 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r13so5493650ejd.5;
        Wed, 27 Apr 2022 12:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wcy/yHzsTgQ28Wq5AenKD6lTaaPcG2J9+67ZI1nrh40=;
        b=g5Ex7jHfsDmdL14aRE4w2MGOkO+9ZJ1v9eEPQxjTl/pylYazCi9sW+cRG94GWIALtv
         XsyUfm/i3DYQAo5w+aiBFUF5DRp7Z9rEL087sWd4O8QKdhfmzpa+TG+dhqR5ze+MlWL2
         KeJz0z9PhXut/sO1vcWGEVbY9SW58+3se/yIDT0TOI85VsUp4vBwzbrDZADoYjDwnzqU
         NxjcAPO1F+cvrdqFnBu7yOPwqOKqbl0nJ6Nj0haW2lvyF2rMdYffnNinuwfgSf0KAHGZ
         bFocbsAj8K14+i8QTu++XCkJmsbWF+M6b5/ygTOpzmZzuUG6Pug0r7CpcCNhK2UWUH5u
         CXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wcy/yHzsTgQ28Wq5AenKD6lTaaPcG2J9+67ZI1nrh40=;
        b=OeKVCLZ4433WWhBqmjic3frRFYdwkvly2BWx0XPEZ2UbMkF/Pdgm3pXC9jSdCsVgl1
         wUAk8pNeWGwbDyCP+J/cIN5WUqFFtUPzC3T+y3kOiU+3As+ZLRh7aLEQSbJumUPluBh3
         lM0Va2oJMYCRbGd/09qwRL/A3M7tdlzwwee3wHg+3ca1EU/8oOScAXzW872vo5L2DLVR
         KtbsJsHe2KiqiNiJqM88kq7JaNoPpNPvOT3iI8aUspXwdLP25ZGPQfN74MwVyzw1VWDc
         7rnVj9dLXZ8U+e6QXSQruopPpA9easJQQmytJf1IGntcKHvzwn2UDrq5ANZQn06GorlG
         Sq6g==
X-Gm-Message-State: AOAM533ndzBKd5I4qfhPzz8Gg5RXi4gbw2H9Mo8atNUhXqVth1IyefUK
        CC+v8KoRJ8lP9gB1gxl4AkgwFl2l7a0jYQ==
X-Google-Smtp-Source: ABdhPJwwBqiertU6+0kXkNFEFcXH+3N/DokNjpIGwaiyxbu4o439QT/7JwN4XodQNQiW6Dvkxzuf1g==
X-Received: by 2002:a17:906:478d:b0:6e8:8ee0:1f9f with SMTP id cw13-20020a170906478d00b006e88ee01f9fmr28106026ejc.296.1651089248702;
        Wed, 27 Apr 2022 12:54:08 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id t12-20020a1709067c0c00b006e86db76851sm7214275ejo.193.2022.04.27.12.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 12:54:08 -0700 (PDT)
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
Subject: Re: [PATCH v4 39/45] media: sun6i-csi: Add support for MIPI CSI-2 to the bridge code
Date:   Wed, 27 Apr 2022 21:54:07 +0200
Message-ID: <8974124.rMLUfLXkoz@jernej-laptop>
In-Reply-To: <20220415152811.636419-40-paul.kocialkowski@bootlin.com>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com> <20220415152811.636419-40-paul.kocialkowski@bootlin.com>
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

Dne petek, 15. april 2022 ob 17:28:05 CEST je Paul Kocialkowski napisal(a):
> Introduce MIPI CSI-2 support to the bridge with a new port, source
> and hardware configuration helper.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  .../platform/sunxi/sun6i-csi/sun6i_csi.h      |  1 +
>  .../sunxi/sun6i-csi/sun6i_csi_bridge.c        | 46 +++++++++++++++++--
>  .../sunxi/sun6i-csi/sun6i_csi_bridge.h        |  1 +
>  3 files changed, 44 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h index
> 1aeaef84abba..6aa83dd11684 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> @@ -21,6 +21,7 @@
> 
>  enum sun6i_csi_port {
>  	SUN6I_CSI_PORT_PARALLEL		= 0,
> +	SUN6I_CSI_PORT_MIPI_CSI2	= 1,
>  };
> 
>  struct sun6i_csi_buffer {
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c index
> ec3e04353106..27289d904d5c 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c
> @@ -226,7 +226,7 @@ static void sun6i_csi_bridge_disable(struct
> sun6i_csi_device *csi_dev) }
> 
>  static void
> -sun6i_csi_bridge_configure_interface(struct sun6i_csi_device *csi_dev)
> +sun6i_csi_bridge_configure_parallel(struct sun6i_csi_device *csi_dev)
>  {
>  	struct device *dev = csi_dev->dev;
>  	struct regmap *regmap = csi_dev->regmap;
> @@ -316,6 +316,25 @@ sun6i_csi_bridge_configure_interface(struct
> sun6i_csi_device *csi_dev) regmap_write(regmap, SUN6I_CSI_IF_CFG_REG,
> value);
>  }
> 
> +static void
> +sun6i_csi_bridge_configure_mipi_csi2(struct sun6i_csi_device *csi_dev)
> +{
> +	struct regmap *regmap = csi_dev->regmap;
> +	u32 value = SUN6I_CSI_IF_CFG_IF_MIPI;
> +	u32 field;
> +
> +	sun6i_csi_bridge_format(csi_dev, NULL, &field);
> +
> +	if (field == V4L2_FIELD_INTERLACED ||
> +	    field == V4L2_FIELD_INTERLACED_TB ||
> +	    field == V4L2_FIELD_INTERLACED_BT)
> +		value |= SUN6I_CSI_IF_CFG_SRC_TYPE_INTERLACED;
> +	else
> +		value |= SUN6I_CSI_IF_CFG_SRC_TYPE_PROGRESSIVE;
> +
> +	regmap_write(regmap, SUN6I_CSI_IF_CFG_REG, value);
> +}
> +
>  static void sun6i_csi_bridge_configure_format(struct sun6i_csi_device
> *csi_dev) {
>  	struct regmap *regmap = csi_dev->regmap;
> @@ -367,9 +386,16 @@ static void sun6i_csi_bridge_configure_format(struct
> sun6i_csi_device *csi_dev) regmap_write(regmap, SUN6I_CSI_CH_CFG_REG,
> value);
>  }
> 
> -static void sun6i_csi_bridge_configure(struct sun6i_csi_device *csi_dev)
> +static void sun6i_csi_bridge_configure(struct sun6i_csi_device *csi_dev,
> +				       struct 
sun6i_csi_bridge_source *source)
>  {
> -	sun6i_csi_bridge_configure_interface(csi_dev);
> +	struct sun6i_csi_bridge *bridge = &csi_dev->bridge;
> +
> +	if (source == &bridge->source_parallel)
> +		sun6i_csi_bridge_configure_parallel(csi_dev);
> +	else
> +		sun6i_csi_bridge_configure_mipi_csi2(csi_dev);
> +
>  	sun6i_csi_bridge_configure_format(csi_dev);
>  }
> 
> @@ -381,6 +407,7 @@ static int sun6i_csi_bridge_s_stream(struct v4l2_subdev
> *subdev, int on) struct sun6i_csi_bridge *bridge = &csi_dev->bridge;
>  	struct media_entity *bridge_entity = &bridge->subdev.entity;
>  	struct device *dev = csi_dev->dev;
> +	struct sun6i_csi_bridge_source *source;
>  	struct v4l2_subdev *source_subdev;
>  	struct media_link *link;
>  	/* Initialize to 0 to use both in disable label (ret != 0) and off. 
*/
> @@ -398,6 +425,11 @@ static int sun6i_csi_bridge_s_stream(struct v4l2_subdev
> *subdev, int on)
> 
>  	source_subdev = media_entity_to_v4l2_subdev(link->source->entity);
> 
> +	if (source_subdev == bridge->source_parallel.subdev)
> +		source = &bridge->source_parallel;
> +	else
> +		source = &bridge->source_mipi_csi2;
> +
>  	if (!on) {
>  		v4l2_subdev_call(source_subdev, video, s_stream, 0);
>  		goto disable;
> @@ -415,7 +447,7 @@ static int sun6i_csi_bridge_s_stream(struct v4l2_subdev
> *subdev, int on)
> 
>  	/* Configure */
> 
> -	sun6i_csi_bridge_configure(csi_dev);
> +	sun6i_csi_bridge_configure(csi_dev, source);
>  	sun6i_csi_capture_configure(csi_dev);
> 
>  	/* State Update */
> @@ -607,6 +639,7 @@ sun6i_csi_bridge_notifier_bound(struct
> v4l2_async_notifier *notifier, struct sun6i_csi_bridge_async_subdev
> *bridge_async_subdev =
>  		container_of(async_subdev, struct 
sun6i_csi_bridge_async_subdev,
>  			     async_subdev);
> +	struct sun6i_csi_bridge *bridge = &csi_dev->bridge;
>  	struct sun6i_csi_bridge_source *source = bridge_async_subdev-
>source;
>  	bool enabled;
> 
> @@ -614,6 +647,9 @@ sun6i_csi_bridge_notifier_bound(struct
> v4l2_async_notifier *notifier, case SUN6I_CSI_PORT_PARALLEL:
>  		enabled = true;
>  		break;
> +	case SUN6I_CSI_PORT_MIPI_CSI2:
> +		enabled = !bridge->source_parallel.expected;
> +		break;
>  	default:
>  		break;
>  	}
> @@ -760,6 +796,8 @@ int sun6i_csi_bridge_setup(struct sun6i_csi_device
> *csi_dev) sun6i_csi_bridge_source_setup(csi_dev, &bridge->source_parallel,
> SUN6I_CSI_PORT_PARALLEL,
>  				      parallel_mbus_types);
> +	sun6i_csi_bridge_source_setup(csi_dev, &bridge->source_mipi_csi2,
> +				      SUN6I_CSI_PORT_MIPI_CSI2, 
NULL);
> 
>  	ret = v4l2_async_nf_register(v4l2_dev, notifier);
>  	if (ret) {
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h index
> cb3b27af4607..ee592a14b9c5 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.h
> @@ -46,6 +46,7 @@ struct sun6i_csi_bridge {
>  	struct mutex			lock; /* Mbus format lock. */
> 
>  	struct sun6i_csi_bridge_source	source_parallel;
> +	struct sun6i_csi_bridge_source	source_mipi_csi2;
>  };
> 
>  /* Helpers */




