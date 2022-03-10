Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219EC4D3F80
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 04:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239165AbiCJDCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 22:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237155AbiCJDBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 22:01:51 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D78124C3B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 19:00:49 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D042F2C0676;
        Thu, 10 Mar 2022 03:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1646881243;
        bh=ssg+WNeSXSjip5E5FzNx/K8I5KRUwLfchkkahr8WXcs=;
        h=From:To:Cc:Subject:Date:From;
        b=JD6Pdck0+azTMqVM/ufEu0hk82MCZTtHpEo6FYlc17ctcHTEA6zw1UuuzyBwiazsk
         302cjpuD1hFbJ/nwzLCdcR/qSruprhzcJQdiylHHoKoM1fPYoduvlR+RZORQAD3/kf
         9hmDVytxncQ34s8KpGPTQ1LlBKxzEWtP/bAOB7Y8uLQ52AQn81HpffAPkdAHYWBwNQ
         tKGJZLqGHs23HJaKui8iy4p7dSoDwQzWZqDGAQpr40u245cAynTbFnq8WbjsE4ws0q
         AU3yUyOA/Dap6V4u589CBq9eBzfNv66CPtSkl0gXkal4y3gxR4Pje7nnTllQsEYYS1
         OPT037Tp6aqCA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B622969db0000>; Thu, 10 Mar 2022 16:00:43 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 92F2413EDD7;
        Thu, 10 Mar 2022 16:00:43 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id A165A2A00D4; Thu, 10 Mar 2022 16:00:41 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linus.walleij@linaro.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        kostap@marvell.com, robert.marko@sartura.hr
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v1 0/4] arm64: mvebu: Support for Marvell 98DX2530 (and variants)
Date:   Thu, 10 Mar 2022 16:00:35 +1300
Message-Id: <20220310030039.2833808-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Cfh2G4jl c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=o8Y5sQTvuykA:10 a=jGREw9QuPlHGdXEqdN8A:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Chris Packham (4):
  dt-bindings: pinctrl: mvebu: Document bindings for AC5
  pinctrl: mvebu: pinctrl driver for 98DX2530 SoC
  arm64: dts: marvell: Add Armada 98DX2530 SoC and RD-AC5X board
  arm64: marvell: enable the 98DX2530 pinctrl driver

 .../bindings/pinctrl/marvell,ac5-pinctrl.yaml |  73 +++
 arch/arm64/Kconfig.platforms                  |   2 +
 arch/arm64/boot/dts/marvell/Makefile          |   1 +
 .../boot/dts/marvell/armada-98dx2530.dtsi     | 459 ++++++++++++++++++
 arch/arm64/boot/dts/marvell/rd-ac5x.dts       |  27 ++
 drivers/pinctrl/mvebu/Kconfig                 |   4 +
 drivers/pinctrl/mvebu/Makefile                |   1 +
 drivers/pinctrl/mvebu/pinctrl-ac5.c           | 226 +++++++++
 8 files changed, 793 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,ac5=
-pinctrl.yaml
 create mode 100644 arch/arm64/boot/dts/marvell/armada-98dx2530.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/rd-ac5x.dts
 create mode 100644 drivers/pinctrl/mvebu/pinctrl-ac5.c

--=20
2.35.1

