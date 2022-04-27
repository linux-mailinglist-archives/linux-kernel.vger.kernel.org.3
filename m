Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0485121B9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiD0SzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 14:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbiD0SyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 14:54:00 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12183DAD3E;
        Wed, 27 Apr 2022 11:40:21 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l7so5178210ejn.2;
        Wed, 27 Apr 2022 11:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uUiRj9ShaGcXVoRdp82isoIpzg+6vO7GGhdlgaIYleg=;
        b=ovdIFcyYsKX0OmrCtG+rCtvekfXilVxP4wrdcpgZkNgDV0pwvS4pPXOFZbYmLz6XLM
         pgj7SBIHzQLZlp6ArPaqLnGXvmGcTcPWAQRbGqsS5WAuTe/H1ok7nVLed9RNArKRXfAt
         wILj8xuimsEPxs6FO1WXLvvnNarPvigxHwJKkPTQn5+6SdsZNTOilxACtTaYb/Ozx4b6
         kKBvoWnN1AvOmeFl1nSh6IpoOs6eenP3OJzcrM3I4/6Swkb7/qS7BuDdMi0WURzTQ/AN
         5AjXmn79EumMY4YgKUFP1cKrhj6KgGGeYnfEgRjF6T0N0ERK5kNsshw6ziIY0IpE6DkA
         fLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uUiRj9ShaGcXVoRdp82isoIpzg+6vO7GGhdlgaIYleg=;
        b=pEnojaIwpj4iad9fro9tPgyOoKj/yTKQrua8nVE3BVsUhhbslPrxj504/HYVFKcIxK
         Q4mNao4ibe7fdDzGK8nwF7rGYQ2L2OuqVKJFStkfcBLOdTrB1SlsmjNCoCJ1IHvDM9F8
         d/DyHk0N719djGPKlAMTczWsU5oqhuYBMU5noM9ZOFk8SUmf16q358Emd+CFHB4bH/7H
         BqJFigKCLgiEVVixO+RG3q8tfeU6iOBv7sHyTwa77z6j0wCkwkOqfy7TdxbL6+rSj4Qg
         6+gFp0VcnTvbNl98hpGTHSLkHDtq4GKmN/R3VY+Xv6ht4A2QAFSXZjRHJmp6hABuBn3i
         8aYQ==
X-Gm-Message-State: AOAM53309nHT2OKUa1N47IMm6LyxHIaT3Qz9trMjHCAIUwFK3okekVnz
        LOCELXustXLKcODMawZXmyySe6WB6TwxQQ==
X-Google-Smtp-Source: ABdhPJwRK7vAdKSdfZ4tlKvfNpSu+/S0SuSAbrR1yFRd62z9h3UhDj7Wo9IYoPztJOgWcvIyofl3qw==
X-Received: by 2002:a17:907:1b05:b0:6f0:18d8:7be0 with SMTP id mp5-20020a1709071b0500b006f018d87be0mr27886541ejc.561.1651084820483;
        Wed, 27 Apr 2022 11:40:20 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id l26-20020a1709062a9a00b006e7ee7ad20bsm7288205eje.149.2022.04.27.11.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:40:20 -0700 (PDT)
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
Subject: Re: [PATCH v4 11/45] media: sun6i-csi: Register the media device after creation
Date:   Wed, 27 Apr 2022 20:40:18 +0200
Message-ID: <2235027.ElGaqSPkdT@jernej-laptop>
In-Reply-To: <20220415152811.636419-12-paul.kocialkowski@bootlin.com>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com> <20220415152811.636419-12-paul.kocialkowski@bootlin.com>
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

Dne petek, 15. april 2022 ob 17:27:37 CEST je Paul Kocialkowski napisal(a):
> There is no particular need to register the media device in the
> subdev notify complete callback.
> 
> Register it in the v4l2 code instead where it's more in-context.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Ideally, error path could use new label, but since media_device_unregister() 
check for if it was registered, this works too.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c index
> 198275e09865..e59ee3e3f372 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> @@ -638,7 +638,7 @@ static int sun6i_subdev_notify_complete(struct
> v4l2_async_notifier *notifier) if (ret < 0)
>  		return ret;
> 
> -	return media_device_register(&v4l2->media_dev);
> +	return 0;
>  }
> 
>  static const struct v4l2_async_notifier_operations sun6i_csi_async_ops = {
> @@ -687,6 +687,12 @@ static int sun6i_csi_v4l2_setup(struct sun6i_csi_device
> *csi_dev)
> 
>  	media_device_init(media_dev);
> 
> +	ret = media_device_register(media_dev);
> +	if (ret) {
> +		dev_err(dev, "failed to register media device: %d\n", 
ret);
> +		goto error_media;
> +	}
> +
>  	/* V4L2 Control Handler */
> 
>  	ret = v4l2_ctrl_handler_init(&v4l2->ctrl_handler, 0);
> @@ -746,6 +752,7 @@ static int sun6i_csi_v4l2_setup(struct sun6i_csi_device
> *csi_dev) v4l2_ctrl_handler_free(&v4l2->ctrl_handler);
> 
>  error_media:
> +	media_device_unregister(media_dev);
>  	media_device_cleanup(media_dev);
> 
>  	return ret;




