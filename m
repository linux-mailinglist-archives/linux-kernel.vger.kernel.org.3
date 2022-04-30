Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE99516087
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 22:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245351AbiD3Uyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 16:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245256AbiD3Uyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 16:54:33 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2A2532F9;
        Sat, 30 Apr 2022 13:51:11 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id j6so21325972ejc.13;
        Sat, 30 Apr 2022 13:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WTxPRlSp8k/tQZEOjjNIb49rT6gGrw+y6fIhsPtqfJw=;
        b=ZgWtBCPbxdcubvjm5eOLFd7UbCE3dkoGHHVjcvNA51pgtArPteh0HqOIgrrNzO996Q
         Up0qyqpDLomuNAoKphExVIv2LRiI9dhnJGBKVAkw3+dqzlc3sIQPXyOKZeKmtl2UcDz6
         uJhXQ+XPHM42Rn+DxdgWhN5rk54ZxlpqHBrXSve6z3C/M/RrJXPmW0t7oY/LaHGFQnk2
         jtsfASrFiWx8JyXCDP2/ougJmSz10bvxefqrMla7NdoTjcW5Fe7Yle9dV7wWsDMDVEbN
         y2ZV048YJMBfJz/XpDSd2OcoLlA6f+iHvd13uxWppi3YPo5FAp0afJHsHBnzzUK1h0qH
         8U8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WTxPRlSp8k/tQZEOjjNIb49rT6gGrw+y6fIhsPtqfJw=;
        b=OyJspYt6ZcyM55JMCaUgrh6NLcrlJRKUAX/tGA8gerq7NNcv0l2/TY+08Y+Xh3L1MD
         tRCtmYpJHej21dUBRrenXM2LXyeTvDBvaDwdCgYPOZBZFxG9bJdOnzBoVrAXX/9A/YK6
         sLv9QWBch3EokMMEkiac9MEtd1O4fWHryvsjVRnccq6S/ReT42MtJCfHLsDCO/Ztfalg
         WchCx5yOYyqjojRAYD+9qrbr/wOrDC73xONZ1g1VEiqA1UstCtV20YlqFyutta+/1xbH
         wT7E1TwAgPaiQsY20tZTi8t6vd9aWjCRzw+QDcg4oFQrBxr0Wbu8X48ge3aKsv0GYO/i
         xKhw==
X-Gm-Message-State: AOAM533Zjsu8SOsWirJltaZX+D+eQ2ZCpsgCvr8KW1YxTBJ/XrWbqIOJ
        YF6SFSBi6sMOXgavh9xhNUo=
X-Google-Smtp-Source: ABdhPJw25aNECHEdXqICt7T/P9ixNI3dZRfalXDP9bVN+Ya9GYt/DWSRLlw0ckTsw/HEUA3vaPmp+w==
X-Received: by 2002:a17:906:60c2:b0:6e7:681e:b4b7 with SMTP id f2-20020a17090660c200b006e7681eb4b7mr5094527ejk.130.1651351869761;
        Sat, 30 Apr 2022 13:51:09 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-113.zg.cable.xnet.hr. [94.253.165.113])
        by smtp.googlemail.com with ESMTPSA id p14-20020a056402154e00b0042617ba63a8sm4457852edx.50.2022.04.30.13.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 13:51:09 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, amitk@kernel.org,
        thara.gopinath@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 4/5] drivers: thermal: tsens: add IPQ8074 support
Date:   Sat, 30 Apr 2022 22:51:00 +0200
Message-Id: <20220430205101.459782-4-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220430205101.459782-1-robimarko@gmail.com>
References: <20220430205101.459782-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

