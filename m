Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0627B527459
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 23:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbiENVzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 17:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbiENVyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 17:54:45 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA992DA8B
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:54:43 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c11so11082076plg.13
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O72LBqaBFc3QSphttd7j5vD07NYu+1pVVzRqZ3jA530=;
        b=XOB+7ikRInJ7Du/5GtJxUlkB867+ZRSPT5Dz2hhhg0k2WjxRSHAIENr7qNLeT47k+n
         E76coTOYrLRpq6fg9FtfYAT0AF0glIkuCH8GDt/wr/5Z2psiyl/6buWoMlTQSQsU+PTW
         FlZtyIApdLLIiR1l1GAFT3ciNQpZbh7gdsdiBkLFSrToi2Wt4CrIfcJvdBFvNyPaQAWh
         6P+jovj2qRdX8rmU13jGZYBBClN64SWk5iGMu9YqrfXoDDMHpvSLQpCb3khXEkGxDlHf
         uzxXAYOsan7qdWDzeOS9xZUq1pMcmXwT9HHzJWefY0Gcx1NQOLNIwsI+5pRlr5YV+I6N
         pZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O72LBqaBFc3QSphttd7j5vD07NYu+1pVVzRqZ3jA530=;
        b=BQQvHbwsZgpkJB6R1Z43pvIC0JwBUShIRyEYpsDrrRsX5eA8Jf3LC6xQgQ4QNCa3l2
         e1rr6qESeHDU5Hw5VFpNBE9ZrBFKmNdYO3EzMeAdS8+LHnDMdL14ik1kdg7+Mdt+5bUZ
         ijA18ZcoUA6xqIJJ2mLojQlwU/r7s8jxFGwOtHc8kR1Zm7NjCLfRjyLZtjgVAs0s/1vh
         ZDXm8ulam3mtvaVN+LzVViaUUsSJjiUTNhI/iI5Yv48BNgZkcQHZ4HIK5+UsMH1Cd7Ha
         doS6Hh4wUO/+qX8VcO9TxAx6PXt3KhFBy91feETOLh58NHM8yXJ7nkK3toZymSG77NJb
         ksGw==
X-Gm-Message-State: AOAM531S5L9vQZZ7us8ud9/VmmCbjJ502LbkIWuS0YF3SOltKQSVHxMh
        NhvwDujHQgVZFBDqWsKNESMnWA==
X-Google-Smtp-Source: ABdhPJxta0ttPlx6u9EiYauwEqUf9ORkOUSmcltYCes1vNyn8VyCN172pppcdA8Yj5J4DD/BmkelbA==
X-Received: by 2002:a17:90b:1d11:b0:1dc:5dd1:b50e with SMTP id on17-20020a17090b1d1100b001dc5dd1b50emr22496454pjb.218.1652565282989;
        Sat, 14 May 2022 14:54:42 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:931c:dd30:fa99:963:d0be])
        by smtp.gmail.com with ESMTPSA id m13-20020a170902db0d00b0015e8d4eb2d2sm4189522plx.284.2022.05.14.14.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:54:42 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        robh@kernel.org
Subject: [PATCH v2 3/6] arm64: dts: qcom: Fix node names for sdhci 'opp-table' nodes (across dts files)
Date:   Sun, 15 May 2022 03:24:21 +0530
Message-Id: <20220514215424.1007718-4-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220514215424.1007718-1-bhupesh.sharma@linaro.org>
References: <20220514215424.1007718-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the Qualcomm sdhci-msm device-tree binding has been converted
to yaml format, 'make dtbs_check' reports a number of issues with
node names for sdhci 'opp-table' nodes, as it doesn't seem to like
any 'preceding text or numbers' before 'opp-table' pattern in the
node names.

Fix the same.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 4 ++--
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 4 ++--
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 4a316c50484d..df0006d4a560 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -725,7 +725,7 @@ sdhc_1: mmc@7c4000 {
 
 			status = "disabled";
 
-			sdhc1_opp_table: sdhc1-opp-table {
+			sdhc1_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
 				opp-100000000 {
@@ -2602,7 +2602,7 @@ sdhc_2: mmc@8804000 {
 
 			status = "disabled";
 
-			sdhc2_opp_table: sdhc2-opp-table {
+			sdhc2_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
 				opp-100000000 {
diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 13c7ae2e379e..1b1eb884136b 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -497,7 +497,7 @@ sdhc_1: mmc@7c4000 {
 
 			status = "disabled";
 
-			sdhc1_opp_table: sdhc1-opp-table {
+			sdhc1_opp_table: opp-table-sdhc1 {
 				compatible = "operating-points-v2";
 
 				opp-19200000 {
@@ -941,7 +941,7 @@ sdhc_2: mmc@8804000 {
 
 			status = "disabled";
 
-			sdhc2_opp_table: sdhc2-opp-table {
+			sdhc2_opp_table: opp-table-sdhc2 {
 				compatible = "operating-points-v2";
 
 				opp-100000000 {
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index a2a1c77c0428..e6b309e9c05b 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3563,7 +3563,7 @@ sdhc_2: mmc@8804000 {
 
 			status = "disabled";
 
-			sdhc2_opp_table: sdhc2-opp-table {
+			sdhc2_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
 				opp-19200000 {
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 6c06e3b2ad2d..9b6dea34cd69 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2937,7 +2937,7 @@ sdhc_2: mmc@8804000 {
 
 			status = "disabled";
 
-			sdhc2_opp_table: sdhc2-opp-table {
+			sdhc2_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
 				opp-19200000 {
-- 
2.35.3

