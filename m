Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5EB9491348
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244198AbiARBCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244112AbiARBCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:02:08 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54D1C06161C;
        Mon, 17 Jan 2022 17:02:07 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id c71so72639749edf.6;
        Mon, 17 Jan 2022 17:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=70y9nP+1TJuyoQVHWKHYrgk62/1kbAozVgHhQoGQnWU=;
        b=Ua355Juvb+5cWQs7Gu/XWJattoD8KtPGSZKPITsu8/pwo6tOdqGkRg78iwsyMaR/3Q
         5Nl6JWabCVo4Ysyl4qcpLQddwq2FtSSNTl0IEWSKUUvxyCCU1LzPPFdMwEScczc0cTSx
         eLyThB2vMDUN+WPoE8SgUPs+Ni55KM+GYapZ7K3IptXwFqs6XYx0qxZCO1au/4ckOW0n
         ziUnL2ARYZyRDq/g1voz3IMBh3mHi7G1+xeK3Is0K96VpYeDq9Z6EC2lAXiWc/gIyD3c
         pWnd09mAyvDhmza6odhGBmhl9SJUovZXXAajqM0GQQSPNvFUgTjATRQvrVqIRjSBr5GT
         8XnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=70y9nP+1TJuyoQVHWKHYrgk62/1kbAozVgHhQoGQnWU=;
        b=fpXvvVYjvLmG3CoWFQ5Mb7DRBEmKPvMJl+TMpqlmsDRrzN8yX848qH+W8qlpp4Q3r8
         MYB2TdPcwKOrxvGCapFEmQOjQSsnk5MAkY1f3tWzE+g9PFy9Y1t2+MVvuCsn8oW43bMh
         bo5LafQlurhHiovmgDq7TIm21LZwMoK04EJZ2pSrBhSD5NUNud3u/QF00FgdS+kdxKM5
         buwUCi8igHhq7Ota8nb6TnEQq7yqKVKSqhvglNH5wQt9IWC8awXgbiWMXsniwtbX/Gyb
         Rew1ozZnwiC3Tvwoi0Sd5sfEs5ZVL9A4eOd74LcACLFqYc/VizkwJAd6ajYYpn886fab
         mqYA==
X-Gm-Message-State: AOAM531zAJGH8FJi/qr4UxEPV5zuKt23ckJIsmGeD/whOXLnwquZMjWr
        1CC3eIHt5YVGv8WVDa88L8814WOCkyQ=
X-Google-Smtp-Source: ABdhPJw587JtgnQlOOPt5ApE1N1/wBG4hMb2MOqEUk6zLxEKAgsPBKF5evubIxpeZlL3w/Qnn8/1CA==
X-Received: by 2002:a05:6402:518d:: with SMTP id q13mr23364662edd.377.1642467726331;
        Mon, 17 Jan 2022 17:02:06 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id 24sm4892127ejg.47.2022.01.17.17.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:02:06 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/14] ARM: dts: qcom: Add syscon and cxo/pxo clock to gcc node for ipq8064
Date:   Tue, 18 Jan 2022 01:44:34 +0100
Message-Id: <20220118004434.17095-15-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220118004434.17095-1-ansuelsmth@gmail.com>
References: <20220118004434.17095-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add syscon compatible required for tsens driver to correctly probe driver
and access the reg. Also add cxo and pxo tag and declare them as gcc clock
now requires them for the ipq8064 gcc driver that has now been modernized.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 11481313bdb6..5524a68cf3d1 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -298,13 +298,13 @@ smem: smem@41000000 {
 	};
 
 	clocks {
-		cxo_board {
+		cxo_board: cxo_board {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <25000000>;
 		};
 
-		pxo_board {
+		pxo_board: pxo_board {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <25000000>;
@@ -736,7 +736,9 @@ tsens_calib_backup: calib_backup@410 {
 		};
 
 		gcc: clock-controller@900000 {
-			compatible = "qcom,gcc-ipq8064";
+			compatible = "qcom,gcc-ipq8064", "syscon";
+			clocks = <&pxo_board>, <&cxo_board>;
+			clock-names = "pxo", "cxo";
 			reg = <0x00900000 0x4000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
-- 
2.33.1

