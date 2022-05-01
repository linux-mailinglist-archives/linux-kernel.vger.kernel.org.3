Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942145166FD
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 20:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354936AbiEASZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 14:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350485AbiEASZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 14:25:35 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08CA527E8;
        Sun,  1 May 2022 11:22:09 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id t5so3814065edw.11;
        Sun, 01 May 2022 11:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WTxPRlSp8k/tQZEOjjNIb49rT6gGrw+y6fIhsPtqfJw=;
        b=XTqEH+89rkDKQE+dauoDGDgNoNPIcHyX2OaAveqY9/vHuQf38j7QAEAhYTha9ba+SQ
         4QklRV71JqeA8H947kJ969TzFGVC8rIz7g4bFsU4R+AIJg3MJOqv4Inh7GuPeTMx5Lzl
         WduWjCaqMnjLyPEoyf8+j/acvpmj7n9N+QD3R6JFUlGZbJNzVTWHpebOBY55CjPQyVgd
         +8S7V0qQabeZ6eQJPWcktGoz2sdXcRy9oMGC75xyCf4+sqDiAsY8c/9KR48rI79zuX1i
         9ikRkyKftfzrLHmRBk62CNBqRCJNygCluxurdP+QrvuIMWxHzOfjVNHggB/Qe3mH89UV
         8Ghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WTxPRlSp8k/tQZEOjjNIb49rT6gGrw+y6fIhsPtqfJw=;
        b=XCG/6I22BIf/mkYH7w4AG6PtAWNW6LpUcYBA82NTGbpDvt7HWT8NmnR61+2OgvRToS
         fsF1aoRSSjDPRQaeiM+nRm6KPD3zD40jFSuQXRQZb6OKrwN+oGj++bQ2FzNcnPWDkjPw
         9cE8d7dv3r5ulrO2Le0s56m+lGGIJ5wlOuB4AbsR0U5mfrO/D5KsRmP68CY6UZ3XJMAZ
         xDpODJ03o2gfBHpXZ1hJwWMPqLP3PDI9HXTtTq425I1X75Y0SzDyOcZZsI0p/4qD2Hb3
         czNveiZGCJ9TjDEddjeXkTQmuJO2KKOziohDRoxHkp7kTWw58/yEe18aB7pMVhUbEOmA
         KJkg==
X-Gm-Message-State: AOAM533tqxAt67ZxuEGCqfugamSlPj4ff3iOeCv7gOei3iIwaNZbJaNS
        9mMcJ4Z5JeU/+M/X1mdFROI=
X-Google-Smtp-Source: ABdhPJxc3oCu0NJkdSfdXGgA9+1i435hcic9oxk/ktV3VLAwh6ALNP/eKL5Tez9o9INkCy3eAY7yjQ==
X-Received: by 2002:a05:6402:28b1:b0:425:c39e:b773 with SMTP id eg49-20020a05640228b100b00425c39eb773mr9630956edb.237.1651429328424;
        Sun, 01 May 2022 11:22:08 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-225-cbl.xnet.hr. [94.253.144.225])
        by smtp.googlemail.com with ESMTPSA id gv49-20020a1709072bf100b006f3ef214e35sm2769811ejc.155.2022.05.01.11.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 11:22:08 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, amitk@kernel.org,
        rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 4/5] drivers: thermal: tsens: add IPQ8074 support
Date:   Sun,  1 May 2022 20:21:59 +0200
Message-Id: <20220501182200.47328-4-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220501182200.47328-1-robimarko@gmail.com>
References: <20220501182200.47328-1-robimarko@gmail.com>
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
index b7701d5efdfc..3624daaaf34b 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -990,6 +990,9 @@ static const struct of_device_id tsens_table[] = {
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
2.35.1

