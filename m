Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522564A8310
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 12:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237660AbiBCLXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 06:23:48 -0500
Received: from muru.com ([72.249.23.125]:45940 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350189AbiBCLXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 06:23:45 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id C8CD7817C;
        Thu,  3 Feb 2022 11:23:28 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Tero Kristo <kristo@kernel.org>
Subject: [PATCH 3/3] dt-bindings: clock: ti: Add clock-output-names for TI composite clocks
Date:   Thu,  3 Feb 2022 13:23:37 +0200
Message-Id: <20220203112337.19821-3-tony@atomide.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220203112337.19821-1-tony@atomide.com>
References: <20220203112337.19821-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the TI composite clocks, we currently have only the divider clock
list clock-output-names as an optional devicetree property. Let's add
clock-output-names for all the TI composite clock bindings.

This allows us to use clock-output-names for the clockctrl instance name
instead of relying on a custom compatible or non-standard node names.

Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Tero Kristo <kristo@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 Documentation/devicetree/bindings/clock/ti/clockdomain.txt     | 3 +++
 Documentation/devicetree/bindings/clock/ti/composite.txt       | 3 +++
 .../devicetree/bindings/clock/ti/fixed-factor-clock.txt        | 1 +
 Documentation/devicetree/bindings/clock/ti/gate.txt            | 1 +
 Documentation/devicetree/bindings/clock/ti/interface.txt       | 1 +
 Documentation/devicetree/bindings/clock/ti/mux.txt             | 1 +
 6 files changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/ti/clockdomain.txt b/Documentation/devicetree/bindings/clock/ti/clockdomain.txt
--- a/Documentation/devicetree/bindings/clock/ti/clockdomain.txt
+++ b/Documentation/devicetree/bindings/clock/ti/clockdomain.txt
@@ -17,6 +17,9 @@ Required properties:
 - #clock-cells : from common clock binding; shall be set to 0.
 - clocks : link phandles of clocks within this domain
 
+Optional properties:
+- clock-output-names : from common clock binding.
+
 Examples:
 	dss_clkdm: dss_clkdm {
 		compatible = "ti,clockdomain";
diff --git a/Documentation/devicetree/bindings/clock/ti/composite.txt b/Documentation/devicetree/bindings/clock/ti/composite.txt
--- a/Documentation/devicetree/bindings/clock/ti/composite.txt
+++ b/Documentation/devicetree/bindings/clock/ti/composite.txt
@@ -27,6 +27,9 @@ Required properties:
 - clocks : link phandles of component clocks
 - #clock-cells : from common clock binding; shall be set to 0.
 
+Optional properties:
+- clock-output-names : from common clock binding.
+
 Examples:
 
 usb_l4_gate_ick: usb_l4_gate_ick {
diff --git a/Documentation/devicetree/bindings/clock/ti/fixed-factor-clock.txt b/Documentation/devicetree/bindings/clock/ti/fixed-factor-clock.txt
--- a/Documentation/devicetree/bindings/clock/ti/fixed-factor-clock.txt
+++ b/Documentation/devicetree/bindings/clock/ti/fixed-factor-clock.txt
@@ -16,6 +16,7 @@ Required properties:
 - clocks: parent clock.
 
 Optional properties:
+- clock-output-names : from common clock binding.
 - ti,autoidle-shift: bit shift of the autoidle enable bit for the clock,
   see [2]
 - reg: offset for the autoidle register of this clock, see [2]
diff --git a/Documentation/devicetree/bindings/clock/ti/gate.txt b/Documentation/devicetree/bindings/clock/ti/gate.txt
--- a/Documentation/devicetree/bindings/clock/ti/gate.txt
+++ b/Documentation/devicetree/bindings/clock/ti/gate.txt
@@ -36,6 +36,7 @@ Required properties:
 	ti,clkdm-gate-clock type
 
 Optional properties:
+- clock-output-names : from common clock binding.
 - ti,bit-shift : bit shift for programming the clock gate, invalid for
 		 ti,clkdm-gate-clock type
 - ti,set-bit-to-disable : inverts default gate programming. Setting the bit
diff --git a/Documentation/devicetree/bindings/clock/ti/interface.txt b/Documentation/devicetree/bindings/clock/ti/interface.txt
--- a/Documentation/devicetree/bindings/clock/ti/interface.txt
+++ b/Documentation/devicetree/bindings/clock/ti/interface.txt
@@ -28,6 +28,7 @@ Required properties:
 - reg : base address for the control register
 
 Optional properties:
+- clock-output-names : from common clock binding.
 - ti,bit-shift : bit shift for the bit enabling/disabling the clock (default 0)
 
 Examples:
diff --git a/Documentation/devicetree/bindings/clock/ti/mux.txt b/Documentation/devicetree/bindings/clock/ti/mux.txt
--- a/Documentation/devicetree/bindings/clock/ti/mux.txt
+++ b/Documentation/devicetree/bindings/clock/ti/mux.txt
@@ -42,6 +42,7 @@ Required properties:
 - reg : register offset for register controlling adjustable mux
 
 Optional properties:
+- clock-output-names : from common clock binding.
 - ti,bit-shift : number of bits to shift the bit-mask, defaults to
   0 if not present
 - ti,index-starts-at-one : valid input select programming starts at 1, not
-- 
2.35.1
