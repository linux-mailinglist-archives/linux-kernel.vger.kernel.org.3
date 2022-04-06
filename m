Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BCC4F619C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbiDFOYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbiDFOYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:24:05 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB1AF3A7C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 20:22:36 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9B1932C099C;
        Wed,  6 Apr 2022 03:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1649215353;
        bh=seiZ/zSp40ediZ6FUmAYZUa2TlaIBma6k+oU9iypC9Q=;
        h=From:To:Cc:Subject:Date:From;
        b=p7kUNgincIv8zKjRb34f5nPBGVG90YYSEtTUwz7W9x48PS6ccq4ecNp+Iwbx3x9P2
         iSotw5k7jId6xOeiJM5AiDSrbX7qE/5eBzW+T7oeNci5iTsuV0TnEod1jOBIKCemta
         eK+CtEizFevPRQpzW6QYI1ILysq/M2nlh5Lw7V4q0cbYONrZfNRGjuqXOfrvxsfl49
         f5aWQEt09mqqiXHDru3j5uQgoLNz8CRAGBR5y35vddijh3/UIlj/otEjJOFl3XES+s
         gIkbiKh4p6nY6A5+Ys9JXZ5YpnhAy00wjAFg+9L0HGeMgRXmE0h1/ftIwxOXYkuDaX
         Nq8gV5gYWEXlQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B624d07790000>; Wed, 06 Apr 2022 15:22:33 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 3D98013EE37;
        Wed,  6 Apr 2022 15:22:33 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id A97D62A2679; Wed,  6 Apr 2022 15:22:28 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linus.walleij@linaro.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        kostap@marvell.com, robert.marko@sartura.hr
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 0/4] arm64: mvebu: Support for Marvell 98DX2530 (and variants)
Date:   Wed,  6 Apr 2022 15:21:54 +1200
Message-Id: <20220406032158.1449049-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=JcrCUnCV c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=z0gMJWrwH1QA:10 a=jGREw9QuPlHGdXEqdN8A:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the Marvell 98DX2530 SoC which is the Contro=
l and
Management CPU integrated into the AlleyCat5/AlleyCat5X series of Marvell
switches.

The CPU core is an ARM Cortex-A55 with neon, simd and crypto extensions.

This is fairly similar to the Armada-3700 SoC so most of the required
peripherals are already supported. This series adds a devicetree and pinc=
trl
driver for the SoC and the RD-AC5X-32G16HVG6HLG reference board.

In the v3 series I've dropped out a few patches. The MMC stuff is more
complicated than just adding a compatible string. The mvneta changes have=
 gone
in via net-next.

Chris Packham (4):
  dt-bindings: pinctrl: mvebu: Document bindings for AC5
  pinctrl: mvebu: pinctrl driver for 98DX2530 SoC
  arm64: dts: marvell: Add Armada 98DX2530 SoC and RD-AC5X board
  arm64: marvell: enable the 98DX2530 pinctrl driver

 .../bindings/pinctrl/marvell,ac5-pinctrl.yaml |  72 +++++
 arch/arm64/Kconfig.platforms                  |   2 +
 arch/arm64/boot/dts/marvell/Makefile          |   1 +
 .../boot/dts/marvell/armada-98dx2530.dtsi     | 302 ++++++++++++++++++
 arch/arm64/boot/dts/marvell/rd-ac5x.dts       |  74 +++++
 drivers/pinctrl/mvebu/Kconfig                 |   4 +
 drivers/pinctrl/mvebu/Makefile                |   1 +
 drivers/pinctrl/mvebu/pinctrl-ac5.c           | 261 +++++++++++++++
 8 files changed, 717 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,ac5=
-pinctrl.yaml
 create mode 100644 arch/arm64/boot/dts/marvell/armada-98dx2530.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/rd-ac5x.dts
 create mode 100644 drivers/pinctrl/mvebu/pinctrl-ac5.c

--=20
2.35.1

