Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2EB8518E15
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242205AbiECUMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242250AbiECUMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:12:21 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6034093C;
        Tue,  3 May 2022 13:08:23 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g23so21070199edy.13;
        Tue, 03 May 2022 13:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WTxPRlSp8k/tQZEOjjNIb49rT6gGrw+y6fIhsPtqfJw=;
        b=U+4hBfSOv9Abvqqi+SKK7arXEjCuYzM+IVRVZ6f0Ajq6bHA0VsHYdpooYARsGwQXy8
         VZnQ/0gA8g8bn97eeSU4xsMyr6CWQHQJcCzbQKxc/r5Ed0mNSNMi3S92X7lX9zUierQ6
         JuOJr9qpsMK7YsJEqk7KOKDXri8Z4ONs7Z2bo0pfpBKHpIbx+Vwy4qjyp26cwZ7X18BJ
         0mKEfzb2ZzUQcrgHYaTvCfrs9rFpWbxS3haPbxc5swktPAx/2kCfQ9XjKT8ku+gl8Yuk
         UyKOkniBnGrquSdtT3vu02SvtNcZW+xRKpyie512TKCNv44XN1UksBkpEhXnVGrvvPkw
         xGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WTxPRlSp8k/tQZEOjjNIb49rT6gGrw+y6fIhsPtqfJw=;
        b=Q+Ak0pkqsfT3W65t6fcvJDd8HPjUxTjjPFj2V5YWPHV2JtByayCua7NXvJsBp1dFrs
         Qkfy7r66wjLwSRRKXe98n89ckzHQSQByK2yOwDgUnqp1cA57SOtyKoMVpenYiG/WyDZX
         wnk4muFir7puk/8kF4C/Pa5oF9lwRypxJuV7z7zvPr5ZU1jN2775f6FM2lO0rpXVl/E1
         7Ayq6tkUyoxiNOvsNPAJ5XM2B2zm0p4XF6/MckQaAHykXRSbsdDMxVZuYTTN3z+J+1TS
         R4B0hIzrgnfjXKqswDmO2wKJO5RNOQ/6w7hqwqgZaI9qAYlpVmK++ykBaK7Aq/RO7aGP
         2kXA==
X-Gm-Message-State: AOAM530yIrFo/pwFV30voCZQu+sKIasyF7Rk8CiT64x+l093w2+yEBOU
        B1P/qyKF1SYpd1BWT9353JI=
X-Google-Smtp-Source: ABdhPJxzLXZX/4fzon2yUiUfry6PLx3nQQFep3+kyJROygcA//BHXoh8imiCaSFh+ETPQxcWCvTyHw==
X-Received: by 2002:a05:6402:2204:b0:426:34f1:1d2d with SMTP id cq4-20020a056402220400b0042634f11d2dmr19684916edb.335.1651608501590;
        Tue, 03 May 2022 13:08:21 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-96-149.xnet.hr. [88.207.96.149])
        by smtp.googlemail.com with ESMTPSA id ml11-20020a170906cc0b00b006f3ef214e59sm4967466ejb.191.2022.05.03.13.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 13:08:21 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     amitk@kernel.org, thara.gopinath@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v4 4/5] drivers: thermal: tsens: add IPQ8074 support
Date:   Tue,  3 May 2022 22:08:12 +0200
Message-Id: <20220503200813.4020698-4-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503200813.4020698-1-robimarko@gmail.com>
References: <20220503200813.4020698-1-robimarko@gmail.com>
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

