Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6CC5196A7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 06:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344544AbiEDEuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 00:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344614AbiEDEuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 00:50:05 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63ABA2CCBC
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 21:46:29 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 45E6B2C044A;
        Wed,  4 May 2022 04:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1651639587;
        bh=C93+mXRX31BdXpVA3Y58To51HyC8bXyh2ozoSRmpz1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rx2UWi/uLYNS7f4iAlGmvy61naMOLZcZ4oaX8nJZIG+diDe1/su+C1TegoGOFeeEC
         quar8tMuhGxUxb2V8PJDEqYQWfrzzdZbvE/KWL2oxDiba1HlMZQmSNjn00iPQgffqa
         qtArDfOqblSuM18ZOBymPGZHrXU2OtucDhMlqNkgRgZ3+aYNsZcj2sRSiyRvLq1CqZ
         6+pQGlpAEE/VVFtv8BLY7XZS0L3HKdZEZ/iZfPcXC47NuDU4loFUgm71QBDG/uSm4M
         YP8VZe6WhnJx8Woo6ZJWDMMQ5N3y7QdPmDpf1Xax6sMiYSLq6iU5qQxpbgQfqBvf8S
         8QDFZbuyNbeiA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B627205220001>; Wed, 04 May 2022 16:46:26 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id E826013EE63;
        Wed,  4 May 2022 16:46:26 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id E4BD72A1FBB; Wed,  4 May 2022 16:46:26 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     catalin.marinas@arm.com, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        kostap@marvell.com, robert.marko@sartura.hr
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v5 2/2] arm64: marvell: enable the 98DX2530 pinctrl driver
Date:   Wed,  4 May 2022 16:46:24 +1200
Message-Id: <20220504044624.951841-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220504044624.951841-1-chris.packham@alliedtelesis.co.nz>
References: <20220504044624.951841-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=C7GXNjH+ c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=oZkIemNP1mAA:10 a=XQcNo-tEeLJW46c85tUA:9
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---

Notes:
    Changes in v5:
    - None
    Changes in v4:
    - None
    Changes in v3:
    - Add review from Andrew
    Changes in v2:
    - None

 arch/arm64/Kconfig.platforms | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 30b123cde02c..229571d57496 100644
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
2.36.0

