Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F9D5781F9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbiGRMP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbiGRMPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:15:39 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B4726114
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:15:30 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id ay11-20020a05600c1e0b00b003a3013da120so7691796wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bh9NZr4gq3p7XYiwnsBZLhMSoV7xIvFjFW59LLlWpBM=;
        b=xiuse1IKKx0XozsiaQHJ4SQtwAU2L7g25uNWBVbiSRGNk/7RNobYrCgwgYtzyyTML7
         GDGCMfE82etDe6Qfd6fw2RqkO519c/uDDwCCR0Iqnh8P1ILw78wknKSnzVJxSojItxPX
         AoFVy3NKFkuJsx6RUpsfgtC7OOg83pHEiF7FdWyeBIqOtE5bxZ6el2TMP/LdTSnkOdCk
         AUNRxkNerbaoSywKcwjpLt1/edruIpyuwTi0xVo0Kdf5A785P0fcXqmQKrOmTGtF3q2R
         Yr1r22iFSdBhXvjuGpvv4iDe5Y7I3DE32EvfqeiouOimN5JWlRC5+Kre4hTKc9iOlp34
         id7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bh9NZr4gq3p7XYiwnsBZLhMSoV7xIvFjFW59LLlWpBM=;
        b=r2NvSdo4jDEATqqRvAqFt0tfqIIOeWJwY57U6hQLaBQsGY22ED8to2BPjXNXkg0hV+
         5hD5Ncz6g1Tw3U/2ro0nkWJjXcgyjDoekny2d7mYQkAEIRUKu5E0jWyW4U5IfIo98Soa
         W6lCBN5eaO6hme3gy/mNp8RDSbghvkeXLKipkGsSbK71SwS6wzQDXOazBqgVKsFN0wUZ
         ucdCCK33Gy8uxPFt40gAnBlubdGrGIFTDCHSH9lmTqSitTFfFzRfq97GmYc0SS5gRJZZ
         cIX/TKK4nUwitXv0fxIPdCuMbO4lYTyDw5nUc3nfmkgY1b/+txTY2A1aSh4aWDK4HR4y
         J7Ig==
X-Gm-Message-State: AJIora8iyX3PhNcpXceRre4Xm5/tK0EjrbEaklxNiisbeeXoACoIU6a/
        7z+3NRdBbDLnrMj3Fc3gDIENTg==
X-Google-Smtp-Source: AGRyM1t73eqThp+YiwuMVeGp3LQdvy3Tti0MdP9P6YfwveVXZEm/D8ATXffrujB0f1dgfh974v8QJg==
X-Received: by 2002:a05:600c:3844:b0:3a3:d71:c4ce with SMTP id s4-20020a05600c384400b003a30d71c4cemr14645076wmr.23.1658146528206;
        Mon, 18 Jul 2022 05:15:28 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id r6-20020a5d6946000000b0021b91d1ddbfsm10795784wrw.21.2022.07.18.05.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 05:15:27 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v2] remoteproc: qcom: q6v5: Use _clk_get_optional for aggre2_clk
Date:   Mon, 18 Jul 2022 15:15:14 +0300
Message-Id: <20220718121514.2451590-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only msm8996 and msm8998 SLPIs need the RPM_SMD_AGGR2_NOC_CLK
(as aggre2 clock). None of the other platforms do. Back when the support
for the mentioned platforms was added to the q6v5 pass driver, the
devm_clk_get_optional was not available, so the has_aggre2_clk was
necessary in order to differentiate between plaforms that need this
clock and those which do not. Now that devm_clk_get_optional is available,
we can drop the has_aggre2_clk. This makes the adsp_data more cleaner
and removes the check within adsp_init_clocks.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

