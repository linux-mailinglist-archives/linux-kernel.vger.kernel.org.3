Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64D2512314
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbiD0Tu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbiD0Tun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:50:43 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1962BB03;
        Wed, 27 Apr 2022 12:47:30 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l18so5442903ejc.7;
        Wed, 27 Apr 2022 12:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LONo22GFE8+qb+RTFT1FYUQE4k/LGm5GxuD++oCjNCo=;
        b=oVQ5t51PpqRAKOMWTnUjjYB06RAXdeQijIcB3h4gxPdrJg919IHzOauTtrCaKnUB7p
         jrj+4kHdkxThd9OtNJgoJjy4qllr60TxUP6f2E8aVsBjZv7/LXEyKM2TdQ+m9i9ABzHN
         ta2jM7RaQ/rIby5LSeUxG03DlsalsdUlvbcOitNiJ6cJ8Bx+XXxMFfxEwAx1tF5h0m8j
         0BT7Azw8ss+JqOhBijJrAvTAmwr9xhjfxbEyTqrebMJv8xjrkQbgUin+aWphFPGDAj5C
         60w1oj59WmxZ2l8g/h66lzVQZnaKmNUWql4qtC/zAts+sHjQ4sUZFhyfd97SNJQNyqgO
         K13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LONo22GFE8+qb+RTFT1FYUQE4k/LGm5GxuD++oCjNCo=;
        b=HjMEnnon6rR8R3AG0xhf2lPn5wdxG/QVPuqjwRzXm/ZblzkMhgE/xXJ0Yslz7T5I2t
         +dXN+/s/80+K2HdpV8p2lKdHQ54ZygT0CLoNbKLPAGNPZpnrKnV6TvWXW6Vjay6PRREh
         83yJDLOhbBvRKFbRsFpllsTYevU4PJQDES1iWzwDOjjGnyDUPjqVwm6yy+jLfxPg7mky
         I4GGc8pcrESpz65SW8CD5o49xFJ+P2PnpZszSs03dc5BBotevpDVgkQAWok/wGSmBSav
         1LwgZIEjWqWmylpg2b1/bmiuquGartTQM2rxwfijXhh+wwcDciije/PeyCsJO8ELUuYb
         Ebsg==
X-Gm-Message-State: AOAM533aYdoYFh2IHzeqVPRMXDkiiH1TZdhmew+ImoXHhyuxJXH4jPOb
        j1q90d2THjeSVgkR5E5zNEc9Hd0GBAuKOA==
X-Google-Smtp-Source: ABdhPJzJatD17YnXsrf0yTeXgTJ1voZs9XJLvJEFIxSvdL3rgPSW4gimCHVTuvtYjbFSC2UjbCAuhQ==
X-Received: by 2002:a17:907:968f:b0:6db:a3c5:ae3e with SMTP id hd15-20020a170907968f00b006dba3c5ae3emr29230108ejc.770.1651088848727;
        Wed, 27 Apr 2022 12:47:28 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id s25-20020aa7d799000000b0042617ba6397sm96065edq.33.2022.04.27.12.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 12:47:28 -0700 (PDT)
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
Subject: Re: [PATCH v4 35/45] media: sun6i-csi: Get bridge subdev directly in capture stream ops
Date:   Wed, 27 Apr 2022 21:47:27 +0200
Message-ID: <2128504.NgBsaNRSFp@jernej-laptop>
In-Reply-To: <20220415152811.636419-36-paul.kocialkowski@bootlin.com>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com> <20220415152811.636419-36-paul.kocialkowski@bootlin.com>
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

Dne petek, 15. april 2022 ob 17:28:01 CEST je Paul Kocialkowski napisal(a):
> The remote subdev connected to the capture video device is always
> our bridge, so get the bridge subdev directly instead of using a
> dedicated helper (which is removed by this commit).
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  .../sunxi/sun6i-csi/sun6i_csi_capture.c       | 30 ++-----------------
>  1 file changed, 3 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c index
> b3452ed825ad..b92f8aa55a92 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> @@ -42,22 +42,6 @@ void sun6i_csi_capture_format(struct sun6i_csi_device
> *csi_dev, *field = csi_dev->capture.format.fmt.pix.field;
>  }
> 
> -static struct v4l2_subdev *
> -sun6i_csi_capture_remote_subdev(struct sun6i_csi_capture *capture, u32
> *pad) -{
> -	struct media_pad *remote;
> -
> -	remote = media_entity_remote_pad(&capture->pad);
> -
> -	if (!remote || !is_media_entity_v4l2_subdev(remote->entity))
> -		return NULL;
> -
> -	if (pad)
> -		*pad = remote->index;
> -
> -	return media_entity_to_v4l2_subdev(remote->entity);
> -}
> -
>  /* Format */
> 
>  static const struct sun6i_csi_capture_format sun6i_csi_capture_formats[] =
> { @@ -822,8 +806,8 @@ static int sun6i_csi_capture_start_streaming(struct
> vb2_queue *queue, struct sun6i_csi_capture *capture = &csi_dev->capture;
>  	struct sun6i_csi_capture_state *state = &capture->state;
>  	struct video_device *video_dev = &capture->video_dev;
> +	struct v4l2_subdev *subdev = &csi_dev->bridge.subdev;
>  	struct device *dev = csi_dev->dev;
> -	struct v4l2_subdev *subdev;
>  	int ret;
> 
>  	state->sequence = 0;
> @@ -832,12 +816,6 @@ static int sun6i_csi_capture_start_streaming(struct
> vb2_queue *queue, if (ret < 0)
>  		goto error_state;
> 
> -	subdev = sun6i_csi_capture_remote_subdev(capture, NULL);
> -	if (!subdev) {
> -		ret = -EINVAL;
> -		goto error_media_pipeline;
> -	}
> -
>  	/* PM */
> 
>  	ret = pm_runtime_resume_and_get(dev);
> @@ -886,12 +864,10 @@ static void sun6i_csi_capture_stop_streaming(struct
> vb2_queue *queue) {
>  	struct sun6i_csi_device *csi_dev = vb2_get_drv_priv(queue);
>  	struct sun6i_csi_capture *capture = &csi_dev->capture;
> +	struct v4l2_subdev *subdev = &csi_dev->bridge.subdev;
>  	struct device *dev = csi_dev->dev;
> -	struct v4l2_subdev *subdev;
> 
> -	subdev = sun6i_csi_capture_remote_subdev(capture, NULL);
> -	if (subdev)
> -		v4l2_subdev_call(subdev, video, s_stream, 0);
> +	v4l2_subdev_call(subdev, video, s_stream, 0);
> 
>  	sun6i_csi_capture_disable(csi_dev);
>  	sun6i_csi_capture_irq_disable(csi_dev);




