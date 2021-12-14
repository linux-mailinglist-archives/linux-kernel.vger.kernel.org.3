Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94014474AD6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 19:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbhLNS1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 13:27:14 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45166 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236978AbhLNS1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 13:27:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3872A616AE;
        Tue, 14 Dec 2021 18:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBF2C34616;
        Tue, 14 Dec 2021 18:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639506421;
        bh=lrQBxnPKakBskTuTHDy0fesvNIkq1zW+D8shl9z0RbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=shmcsCVpHR0g531BoJSgMCy00Sq8FBpCIdU5QQUDqM2MpIa5hUgm6q4V3ev9rAzm0
         26XwQ44Iw0jzmvBLzGVFSxfP4W0c7mDZ2L4zRF3xx3t7p20TNRJvC+6HP/WXWNCkel
         JfEqOwKssHyBpQXiAsHshmkaR0dMEIRp7JpppL9YzDX0xJ4witxMwxY9tVRf18SNpw
         UKtQz7YQFOymvvdC8HztNkSD410W1mtsfPBx8+IbCvtLTAhhh6nHmwaOMdaQ062ucA
         1BDNJXDOd+7cdqiVmEk29GmzBo1yo1+JJRv/soT8cN+83aP/FcBj05wgraR5a9U+g3
         1qE0ruOf2LDEg==
Received: from cfbb000407.r.cam.camfibre.uk ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mxCVv-00C7Tq-PA; Tue, 14 Dec 2021 18:26:59 +0000
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
Subject: [PATCH v3 06/10] arm64: dts: apple: Add t8103 PMU interrupt affinities
Date:   Tue, 14 Dec 2021 18:26:30 +0000
Message-Id: <20211214182634.727330-7-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211214182634.727330-1-maz@kernel.org>
References: <20211214182634.727330-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, will@kernel.org, marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, robh+dt@kernel.org, tglx@linutronix.de, dougallj@gmail.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two PMU pseudo interrupts have specific affinities. One set
is affine to the small cores, and the other set affine to the
big ones.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/boot/dts/apple/t8103.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index e22c9433d5e0..207ee69e6e2e 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -132,6 +132,18 @@ aic: interrupt-controller@23b100000 {
 			#interrupt-cells = <3>;
 			interrupt-controller;
 			reg = <0x2 0x3b100000 0x0 0x8000>;
+
+			affinities {
+				e-core-pmu-affinity {
+					fiq-index = <AIC_CPU_PMU_E>;
+					affinity = <&cpu0 &cpu1 &cpu2 &cpu3>;
+				};
+
+				p-core-pmu-affinity {
+					fiq-index = <AIC_CPU_PMU_P>;
+					affinity = <&cpu4 &cpu5 &cpu6 &cpu7>;
+				};
+			};
 		};
 
 		pinctrl_ap: pinctrl@23c100000 {
-- 
2.30.2

