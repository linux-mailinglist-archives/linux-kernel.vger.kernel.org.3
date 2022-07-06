Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6883B5691EF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbiGFSfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234190AbiGFSex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:34:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B840D220D3;
        Wed,  6 Jul 2022 11:34:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55397B81E8A;
        Wed,  6 Jul 2022 18:34:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C1BC341D2;
        Wed,  6 Jul 2022 18:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657132490;
        bh=6emB0shZlqkchDlQ5/5uGI3aqBajl0+i59MWBCmXheY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O0lXWCXvPsAiXdqh83oHQQwIt9N95gR+Ux321VGt8KfEB0AZoXKmBVtM4mMqkhakp
         5hQcNttUGRnj19PvWycBIBffKERViuuDFlv83wMpHAwGPp9oZ3JcAWjs5DdSK7SWoO
         IDI5vnc9sMvcj5GrCNrNdDS1H2NWUSRr97Hn6/vp+JDC3UYz4s+RXcmGWdOP7T7J4F
         bU2nW7TiwLkbrCmKzx3zxNdC+MJj5kzGRd94XDXaENdywxVgrY4Z2gaPnpScjyQw9/
         +tMaKm3qZIdYmA4mWacpWeT6hDpSParlPxc64JceUKIo9bQbRtQ73gOv5AtGpfTzbk
         OMicIJdhz4q5w==
Received: by pali.im (Postfix)
        id 60885821; Wed,  6 Jul 2022 20:34:47 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] ARM: dts: dove: Add definitions for PCIe legacy INTx interrupts
Date:   Wed,  6 Jul 2022 20:31:05 +0200
Message-Id: <20220706183114.30783-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220706183114.30783-1-pali@kernel.org>
References: <20220706183114.30783-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/arm/boot/dts/dove.dtsi | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 89e0bdaf3a85..96ba47c061a7 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -122,8 +122,18 @@
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
@@ -141,8 +151,18 @@
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
2.20.1

