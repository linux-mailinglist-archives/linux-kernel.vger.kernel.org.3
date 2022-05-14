Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F0D527150
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 15:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbiENNgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 09:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbiENNge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 09:36:34 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8AB18E23;
        Sat, 14 May 2022 06:36:33 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id m20so20909288ejj.10;
        Sat, 14 May 2022 06:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VymNsO9H8vXev+tiyOhAo/oE9mXI2dXizsJGlsEEQ7M=;
        b=U0xcrl1+33ooDeGyYEvLTuxZUiFJ1G+F6tNH+a/Fe79ebH4D0fHhkPMbgtrS1CYRY9
         AmHE8zmyq8CiNb6QbKt0TU9ISdTI7yul4Y9S5MM78mj2f6aSE73srHj0llzFWm+heX+n
         vxjj6E0n30bMybxyDegia7GDYgQpIIt8sIn/e3mHagwRhF+IStAKE3d6pPkLlhZh1hiu
         BV3VThfgOaSirer8YLww/6OGCP7sb9gUdBbdzVgIoH9vh3TtntZKc139P5g+iNBquf32
         gxcl1lvrcTThP/igiSd5r8SZIoH5IgOP+Pm/xuEsCsm6Dh7EEOMYJ7kgTFkI7TLrokPc
         bo0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VymNsO9H8vXev+tiyOhAo/oE9mXI2dXizsJGlsEEQ7M=;
        b=DunznjFAM4+6L8gVEwXRtYgWNKpNHPMg6q77T5W0b3uEzVGoELDZSFwEqNijaAQX6l
         89NmOh21zGGcTnUf+EM0KeB41ZJN153Nn5FjgBuvWijC5nyrGXkzGIUCUWx1o9VEekvN
         UBkNqzugGj+3INiAvkvJV8zoZSRF2pbWM3pGKeyEfYszdj6QD2o9sEczxPkFduvwvpHJ
         5lJQmidnzDgenxIrgO9Hc+qHVaYoJyjA+0aYPnhN3NZuh6QhpDXN/5kXnKLVZ5G5oSyy
         5t+RXi4WGvQuVeaZCjJx8TFWkOvkzdW2efOj7x5RhAtU8tvOvArdl6rzi6J8QY9l18UC
         l9AA==
X-Gm-Message-State: AOAM531DqB9gCBaIW88PEh/76rLB6SgfBfYPhuC13kSObmCeIMWTgEYg
        l/Da51ds3zAkRFkS3FA+Usk=
X-Google-Smtp-Source: ABdhPJyvEAUNi0SNhPPHnm5cy2aKmPXeX+3XH6wYj1nL4AKXica1uFiPnVGsop4zTWEUFMhY/meH2w==
X-Received: by 2002:a17:907:948c:b0:6f5:183f:eb6 with SMTP id dm12-20020a170907948c00b006f5183f0eb6mr8055998ejc.112.1652535392262;
        Sat, 14 May 2022 06:36:32 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id ci18-20020a170907267200b006f3ef214e49sm1736739ejc.175.2022.05.14.06.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 06:36:31 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Liang Chen <cl@rock-chips.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v4 0/3] Enable JPEG Encoder on RK3566/RK3568
Date:   Sat, 14 May 2022 15:36:01 +0200
Message-Id: <20220514133604.174905-1-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this is v4 of my RK356x JPEG encoder patch set. It enables the Hantro
hardware encoder of the RK3566 and RK3568 line of SoCs, with JPEG being
the only format the driver currently supports encoding for.

The first patch adds a new binding, the rockchip-vepu binding, to
describe this kind of hardware. The reason for going with a new binding
instead of modifying the vpu binding as the previous versions did is
that the vpu binding is getting quite long, and Ezequiel Garcia suggested
(on IRC) that we could document encoder only instances in their own
binding. This makes sense to me, especially considering that RK3588 will
have more Hantro instances like this to document.

The second patch makes the actual driver changes to support this variant.

The third and final patch makes the necessary device tree changes for
the rk356x device tree file to add both the node for the encoder and
its MMU.

The series has been tested on a PINE64 Quartz64 Model A with an RK3566
SoC using GStreamer.

No interdiff this time around, I discovered that it breaks patchwork.

Regards,
Nicolas Frattaroli

Changes in v4:
 - bindings: move vepu to its own binding, also add it to MAINTAINERS
 - driver: rename a stray rk3568_jpeg_enc_codec_ops to
   rk3568_vepu_codec_ops
 - devicetree: remove interrupt-names property
 - rebase onto linux-next

Changes in v3:
 - bindings: change consts to an enum
 - bindings: add check to make sure devices with a -vepu compatible only
   have the vepu interrupt

Changes in v2:
 - rename compatible as it's not JPEG only
 - rename device tree nodes as it's not JPEG only
 - reword commits as it's not JPEG only
 - get rid of a whole bunch of redundant struct definitions, as, you
   guessed it, it's not JPEG only

Nicolas Frattaroli (3):
  media: dt-binding: media: Add rockchip-vepu binding
  media: hantro: Add support for RK356x encoder
  arm64: dts: rockchip: Add Hantro encoder node to rk356x

 .../bindings/media/rockchip-vepu.yaml         | 64 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      | 20 ++++++
 drivers/staging/media/hantro/hantro_drv.c     |  1 +
 drivers/staging/media/hantro/hantro_hw.h      |  1 +
 .../staging/media/hantro/rockchip_vpu_hw.c    | 25 ++++++++
 6 files changed, 112 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/rockchip-vepu.yaml

-- 
2.36.1

