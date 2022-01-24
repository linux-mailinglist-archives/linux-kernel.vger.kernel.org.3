Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A135B4986B4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244568AbiAXR05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:26:57 -0500
Received: from fwd1.porkbun.com ([52.10.174.57]:36506 "EHLO fwd1.porkbun.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244304AbiAXR0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:26:51 -0500
Received: by fwd1.porkbun.com (Postfix, from userid 497)
        id E8E3341B7F; Mon, 24 Jan 2022 17:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh;
        s=default; t=1643044732;
        bh=a9whC7JtDB4/7zPJIuUirqdml13MUQ9IgB9uwgfXCD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SyMBu2Xy7B6VPeLaeONMFPU5iX6G0WEDzhLMD/9qyZeHfew+TTHRp7+ZnbR/KmyB8
         KqH713cA7/vyxWugR5YjZLi1/ynNFq+2SyaA3p3N45WYzp/cr2CknDWHiFg1gMdj2g
         YJ4YpX4tXdCynczsT9ZLy3602Yd9x0csdIajBXWk=
X-Spam-Checker-Version: SpamAssassin 3.4.3 (2019-12-06) on
        ip-172-31-37-14.us-west-2.compute.internal
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU autolearn=unavailable
        autolearn_force=no version=3.4.3
Received: from rayyan-pc.broadband (unknown [90.242.138.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: rayyan@ansari.sh)
        by fwd1.porkbun.com (Postfix) with ESMTPSA id C44A8409E8;
        Mon, 24 Jan 2022 17:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh;
        s=default; t=1643044572;
        bh=a9whC7JtDB4/7zPJIuUirqdml13MUQ9IgB9uwgfXCD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=amH6gn+4/lbzBWtmupToE1eeYfkq0ggTOzp8qGjaW1//5w/TslNH8dfXTH1diCkfH
         zfPONxD+KS0z6yyJG+J4YL108aw3la9lpfTHee3EeLCTmVZKM5aom1aVmPZnCAX72E
         YMwYIQX/MkqgTQSQZdjVWXRN9GNeUVKJsfjEclnY=
From:   Rayyan Ansari <rayyan@ansari.sh>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rayyan Ansari <rayyan@ansari.sh>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ARM: dts: qcom: pm8226: Add node for the MPP
Date:   Mon, 24 Jan 2022 17:15:38 +0000
Message-Id: <20220124171538.18088-3-rayyan@ansari.sh>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124171538.18088-1-rayyan@ansari.sh>
References: <20220124171538.18088-1-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PM8226 provides 8 Multi-Purpose Pins (or MPPs for short).
Add a node to support them.

Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
---
 arch/arm/boot/dts/qcom-pm8226.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-pm8226.dtsi b/arch/arm/boot/dts/qcom-pm8226.dtsi
index dddb5150dfd7..9db3ea28b321 100644
--- a/arch/arm/boot/dts/qcom-pm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8226.dtsi
@@ -16,6 +16,16 @@ pwrkey@800 {
 			debounce = <15625>;
 			bias-pull-up;
 		};
+
+		pm8226_mpps: mpps@a000 {
+			compatible = "qcom,pm8226-mpp", "qcom,spmi-mpp";
+			reg = <0xa000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pm8226_mpps 0 0 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
 	};
 
 	pm8226_1: pm8226@1 {
-- 
2.34.1

