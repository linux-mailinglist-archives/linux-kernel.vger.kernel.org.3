Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68034CD3B0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 12:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbiCDLmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 06:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiCDLmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 06:42:04 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7B9162013;
        Fri,  4 Mar 2022 03:41:16 -0800 (PST)
Received: from Monstersaurus.ksquared.org.uk.beta.tailscale.net (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B971D51C;
        Fri,  4 Mar 2022 12:41:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1646394074;
        bh=znyJ/7LFtbo32JZV1vCfRMhmsn+HUg4UTHM7rnmyVe8=;
        h=From:To:Cc:Subject:Date:From;
        b=F6zHpnkwai2c7OsKRk5k0Mjvwc82dbr4e5vtOsxIzLVLrQnYaIXRsTm+zNZ4e3c4D
         /EUbSu4cN2IW+5NYS3GH4xN1iLKurnQn/4TbO9qS8aNIueHnVvpfM/mY+A5z6ILyQE
         OhOidrPUXTVzZfW/p9bGDUTYpelBeqv34yFcmISs=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     Geert Uytterhoeven <geert@glider.be>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: dts: renesas: falcon-cpu: Use INTC_EX for SN65DSI86
Date:   Fri,  4 Mar 2022 11:41:10 +0000
Message-Id: <20220304114110.3939390-1-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The INTC block is a better choice for handling the interrupts on the V3U
as the INTC will always be powered, while the GPIO block may be
de-clocked if not in use. Further more, it may be likely to have a lower
power consumption as it does not need to drive the pins.

Switch the interrupt parent and interrupts definition from gpio1 to
intc_ex, allowing the PFC to configure the pin muxing accordingly.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---
 arch/arm64/boot/dts/renesas/r8a779a0-falcon-cpu.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a779a0-falcon-cpu.dtsi b/arch/arm64/boot/dts/renesas/r8a779a0-falcon-cpu.dtsi
index 6af3f4f4f268..b7254a0f08b6 100644
--- a/arch/arm64/boot/dts/renesas/r8a779a0-falcon-cpu.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779a0-falcon-cpu.dtsi
@@ -198,8 +198,8 @@ bridge@2c {
 		clocks = <&sn65dsi86_refclk>;
 		clock-names = "refclk";
 
-		interrupt-parent = <&gpio1>;
-		interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&intc_ex>;
+		interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
 
 		vccio-supply = <&reg_1p8v>;
 		vpll-supply = <&reg_1p8v>;
-- 
2.32.0

