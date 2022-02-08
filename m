Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579284AE1A8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385547AbiBHS5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385562AbiBHS5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:57:10 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAEBC0612BD;
        Tue,  8 Feb 2022 10:57:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 20703CE1BF0;
        Tue,  8 Feb 2022 18:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84655C34102;
        Tue,  8 Feb 2022 18:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644346625;
        bh=ffXhP80bXiWm6QZsRgVzkuhQFwsVc53UEqMBTezk5bA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QF3gwDPyWo5uLsZKvReJhYDDmS23LwS9BmP1BgkrGVfPcMqj6qaE8uEDETAyJyU3j
         Owkf6EVUXzWHNsdIhsB4msAz4BnJRKqnMXmHR4UJL5oHn4VPrfsETDSdhGiFfhR45/
         Iiny68Le5ygiThMaMsMDnJzrA94GJIoVdVUkTHXYDNCQ5GAdln24QU4Uz/5YFbiIow
         7t54QrKr5hsrYfWol7xUizMxRdsH3pHdgwkwodsGJGvhs0ZHEwPnvAYlzCc5NfMqdr
         67FG9ca8WiHP/9PR3P71NI4SLPMg+4wM2de/RIZ43uKPpvl9y/+efQCPWuXI6OJPrW
         yIdx+a2SFCK3A==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nHVfj-006MEi-JJ; Tue, 08 Feb 2022 18:57:03 +0000
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
Subject: [PATCH v5 06/10] arm64: dts: apple: Add t8103 PMU interrupt affinities
Date:   Tue,  8 Feb 2022 18:56:00 +0000
Message-Id: <20220208185604.1097957-7-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220208185604.1097957-1-maz@kernel.org>
References: <20220208185604.1097957-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, will@kernel.org, marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, robh+dt@kernel.org, tglx@linutronix.de, dougallj@gmail.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 19afbc91020a..a2e006538c56 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -213,6 +213,18 @@ aic: interrupt-controller@23b100000 {
 			interrupt-controller;
 			reg = <0x2 0x3b100000 0x0 0x8000>;
 			power-domains = <&ps_aic>;
+
+			affinities {
+				e-core-pmu-affinity {
+					apple,fiq-index = <AIC_CPU_PMU_E>;
+					cpus = <&cpu0 &cpu1 &cpu2 &cpu3>;
+				};
+
+				p-core-pmu-affinity {
+					apple,fiq-index = <AIC_CPU_PMU_P>;
+					cpus = <&cpu4 &cpu5 &cpu6 &cpu7>;
+				};
+			};
 		};
 
 		pmgr: power-management@23b700000 {
-- 
2.30.2