Changes since v1:
 * reworded the commit message to explain why this change would make
   sense, as suggested by Bjorn.

 drivers/remoteproc/qcom_q6v5_pas.c | 41 +++++-------------------------
 1 file changed, 7 insertions(+), 34 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 6ae39c5653b1..beef7a09c380 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -34,7 +34,6 @@ struct adsp_data {
 	const char *firmware_name;
 	int pas_id;
 	unsigned int minidump_id;
-	bool has_aggre2_clk;
 	bool auto_boot;

 	char **proxy_pd_names;
@@ -64,7 +63,6 @@ struct qcom_adsp {
 	int pas_id;
 	unsigned int minidump_id;
 	int crash_reason_smem;
-	bool has_aggre2_clk;
 	const char *info_name;

 	struct completion start_done;
@@ -310,15 +308,13 @@ static int adsp_init_clock(struct qcom_adsp *adsp)
 		return ret;
 	}

-	if (adsp->has_aggre2_clk) {
-		adsp->aggre2_clk = devm_clk_get(adsp->dev, "aggre2");
-		if (IS_ERR(adsp->aggre2_clk)) {
-			ret = PTR_ERR(adsp->aggre2_clk);
-			if (ret != -EPROBE_DEFER)
-				dev_err(adsp->dev,
-					"failed to get aggre2 clock");
-			return ret;
-		}
+	adsp->aggre2_clk = devm_clk_get_optional(adsp->dev, "aggre2");
+	if (IS_ERR(adsp->aggre2_clk)) {
+		ret = PTR_ERR(adsp->aggre2_clk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(adsp->dev,
+				"failed to get aggre2 clock");
+		return ret;
 	}

 	return 0;
@@ -457,7 +453,6 @@ static int adsp_probe(struct platform_device *pdev)
 	adsp->rproc = rproc;
 	adsp->minidump_id = desc->minidump_id;
 	adsp->pas_id = desc->pas_id;
-	adsp->has_aggre2_clk = desc->has_aggre2_clk;
 	adsp->info_name = desc->sysmon_name;
 	platform_set_drvdata(pdev, adsp);

@@ -531,7 +526,6 @@ static const struct adsp_data adsp_resource_init = {
 		.crash_reason_smem = 423,
 		.firmware_name = "adsp.mdt",
 		.pas_id = 1,
-		.has_aggre2_clk = false,
 		.auto_boot = true,
 		.ssr_name = "lpass",
 		.sysmon_name = "adsp",
@@ -542,7 +536,6 @@ static const struct adsp_data sdm845_adsp_resource_init = {
 		.crash_reason_smem = 423,
 		.firmware_name = "adsp.mdt",
 		.pas_id = 1,
-		.has_aggre2_clk = false,
 		.auto_boot = true,
 		.load_state = "adsp",
 		.ssr_name = "lpass",
@@ -554,7 +547,6 @@ static const struct adsp_data sm6350_adsp_resource = {
 	.crash_reason_smem = 423,
 	.firmware_name = "adsp.mdt",
 	.pas_id = 1,
-	.has_aggre2_clk = false,
 	.auto_boot = true,
 	.proxy_pd_names = (char*[]){
 		"lcx",
@@ -571,7 +563,6 @@ static const struct adsp_data sm8150_adsp_resource = {
 		.crash_reason_smem = 423,
 		.firmware_name = "adsp.mdt",
 		.pas_id = 1,
-		.has_aggre2_clk = false,
 		.auto_boot = true,
 		.proxy_pd_names = (char*[]){
 			"cx",
@@ -587,7 +578,6 @@ static const struct adsp_data sm8250_adsp_resource = {
 	.crash_reason_smem = 423,
 	.firmware_name = "adsp.mdt",
 	.pas_id = 1,
-	.has_aggre2_clk = false,
 	.auto_boot = true,
 	.proxy_pd_names = (char*[]){
 		"lcx",
@@ -604,7 +594,6 @@ static const struct adsp_data sm8350_adsp_resource = {
 	.crash_reason_smem = 423,
 	.firmware_name = "adsp.mdt",
 	.pas_id = 1,
-	.has_aggre2_clk = false,
 	.auto_boot = true,
 	.proxy_pd_names = (char*[]){
 		"lcx",
@@ -621,7 +610,6 @@ static const struct adsp_data msm8996_adsp_resource = {
 		.crash_reason_smem = 423,
 		.firmware_name = "adsp.mdt",
 		.pas_id = 1,
-		.has_aggre2_clk = false,
 		.auto_boot = true,
 		.proxy_pd_names = (char*[]){
 			"cx",
@@ -636,7 +624,6 @@ static const struct adsp_data cdsp_resource_init = {
 	.crash_reason_smem = 601,
 	.firmware_name = "cdsp.mdt",
 	.pas_id = 18,
-	.has_aggre2_clk = false,
 	.auto_boot = true,
 	.ssr_name = "cdsp",
 	.sysmon_name = "cdsp",
@@ -647,7 +634,6 @@ static const struct adsp_data sdm845_cdsp_resource_init = {
 	.crash_reason_smem = 601,
 	.firmware_name = "cdsp.mdt",
 	.pas_id = 18,
-	.has_aggre2_clk = false,
 	.auto_boot = true,
 	.load_state = "cdsp",
 	.ssr_name = "cdsp",
@@ -659,7 +645,6 @@ static const struct adsp_data sm6350_cdsp_resource = {
 	.crash_reason_smem = 601,
 	.firmware_name = "cdsp.mdt",
 	.pas_id = 18,
-	.has_aggre2_clk = false,
 	.auto_boot = true,
 	.proxy_pd_names = (char*[]){
 		"cx",
@@ -676,7 +661,6 @@ static const struct adsp_data sm8150_cdsp_resource = {
 	.crash_reason_smem = 601,
 	.firmware_name = "cdsp.mdt",
 	.pas_id = 18,
-	.has_aggre2_clk = false,
 	.auto_boot = true,
 	.proxy_pd_names = (char*[]){
 		"cx",
@@ -692,7 +676,6 @@ static const struct adsp_data sm8250_cdsp_resource = {
 	.crash_reason_smem = 601,
 	.firmware_name = "cdsp.mdt",
 	.pas_id = 18,
-	.has_aggre2_clk = false,
 	.auto_boot = true,
 	.proxy_pd_names = (char*[]){
 		"cx",
@@ -708,7 +691,6 @@ static const struct adsp_data sc8280xp_nsp0_resource = {
 	.crash_reason_smem = 601,
 	.firmware_name = "cdsp.mdt",
 	.pas_id = 18,
-	.has_aggre2_clk = false,
 	.auto_boot = true,
 	.proxy_pd_names = (char*[]){
 		"nsp",
@@ -723,7 +705,6 @@ static const struct adsp_data sc8280xp_nsp1_resource = {
 	.crash_reason_smem = 633,
 	.firmware_name = "cdsp.mdt",
 	.pas_id = 30,
-	.has_aggre2_clk = false,
 	.auto_boot = true,
 	.proxy_pd_names = (char*[]){
 		"nsp",
@@ -738,7 +719,6 @@ static const struct adsp_data sm8350_cdsp_resource = {
 	.crash_reason_smem = 601,
 	.firmware_name = "cdsp.mdt",
 	.pas_id = 18,
-	.has_aggre2_clk = false,
 	.auto_boot = true,
 	.proxy_pd_names = (char*[]){
 		"cx",
@@ -756,7 +736,6 @@ static const struct adsp_data mpss_resource_init = {
 	.firmware_name = "modem.mdt",
 	.pas_id = 4,
 	.minidump_id = 3,
-	.has_aggre2_clk = false,
 	.auto_boot = false,
 	.proxy_pd_names = (char*[]){
 		"cx",
@@ -773,7 +752,6 @@ static const struct adsp_data sc8180x_mpss_resource = {
 	.crash_reason_smem = 421,
 	.firmware_name = "modem.mdt",
 	.pas_id = 4,
-	.has_aggre2_clk = false,
 	.auto_boot = false,
 	.proxy_pd_names = (char*[]){
 		"cx",
@@ -789,7 +767,6 @@ static const struct adsp_data slpi_resource_init = {
 		.crash_reason_smem = 424,
 		.firmware_name = "slpi.mdt",
 		.pas_id = 12,
-		.has_aggre2_clk = true,
 		.auto_boot = true,
 		.proxy_pd_names = (char*[]){
 			"ssc_cx",
@@ -804,7 +781,6 @@ static const struct adsp_data sm8150_slpi_resource = {
 		.crash_reason_smem = 424,
 		.firmware_name = "slpi.mdt",
 		.pas_id = 12,
-		.has_aggre2_clk = false,
 		.auto_boot = true,
 		.proxy_pd_names = (char*[]){
 			"lcx",
@@ -821,7 +797,6 @@ static const struct adsp_data sm8250_slpi_resource = {
 	.crash_reason_smem = 424,
 	.firmware_name = "slpi.mdt",
 	.pas_id = 12,
-	.has_aggre2_clk = false,
 	.auto_boot = true,
 	.proxy_pd_names = (char*[]){
 		"lcx",
@@ -838,7 +813,6 @@ static const struct adsp_data sm8350_slpi_resource = {
 	.crash_reason_smem = 424,
 	.firmware_name = "slpi.mdt",
 	.pas_id = 12,
-	.has_aggre2_clk = false,
 	.auto_boot = true,
 	.proxy_pd_names = (char*[]){
 		"lcx",
@@ -865,7 +839,6 @@ static const struct adsp_data sdx55_mpss_resource = {
 	.crash_reason_smem = 421,
 	.firmware_name = "modem.mdt",
 	.pas_id = 4,
-	.has_aggre2_clk = false,
 	.auto_boot = true,
 	.proxy_pd_names = (char*[]){
 		"cx",
--
2.34.3

