Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DF651231A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbiD0TyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbiD0TyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:54:09 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1349F5BD36;
        Wed, 27 Apr 2022 12:50:57 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id p4so3207691edx.0;
        Wed, 27 Apr 2022 12:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=33j4YNSNaU5u59fgSber6SgSZ1FYBjfWnCsj8i53xiY=;
        b=paqZNLRh816sci8wvt4ZMNGemC8tLQEZQbrY9GK0GF+9tda40M4Hbqk6a0iBrMeUWR
         pFZw8B9zMxIKU4oUgr8+nrR6asJ3HHqlfrm/haG45dyuWn4dCJtZo9iXZTnfySlgXT3t
         hfWQrG+tpXivhbySzfp7k6Rk5PR2rVcj6riFEWVUFsFoTt/5h7OvNo2+YpjEVTZ2xbUC
         c10ykpZtbfcdncFg30IrZLX8FfLSEHT6hnStz8jts0Luz3Lxkcny6oyP0KExznklnIZU
         VYhJCy5QIq7gG+pKuyC/cj25vXJGb4q9Sa9LyBnXyRWxTevQJuTPOWyWGT0vXxA0M61N
         uP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=33j4YNSNaU5u59fgSber6SgSZ1FYBjfWnCsj8i53xiY=;
        b=saSJc719rt9UWFXnBeQvSSbkCfrHbE+2pm8ekP7cuXA8B1uLSyDx7w79ewhlepXsgD
         XFPy1krwA7ki4p2k/qrZQYmgutknf5uWz6skbgP+qo8kFSLXq4/GP9WE6kDG/x1ciEB0
         q28ST1m+nZ1ae+poK7MLarF4IJPC4GpijsdFfeU0/u09litotzk2yuEtIHgDNC1fxIUi
         l7WG7k27JTeoNLTEjrCfzbPOYbzA419IZcZlEhbXCK5pdNmyOUAzpCvnSxRx4aP5/3MM
         xVchAbWdSCiKMY0hxOd3BWCd5YQlmqEMBVhogYB8yTrHARgB8Rar25WaNYgOnfQoGo4o
         zcnw==
X-Gm-Message-State: AOAM530HxWv3vqH+FUDjXVueOlUIskBGccTE/cPCJIvKmBAMcvWoJBHp
        8aNZ1P0kitWBX9YgvyCFn1MdOtkxtFamew==
X-Google-Smtp-Source: ABdhPJw1YgYtwx9aqlQwyWIGlVQaBzLeEYF1CEFQZPIzcHlqxRakh1b8DdGiXc19hCSJewwbYeHPOA==
X-Received: by 2002:a05:6402:5286:b0:425:f0fb:5d23 with SMTP id en6-20020a056402528600b00425f0fb5d23mr15599225edb.243.1651089055670;
        Wed, 27 Apr 2022 12:50:55 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id j12-20020aa7de8c000000b0042617ba63b2sm104085edv.60.2022.04.27.12.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 12:50:55 -0700 (PDT)
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
Subject: Re: [PATCH v4 37/45] media: sun6i-csi: Rename the capture video device to sun6i-csi-capture
Date:   Wed, 27 Apr 2022 21:50:54 +0200
Message-ID: <14612220.tv2OnDr8pf@jernej-laptop>
In-Reply-To: <20220415152811.636419-38-paul.kocialkowski@bootlin.com>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com> <20220415152811.636419-38-paul.kocialkowski@bootlin.com>
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

Dne petek, 15. april 2022 ob 17:28:03 CEST je Paul Kocialkowski napisal(a):
> Now that the driver is properly split between bridge and capture,
> rename the video device to highlight its role and be in line with
> the bridge entity naming.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c | 3 ++-
>  drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c index
> a6619d083308..c3b1e1411da4 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.c
> @@ -1027,7 +1027,8 @@ int sun6i_csi_capture_setup(struct sun6i_csi_device
> *csi_dev)
> 
>  	/* Video Device */
> 
> -	strscpy(video_dev->name, SUN6I_CSI_NAME, sizeof(video_dev->name));
> +	strscpy(video_dev->name, SUN6I_CSI_CAPTURE_NAME,
> +		sizeof(video_dev->name));
>  	video_dev->device_caps = V4L2_CAP_VIDEO_CAPTURE | 
V4L2_CAP_STREAMING;
>  	video_dev->vfl_dir = VFL_DIR_RX;
>  	video_dev->release = video_device_release_empty;
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h index
> a61db3bc72e5..59c57bcefeec 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi_capture.h
> @@ -11,6 +11,8 @@
>  #include <media/v4l2-dev.h>
>  #include <media/videobuf2-core.h>
> 
> +#define SUN6I_CSI_CAPTURE_NAME	"sun6i-csi-capture"
> +
>  #define SUN6I_CSI_CAPTURE_WIDTH_MIN	32
>  #define SUN6I_CSI_CAPTURE_WIDTH_MAX	4800
>  #define SUN6I_CSI_CAPTURE_HEIGHT_MIN	32




