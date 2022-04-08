Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5004F9F33
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 23:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239867AbiDHVd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 17:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiDHVdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 17:33:23 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C7A1108
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 14:31:18 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-e1dcc0a327so11099828fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 14:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wxR0dOiAKCN5q6I8wFdU62eZaH09nuCMvX0qbjdCwt4=;
        b=UZA2ymL7eUIrFkq3bukFjUVMpQNoh6YTAGhNxqgaMPLQRRLE+1U1kWUqt2uQUKK7fj
         z+fqjcDDqcFCPeY6EfA+3RF9Cec4RtAD9LtepFeLEAsc5983eX5KjWLh+Ra1v7wbUA9+
         Aj3foccpQ6mPkzBupd4uys/TS2IyS5zw7SsUmdUdtUZMCDXzPxpna4mUsP6TMDtFP8Ex
         8bm6yvedDGxaI+EQQZrK5I7QnEH7wGbxQmmGs6HIoWkYrQ85dz+vTelAJEd6C4/XuPsH
         wOpfZ5c1fvdN6ptoGsF9BYiuJ4ANsVzMBpUYKonusDCH4sdZN+6uVJ5mY5nNzAqDbaNd
         Q2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wxR0dOiAKCN5q6I8wFdU62eZaH09nuCMvX0qbjdCwt4=;
        b=UtM+6avIV9oYwdDcHbjzjkfam9cCOxU0THt3s0scGbgBShxzrdynke3Mu6QPz76RmL
         2kj+eTuENDAaA3ApOTB+xqNV8krxvXSvGRHWPKnNcEipcNF6RFf4n/+CLUVjLpn89Gm1
         W5/rKhT/3hH6zEkGeldw2sYgWA63PWL8UgzyjSuUAnVOZImvCwzpbml0LyGqVjDG8UQ4
         Ji78+TkJBuQSCF7cuVhKgwasAjlXf/buzBHQyRaM4ch5by/mUqAU6L4h61ivxEKMKzna
         uV5UIJBiUOEacswlZhTE2wMcqzQllKhHJp4lfODke2sPHuRZvbBNKCm/Z3IM+SZa7u+N
         S8iQ==
X-Gm-Message-State: AOAM532YTs1Am+LiTSs3rmQ9rNB1H4MPiMHtwc0q86/7K/2s2tVewsH2
        z1HjnFQCCIikLoGDcdsFGOtH8g==
X-Google-Smtp-Source: ABdhPJwAxTu7dwzEdf5ou+R5GZHGyjcn6DjaI9Isdxu+BtUqPmp+ZnCqBgTAxPX6bvY1xTi7ebTsIw==
X-Received: by 2002:a05:6870:204c:b0:de:10fe:ba3b with SMTP id l12-20020a056870204c00b000de10feba3bmr9869150oad.80.1649453477483;
        Fri, 08 Apr 2022 14:31:17 -0700 (PDT)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id m126-20020aca3f84000000b002ef895f4bf8sm8983536oia.24.2022.04.08.14.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 14:31:16 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/3] soc: qcom: llcc: Add sc8180x and sc8280xp configurations
Date:   Fri,  8 Apr 2022 14:33:35 -0700
Message-Id: <20220408213336.581661-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220408213336.581661-1-bjorn.andersson@linaro.org>
References: <20220408213336.581661-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LLCC configuration data for the SC8180X and SC8280XP platforms,
based on the downstream tables.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/soc/qcom/llcc-qcom.c       | 60 ++++++++++++++++++++++++++++++
 include/linux/soc/qcom/llcc-qcom.h |  2 +
 2 files changed, 62 insertions(+)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index eecafeded56f..a76d58195637 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -130,6 +130,50 @@ static const struct llcc_slice_config sc7280_data[] =  {
 	{ LLCC_MODPE,    29, 64,  1, 1, 0x3f, 0x0, 0, 0, 0, 1, 0, 0},
 };
 
