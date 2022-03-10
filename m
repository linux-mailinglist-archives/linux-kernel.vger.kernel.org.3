Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8774D3F7C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 04:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238372AbiCJDBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 22:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiCJDBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 22:01:48 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A27B124C3B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 19:00:46 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 376552C0C61;
        Thu, 10 Mar 2022 03:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1646881244;
        bh=bhyF/NCDXANrCw6v9FLOgZoyTG+XDLRL020LrUJIdEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nqdCnlxNG74lIoOiQsoGhAnF2YXVFhcPabOttpOFU0cyA2I7uzLfmIwLPoU+J8iWk
         nFAbVhw6wfr954swdBfDqCF7pym3uWlS9Q9Lw5g2jkqF0lzmqzx4yh1V6iQ9lz1O6A
         3UUvy8ifLBcB4a7qEFjI8Skq165QGVtsSl3zVsgVGenVSKpytQNkjnibhqJNxBQqoI
         YnmhIe+jjhiCmJHvbh1Oev2h7A5MyjOD4jy1wfKm8JGyYPLHNv1lKN3ilzn1VZceOJ
         u4opikFZBYhXtmHDEUu3700binh2Qk8iDexMJmVvxtuUmbnAjiib6vI8Ql9NJk9e/y
         +ZrmAjjFepSqg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B622969db0004>; Thu, 10 Mar 2022 16:00:43 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 9C82913EE9C;
        Thu, 10 Mar 2022 16:00:43 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id ACBCF2A00D4; Thu, 10 Mar 2022 16:00:41 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linus.walleij@linaro.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        kostap@marvell.com, robert.marko@sartura.hr
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v1 4/4] arm64: marvell: enable the 98DX2530 pinctrl driver
Date:   Thu, 10 Mar 2022 16:00:39 +1300
Message-Id: <20220310030039.2833808-5-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310030039.2833808-1-chris.packham@alliedtelesis.co.nz>
References: <20220310030039.2833808-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Cfh2G4jl c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=o8Y5sQTvuykA:10 a=XQcNo-tEeLJW46c85tUA:9
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

This commit makes sure the drivers for the 98DX2530 pin controller is
enabled.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm64/Kconfig.platforms | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 21697449d762..6bbb56901794 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -183,11 +183,13 @@ config ARCH_MVEBU
 	select PINCTRL_ARMADA_37XX
 	select PINCTRL_ARMADA_AP806
 	select PINCTRL_ARMADA_CP110
+	select PINCTRL_AC5
 	help
 	  This enables support for Marvell EBU familly, including:
 	   - Armada 3700 SoC Family
 	   - Armada 7K SoC Family
 	   - Armada 8K SoC Family
+	   - 98DX2530 SoC Family
=20
 config ARCH_MXC
 	bool "ARMv8 based NXP i.MX SoC family"
--=20
2.35.1

