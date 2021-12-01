Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD4B46487D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237530AbhLAHd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347570AbhLAHdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:33:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43447C061759;
        Tue, 30 Nov 2021 23:29:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D13FB81DCD;
        Wed,  1 Dec 2021 07:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7772EC53FD2;
        Wed,  1 Dec 2021 07:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638343788;
        bh=U1j7MvbU2HWqoZabRFMM4z5W710RB/aXOuL9G6hwghc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NleVHZuxHvpbHZ1OazLK4Q/TEeW0mOMBhhaYPU8OeyXULrnyX8MUTKCd/BymJsgL9
         ubfxbgF5H59Bw1hYYhzo58BP6KQSWMUhH5y9BYCK5sGbFGaKv/gzG5V8TI6OdVcGDI
         di+LCtSykcDuH/bReiYQ4sBFR36Ks2EVyVMng5sBnfu/kfVGuiAPRKizDHNmCcNrre
         tMLNtl76HRMxCffAzZ+7r7K87ZY/qBRwiptBo2sOIN4IWEodbDlV0sYPhV/jR3uhra
         AR2VX4EsSlSe2zgOsGjcFUjXT2HGaUk1Oosv7qs3SzYrPGtrN+gv/ebhSZodAjzsZw
         LtJKe+bu+D9BQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/15] arm64: dts: qcom: sm8450-qrd: enable ufs nodes
Date:   Wed,  1 Dec 2021 12:59:09 +0530
Message-Id: <20211201072915.3969178-10-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211201072915.3969178-1-vkoul@kernel.org>
References: <20211201072915.3969178-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the UFS and phy node and add the regulators used by them.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8450-qrd.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
index 218eb3ce1ee5..3e65d662ab8c 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sm8450.dtsi"
 
@@ -353,3 +354,23 @@ &tlmm {
 &uart7 {
 	status = "okay";
 };
+
+&ufs_mem_hc {
+	status = "okay";
+
+	reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
+
+	vcc-supply = <&vreg_l7b_2p5>;
+	vcc-max-microamp = <1100000>;
+	vccq-supply = <&vreg_l9b_1p2>;
+	vccq-max-microamp = <1200000>;
+};
+
+&ufs_mem_phy {
+	status = "okay";
+
+	vdda-phy-supply = <&vreg_l5b_0p88>;
+	vdda-pll-supply = <&vreg_l6b_1p2>;
+	vdda-max-microamp = <173000>;
+	vdda-pll-max-microamp = <24900>;
+};
-- 
2.31.1

