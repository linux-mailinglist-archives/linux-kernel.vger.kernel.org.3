Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA21246E6C6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbhLIKjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234744AbhLIKjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:39:24 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200B0C061D76;
        Thu,  9 Dec 2021 02:35:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DC6D3CE257F;
        Thu,  9 Dec 2021 10:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C406C341CC;
        Thu,  9 Dec 2021 10:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639046146;
        bh=zfPyEo0OfnsVrPVH6Fj9PNH/jTddEynWlh/fgUBLrxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N6ySMPGxIDlUcR4mCu6IKfPLn1/6IalUjaGZ3z/4kHT/lzYxvJkrpT0Ij05P4DRsm
         Y27V/6ataMf2Sv7sL3RZ8tSVZYJs4V82mr2bGNz4fDU6dQqA13h1bQ+aRTwoA+kSPv
         F/6q9+9s69xOK+2fBEmVvQge5WH/O9yUQ1lcgrNonR6G1uuLXlet+OrFyw17dnkzMc
         nDn7iRSYL667NKYmOOc/GYKntkCRIQS/E7Uq8YEe3FS69nJeAPwNHKi0HoXPi+NKY7
         rqgeZ1JV0FViDGYNYTFvVfFjCWmjnAY0IYTxCWwRUJHadeiV2lP9HTXgNJam7cf11l
         kyPlFcxEa5YWw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/13] arm64: dts: qcom: sm8450: add spmi node
Date:   Thu,  9 Dec 2021 16:05:02 +0530
Message-Id: <20211209103505.197453-11-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211209103505.197453-1-vkoul@kernel.org>
References: <20211209103505.197453-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the spmi bus as found in the SM8450 SoC

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index f75de777f6ea..b80e34fd3fe1 100644
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

