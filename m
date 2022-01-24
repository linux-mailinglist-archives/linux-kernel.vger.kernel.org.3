Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC396499C36
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 23:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578745AbiAXWDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 17:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377195AbiAXVRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 16:17:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4FAC067A6F;
        Mon, 24 Jan 2022 12:12:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F7C9B8119E;
        Mon, 24 Jan 2022 20:12:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A69C340EA;
        Mon, 24 Jan 2022 20:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643055159;
        bh=D4DFxQ0NvYaCCiIOskF2Q4DtYSIOrAhdQyICBlG0lyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZX8JrGGGuabGiXs84XsSIs0Nd2v6F67VtiUBhCwLEHDFnmRkhmuWl2kbC27OFWRDt
         vqKP+5qVGHVfZRibu/qZCN6xbHPJrFlkPn/75pN0juYXr3wwZ8Hd+vXi8d+BSZutP+
         URFMEb3ap4Rmm/xEtJ0zP2J/PAnqQu8NjG060y6ZhFoE1J5LQSt0bsOqt3K6685n3q
         FIscOUEoOHUz+d6CoRmOLVs4Fuen+phkax1vKYwUQ2n40cy3koNthusFkX3fbyPQ7j
         aK/ciNZk6ttAHlwgynsD1kS2eKXYyPlSU/VHPpK25R+uec2578kDXuFz6lWxAGeDOn
         l2olM/LgT4tFA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nC5hd-002Y3f-Dh; Mon, 24 Jan 2022 20:12:37 +0000
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
Subject: [PATCH v4 06/10] arm64: dts: apple: Add t8103 PMU interrupt affinities
Date:   Mon, 24 Jan 2022 20:12:27 +0000
Message-Id: <20220124201231.298961-7-maz@kernel.org>
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

The two PMU pseudo interrupts have specific affinities. One set
is affine to the small cores, and the other set affine to the
big ones.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/boot/dts/apple/t8103.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index 19afbc91020a..ca856f9955d8 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -213,6 +213,18 @@ aic: interrupt-controller@23b100000 {
 			interrupt-controller;
 			reg = <0x2 0x3b100000 0x0 0x8000>;
 			power-domains = <&ps_aic>;
+
+			affinities {
+				e-core-pmu-affinity {
+					fiq-index = <AIC_CPU_PMU_E>;
+					cpus = <&cpu0 &cpu1 &cpu2 &cpu3>;
+				};
+
+				p-core-pmu-affinity {
+					fiq-index = <AIC_CPU_PMU_P>;
+					cpus = <&cpu4 &cpu5 &cpu6 &cpu7>;
+				};
+			};
 		};
 
 		pmgr: power-management@23b700000 {
-- 
2.30.2

