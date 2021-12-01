Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75145464882
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347680AbhLAHda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:33:30 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60416 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347637AbhLAHdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:33:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E71D2B81DBE;
        Wed,  1 Dec 2021 07:29:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C0BC53FAD;
        Wed,  1 Dec 2021 07:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638343794;
        bh=FC8+NrK3g3u21XVQNMSt0ZiUgeoVa8SH0bDWkvPD2Mg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HWo8UmiH7IM1HNshrnWXuSljft9WpQPJ+NujjHMDUvhS9jpcldmcnGO0Y9L0LUPAM
         Bvc2eubLc7xqb83uayvPKowneH90xLOGAKcUI7JQ0BbRN3y5jyoV0A2fieNOw2E2eb
         TdpyT/uHIJTFifRN7VWA1owUy7kk5uy81b/9Mw78ahAoEac/0LZnmvy+r22E5Yz7eG
         arS1fE+BdarRenlCSNwrBAKTI71iOEn/r9JSSL0tu89AJC5+OBDOKkthBNcS1MEwPY
         EGIhJQykkAbngrx3fl0FPf7aZwMHI0pDQbrrEDqbWOwL9Ltbyg3EzqpxceHfZdh7KN
         vx03zkjKxIJcw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/15] arm64: dts: qcom: sm8450: add spmi node
Date:   Wed,  1 Dec 2021 12:59:11 +0530
Message-Id: <20211201072915.3969178-12-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211201072915.3969178-1-vkoul@kernel.org>
References: <20211201072915.3969178-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the spmi bus as found in the SM8450 SoC

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 4c7cdcea33fa..25d93a51ac19 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -645,6 +645,24 @@ pdc: interrupt-controller@b220000 {
 			interrupt-controller;
 		};
 
+		spmi_bus: spmi@c42d000 {
+			compatible = "qcom,spmi-pmic-arb";
+			reg = <0x0 0x0c400000 0x0 0x00003000>,
+			      <0x0 0x0c500000 0x0 0x00400000>,
+			      <0x0 0x0c440000 0x0 0x00080000>,
+			      <0x0 0x0c4c0000 0x0 0x00010000>,
+			      <0x0 0x0c42d000 0x0 0x00010000>;
+			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
+			interrupt-names = "periph_irq";
+			interrupts-extended = <&pdc 1 IRQ_TYPE_LEVEL_HIGH>;
+			qcom,ee = <0>;
+			qcom,channel = <0>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+			interrupt-controller;
+			#interrupt-cells = <4>;
+		};
+
 		tlmm: pinctrl@f100000 {
 			compatible = "qcom,sm8450-tlmm";
 			reg = <0 0x0f100000 0 0x300000>;
-- 
2.31.1

