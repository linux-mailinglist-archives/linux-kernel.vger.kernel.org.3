Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA62512574
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 00:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbiD0Wsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 18:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbiD0Ws3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 18:48:29 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41871BEBF;
        Wed, 27 Apr 2022 15:45:14 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id y3so6093367ejo.12;
        Wed, 27 Apr 2022 15:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ULuEHFX75GMwmo8k2GzRUntcH3yDcucdCP1qTc/I1I4=;
        b=ml8uzSNJMVs1/c6qGisCf+ClB3pqZe7KZtcX9j50z3ZpwAqed+4ReF/LBsDS6MEa13
         fcf1XXRgzmoNG60h+AX1FFwo1w3N5Tx84W0KYKYDSSlXYm07xf9MyW27uXcw47ArSttb
         y5ZNDJXdKgUbVHtLIUGnhraNOoSizkDT6oyHxJX+vTNrze3tUJbsrpWdGv5SHa+rfhV/
         HjrKmJlCwBbH1WMxtq8+MV4qOvHavNuK4UhqXC+SW5rIgSNenYyv/tofybFkaLG466bw
         ogRBcnYhJHXDhZWM0nAClK0PTcjEZnd5XEPs5//E5udmm8/hj3ueTWnesQsv/zssDiFp
         GLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ULuEHFX75GMwmo8k2GzRUntcH3yDcucdCP1qTc/I1I4=;
        b=thPNRPrwDdRLGc7U9/PMQUNue5wNyVLA9b6MpETf5DfzXMsOspSL1NJap976WpJqG0
         ewkSvbgbslcL7vAZT32xUPbMl8FRj7n/67KF6GaA/GD9kM4qVSASTAotTkFl96CM2wCs
         jpoKFeHYzLNJh/4qPk2S5uzRLCvIoJfJULROGKbiouYIC+p6BEE/rKdAX0qrYPPltugs
         2o2YrpYD4bza9NGpc/dwTvzFQvcZqgj+QsBDYBIGsKZJlHCnG+5qaxLitzMBGrHAsPXT
         r6jAwo/pSWAxjkeUDxZjGlCTIL2fpnMZTztpSw7usEFZaseP14qEfq3RXWtRWE8gFEJ2
         OeHQ==
X-Gm-Message-State: AOAM531zaL2+hFq24znZKUzlpy6chD9YuETDGG9zCN7B6kXU4Klz6kI9
        kuxV5NzlD5O0FQmWpnb+WnM=
X-Google-Smtp-Source: ABdhPJw/kmkRb4ECwQsyT2nZLTfzWQIwaBKXnJ04SiQk3nK6jZlCQaiwz131OR/BDU6OGu6woJ2hCg==
X-Received: by 2002:a17:907:c06:b0:6e0:9149:8047 with SMTP id ga6-20020a1709070c0600b006e091498047mr27930716ejc.765.1651099513153;
        Wed, 27 Apr 2022 15:45:13 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id t27-20020a1709063e5b00b006f3a94f5194sm3762594eji.77.2022.04.27.15.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 15:45:12 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Liang Chen <cl@rock-chips.com>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 0/3] Enable JPEG Encoder on RK3566/RK3568
Date:   Thu, 28 Apr 2022 00:44:35 +0200
Message-Id: <20220427224438.335327-1-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the following series adds support for and enables the hardware JPEG
encoder on the RK3566 and RK3568 line of SoCs by Rockchip.

The JPEG encoder is its own little Hantro instance with seemingly just
the encode functionality.

The first patch modifies the bindings with a new compatible, and adds
the ability to just have a vepu interrupt without a vdpu interrupt.

The second patch makes the actual driver changes to support this variant.

The third and final patch makes the necessary device tree changes for
the rk356x device tree file to add both the node for the encoder and
its MMU.

The series has been tested on a PINE64 Quartz64 Model A with an RK3566
SoC using GStreamer.

Regards,
Nicolas Frattaroli

Nicolas Frattaroli (3):
  dt-bindings: media: rockchip-vpu: Add RK3568 JPEG compatible
  media: hantro: Add support for RK356x JPEG encoder
  arm64: dts: rockchip: Add JPEG encoder node to rk356x

 .../bindings/media/rockchip-vpu.yaml          |  2 +
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      | 21 +++++++
 drivers/staging/media/hantro/hantro_drv.c     |  1 +
 drivers/staging/media/hantro/hantro_hw.h      |  1 +
 .../staging/media/hantro/rockchip_vpu_hw.c    | 62 +++++++++++++++++++
 5 files changed, 87 insertions(+)

-- 
2.36.0

