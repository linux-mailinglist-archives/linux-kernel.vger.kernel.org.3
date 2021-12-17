Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CA44789CE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 12:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbhLQLYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 06:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235364AbhLQLYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 06:24:08 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3274EC06173F;
        Fri, 17 Dec 2021 03:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=g3pXkM+tLeMcREG8okalcNDK14B8xjoOzYtz2KiKzEs=; b=j4qMQCI2sk7/Yrdppzllh1hz4U
        s/uQ1HpzYweDf29KFiVB/Ll06o8xbMYB1Z24lFZHBg+t+5DkYbpB8aROORKLGRCGLzQtxHpVnKTHw
        ROMC+phs6tXdrhiHFA9twoqG5KU1wxSy7PeuoMJANELlmklRZ3atracR7hqIMpJhjFLo=;
Received: from p54ae911a.dip0.t-ipconnect.de ([84.174.145.26] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1myBLH-000742-47; Fri, 17 Dec 2021 12:24:03 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     john@phrozen.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 08/14] ARM: dts: add clock support for Airoha EN7523
Date:   Fri, 17 Dec 2021 12:23:38 +0100
Message-Id: <20211217112345.14029-9-nbd@nbd.name>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217112345.14029-1-nbd@nbd.name>
References: <20211217112345.14029-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver only registers fixed rate clocks, since the clocks are fully
initialized by the boot loader and should not be changed later, according
to Airoha.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 arch/arm/boot/dts/en7523.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/en7523.dtsi b/arch/arm/boot/dts/en7523.dtsi
index 7e17311a3f90..0148958c607b 100644
--- a/arch/arm/boot/dts/en7523.dtsi
+++ b/arch/arm/boot/dts/en7523.dtsi
@@ -2,6 +2,7 @@
 
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/en7523-clk.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -82,6 +83,13 @@ L2_0: l2-cache0 {
 		};
 	};
 
+	scu: scu@1fa20000 {
+		compatible = "airoha,en7523-scu";
+		reg = <0x1fa20000 0x400>,
+		      <0x1fb00000 0x1000>;
+		#clock-cells = <1>;
+	};
+
 	gic: interrupt-controller@9000000 {
 		compatible = "arm,gic-v3";
 		interrupt-controller;
-- 
2.34.1

