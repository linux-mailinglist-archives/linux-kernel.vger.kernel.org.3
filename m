Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E415157F7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381318AbiD2WMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381306AbiD2WMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:12:19 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDD9DC5B0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:08:56 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id x52so6433913pfu.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fn2AqSrDktu9onw+xJqRpycXOFpgfT+y+eBhGZX0B1o=;
        b=IG945+9+87GJjDBoc4SK4z5/C0j/QS5H4YBj4P1yoXFP0zgLq/lZzMNjdYh5V4iqxV
         YKSRRRaShZc1KM7plw6uKeakwfRPBgK4itHafkGR6kqLPKJQXypuw3bn/S0VeyycjrAU
         vm2KkWl1+12CqUSEWn6ZC0s1zCNhBfB/YsFfCw9s33n1b0C9PohMLRP+rQd+OGHbqHex
         rju/o7My9FjLJyeKKE4osyZIyFfNazqUWF2nW2j8Cuv121KbSykKVs609IQIyWsVeHkL
         BOpI5qMmiDMlTkQz81Ulhissqg+aeCOXC5C9P3IZOG3iHPM7G+rB5kUZVNgTz+zMGS9W
         TsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fn2AqSrDktu9onw+xJqRpycXOFpgfT+y+eBhGZX0B1o=;
        b=xzQoXwpYb8Eif6JNH+WVSyC3U93bYoFrlOaGP1zJkaDqqrErB6WrQT0es47ULgg2zY
         vLGGk3xVDvIx1gfs22osBA2sUUxHe4CWmsi+VIVCYReUSrc24TLCG2y749FF5sPSj/lD
         lzx/TYvWhWflT4vEOfxOLA+Kk8DJDPBJEaPCJ8pN4xTxPk3eimpbHhJZIlWDJpS4DYLM
         kXz1mhAnihublKOGN/zu198Cq0sIuwtZbPxlns8mr6bk6jnEvLryZt72gCrnyMhMjXPR
         hhIYOvtHz05AxVfOei5HDZcxFgLrlu8KMMOkkt7XMKTV/kbSb930ZhJ5yKU7uV/fPdDt
         6LAQ==
X-Gm-Message-State: AOAM5317JXXSUYUyiDJyuuSP7iVd+CqSkTztgMVGTpIa0+ox/8Abxk22
        2cCw1ef3A2uTGJIGMd9NPKzILg==
X-Google-Smtp-Source: ABdhPJzi6qLlidSSflnORETma01551eA6GrtpzUGwF3DC2DSxAkAeUnnYNlERW0/1Ch9Gkfe0tbO4g==
X-Received: by 2002:a63:1918:0:b0:3ab:8c08:6774 with SMTP id z24-20020a631918000000b003ab8c086774mr1052886pgl.226.1651270135669;
        Fri, 29 Apr 2022 15:08:55 -0700 (PDT)
Received: from localhost.localdomain ([223.233.64.97])
        by smtp.gmail.com with ESMTPSA id n21-20020aa78a55000000b0050dc76281c2sm170020pfa.156.2022.04.29.15.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 15:08:55 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-mmc@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, robh@kernel.org
Subject: [PATCH 2/4] mmc: host/sdhci-msm: Add SoC specific compatibles
Date:   Sat, 30 Apr 2022 03:38:31 +0530
Message-Id: <20220429220833.873672-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429220833.873672-1-bhupesh.sharma@linaro.org>
References: <20220429220833.873672-1-bhupesh.sharma@linaro.org>
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

Since Qualcomm device-trees already use SoC specific compatibles
for describing the 'sdhci-msm' nodes, it makes sense to add the support
for the same in the driver as well.

Keep the old deprecated compatible strings still in the driver,
to ensure backward compatibility with older device-trees.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/mmc/host/sdhci-msm.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 50c71e0ba5e4..2de8d115a37a 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2434,8 +2434,31 @@ static const struct sdhci_msm_variant_info sdm845_sdhci_var = {
 };
 
 static const struct of_device_id sdhci_msm_dt_match[] = {
+	 /* Following two entries are deprecated (kept only for backward compatibility) */
 	{.compatible = "qcom,sdhci-msm-v4", .data = &sdhci_msm_mci_var},
 	{.compatible = "qcom,sdhci-msm-v5", .data = &sdhci_msm_v5_var},
+	/* Add entries for sdcc versions less than 5.0 here */
+	{.compatible = "qcom,apq8084-sdhci", .data = &sdhci_msm_mci_var},
+	{.compatible = "qcom,msm8226-sdhci", .data = &sdhci_msm_mci_var},
+	{.compatible = "qcom,msm8916-sdhci", .data = &sdhci_msm_mci_var},
+	{.compatible = "qcom,msm8953-sdhci", .data = &sdhci_msm_mci_var},
+	{.compatible = "qcom,msm8974-sdhci", .data = &sdhci_msm_mci_var},
+	{.compatible = "qcom,msm8992-sdhci", .data = &sdhci_msm_mci_var},
+	{.compatible = "qcom,msm8994-sdhci", .data = &sdhci_msm_mci_var},
+	{.compatible = "qcom,msm8996-sdhci", .data = &sdhci_msm_mci_var},
+	/*
+	 * Add entries for sdcc version 5.0 here. For SDCC version 5.0.0,
+	 * MCI registers are removed from SDCC interface and some registers
+	 * are moved to HC.
+	 */
+	{.compatible = "qcom,qcs404-sdhci", .data = &sdhci_msm_v5_var},
+	{.compatible = "qcom,sdx55-sdhci",  .data = &sdhci_msm_v5_var},
+	{.compatible = "qcom,sdm630-sdhci", .data = &sdhci_msm_v5_var},
+	{.compatible = "qcom,sm6125-sdhci", .data = &sdhci_msm_v5_var},
+	{.compatible = "qcom,sm6350-sdhci", .data = &sdhci_msm_v5_var},
+	{.compatible = "qcom,sm8250-sdhci", .data = &sdhci_msm_v5_var},
+	{.compatible = "qcom,sc7280-sdhci", .data = &sdhci_msm_v5_var},
+	/* Add entries where soc specific handling is required, here */
 	{.compatible = "qcom,sdm845-sdhci", .data = &sdm845_sdhci_var},
 	{.compatible = "qcom,sc7180-sdhci", .data = &sdm845_sdhci_var},
 	{},
-- 
2.35.1

