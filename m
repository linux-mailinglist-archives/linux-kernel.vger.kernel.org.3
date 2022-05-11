Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961D452385C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344502AbiEKQQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbiEKQQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:16:23 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE9925E83;
        Wed, 11 May 2022 09:16:22 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id a191so2218266pge.2;
        Wed, 11 May 2022 09:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CU+mxLzT2lKMrywnr1rwE6gmb+W0X+NRj+YM58ApNSw=;
        b=QJutaYpTc95yJslW/QR31EKZU5VboJP08esdGNsJ3bWQXZGFRovAU+n7etO3vYHlA6
         tB0Mf0cLMRSPvV7u7NeIvlLPO9MQOfyDkhClZBQ2KhQJBkIe+ieHifcvbZdBEWh/lk0d
         4dDzdipsTKIRdT3lCdymJm/Lf5yxfkPXZLiYU3k0YtZBoVEOR8hM/+LjV06kGL3E9YEK
         p9e2F6zN99YglVvdsvDx7WxuJdf4TArXBwOk8Qh7ZjC9HaE12HdLs6p03f0+Xmaf5yCV
         1dvMUwOckEld9hcY8DUbqy9Pb/KtAu/18PLlzQAGVU9oVI5txCa/EOoijNv/RjSOIesZ
         nDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CU+mxLzT2lKMrywnr1rwE6gmb+W0X+NRj+YM58ApNSw=;
        b=HX7Pj+TSDsjwqlZEK/YAJVVbMrkZniqUST7Z+Z8hyi9KFFE3j37h0DTPraKbkIXOM1
         GX2h62Vk1MYriJZeqxOI7EzavHLcxB/rSghbyAFJXJfYdygvftLQxr7LIwcO9uMo1qac
         bE4unB/XB+xpIg68ubE8Rx+fEq5aVXShJlIdpNr/nJbb7WLXPX+LHSzZz+KaAj+aWnQ+
         /Okbc3Uz4p2W+YwnsadlZxMrdJyK78/ul2bmB76amd7+bvg/nUJH3fdRpALYjEpMWw4c
         fPJj7VT5pOoG+EqX5ILdPLqEIF6gLDZDgdlasMfKWzArIhGKKJOsS72QHwFUh+SereWS
         CDAw==
X-Gm-Message-State: AOAM533RBeJ3ABal6xLqQspVBkfvVX1vwa8xHYVxqDvebhO+M0ff5E4C
        IVsPt575hm+CuvdpDgtx+d8sx0CIAL5Tsogq
X-Google-Smtp-Source: ABdhPJw+tjlF3RGkx12l9Wv9cBRwKsZ9vL03zq42S5aJnl5DfDG+TeIJeF0rywl12On8RPWpD0CofA==
X-Received: by 2002:a05:6a02:11a:b0:39d:698d:5067 with SMTP id bg26-20020a056a02011a00b0039d698d5067mr20967409pgb.310.1652285781753;
        Wed, 11 May 2022 09:16:21 -0700 (PDT)
Received: from skynet-linux.local ([49.204.239.218])
        by smtp.googlemail.com with ESMTPSA id x7-20020a17090a1f8700b001ded49491basm220322pja.2.2022.05.11.09.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 09:16:21 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     linux-remoteproc@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 1/9] remoteproc: qcom: pas: Add MSM8953 ADSP PIL support
Date:   Wed, 11 May 2022 21:45:54 +0530
Message-Id: <20220511161602.117772-2-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220511161602.117772-1-sireeshkodali1@gmail.com>
References: <20220511161602.117772-1-sireeshkodali1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Audio DSP PIL found on the Qualcomm MSM8953
platform. The same configuration is used on all SoCs based on the
MSM8953 platform (SDM450, SDA450, SDM625, SDM632, APQ8053).

Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 31 ++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 1ae47cc153e5..4dcb714a1468 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -617,7 +617,37 @@ static const struct adsp_data sm8350_adsp_resource = {
 	.ssctl_id = 0x14,
 };
 
+static const struct adsp_data msm8953_adsp_resource = {
+	.crash_reason_smem = 423,
+	.firmware_name = "adsp.mdt",
+	.pas_id = 1,
+	.has_aggre2_clk = false,
+	.auto_boot = true,
+	.proxy_pd_names = (char*[]){
+		"cx",
+		NULL,
+	},
+	.ssr_name = "lpass",
+	.sysmon_name = "adsp",
+	.ssctl_id = 0x14,
+};
+
 static const struct adsp_data msm8996_adsp_resource = {
+	.crash_reason_smem = 423,
+	.firmware_name = "adsp.mdt",
+	.pas_id = 1,
+	.has_aggre2_clk = false,
+	.auto_boot = true,
+	.proxy_pd_names = (char*[]){
+		"cx",
+		NULL,
+	},
+	.ssr_name = "lpass",
+	.sysmon_name = "adsp",
+	.ssctl_id = 0x14,
+};
+
+static const struct adsp_data msm8998_adsp_resource = {
 		.crash_reason_smem = 423,
 		.firmware_name = "adsp.mdt",
 		.pas_id = 1,
@@ -850,6 +880,7 @@ static const struct adsp_data sdx55_mpss_resource = {
 static const struct of_device_id adsp_of_match[] = {
 	{ .compatible = "qcom,msm8974-adsp-pil", .data = &adsp_resource_init},
 	{ .compatible = "qcom,msm8996-adsp-pil", .data = &msm8996_adsp_resource},
+	{ .compatible = "qcom,msm8953-adsp-pil", .data = &msm8953_adsp_resource},
 	{ .compatible = "qcom,msm8996-slpi-pil", .data = &slpi_resource_init},
 	{ .compatible = "qcom,msm8998-adsp-pas", .data = &msm8996_adsp_resource},
 	{ .compatible = "qcom,msm8998-slpi-pas", .data = &slpi_resource_init},
-- 
2.36.0

