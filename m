Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077615121CD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbiD0Szy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 14:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbiD0SzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 14:55:07 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60335C670;
        Wed, 27 Apr 2022 11:42:10 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z19so2952672edx.9;
        Wed, 27 Apr 2022 11:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kM7QKgAFBW1YvmaUCZRsC0/6t1UvkOHugGgZxLi1Vr0=;
        b=S+kHBI/504UiUBVwrLTFGKBKaowxmoONKDYMlQIV4s6mofRVbccXVXAXj8K8BXLa55
         PKPXRzXNTv7UPUOFRBnPq0CsvYN8ufGPVTnQg7zCGVX7dBsIBvweiLQZKoNC2kGHoNb4
         Gn+9odGqMMu9c04/gJYxVhVh2ixOrzAu3Zl/Mu+/eviXikF2zSs9HCzA1bzDxjU6ONDO
         IHbqsqDFjkpRpyKLWsujzupJKuRBPnlTuFDxCrWs0OAVAXMXeVPw1XtRYa2stKmZNcXd
         1z+bK1OVuUcDn7Mk8cKdsnS95xTJpBq75UmfQ1nObO6NkLmInR0yKfGPGGoqzz9MKZ8U
         o53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kM7QKgAFBW1YvmaUCZRsC0/6t1UvkOHugGgZxLi1Vr0=;
        b=b67p7FNUMC20Yqq6BffC5S/Rj4G5jTT+zVo78JbSOQjocTxWENP+UAPtYyTd3xT8Rh
         d5fcCZKdznCghPXRKBybHPxKJJfH+DXnpKbBO3BWgMpKl72x1JtOHNijJmJRlm2KNHSs
         C1z6PMHNz5jE7yyhx7rienmDmckP8sGlv0C94qtMe3UWOSih+ZHgHMJPt6Y9cis0wCbx
         3VLPLjHEGiFFv5DVFA9mgt2w3UI/49ADMy4vksxKEe/woYhiyYE2vsUtttkcj2WcFYMx
         2mdB1zxNmC9cVaDzFwR+7iUJnVxDABSiT9J/zHeTKHgvtmdLQ9SYwk+YDR3dUF1nFpL4
         jx0A==
X-Gm-Message-State: AOAM530ociJqu3be0vDU917qEU0pv5im2uPJwqk/Gws05IwCyxN8FXz+
        kLtgGFqbWvBVfqNgUmIrT4eXL9dtM3HtxA==
X-Google-Smtp-Source: ABdhPJwXgfYi2dTLT9QE2lh91WC5EwoIzb7cZ7ysQtl/DgiXIIGDXTWRE8w1/uoxyG/OsjUPhQ/wCA==
X-Received: by 2002:a05:6402:364:b0:425:f88d:7d4a with SMTP id s4-20020a056402036400b00425f88d7d4amr11968554edw.68.1651084929330;
        Wed, 27 Apr 2022 11:42:09 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id e19-20020a056402105300b0042617ba6384sm7099edu.14.2022.04.27.11.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:42:08 -0700 (PDT)
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
Subject: Re: [PATCH v4 12/45] media: sun6i-csi: Add media ops with link notify callback
Date:   Wed, 27 Apr 2022 20:42:07 +0200
Message-ID: <1813200.tdWV9SEqCh@jernej-laptop>
In-Reply-To: <20220415152811.636419-13-paul.kocialkowski@bootlin.com>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com> <20220415152811.636419-13-paul.kocialkowski@bootlin.com>
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

Dne petek, 15. april 2022 ob 17:27:38 CEST je Paul Kocialkowski napisal(a):
> In order to keep the power use count fields balanced when link changes
> happen between v4l2_pipeline_pm_get/set calls (in open/close),
> the link_notify media operation callback needs to be registered.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c index
> e59ee3e3f372..578714606c2f 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> @@ -23,6 +23,7 @@
>  #include <linux/sched.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
> +#include <media/v4l2-mc.h>
> 
>  #include "sun6i_csi.h"
>  #include "sun6i_csi_reg.h"
> @@ -574,6 +575,12 @@ void sun6i_csi_set_stream(struct sun6i_csi_device
> *csi_dev, bool enable) CSI_CAP_CH0_VCAP_ON);
>  }
> 
> +/* Media */
> +
> +static const struct media_device_ops sun6i_csi_media_ops = {
> +	.link_notify = v4l2_pipeline_link_notify,
> +};
> +
>  /* V4L2 */
> 
>  static int sun6i_csi_link_entity(struct sun6i_csi_device *csi_dev,
> @@ -683,6 +690,7 @@ static int sun6i_csi_v4l2_setup(struct sun6i_csi_device
> *csi_dev) snprintf(media_dev->bus_info, sizeof(media_dev->bus_info),
>  		 "platform:%s", dev_name(dev));
>  	media_dev->hw_revision = 0;
> +	media_dev->ops = &sun6i_csi_media_ops;
>  	media_dev->dev = dev;
> 
>  	media_device_init(media_dev);




