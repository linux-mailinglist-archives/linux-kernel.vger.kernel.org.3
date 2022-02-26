Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA20B4C5794
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 19:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbiBZSlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 13:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbiBZSlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 13:41:32 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B62B1E64F6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 10:40:58 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id g7-20020a17090a708700b001bb78857ccdso11241415pjk.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 10:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NhYp7rvNV+p3QtraK3mzi6k8+sTimZVZsYgYTKLgOjw=;
        b=ktI7wjlrlnHVlR7gidgss4RFsubYBAMmdP1LjboWTcwBtemI2uUEBev1G0JAAWHJrU
         gNvV5jaUhrlWBCeloQ8Wk6mFC8Ej9d7c1ejiXJHegJxc0J4W11egy3iFDUPOmtIB3jE0
         FXGzchdtuRILbMXxoKmnxDTub6qmaq+mXno9sBbppD/LCZleUgnZ2nNaW0GHT6pVCzCn
         UimUSDgRSQQcD7plCi78gRIo7cgbBKPYZa/WuHnpRNKLsOk5R9AQhcpESJIKBbRF3h9Q
         fmsq73BqZMlXS5Jiimc08PyCaTPxEZ1ixvKZVpvwjkqO1DIRKqbUsvLP/rMtb67SJAPJ
         X3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NhYp7rvNV+p3QtraK3mzi6k8+sTimZVZsYgYTKLgOjw=;
        b=LUp9nx0dNat6orU8xGVSHAknuOouWX8AofVGC5GP6NCQQT5QLTzExGcD1st4tfIdJ7
         bJV+3VWU/AAqg9uQS82Hao36NMPJex2LidOb2nCGl0DBwpqqJaYE/xeSkJmEy6Vpz3MD
         q90fiMDOqAIOCVOKKRBS3esdiW5+av0N0yUBrsT6vQ+Fc12FkAMkrqRTaVh82+4Y+clM
         ZnyPdwFlgXxFhLBBlT3W/XXbbFbbGqGEj3qQrS4SaHMCywJjzbVrExUbPlR/UrL0ZvTp
         A72b5dzRjKViPj7rcYvEqM0dbAab1lNVc35PUQYq8QpVAgjIpZTjEOcJYz8l8r36iM+w
         DbjA==
X-Gm-Message-State: AOAM532amKbbJ4CJQGaIL8k1tcrFnAUn+kc1bOFAUSjhknSFdHQTG7eb
        L+dHdEqIN0+muy4NDVx/nUzOEg==
X-Google-Smtp-Source: ABdhPJww4jzPYcubElE8G9u93oVs9BTdT1cirgioMPIGfdOeCIk//dvrTS0HnJCnk/dhH+SNFhf7Ww==
X-Received: by 2002:a17:90b:1054:b0:1bb:fc13:73ab with SMTP id gq20-20020a17090b105400b001bbfc1373abmr8946775pjb.241.1645900857671;
        Sat, 26 Feb 2022 10:40:57 -0800 (PST)
Received: from localhost.localdomain ([223.179.136.225])
        by smtp.gmail.com with ESMTPSA id b187-20020a621bc4000000b004f3c8f3b560sm7049319pfb.129.2022.02.26.10.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 10:40:57 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, maz@kernel.org,
        quic_mkshah@quicinc.com, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v2 2/4] pinctrl: qcom: sm8150: Specify PDC map
Date:   Sun, 27 Feb 2022 00:10:26 +0530
Message-Id: <20220226184028.111566-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220226184028.111566-1-bhupesh.sharma@linaro.org>
References: <20220226184028.111566-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify the PDC mapping for SM8150, so that gpio interrupts are
properly mapped to the wakeup IRQs of the PDC.

Cc: Maulik Shah <quic_mkshah@quicinc.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-sm8150.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-sm8150.c b/drivers/pinctrl/qcom/pinctrl-sm8150.c
index 7359bae68c69..1cc622694553 100644
--- a/drivers/pinctrl/qcom/pinctrl-sm8150.c
+++ b/drivers/pinctrl/qcom/pinctrl-sm8150.c
@@ -1500,6 +1500,25 @@ static const struct msm_pingroup sm8150_groups[] = {
 	[178] = SDC_QDSD_PINGROUP(sdc2_data, 0xB2000, 9, 0),
 };
 
+static const struct msm_gpio_wakeirq_map sm8150_pdc_map[] = {
+	{ 3, 31 }, { 5, 32 }, { 8, 33 }, { 9, 34 }, { 10, 100 },
+	{ 12, 104 }, { 24, 37 }, { 26, 38 }, { 27, 41 }, { 28, 42 },
+	{ 30, 39 }, { 36, 43 }, { 37, 44 }, { 38, 30 }, { 39, 118 },
+	{ 39, 125 }, { 41, 47 }, { 42, 48 }, { 46, 50 }, { 47, 49 },
+	{ 48, 51 }, { 49, 53 }, { 50, 52 }, { 51, 116 }, { 51, 123 },
+	{ 53, 54 }, { 54, 55 }, { 55, 56 }, { 56, 57 }, { 58, 58 },
+	{ 60, 60 }, { 61, 61 }, { 68, 62 }, { 70, 63 }, { 76, 71 },
+	{ 77, 66 }, { 81, 64 }, { 83, 65 }, { 86, 67 }, { 87, 84 },
+	{ 88, 117 }, { 88, 124 }, { 90, 69 }, { 91, 70 }, { 93, 75 },
+	{ 95, 72 }, { 96, 73 }, { 97, 74 }, { 101, 40 }, { 103, 77 },
+	{ 104, 78 }, { 108, 79 }, { 112, 80 }, { 113, 81 }, { 114, 82 },
+	{ 117, 85 }, { 118, 101 }, { 119, 87 }, { 120, 88 }, { 121, 89 },
+	{ 122, 90 }, { 123, 91 }, { 124, 92 }, { 125, 93 }, { 129, 94 },
+	{ 132, 105 }, { 133, 83 }, { 134, 36 }, { 136, 97 }, { 142, 103 },
+	{ 144, 115 }, { 144, 122 }, { 147, 102 }, { 150, 107 },
+	{ 152, 108 }, { 153, 109 }
+};
+
 static const struct msm_pinctrl_soc_data sm8150_pinctrl = {
 	.pins = sm8150_pins,
 	.npins = ARRAY_SIZE(sm8150_pins),
@@ -1510,6 +1529,9 @@ static const struct msm_pinctrl_soc_data sm8150_pinctrl = {
 	.ngpios = 176,
 	.tiles = sm8150_tiles,
 	.ntiles = ARRAY_SIZE(sm8150_tiles),
+	.wakeirq_map = sm8150_pdc_map,
+	.nwakeirq_map = ARRAY_SIZE(sm8150_pdc_map),
+	.wakeirq_dual_edge_errata = true,
 };
 
 static int sm8150_pinctrl_probe(struct platform_device *pdev)
-- 
2.35.1

