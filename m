Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243D5547AE3
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 17:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237771AbiFLPyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 11:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiFLPyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 11:54:32 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EB036329;
        Sun, 12 Jun 2022 08:54:30 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bg6so6861765ejb.0;
        Sun, 12 Jun 2022 08:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fgRDXCG0152Z3tFDn2gSPrHtara3Cv/otakf5tLuBg8=;
        b=bKKJa3yTkzViWR9SYaKXSbaSBhzt4NWlst6pZhou6xHjuwAuCAVDMPsgZorewuVY/A
         LBP+qx0Y3f8GjqZ63quFAqx84tof3XZB0cChOUbRJvtDgHofl0AWieEBXGSUlT6wGwID
         TuhUSYAufWyRrwU3Q0F/E5uMr8hL9QhxCJqM6g4UxsbQIx6pnAQzea2emEGvnKUGUqzw
         8H0u+ZjuDI7qeK1IwkRwE295OYNuKHfaIKWUOQDtgTzzJWFbDq7OaFy4H6MHeTFhN35j
         S8bX+mlaAf1tNkdBJ0Mf4EFricO0bEe6KBfc1+W1dxj1nCekiBT2k8muiUNYaPOhdP6U
         J6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fgRDXCG0152Z3tFDn2gSPrHtara3Cv/otakf5tLuBg8=;
        b=qCzkHld1Vqxr5MQj3ujN07FjSouC1G1+TwKQLxiiB1dFJ4y7wuRCpZgFVDmaq9v2MM
         gxUeuG0ieTqX/gnEGe136dXNBIH6ntVMotFBwRr5+G+A/1ai49eAEWeuInXnFg9jJgiV
         mVePzhUShFLy1gJGM5Rb24mDxITNHOl1OlSyIMoWgXFx1KKQi3rqc4/vI51/c25EWNkZ
         dDb1qHo1L7kvlc3pdITyZPPle+k2LJlYyH6tLdi7wu627vZo+0tId35MsEHsE3XCetr2
         /6tCIj6vToO+fI0DwY4/fSIul9VqaKf+uQi71DnkAUPhDUy1fTJ79I10hDk1/3idCRnB
         eo7w==
X-Gm-Message-State: AOAM531Q8sSAd+N5VlB3p2FH7UPO7VfBSJz8RVPyLJCa35zWb+QzVLM4
        kUrUZZ9TAP5FoBivKWMN4s0=
X-Google-Smtp-Source: ABdhPJwxbSdECkbBuOQJjUIZERJaR0TEJtWoXqbo0LfKbmT+uXP9XNPSyMZm98oHFA6EIt/82xSd+A==
X-Received: by 2002:a17:906:1f09:b0:70d:b470:1aaa with SMTP id w9-20020a1709061f0900b0070db4701aaamr45775524ejj.758.1655049269268;
        Sun, 12 Jun 2022 08:54:29 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id o1-20020a1709064f8100b006f3ef214de7sm2609459eju.77.2022.06.12.08.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 08:54:28 -0700 (PDT)
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
Subject: [PATCH v5 0/3] Enable JPEG Encoder on RK3566/RK3568
Date:   Sun, 12 Jun 2022 17:53:43 +0200
Message-Id: <20220612155346.16288-1-frattaroli.nicolas@gmail.com>
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

this is v5 of my RK356x JPEG encoder patch set. It enables the Hantro
hardware encoder of the RK3566 and RK3568 line of SoCs, with JPEG being
the only format the driver currently supports encoding for.

The first patch adds a new binding, the rockchip,rk3568-vepu binding, to
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

Regards,
Nicolas Frattaroli

Changes in v5:
 - rename rockchip-vepu.yaml to rockchip,rk3568-vepu.yaml
 - fix #address-cells/#size-cells in bindings example
 - fix indentation in bindings example

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
  media: dt-binding: media: Add rk3568-vepu binding
  media: hantro: Add support for RK356x encoder
  arm64: dts: rockchip: Add Hantro encoder node to rk356x

 .../bindings/media/rockchip,rk3568-vepu.yaml  | 69 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      | 20 ++++++
 drivers/staging/media/hantro/hantro_drv.c     |  1 +
 drivers/staging/media/hantro/hantro_hw.h      |  1 +
 .../staging/media/hantro/rockchip_vpu_hw.c    | 25 +++++++
 6 files changed, 117 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml

-- 
2.36.1

