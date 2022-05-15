Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DF3527AE0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 01:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237728AbiEOXbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 19:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237143AbiEOXbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 19:31:10 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1A35FC2
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 16:31:01 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 91A842C044A;
        Sun, 15 May 2022 23:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1652657458;
        bh=GZLu1OeaLOTOIoEPp30r9KAOSr1uCNbQE1buOUq0g7s=;
        h=From:To:Cc:Subject:Date:From;
        b=mz8of1ta1LQ1ZQuWlWJNqMjrOO/cGQebNelfMLOYn3BM8scrn+BIiBkKxLH5cwwfx
         xaTgkxTieU2zJ9P5HC8eTpM7tB7wqQ057jt5yoIzjNfagIa2A75BKSLeruGO2BTLyB
         /FTaBI2kpjXS4u/XPMwlkGY04AKjShIDp9WMlDXNydfmye0CDac6zqjxFdNuPiQ23a
         mMGDkNLH5VKIvPt7nrOEbW48moNeboN9u0rUCUI5tKYl3PUYiq7hIcRNy9tH4EJVh4
         GXN/N0gTZISFT4C3DpqcRS804rLA/Yi5Ho5c8LDgAd74kaNt+gBkU+3DyNX8vy0vhf
         gE2ZEsqBOrfaA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B62818d320000>; Mon, 16 May 2022 11:30:58 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 2C60E13EE43;
        Mon, 16 May 2022 11:30:58 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 27A2C2A0086; Mon, 16 May 2022 11:30:58 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        kostap@marvell.com, robert.marko@sartura.hr,
        vadym.kochan@plvision.eu
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v8 0/3] arm64: mvebu: Support for Marvell 98DX2530 (and variants)
Date:   Mon, 16 May 2022 11:30:44 +1200
Message-Id: <20220515233047.531979-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=U+Hs8tju c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=oZkIemNP1mAA:10 a=1gLZ1RiacOvl1JNmVH8A:9
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

The pinctrl changes from v4 have been picked up and are in linux-next so =
I
haven't included them in this round. That leaves just the dts files and a=
 minor
Kconfig update for arm64.

Chris Packham (3):
  dt-bindings: marvell: Document the AC5/AC5X compatibles
  arm64: dts: marvell: Add Armada 98DX2530 SoC and RD-AC5X board
  arm64: marvell: enable the 98DX2530 pinctrl driver

 .../bindings/arm/marvell/armada-98dx25xx.yaml |  32 ++
 arch/arm64/Kconfig.platforms                  |   2 +
 arch/arm64/boot/dts/marvell/Makefile          |   1 +
 .../boot/dts/marvell/armada-98dx25xx.dtsi     | 297 ++++++++++++++++++
 .../boot/dts/marvell/armada-98dx35xx-rd.dts   | 101 ++++++
 .../boot/dts/marvell/armada-98dx35xx.dtsi     |  13 +
 6 files changed, 446 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-=
98dx25xx.yaml
 create mode 100644 arch/arm64/boot/dts/marvell/armada-98dx25xx.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-98dx35xx-rd.dts
 create mode 100644 arch/arm64/boot/dts/marvell/armada-98dx35xx.dtsi

--=20
2.36.1

