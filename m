Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13519518DD9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237579AbiECUJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238116AbiECUJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:09:14 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88371A81F;
        Tue,  3 May 2022 13:05:40 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id i19so35408239eja.11;
        Tue, 03 May 2022 13:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WTxPRlSp8k/tQZEOjjNIb49rT6gGrw+y6fIhsPtqfJw=;
        b=FPw/kgO3kRxUOvJ0Ls1YbCPnbUV0Dd4LhhhhKMQUfqqdPhWAEwQ8MvItKLDjxiQPXp
         FkYVY2Q3hQ4ykRgNYJidQICznTbsRdSP9+iCS0mdV8p3fjm+Y4H1zcI+bYasgU+Yu8e9
         bE5iP/nySKJktmYKqC4+Iys2cpZKL7OjaazAy7UQUHsNFfESmdjFgOw336gyXUiTbpIS
         pdh8Bks7jH+ELJca9EF6IHeiTltBVF4KY8L41hAwrmS/m5SUUIhpBqV/ZB7x2iZ90R9h
         KyWGiPtIfwmxRFiwWRvCHOHUO9P7s7cni8or6PfEnbomkD8kp1RnEtkGh+KCYb2GiEGO
         rA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WTxPRlSp8k/tQZEOjjNIb49rT6gGrw+y6fIhsPtqfJw=;
        b=2Ggxcfw7LxNB07jyGSoON9fDh+Of9NYlHYg1Tg53WV0z0eTq2GIpNTupFsYFWFg9f1
         V8ZxDbQSsoqaNRrlvxhxLPCzdxXXhCrUHLNX+ARTEB4mUFscYk0kMlbjJgvsEWREwb0D
         4LO8RdyhZZXUkK8VRzLYUaiH2bUtBltmG0ya306+C7rfz04frKpkQsJPztw1zTGd0Yt9
         4JbqrF0A8Nxh6QslvuUldyl6kmH+v5T94iPYO7vjreFczxQExlAD2hP+PQt7perb99Zt
         t3RSDG2CdTjrYLl9JlYCm6iHXQxvBFPOUYhWovUhxtM5Us2FUKearr7LTwtapCqc3QSO
         7oTQ==
X-Gm-Message-State: AOAM53059xndyPErvAzY6EFzu3XKe3WyOSqH9ihqD0ojDK74vSQM1yYX
        /Cdn9TTqweK9sev49nljAJo=
X-Google-Smtp-Source: ABdhPJy97wcx2+LQYk1Z0yYUYdRE+FDtycigEOVnhsq0UROZnJzxl30FOcTr/0vzDwv23e42Kw1AXA==
X-Received: by 2002:a17:907:7d89:b0:6f3:ef24:ddd2 with SMTP id oz9-20020a1709077d8900b006f3ef24ddd2mr17109585ejc.550.1651608339476;
        Tue, 03 May 2022 13:05:39 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-96-149.xnet.hr. [88.207.96.149])
        by smtp.googlemail.com with ESMTPSA id ee47-20020a056402292f00b0041d893ed437sm8688450edb.2.2022.05.03.13.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 13:05:38 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     amitk@kernel.org, thara.gopinath@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 4/5] drivers: thermal: tsens: add IPQ8074 support
Date:   Tue,  3 May 2022 22:05:29 +0200
Message-Id: <20220503200530.4019673-4-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503200530.4019673-1-robimarko@gmail.com>
References: <20220503200530.4019673-1-robimarko@gmail.com>
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

