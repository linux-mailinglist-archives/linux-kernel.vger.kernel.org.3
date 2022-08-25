Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1345A0C80
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238201AbiHYJZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239875AbiHYJZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:25:04 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484D72C135
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 02:24:57 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by xavier.telenet-ops.be with bizsmtp
        id BlQu280064C55Sk01lQuug; Thu, 25 Aug 2022 11:24:54 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oR96b-002VXD-NG; Thu, 25 Aug 2022 11:24:53 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oR96b-005VhA-4g; Thu, 25 Aug 2022 11:24:53 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] arm64: dts: renesas: r8a779g0: Fix HSCIF0 interrupt number
Date:   Thu, 25 Aug 2022 11:24:47 +0200
Message-Id: <751dcef40d4534e856ed49b1d5b3a3e8d365ec42.1661419377.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt number for the HSCIF0 serial port, which serves as the
serial console on the White Hawk board, is incorrect, causing userspace
to hang immediately as soon as it tries to print something.
Kernel output is unaffected, as it is printed using polling.

Fixes: 987da486d84a5643 ("arm64: dts: renesas: Add Renesas R8A779G0 SoC support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Oops, I must have been looking at the wrong datasheet while reviewing
https://lore.kernel.org/r/CAMuHMdVffc4iqX6wAKwyq_eTX5c0H3-tqs_pvsec7v1_q6hS3g@mail.gmail.com

To be queued in renesas-fixes.
---
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
index 7cbb0de060ddc03b..1c15726cff8bf10f 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
@@ -85,7 +85,7 @@ hscif0: serial@e6540000 {
 				     "renesas,rcar-gen4-hscif",
 				     "renesas,hscif";
 			reg = <0 0xe6540000 0 96>;
-			interrupts = <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 514>,
 				 <&cpg CPG_CORE R8A779G0_CLK_S0D3_PER>,
 				 <&scif_clk>;
-- 
2.25.1

