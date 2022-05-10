Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE72C522765
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 01:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbiEJXKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 19:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbiEJXKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 19:10:17 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E186294486
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 16:10:13 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 25D9F2C012A;
        Tue, 10 May 2022 23:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1652224210;
        bh=PdPm6LJTDTCiiS+YcsT3r34uGQiAI04kijhj/3xrI3k=;
        h=From:To:Cc:Subject:Date:From;
        b=NFK4AiDg4zLiDuSId6+Od0mL5vIx32aQdaExPbKhDdowKKbNw1ZTD/J27jbG2q+in
         JEEFisWXRJPJ6N7Im6OwZMgcLrooo1o1OLgF0vc0xo7XqpEHqTfnigRdKMLeVl4XIk
         UfLnfnokvpHUS+Dqm2BJwcaZlCJ7EBUBNdDy2xNojdGsKA3metLX74azOaUdVVyO/q
         UTgSKrjGSduGYDaK7Sopqy5QLcLQsv+ppyOElqW8pjeogXNsZJfE54FyFMZF+o3tx5
         vO68Mu52b7Xvih+vodzgOtpatHyprBYOktJjaG8UIap/UlTBXfRAPWF3Tdv9QJDvlB
         TsUG9gdfqVWbg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B627af0d10000>; Wed, 11 May 2022 11:10:09 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id C6A5F13EE40;
        Wed, 11 May 2022 11:10:09 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id C18F92A00D3; Wed, 11 May 2022 11:10:09 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        kostap@marvell.com, robert.marko@sartura.hr
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v6 0/3] arm64: mvebu: Support for Marvell 98DX2530 (and variants)
Date:   Wed, 11 May 2022 11:09:59 +1200
Message-Id: <20220510231002.1160798-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=C7GXNjH+ c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=oZkIemNP1mAA:10 a=1gLZ1RiacOvl1JNmVH8A:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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

 .../bindings/arm/marvell/armada-98dx2530.yaml |  27 ++
 arch/arm64/Kconfig.platforms                  |   2 +
 arch/arm64/boot/dts/marvell/Makefile          |   1 +
 .../boot/dts/marvell/armada-98dx2530.dtsi     | 313 ++++++++++++++++++
 arch/arm64/boot/dts/marvell/rd-ac5x.dts       |  90 +++++
 5 files changed, 433 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-=
98dx2530.yaml
 create mode 100644 arch/arm64/boot/dts/marvell/armada-98dx2530.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/rd-ac5x.dts

--=20
2.36.0

