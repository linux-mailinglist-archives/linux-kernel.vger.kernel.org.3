Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB11572125
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbiGLQl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiGLQlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:41:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976F1B31F0;
        Tue, 12 Jul 2022 09:41:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F0B061943;
        Tue, 12 Jul 2022 16:41:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4E0C341C0;
        Tue, 12 Jul 2022 16:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657644077;
        bh=bnrIiFlK9D2TsTIOY/TJyiBk3yRsU3u0vZgDR+kcVq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y1xSwDtpxeoE/xLUlPKH7ydSAMBXzxvWaeLbXp552Q0dDOghmymVemW3r9Q18QaGJ
         1D/8AWf45NwJH8+mej3njVbvmTbflWnNWThSIBrAA/jXR+jPEVUO5wzSkEFxMFIfWt
         R8+KefzI35uQqwwJ+YE4HYwIr2vzR9j5cTa8b68Izu9cOT9G+XEDjk07mWf6npNGQi
         8TFJw1dYAM84jZQ5ZJWDn38SNRalDn3srmQX3WZCpeD2gMeG+QFdTsOmFRwl5DeX+C
         aucQwlL8S9qHRXZvt1WUW9whvnJbBSP9UB09s7WkFKvlVcy7fvzz8oyT9SETJJwReh
         sZCLpEXU64qZA==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 02/10] ARM: dts: dove: Add definitions for PCIe legacy INTx interrupts
Date:   Tue, 12 Jul 2022 18:41:00 +0200
Message-Id: <20220712164108.30262-3-kabel@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220712164108.30262-1-kabel@kernel.org>
References: <20220712164108.30262-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Add definitions for PCIe legacy INTx interrupts.

This is required for example in a scenario where a driver requests only
one of the legacy interrupts (INTA). Without this, the driver would be
notified on events on all 4 (INTA, INTB, INTC, INTD), even if it
requested only one of them.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 arch/arm/boot/dts/dove.dtsi | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 89e0bdaf3a85..96ba47c061a7 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -122,8 +122,18 @@ pcie0: pcie@1 {
 				bus-range = <0x00 0xff>;
 
 				#interrupt-cells = <1>;
-				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &intc 16>;
+				interrupt-names = "intx";
+				interrupts = <16>;
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &pcie0_intc 0>,
+						<0 0 0 2 &pcie0_intc 1>,
+						<0 0 0 3 &pcie0_intc 2>,
+						<0 0 0 4 &pcie0_intc 3>;
+
+				pcie0_intc: interrupt-controller {
+					interrupt-controller;
+					#interrupt-cells = <1>;
+				};
 			};
 
 			pcie1: pcie@2 {
@@ -141,8 +151,18 @@ pcie1: pcie@2 {
 				bus-range = <0x00 0xff>;
 
 				#interrupt-cells = <1>;
-				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &intc 18>;
+				interrupt-names = "intx";
+				interrupts = <18>;
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &pcie1_intc 0>,
+						<0 0 0 2 &pcie1_intc 1>,
+						<0 0 0 3 &pcie1_intc 2>,
+						<0 0 0 4 &pcie1_intc 3>;
+
+				pcie1_intc: interrupt-controller {
+					interrupt-controller;
+					#interrupt-cells = <1>;
+				};
 			};
 		};
 
-- 
2.35.1

