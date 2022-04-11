Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCECA4FBC27
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346105AbiDKMfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239527AbiDKMfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:35:08 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C6C3EBB9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 05:32:50 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:b509:6862:2557:437a])
        by michel.telenet-ops.be with bizsmtp
        id HQYm2700Z1G7NMJ06QYm34; Mon, 11 Apr 2022 14:32:48 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ndtDp-000AML-WB; Mon, 11 Apr 2022 14:32:46 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ndtDp-009IkF-I1; Mon, 11 Apr 2022 14:32:45 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Magnus Damm <magnus.damm@gmail.com>
Cc:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ARM: dts: r9a06g032: Drop "arm,cortex-a7-timer" from timer node
Date:   Mon, 11 Apr 2022 14:32:44 +0200
Message-Id: <a8e0cf00a983b4c539cdb1cfad5cc6b10b423c5b.1649680220.git.geert+renesas@glider.be>
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

"make dtbs_check":

    arch/arm/boot/dts/r9a06g032-rzn1d400-db.dt.yaml: timer: compatible: 'oneOf' conditional failed, one must be fixed:
	    ['arm,cortex-a7-timer', 'arm,armv7-timer'] is too long
	    'arm,cortex-a7-timer' is not one of ['arm,cortex-a15-timer']
	    'arm,cortex-a7-timer' is not one of ['arm,armv7-timer']
	    'arm,cortex-a7-timer' is not one of ['arm,armv8-timer']
	    From schema: Documentation/devicetree/bindings/timer/arm,arch_timer.yaml

The Cortex-A7 timer should just declare compatibility with
"arm,armv7-timer".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
To be queued in renesas-devel for v5.19.

 arch/arm/boot/dts/r9a06g032.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
index 636a6ab31c589c3e..2257706ce84fc70a 100644
--- a/arch/arm/boot/dts/r9a06g032.dtsi
+++ b/arch/arm/boot/dts/r9a06g032.dtsi
@@ -214,8 +214,7 @@ gic: interrupt-controller@44101000 {
 	};
 
 	timer {
-		compatible = "arm,cortex-a7-timer",
-			     "arm,armv7-timer";
+		compatible = "arm,armv7-timer";
 		interrupt-parent = <&gic>;
 		arm,cpu-registers-not-fw-configured;
 		always-on;
-- 
2.25.1