+static const struct llcc_slice_config sc8180x_data[] = {
+	{ LLCC_CPUSS,    1, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 1 },
+	{ LLCC_VIDSC0,    2, 512, 2, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
+	{ LLCC_VIDSC1,    3, 512, 2, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
+	{ LLCC_ROTATOR,    4, 1024, 2, 1, 0xfff, 0x0, 2, 0, 0, 1, 0 },
+	{ LLCC_VOICE,    5, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
+	{ LLCC_AUDIO,    6, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
+	{ LLCC_MDMHPGRW,    7, 1024, 2, 0, 0xfff, 0x0, 0, 0, 0, 1, 0 },
+	{ LLCC_MDM,    8, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
+	{ LLCC_CMPT,   10, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
+	{ LLCC_GPUHTW,   11, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
+	{ LLCC_GPU,   12, 5120, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
+	{ LLCC_MMUHWT,   13, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1 },
+	{ LLCC_CMPTDMA,   15, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
+	{ LLCC_DISP,   16, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
+	{ LLCC_VIDFW,   17, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
+	{ LLCC_MDMHPFX,   20, 1024, 2, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
+	{ LLCC_MDMPNG,   21, 1024, 0, 1, 0xf, 0x0, 0, 0, 0, 1, 0 },
+	{ LLCC_AUDHW,   22, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
+	{ LLCC_NPU,   23, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
+	{ LLCC_WLHW,   24, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
+	{ LLCC_PIMEM,   25, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
+};
+
+static const struct llcc_slice_config sc8280xp_data[] = {
+	{ LLCC_CPUSS,    1,  6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 1 },
+	{ LLCC_VIDSC0,   2,  512,  3, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
+	{ LLCC_AUDIO,    6,  1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 0 },
+	{ LLCC_CMPT,     10, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 0 },
+	{ LLCC_GPUHTW,   11, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
+	{ LLCC_GPU,      12, 4608, 1, 0, 0xfff, 0x0, 0, 0, 0, 1, 0 },
+	{ LLCC_MMUHWT,   13, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1 },
+	{ LLCC_DISP,     16, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
+	{ LLCC_AUDHW,    22, 2048, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
+	{ LLCC_DRE,      26, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
+	{ LLCC_CVP,      28, 512,  3, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
+	{ LLCC_APTCM,    30, 1024, 3, 1, 0x0,   0x1, 1, 0, 0, 1, 0 },
+	{ LLCC_WRCACHE,  31, 512,  1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1 },
+	{ LLCC_CVPFW,    17, 512,  1, 0, 0xfff, 0x0, 0, 0, 0, 1, 0 },
+	{ LLCC_CPUSS1,   3,  2048, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0 },
+	{ LLCC_CAMEXP0,  14, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 0 },
+	{ LLCC_CPUHWT,   5,  512,  1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1 },
+};
+
 static const struct llcc_slice_config sdm845_data[] =  {
 	{ LLCC_CPUSS,    1,  2816, 1, 0, 0xffc, 0x2,   0, 0, 1, 1, 1 },
 	{ LLCC_VIDSC0,   2,  512,  2, 1, 0x0,   0x0f0, 0, 0, 1, 1, 0 },
@@ -276,6 +320,20 @@ static const struct qcom_llcc_config sc7280_cfg = {
 	.reg_offset	= llcc_v1_2_reg_offset,
 };
 
+static const struct qcom_llcc_config sc8180x_cfg = {
+	.sct_data	= sc8180x_data,
+	.size		= ARRAY_SIZE(sc8180x_data),
+	.need_llcc_cfg	= true,
+	.reg_offset	= llcc_v1_2_reg_offset,
+};
+
+static const struct qcom_llcc_config sc8280xp_cfg = {
+	.sct_data	= sc8280xp_data,
+	.size		= ARRAY_SIZE(sc8280xp_data),
+	.need_llcc_cfg	= true,
+	.reg_offset	= llcc_v1_2_reg_offset,
+};
+
 static const struct qcom_llcc_config sdm845_cfg = {
 	.sct_data	= sdm845_data,
 	.size		= ARRAY_SIZE(sdm845_data),
@@ -741,6 +799,8 @@ static int qcom_llcc_probe(struct platform_device *pdev)
 static const struct of_device_id qcom_llcc_of_match[] = {
 	{ .compatible = "qcom,sc7180-llcc", .data = &sc7180_cfg },
 	{ .compatible = "qcom,sc7280-llcc", .data = &sc7280_cfg },
+	{ .compatible = "qcom,sc8180x-llcc", .data = &sc8180x_cfg },
+	{ .compatible = "qcom,sc8280xp-llcc", .data = &sc8280xp_cfg },
 	{ .compatible = "qcom,sdm845-llcc", .data = &sdm845_cfg },
 	{ .compatible = "qcom,sm6350-llcc", .data = &sm6350_cfg },
 	{ .compatible = "qcom,sm8150-llcc", .data = &sm8150_cfg },
diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
index 0bc21ee58fac..9ed5384c5ca1 100644
--- a/include/linux/soc/qcom/llcc-qcom.h
+++ b/include/linux/soc/qcom/llcc-qcom.h
@@ -29,6 +29,8 @@
 #define LLCC_AUDHW       22
 #define LLCC_NPU         23
 #define LLCC_WLHW        24
+#define LLCC_PIMEM       25
+#define LLCC_DRE         26
 #define LLCC_CVP         28
 #define LLCC_MODPE       29
 #define LLCC_APTCM       30
-- 
2.35.1

