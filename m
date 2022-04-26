Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF9B510952
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 21:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354286AbiDZTzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 15:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiDZTzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 15:55:01 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3116B0A4;
        Tue, 26 Apr 2022 12:51:50 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1njRDu-0006aF-4F; Tue, 26 Apr 2022 21:51:46 +0200
Date:   Tue, 26 Apr 2022 20:51:36 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH] arm64: dts: mediatek: mt7622: fix GICv2 range
Message-ID: <YmhNSLgp/yg8Vr1F@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the current range specified for the CPU interface there is an
error message at boot:

GIC: GICv2 detected, but range too small and irqchip.gicv2_force_probe not set

Setting irqchip.gicv2_force_probe=1 in bootargs results in:

GIC: Aliased GICv2 at 0x0000000010320000, trying to find the canonical range over 128kB
GIC: Adjusting CPU interface base to 0x000000001032f000
GIC: Using split EOI/Deactivate mode

Using the adjusted CPU interface base and 8K size results in only the
final line remaining and fully working system as well as /proc/interrupts
showing additional IPI3,4,5,6:

IPI3:         0          0       CPU stop (for crash dump) interrupts
IPI4:         0          0       Timer broadcast interrupts
IPI5:         0          0       IRQ work interrupts
IPI6:         0          0       CPU wake-up interrupts

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 8c2563a3919a40..759803c2ce1577 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -332,7 +332,7 @@ gic: interrupt-controller@10300000 {
 		#interrupt-cells = <3>;
 		interrupt-parent = <&gic>;
 		reg = <0 0x10310000 0 0x1000>,
-		      <0 0x10320000 0 0x1000>,
+		      <0 0x1032f000 0 0x2000>,
 		      <0 0x10340000 0 0x2000>,
 		      <0 0x10360000 0 0x2000>;
 	};
-- 
2.36.0

