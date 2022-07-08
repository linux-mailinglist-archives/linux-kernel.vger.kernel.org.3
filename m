Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6979556BAB1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 15:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237980AbiGHN3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 09:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238076AbiGHN3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 09:29:38 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083FE2CC8E;
        Fri,  8 Jul 2022 06:29:37 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id v12so14250958edc.10;
        Fri, 08 Jul 2022 06:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F9h/5c6DpgeJo5Kf/PBoKFhnLFQYnTIMnjo/eMhJ6HQ=;
        b=cvH4GNBGE7LD3dXfZ+BVExDspEsu3egK/S3lzI7uFoORGs2iihdvvRPOJftyl/oOnK
         HMG9isKzPWCN0vkYGsNqE/8QkQc3xlLDD2hnBBFNkaiODQ00on+MLZDsXe0MwjA1t0vU
         sRkTrl906ruu2iE15jMn8HP+lm2+LoZ2A/CRtgH5Sn6Qv54XHCI4Y1gUuZriXZag4b44
         dWa8E7xgaIlmMb/vm42YQJayJqax1TeSAt5f0OqdFXIXKbCSuxzTyqa4da09fuQh6f5X
         3flo+ByZn9HFvqvtq1nz20puhc8xdj2VQIOmGAm4INxc5jxQGPlqukihv8xNXSqV0d/G
         Ilxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F9h/5c6DpgeJo5Kf/PBoKFhnLFQYnTIMnjo/eMhJ6HQ=;
        b=Hs4m4FlEvFcZUkPmkQDHZ2NZYrTa9KYrJ+bqkmevXYOnN9EUlw5Yi2Ob5KiTr1iCcU
         SpNx1qtF/X5Os3aOoU2q6j5IyP9e5BHr8dxoPEZ0kQNK3Icn/x5PMfqjysvNsdj2bL6j
         rmitIX6Btv/XRZkMEhS1frmnTXadll1evuk14PKAfTBW/8HsHZoTqyGe+JdMrK1Isk2z
         NseAuL3fIMHiNc1Vj2S6BO2z1IzJOnSzrbSmdQFHmCsXc7A8Nlu6HHE7btUhvTiyF5qP
         9/L0ctQnka2mye4T/Bb7BzjR23KPZ1pPhhPma//128ZUunhhFrZCWsJobC9rIZwQO8Y0
         AdUg==
X-Gm-Message-State: AJIora8tmMSNhvyz03IPQoOCTpfUCYy6XDXdYFOZJmM6gOFraqb0cnvc
        S8E+JoUeNiSb8etBRVBczBQ=
X-Google-Smtp-Source: AGRyM1sj6YYUXMufaOOqAOQf0Gbr3f5V8fUk6qGbwAIBg7qJeATLfkVnX5WW95PqSuESoVBy7WfoCw==
X-Received: by 2002:a05:6402:4507:b0:43a:5b42:2be5 with SMTP id ez7-20020a056402450700b0043a5b422be5mr4798128edb.392.1657286976587;
        Fri, 08 Jul 2022 06:29:36 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-96-250.xnet.hr. [88.207.96.250])
        by smtp.googlemail.com with ESMTPSA id q4-20020a1709064cc400b006fec4ee28d0sm20170398ejt.189.2022.07.08.06.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 06:29:36 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, amitk@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v5 4/5] drivers: thermal: tsens: add IPQ8074 support
Date:   Fri,  8 Jul 2022 15:29:29 +0200
Message-Id: <20220708132930.595897-4-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220708132930.595897-1-robimarko@gmail.com>
References: <20220708132930.595897-1-robimarko@gmail.com>
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
index f65e80e44d34..b2f091061761 100644
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
2.36.1

