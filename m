Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001E34993CB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 21:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387217AbiAXUgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 15:36:40 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39684 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347369AbiAXUMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 15:12:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C44261446;
        Mon, 24 Jan 2022 20:12:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF9AC340EC;
        Mon, 24 Jan 2022 20:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643055159;
        bh=YaKveBwpxFwRietemPz69WhA3Q6XcSoMygr0LTUe+c4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dzdSp0Q/0bEw3FZcskjmxWxEv4BUzUpUo927d5k7SvXXcPEyMGltnVzcvfNiEjqFr
         yuVUkoOvuZKkm4rk50GKgf7+ncr9dn/XFDy7huf7kNMC77demCKwDc23kn+N6moIDe
         ix6y3tsXqiDFDuPxyKg+eHyHEbuyp29CtpygcpNqu9soLQYt77DY/ZcZdo+mC5CJ+H
         bnl4/ckal2VijVyUs/wyJplYBlARw5w960SEPbmzBtsWxqOh5wjyS9UmFmdLRPmZWu
         ZfnnJmqp5tKpz89g05zaXlhT7KbeLH1CDbJ9RwtYrx4tTI2bYVWpOUhlrUfuxZTYpq
         3ysRYa5uA/XDQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nC5hd-002Y3f-Nx; Mon, 24 Jan 2022 20:12:37 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dougall <dougallj@gmail.com>, kernel-team@android.com
Subject: [PATCH v4 07/10] arm64: dts: apple: Add t8303 PMU nodes
Date:   Mon, 24 Jan 2022 20:12:28 +0000
Message-Id: <20220124201231.298961-8-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124201231.298961-1-maz@kernel.org>
References: <20220124201231.298961-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, will@kernel.org, marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, robh+dt@kernel.org, tglx@linutronix.de, dougallj@gmail.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Advertise the two PMU nodes for the t8103 SoC.

Reviewed-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/boot/dts/apple/t8103.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index ca856f9955d8..aa0768ecb800 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -97,6 +97,18 @@ timer {
 			     <AIC_FIQ AIC_TMR_HV_VIRT IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	pmu-e {
+		compatible = "apple,icestorm-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_FIQ AIC_CPU_PMU_E IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	pmu-p {
+		compatible = "apple,firestorm-pmu";
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_FIQ AIC_CPU_PMU_P IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	clkref: clock-ref {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-- 
2.30.2

