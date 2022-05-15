Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289F5527AE8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 01:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238067AbiEOXbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 19:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236574AbiEOXbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 19:31:09 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9645FB6
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 16:31:01 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9F8612C064F;
        Sun, 15 May 2022 23:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1652657458;
        bh=QTv0WPvCW6I+t9KFIXgK7cvfOxfs3q/co2r5/gsWjUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oRfE2OrDo0J9IBIeB/qZzcpxXFI4isNIbXRFzsPIQdyHlc0Z5uiaZEsi06w2lgSR+
         Ai4oLb6r72FBS/EhpQtyPAy7whhR2l7mRl03LdaIhw0Rvt+EBIDveNl5TFACZdSMO2
         XdVLZgSBtiksRtPCeS94DCbZ03NMvL9+OMtjsyquuFHHSNZK6Dy74nxtH5m4eIYF0t
         KlvygsxBq66zhWiZeX5bP8sF/rtUdcKKb7jG52M1wWM1gbEw+Gr+RCth1RLfzsQQc1
         fVIYhNmVTk+d6q677gLyOagx3BqWSBsm5Gw9cUxPLELi9Zs3Aq/XGb09EWuK/LDRsU
         usdlUMnmTUvIw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B62818d320003>; Mon, 16 May 2022 11:30:58 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 332F313EEA2;
        Mon, 16 May 2022 11:30:58 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 30D592A0087; Mon, 16 May 2022 11:30:58 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        kostap@marvell.com, robert.marko@sartura.hr,
        vadym.kochan@plvision.eu
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v8 3/3] arm64: marvell: enable the 98DX2530 pinctrl driver
Date:   Mon, 16 May 2022 11:30:47 +1200
Message-Id: <20220515233047.531979-4-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220515233047.531979-1-chris.packham@alliedtelesis.co.nz>
References: <20220515233047.531979-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=U+Hs8tju c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=oZkIemNP1mAA:10 a=fS6p1-WInKxkAavKfkQA:9
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

This commit makes sure the drivers for the 98DX2530 pin controller is
enabled.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---

Notes:
    Changes in v8:
    - None
    Changes in v7:
    - None
    Changes in v6:
    - None
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
2.36.1

