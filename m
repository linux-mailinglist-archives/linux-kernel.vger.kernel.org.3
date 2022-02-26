Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4223F4C5661
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 14:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbiBZNyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 08:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbiBZNxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 08:53:43 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C2415AF0E;
        Sat, 26 Feb 2022 05:52:58 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id hw13so16093917ejc.9;
        Sat, 26 Feb 2022 05:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JMwsuXhcZCUY1xAPROhRSlnLd+vcejQGSPOqCS3EgMc=;
        b=N+4fOhzAVoXkCKmyZSoL18l3f6i6mwhm1I6KOcxKmUyZ6NP99hWFig6q/Roo13Vl7d
         Pfeg72uSsSU1Qgy7kc8gecgw9JtWL+EeItD0otAIr0/6Nw/J6Wn7gnG7uDuAAMaVAhO4
         yOXkX1dgfh79CNONve7cB3Wrtm8AM2ZgP1Gkf8y02UZkMVtPHCb7AJ27JC8stJ3ujkts
         zlL28LRFZCheVUgb3ke1wGeVik3X19MVEciipvGGc3Pe8TXxk1okMCzX7pWHH3pfsguZ
         yf85RtnIia9DbVwG60/p9cV1HQTDBXIUaVUbidhgT1tzCN/zNGfOxFj8Y73IBgRCjrZ6
         IHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JMwsuXhcZCUY1xAPROhRSlnLd+vcejQGSPOqCS3EgMc=;
        b=nLikmAKplAU7kUcRBeNR/GW+0AvM7yVEgOOFOYdrvC3YgU1ygwwHkNu4bAnGAFJOis
         Fs7KA50gOfrAhePD6mloUBrfebSXohg5Qw/eBcf/4imAS2jwYI7XPD5i6PpvPgtr9wP8
         v8KzbqiKLBkvOLYY8rhSo3hj4yARXs5oJ4stgmljYGYymE/AZcKUJ07j5aBaW2zN8ilQ
         o4aSWRLb+/shusyswqRxgcZ2FHq+6/xWAyd+Bm5tV+Wmm/gPaLWsls7TcHkp58BXWCKJ
         0IpPgSTo7RpBkmOcxVoQvaM/t+3NaeyH+PjrwQZ9p6FSJh9CzIckor36p+FQ0i5l6yMR
         Zeqg==
X-Gm-Message-State: AOAM5304t1G19SBcNTyKQv8kmv8tEquR2oAlFHfNptLEqYUd0y6z8Mk/
        b/SRvkKjNj6VRW7U3Afa2jQ=
X-Google-Smtp-Source: ABdhPJzZfBY8B14M+bdFwPcMLSvMyiyZbdc+OHFml0f8dD3R7rDblC2MDuHs6ArFh8glN4d+5tZYlA==
X-Received: by 2002:a17:906:40da:b0:6ce:51b:a593 with SMTP id a26-20020a17090640da00b006ce051ba593mr9768284ejk.604.1645883577117;
        Sat, 26 Feb 2022 05:52:57 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-95-251-226-220.retail.telecomitalia.it. [95.251.226.220])
        by smtp.googlemail.com with ESMTPSA id j21-20020aa7c415000000b004127ac9ddc3sm2836369edq.50.2022.02.26.05.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 05:52:56 -0800 (PST)
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
Subject: [PATCH v6 15/15] ARM: dts: qcom: add syscon and cxo/pxo clock to gcc node for ipq8064
Date:   Sat, 26 Feb 2022 14:52:35 +0100
Message-Id: <20220226135235.10051-16-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220226135235.10051-1-ansuelsmth@gmail.com>
References: <20220226135235.10051-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add syscon compatible required for tsens driver to correctly probe driver
and access the reg. Also add cxo and pxo tag and declare them as gcc clock
now requires them for the ipq8064 gcc driver that has now been modernized.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
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
2.34.1

