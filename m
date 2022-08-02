Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9819E587AF4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 12:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236604AbiHBKp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 06:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbiHBKpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 06:45:16 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6E155BC;
        Tue,  2 Aug 2022 03:45:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9F860CE10EC;
        Tue,  2 Aug 2022 10:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193D1C433D7;
        Tue,  2 Aug 2022 10:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659437107;
        bh=uK9I3WB5J7p9D/LzHIBJ3uwN3PHEVPmRvawF9Vh0N0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gQJVTwBHg7iCUY3pWPY+NoPbvEF74gNrmUy05OFRP4NQOPkyJ+5VnshoFFdvRl9b2
         nEBzwn0vHWb2idODE2dZRtTOPr+lJcodhc+ctI1rF+4hJZYLrLXgaxSq3w++2fC6Nl
         oVoKLMXXHUnT/pVpt81Y9sZ9nexm3YLl54OCt313LvDKa0ZSdobaY7G8hUVqnCHbzA
         5Fvl2NFd/vhvHbZSB7KjerstmK5T2KzNllSRQquI4cyLlbSfsFNcmXBbJQ64OL+NP5
         3DAscPjB2d3MUNeIBkt/jt14N6/MUrueIomr0SVYnl/s6ZHxhqKa8is3vq5Ce8JjF2
         slq6dfnnvrSSQ==
From:   Roger Quadros <rogerq@kernel.org>
To:     nm@ti.com, vigneshr@ti.com
Cc:     kishon@ti.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v4 2/2] arm64: dts: ti: k3-am64-main: Add ELM (Error Location Module) node
Date:   Tue,  2 Aug 2022 13:44:56 +0300
Message-Id: <20220802104456.11069-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220802104456.11069-1-rogerq@kernel.org>
References: <20220802104456.11069-1-rogerq@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ELM module is used for GPMC NAND accesses for detecting
and correcting errors during reads due to NAND bitflips errors.

4-, 8-, and 16-bit error-correction levels are supported using
the BCH (Bose-ChaudhurI-Hocquenghem) algorithm.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 9 +++++++++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts  | 4 ++++
 arch/arm64/boot/dts/ti/k3-am642-sk.dts   | 4 ++++
 3 files changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 0059de0aeedf..c1caa7c7c6eb 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -1327,4 +1327,13 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
+
+	elm0: ecc@25010000 {
+		compatible = "ti,am64-elm";
+		reg = <0x00 0x25010000 0x00 0x2000>;
+		interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 54 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 54 0>;
+		clock-names = "fck";
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 30647fc3eec2..abc0fe61b6b8 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -680,3 +680,7 @@
 &gpmc0 {
 	status = "disabled";
 };
+
+&elm0 {
+	status = "disabled";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index bd9b36b16787..bec1edfeef37 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -597,3 +597,7 @@
 &gpmc0 {
 	status = "disabled";
 };
+
+&elm0 {
+	status = "disabled";
+};
-- 
2.17.1

