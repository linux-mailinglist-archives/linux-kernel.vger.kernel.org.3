Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6334966EE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 22:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiAUVEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 16:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbiAUVEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 16:04:10 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E523CC06175A;
        Fri, 21 Jan 2022 13:04:08 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id l5so27759882edv.3;
        Fri, 21 Jan 2022 13:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=70y9nP+1TJuyoQVHWKHYrgk62/1kbAozVgHhQoGQnWU=;
        b=ifaBPUIYWqx0Yuxwid+52Kneq6qIIEZpQyCGPZBb+SdwutjTuyrN/oWw8oiyCbLJ/4
         JWNQWjVEd/tMRmtzrg1+Vp0Y9SEKG8h6m6ue3U3cXDOxv42tsqAet4qqt0HcFhztaDtG
         j/6fGOWsEhoqiqLUrXk5rc1rKrfSi5gXBWqnaDtx7Ae73aH8qX9boL2yfxLD2gbGYFKw
         HVgGDv5RL8q05bcDRzhiDltJvNTL8QXvqp5d0pwmqVKp0yTbSz7mLQ8He1qYyxSX/iGA
         slqJ8p3O+RiqiRI7evjb7n3SbBCv1C4cPjyyLnQ+ZT5wZvr+5PwaC6CestOwpIYs2Zph
         U2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=70y9nP+1TJuyoQVHWKHYrgk62/1kbAozVgHhQoGQnWU=;
        b=vJ4oNSnSmEcrKpBxiENzCONaJ0O8+g2FEaiNXtA4/bf7oIF3Kwmj3oP5Vdw71/KVWI
         QDcotawdN6YqOQP64SIyiy6ccCGbJOVf0NGDsD6BUR7BLgYtrVzxINjjs2j5Er5ocSyd
         108VyzmVblq7j8CH0y74GuhlztwYbZp3s0VFTMKivC0NZ44xLt9NxqA+r46jHWzo8CY7
         RXCV6gm+sGDlAQ2no1cP0luU6SortxyURW4Mn9AVkHHCkqYBMwq4UY6kqUC4kwtKzZum
         MRoNmIVxlpvBIeaN9QtLBAcXokpITpzH58y7DNZQPX+TbWeD1xOl9Wt9G7EkscEOCMO4
         EMPA==
X-Gm-Message-State: AOAM533smrrKmyHpyiiemTo+70EsGAirSRrVMkv1X9HbBWxhRn8bskej
        4Jkj853Tqs5LyI8T3/Q0xt0=
X-Google-Smtp-Source: ABdhPJy1y4HO8/1WaxNmwSExaeBcf58GI14B5KbdtJCqWCaEiOtb20D7eSoT8DXN+D/CEEd8o4jPGQ==
X-Received: by 2002:a05:6402:b4c:: with SMTP id bx12mr5776585edb.363.1642799047385;
        Fri, 21 Jan 2022 13:04:07 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id p23sm2898595edx.86.2022.01.21.13.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 13:04:06 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 15/15] ARM: dts: qcom: Add syscon and cxo/pxo clock to gcc node for ipq8064
Date:   Fri, 21 Jan 2022 22:03:40 +0100
Message-Id: <20220121210340.32362-16-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220121210340.32362-1-ansuelsmth@gmail.com>
References: <20220121210340.32362-1-ansuelsmth@gmail.com>
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

