Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8295122CD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbiD0Tf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiD0Tf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:35:26 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B60CE;
        Wed, 27 Apr 2022 12:32:13 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id p4so3158454edx.0;
        Wed, 27 Apr 2022 12:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JhnYrw0AR5Z7jkNOIRMJJDs+xZns0y5ZouI6A7Yq2m4=;
        b=it+qMq+p7Ih5sV2oP8h90O+A66YmhvIlQ5DX8ZHmeUw3CUBBx//p0vDiJGey9z0uIh
         bx6H014af/WfMFeUW/y49vhZWL+bAMkkDwbttSQAa5L4W+jZ2Ye5Yph9Nw+bvdm04F3M
         LCuKkt5dXpk1/oEug5xk5qAVCXw18q4iCnv6UBp3Pe8OWXV35Q6TzSd+FFyGmcZgVDsy
         vA6guExkKI5BaVDgivRgeO+tiyrCSgn0D5Cplnj/9TUeuqFaGzANrhiasI0H9NrOI/Fu
         TPDoBoEQqAwkonqOkv8Nm2ndoIzYcxK43vaXzk0aQDttrNI1yFrNdHAuK4zAs/0E+mV2
         HvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JhnYrw0AR5Z7jkNOIRMJJDs+xZns0y5ZouI6A7Yq2m4=;
        b=OK1pieXOjYF09ohDGldxkEUw3V3SVBR2I0ZacvkkoSVjP/I2RW8MTcq2FsRITbsncA
         TzPf/M8OanMccyJk5/mnk8aXHBDzqS2GTnDoxrX2C8vLAsf75/6e5OLWYzAj4VdG8YwO
         +7YKVMjP9oPvyFBKE54ifwOU3lSbjOM0gc52D8sJBQry6ACPzqS/DKnXEi+lNCEHzy8Q
         0QaVroJRypxmWBXegTiMObpdkU3t+F26RR+suKFVJwZglzqQgdh6A/jyc0CKXsLr9yvj
         vqEPX4yhk8gxDu4j+hEBWlfXUUD+0/Ni8P5Y+5Q/SoI9KQVZYwkerr+SXlii2d+WyLW8
         qU5g==
X-Gm-Message-State: AOAM5328SchULwftg7HIzDX/iwizd47xlF48UQ8XhYAtilQkVH2FC2tp
        jaXqPutB0RypPSv5FP6dAOwkNdLlNNkzHA==
X-Google-Smtp-Source: ABdhPJxMYyDg9X/787fWvrzZZ7v36nyynk8yGgYPu7j2miTQJHngFnPm9HXf6WWh9F3WgCeAdKpCzg==
X-Received: by 2002:a05:6402:51d2:b0:424:536:94dd with SMTP id r18-20020a05640251d200b00424053694ddmr32374846edd.191.1651087932349;
        Wed, 27 Apr 2022 12:32:12 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id s12-20020a1709062ecc00b006e8558c9a5csm7212048eji.94.2022.04.27.12.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 12:32:12 -0700 (PDT)
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
Subject: Re: [PATCH v4 28/45] media: sun6i-csi: Get mbus code from bridge instead of storing it
Date:   Wed, 27 Apr 2022 21:32:10 +0200
Message-ID: <2106792.Mh6RI2rZIc@jernej-laptop>
In-Reply-To: <20220415152811.636419-29-paul.kocialkowski@bootlin.com>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com> <20220415152811.636419-29-paul.kocialkowski@bootlin.com>
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

Dne petek, 15. april 2022 ob 17:27:54 CEST je Paul Kocialkowski napisal(a):
> Another instance of removing a duplicated variable and using common
> helpers instead.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  .../sunxi/sun6i-csi/sun6i_csi_capture.c        | 18 +++++-------------
>  .../sunxi/sun6i-csi/sun6i_csi_capture.h        |  1 -
>  2 files changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c index
> c4e803a38851..e2070353f93f 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> @@ -17,6 +17,7 @@
>  #include <media/videobuf2-v4l2.h>
> 
>  #include "sun6i_csi.h"
> +#include "sun6i_csi_bridge.h"
>  #include "sun6i_csi_capture.h"
>  #include "sun6i_csi_reg.h"
> 
> @@ -455,20 +456,20 @@ sun6i_csi_capture_configure_interface(struct
> sun6i_csi_device *csi_dev)
> 
>  static void sun6i_csi_capture_configure_format(struct sun6i_csi_device
> *csi_dev) {
> -	struct sun6i_csi_capture *capture = &csi_dev->capture;
> -	u32 pixelformat, field;
> +	u32 mbus_code, pixelformat, field;
>  	u32 cfg = 0;
>  	u32 val;
> 
>  	sun6i_csi_capture_format(csi_dev, &pixelformat, &field);
> +	sun6i_csi_bridge_format(csi_dev, &mbus_code, NULL);
> 
> -	val = get_csi_input_format(csi_dev, capture->mbus_code, 
pixelformat);
> +	val = get_csi_input_format(csi_dev, mbus_code, pixelformat);
>  	cfg |= SUN6I_CSI_CH_CFG_INPUT_FMT(val);
> 
>  	val = get_csi_output_format(csi_dev, pixelformat, field);
>  	cfg |= SUN6I_CSI_CH_CFG_OUTPUT_FMT(val);
> 
> -	val = get_csi_input_seq(csi_dev, capture->mbus_code, pixelformat);
> +	val = get_csi_input_seq(csi_dev, mbus_code, pixelformat);
>  	cfg |= SUN6I_CSI_CH_CFG_INPUT_YUV_SEQ(val);
> 
>  	if (field == V4L2_FIELD_TOP)
> @@ -739,11 +740,6 @@ static int sun6i_csi_capture_start_streaming(struct
> vb2_queue *queue, if (ret < 0)
>  		goto error_state;
> 
> -	if (capture->mbus_code == 0) {
> -		ret = -EINVAL;
> -		goto error_media_pipeline;
> -	}
> -
>  	subdev = sun6i_csi_capture_remote_subdev(capture, NULL);
>  	if (!subdev) {
>  		ret = -EINVAL;
> @@ -1076,8 +1072,6 @@ static int sun6i_csi_capture_link_validate(struct
> media_link *link) struct v4l2_subdev_format source_fmt;
>  	int ret;
> 
> -	capture->mbus_code = 0;
> -
>  	if (!media_entity_remote_pad(link->sink->entity->pads)) {
>  		dev_info(csi_dev->dev, "capture node %s pad not 
connected\n",
>  			 vdev->name);
> @@ -1109,8 +1103,6 @@ static int sun6i_csi_capture_link_validate(struct
> media_link *link) return -EPIPE;
>  	}
> 
> -	capture->mbus_code = source_fmt.format.code;
> -
>  	return 0;
>  }
> 
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h index
> 02bdf45f7ca5..3b9759e1563d 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
> @@ -39,7 +39,6 @@ struct sun6i_csi_capture {
>  	struct media_pad		pad;
> 
>  	struct v4l2_format		format;
> -	u32				mbus_code;
>  };
> 
>  void sun6i_csi_capture_dimensions(struct sun6i_csi_device *csi_dev,




