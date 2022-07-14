Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0063574A54
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiGNKPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 06:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238188AbiGNKPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:15:01 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9266515817;
        Thu, 14 Jul 2022 03:15:00 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id y8so1779680eda.3;
        Thu, 14 Jul 2022 03:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vyOf8WcrejLVMLs4vhoW+mmm6Iy3fT1Bik+V9Nrt0k4=;
        b=jxVSY+0Gh7qChCWueKHvCMamh3ehifZz2tFcXKD1eKmiQZCPQs+ZkYQMTwe2XewVeQ
         7gYgActTEm32eSBtY2EzMxY8nTJqGI07AxFd9Zcwn2iXEKGzWSDdyQshI5C0Ky2yxGi2
         4ilzg1qK56fWIbJYPbas8Yg5b3IZwwd1fd2QL58PRh4ceP0dnvcocvQ7awd5U6wozSYg
         gBweBC9WJbXvpgmMCPFNizpRyqYF5CN14fQkUV4J3frxFPwBoC6nKD1Ew4oX1sRKeTt6
         5zanwWu1EgadsrgC1NjZp2BIyYIipb6Fkub9ymluSMRXJupgG+9n6avVylqQ7zRhX2m4
         KkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vyOf8WcrejLVMLs4vhoW+mmm6Iy3fT1Bik+V9Nrt0k4=;
        b=dIQaj1COg4xjD1gLHqaPZz0ZKR4lUJ3l/SbPgRajOSZq/FhH81ROItXytrNmng+Yp8
         QTRmhorOpDVG4sTEEyrP0npCYc2mnSHL66vsZFx+gzV62XnRuKMDQ2ATxoiVoDVt5TIU
         tVWScJvY63knyznDAf6okrx3g0CUVzgmlwt0ZjvH2dG0WmJrUEb72BXJQ2GbeinqP2/G
         UZIx1N2Tt3fDiNzxWnsADmSmesBTxNMAXCsStLq2Lq2zdPFtQz5srCuwkvo4ktziMclQ
         Fy3QLjjLNF6r3Vubig9bXx30b+Pb8hxGcf5zOC6/Vqd5CutNJs2rfax5ljXgpy4GrDyu
         X9mw==
X-Gm-Message-State: AJIora/wsQDMxyWq6Sh6CopMAPiUpA+3qQNLrO1EXTD01sMbVz3E+SNQ
        TfXzhFdAETf6kqlBYpwURGg=
X-Google-Smtp-Source: AGRyM1t3SY7UDsoEj1+Q001d9vX4XwfPHKtu/an5YuAvVug9HIu5wtrbi3KGjTezw6hF2aNU753SvA==
X-Received: by 2002:a05:6402:1a35:b0:43a:f63f:af56 with SMTP id be21-20020a0564021a3500b0043af63faf56mr11295220edb.59.1657793699160;
        Thu, 14 Jul 2022 03:14:59 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-197.xnet.hr. [88.207.98.197])
        by smtp.googlemail.com with ESMTPSA id gr19-20020a170906e2d300b0072b592ee073sm535313ejb.147.2022.07.14.03.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 03:14:58 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, amitk@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v6 4/5] drivers: thermal: tsens: add IPQ8074 support
Date:   Thu, 14 Jul 2022 12:14:50 +0200
Message-Id: <20220714101451.198211-4-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220714101451.198211-1-robimarko@gmail.com>
References: <20220714101451.198211-1-robimarko@gmail.com>
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

Qualcomm IPQ8074 uses tsens v2.3 IP, however unlike other tsens v2 IP
it only has one IRQ, that is used for up/low as well as critical.
It also does not support negative trip temperatures.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/thermal/qcom/tsens-v2.c | 17 +++++++++++++++++
 drivers/thermal/qcom/tsens.c    |  3 +++
 drivers/thermal/qcom/tsens.h    |  2 +-
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 9babc69bfd22..29a61d2d6ca3 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -39,6 +39,17 @@ static struct tsens_features tsens_v2_feat = {
 	.trip_max_temp	= 120000,
 };
 
+static struct tsens_features ipq8074_feat = {
+	.ver_major	= VER_2_X,
+	.crit_int	= 1,
+	.combo_int	= 1,
+	.adc		= 0,
+	.srot_split	= 1,
+	.max_sensors	= 16,
+	.trip_min_temp	= 0,
+	.trip_max_temp	= 204000,
+};
+
 static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
 	/* ----- SROT ------ */
 	/* VERSION */
@@ -104,6 +115,12 @@ struct tsens_plat_data data_tsens_v2 = {
 	.fields	= tsens_v2_regfields,
 };
 
+struct tsens_plat_data data_ipq8074 = {
+	.ops		= &ops_generic_v2,
+	.feat		= &ipq8074_feat,
+	.fields	= tsens_v2_regfields,
+};
+
 /* Kept around for backward compatibility with old msm8996.dtsi */
 struct tsens_plat_data data_8996 = {
 	.num_sensors	= 13,
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 3286f295d61c..e4de73d9a499 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -991,6 +991,9 @@ static const struct of_device_id tsens_table[] = {
 	{
 		.compatible = "qcom,ipq8064-tsens",
 		.data = &data_8960,
+	}, {
+		.compatible = "qcom,ipq8074-tsens",
+		.data = &data_ipq8074,
 	}, {
 		.compatible = "qcom,mdm9607-tsens",
 		.data = &data_9607,
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 747004476347..8dd990d944ad 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -599,6 +599,6 @@ extern struct tsens_plat_data data_8916, data_8939, data_8974, data_9607;
 extern struct tsens_plat_data data_tsens_v1, data_8976;
 
 /* TSENS v2 targets */
-extern struct tsens_plat_data data_8996, data_tsens_v2;
+extern struct tsens_plat_data data_8996, data_ipq8074, data_tsens_v2;
 
 #endif /* __QCOM_TSENS_H__ */
-- 
2.36.1

