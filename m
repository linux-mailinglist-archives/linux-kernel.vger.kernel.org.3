Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CBE527A10
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 22:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238839AbiEOUqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 16:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbiEOUpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 16:45:50 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571AA237EA;
        Sun, 15 May 2022 13:45:49 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id en5so1880794edb.1;
        Sun, 15 May 2022 13:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RR8GcrWO/N6Yh+M7ykjztK55oOJPryhOh+Be43AJsak=;
        b=a9gfspHSO4F6sCZHoh8MtHxN1rdlPQvGJvunQq5aHD0+OHvq7IaJF7c3Z0ddhdyzfx
         xFCcj1yFj19Hs9PCz6KOtkwj0mioXYSEbuYRAn7SfZsbcKYTy8MjClYKBlp/00QXkCC5
         vvp59JvEY9sTScLkA8nNCZcogFxrp+aTfBBUFHXyuHQTusFVZm25TnzdU8T3Ofn7657O
         tVnrFMU4/ZbWWxqQPzo0qSeURFTYxElu/ZJglJhDaxr5UsP0gozGxMMi6d1goHa4q3yT
         TLZktEn3V4XTlJh4xo+X6dRI7S/F+p39rxC41vKzvNOLZPCcw3KPVtoeBjss1gbBgcW7
         8SCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RR8GcrWO/N6Yh+M7ykjztK55oOJPryhOh+Be43AJsak=;
        b=GlqCdWcg3XZPQAwWYUjnk3WGI9h/2QKWzDZ1YCcSNauaJqtu57EVbStBi0MVc2ZkNY
         J3rJWR07ERJLtDgmNDzSZOfzTTKAw9j88rl50dhax758u16AkqHPwxH47DqHoTlGR+tL
         hOztDNHXU6E23TkCZMiA/tkPkneZnp4KLuNCBP2dpwp2kmRvxRE21tjLaGCnh2Mz0I9/
         kdTmFHy7JDhNqZ0MtPIclxnsdm7eJfUkNrd0ssIwh4gXJ72DEndWFQSm9Ygk/y0hgg8c
         J7GC0Yv1FPXqJnU0B3FXzS2OoleT80IWp61cJrH0mXfQ6+VfKZP4mwsYxSFAbWkJ2AXK
         S1+A==
X-Gm-Message-State: AOAM530Ni4zmLfJ/GjD/HxO9OC5ivGGCr2hIfVeO+K02+leolfBS7CtY
        NV3kSD4rQFJ8hDzhk715rYU=
X-Google-Smtp-Source: ABdhPJyAlXBYnl6PztUH2q1hSxgpYTJEGe7EmA+EalIc1ZrtmQjVlFV3ZGUbnnt1nu2hLYABOBi4Sg==
X-Received: by 2002:a05:6402:42c8:b0:427:d087:29 with SMTP id i8-20020a05640242c800b00427d0870029mr9981259edc.53.1652647547846;
        Sun, 15 May 2022 13:45:47 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-105.xnet.hr. [88.207.98.105])
        by smtp.googlemail.com with ESMTPSA id i10-20020a50870a000000b0042617ba63cdsm4174156edb.87.2022.05.15.13.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 13:45:47 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        jassisinghbrar@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v4 4/6] mailbox: qcom-apcs-ipc: add IPQ8074 APSS clock controller support
Date:   Sun, 15 May 2022 22:45:38 +0200
Message-Id: <20220515204540.477711-4-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220515204540.477711-1-robimarko@gmail.com>
References: <20220515204540.477711-1-robimarko@gmail.com>
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

IPQ8074 has the APSS clock controller utilizing the same register space as
the APCS, so provide access to the APSS utilizing a child device like
IPQ6018 does as well, but just by utilizing the IPQ8074 specific APSS
clock driver.

Also, APCS register space in IPQ8074 is 0x6000 so max_register needs to be
updated to 0x5FFC.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index 80a54d81412e..b3b9debf5673 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -33,6 +33,10 @@ static const struct qcom_apcs_ipc_data ipq6018_apcs_data = {
 	.offset = 8, .clk_name = "qcom,apss-ipq6018-clk"
 };
 
+static const struct qcom_apcs_ipc_data ipq8074_apcs_data = {
+	.offset = 8, .clk_name = "qcom,apss-ipq8074-clk"
+};
+
 static const struct qcom_apcs_ipc_data msm8916_apcs_data = {
 	.offset = 8, .clk_name = "qcom-apcs-msm8916-clk"
 };
@@ -57,7 +61,7 @@ static const struct regmap_config apcs_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
-	.max_register = 0x1008,
+	.max_register = 0x5FFC,
 	.fast_io = true,
 };
 
@@ -142,7 +146,7 @@ static int qcom_apcs_ipc_remove(struct platform_device *pdev)
 /* .data is the offset of the ipc register within the global block */
 static const struct of_device_id qcom_apcs_ipc_of_match[] = {
 	{ .compatible = "qcom,ipq6018-apcs-apps-global", .data = &ipq6018_apcs_data },
-	{ .compatible = "qcom,ipq8074-apcs-apps-global", .data = &msm8994_apcs_data },
+	{ .compatible = "qcom,ipq8074-apcs-apps-global", .data = &ipq8074_apcs_data },
 	{ .compatible = "qcom,msm8916-apcs-kpss-global", .data = &msm8916_apcs_data },
 	{ .compatible = "qcom,msm8939-apcs-kpss-global", .data = &msm8916_apcs_data },
 	{ .compatible = "qcom,msm8953-apcs-kpss-global", .data = &msm8994_apcs_data },
-- 
2.36.1

