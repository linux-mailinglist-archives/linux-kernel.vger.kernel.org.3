Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6253C512337
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 22:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbiD0UEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 16:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbiD0UEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 16:04:43 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305F5B4F;
        Wed, 27 Apr 2022 13:01:30 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bv19so5521788ejb.6;
        Wed, 27 Apr 2022 13:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aLowST4nKAkGr9c3fHqSpsjf0Wm9DG/3Bvzsg405mP4=;
        b=MG4f5rcNTMQf8BjT+/LacYXM0bt4cXS55yondFKDP25V8gs4yEsHXcgyWwR+jliuWe
         eJll4Db9T1i52aZdoZIC3shF446867eVgacgMi4oD48JvDrZB0lSwMhoaVSqPNk4RzQB
         jGIXOzBcUH5gnrZTVBGKIhIu5NERUEYaY+H7z/QQLQ3UhQoRfa/HGoJ5esB8EggsPCCT
         YpuKsbNc/rXOTEFEeFkAKIRQbyMfcrlh5kKvSZBoKMM7FD78MF4PVUo+InCNaHrbDg7K
         XvQ880yfuVwBQmMFu529yKCSLH39A63IBkIyoX/CYhNmWzbS/Uyy8P+4nt6ct28AQIof
         keSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aLowST4nKAkGr9c3fHqSpsjf0Wm9DG/3Bvzsg405mP4=;
        b=MVanWrv649MH14INyvA9GRAkjXLxF/kLVSsdxdehFvcmA+0tQlb/IH7cMaF/Dfl6NH
         x/sftUkDxYMe3GwMorbeon1rIZo+zsFyX1wGgD2g0NIJkm+zlarvbwBCzNCe0U1ouE3b
         GYUTIv9IMIu7yOj5Ax21hMQYCAuDC/PU9IIZZAYPV/KW8oTGo0fDdTDYtLGJ0einzSqK
         Bbtll5HcvUsqYhg8ehwARg55R1krTnaJ/s4mLHeTZWwSqUD8pgFEJsX1ltxXcB4nJn7N
         8ntxhCtciIfhBzyqEIqVpmUhk+5Uw4xinbQjJwVAxXS/NfWovWL10op3KP4tuYykw5Tr
         OJ3A==
X-Gm-Message-State: AOAM532z62arhjrHszKbFBcA7aWqyjaVIVRbrKRjYhnOjY8ouFKhqXY2
        Y9YewoW0IqbWxq6rYc5yPsKaNXMzX6hqeA==
X-Google-Smtp-Source: ABdhPJxS4IZ0+iTjCGdsh1af2+eAD2UhX/BmO3fFmIZzxswqPED//m8AjF4IdzLfr7I4JgzHWJKYZw==
X-Received: by 2002:a17:906:3ec1:b0:6e8:aae3:90de with SMTP id d1-20020a1709063ec100b006e8aae390demr28151878ejj.127.1651089688800;
        Wed, 27 Apr 2022 13:01:28 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id hb44-20020a170907162c00b006f3bd744275sm2794919ejc.181.2022.04.27.13.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 13:01:28 -0700 (PDT)
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
Subject: Re: [PATCH v4 45/45] MAINTAINERS: Add myself as sun6i-csi maintainer and rename/move entry
Date:   Wed, 27 Apr 2022 22:01:27 +0200
Message-ID: <13001519.dW097sEU6C@jernej-laptop>
In-Reply-To: <20220415152811.636419-46-paul.kocialkowski@bootlin.com>
References: <20220415152811.636419-1-paul.kocialkowski@bootlin.com> <20220415152811.636419-46-paul.kocialkowski@bootlin.com>
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

Dne petek, 15. april 2022 ob 17:28:11 CEST je Paul Kocialkowski napisal(a):
> Given the substantial rework of the driver that I carried out and the
> knowledge acquired about the hardware along the way, make myself a
> maintainer of the sun6i-csi driver.
> 
> Also rename and move the entry while at it since the driver is not
> specific to the V3s.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by; Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  MAINTAINERS | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0c7a3c792837..43f456982ecc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -761,6 +761,15 @@ T:	git git://linuxtv.org/media_tree.git
>  F:	Documentation/devicetree/bindings/media/allwinner,sun4i-a10-
csi.yaml
>  F:	drivers/media/platform/sunxi/sun4i-csi/
> 
> +ALLWINNER A31 CSI DRIVER
> +M:	Yong Deng <yong.deng@magewell.com>
> +M:	Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> +L:	linux-media@vger.kernel.org
> +S:	Maintained
> +T:	git git://linuxtv.org/media_tree.git
> +F:	Documentation/devicetree/bindings/media/allwinner,sun6i-a31-
csi.yaml
> +F:	drivers/media/platform/sunxi/sun6i-csi/
> +
>  ALLWINNER A31 MIPI CSI-2 BRIDGE DRIVER
>  M:	Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>  L:	linux-media@vger.kernel.org
> @@ -5232,14 +5241,6 @@ M:	Jaya Kumar <jayakumar.alsa@gmail.com>
>  S:	Maintained
>  F:	sound/pci/cs5535audio/
> 
> -CSI DRIVERS FOR ALLWINNER V3s
> -M:	Yong Deng <yong.deng@magewell.com>
> -L:	linux-media@vger.kernel.org
> -S:	Maintained
> -T:	git git://linuxtv.org/media_tree.git
> -F:	Documentation/devicetree/bindings/media/allwinner,sun6i-a31-
csi.yaml
> -F:	drivers/media/platform/sunxi/sun6i-csi/
> -
>  CW1200 WLAN driver
>  M:	Solomon Peachy <pizza@shaftnet.org>
>  S:	Maintained




