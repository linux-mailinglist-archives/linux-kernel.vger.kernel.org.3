Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3022518D9D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbiECUAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235802AbiECUAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:00:13 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176533FBE9;
        Tue,  3 May 2022 12:56:38 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id p18so21045093edr.7;
        Tue, 03 May 2022 12:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FkZyMHsY41xT/CmWQtmq+DH5943q52c4v6gNy4xAhCo=;
        b=D5Gazh210ETF5k1PBU74odUvmQdwax0VgKOpz4kG/QibDk2LgKUrAthppDZaYJjy8b
         5LB/tYBavIkgyYRs7kPZYdi1A7najaRXkv4YJH1VggLPMpcLV8z3W+DC8lm7WItUoONY
         +h3Qwx5Hdw6vyW/y51ayXom8bqLCKbIc4BdpiBBNg1qz2Qkqzf7K+Py8/Jsb+qXb34Kb
         ScUN4Uz23p2IZESaAqAjppGM1yCFhAc3GCHUhgYM23jK37tg4GEb7dY8QxCY/IbhoB6V
         ccad7EQ6j3OpmJz2fpnxc3iflZTlmgm9OzUdIANINwI0Mcr+hd95rrHerMfzweG3NZNu
         GPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FkZyMHsY41xT/CmWQtmq+DH5943q52c4v6gNy4xAhCo=;
        b=GjJyvZRGtFXFK/PfeS+A6aZoyMJAQqKngamyefIZVPaa0PYCgXdLj1EYckdvmf4UN1
         pNtGF2V1LfeGL/B6yMBNFY/JqBH4R7ONffJtwTWjCRq0E9lm8HAVyYLTlcYS08bkB4w2
         CF958XS1RhiwAngr3MwuwiI3JdG7zkLWOTNkxiG9UWC5O9OMje9/GyqtO47rA3oxBRL3
         VK3N+zIemTRve3vGrqo7er3636NU1OB/eSpQHuGMLXV343QxSQRAVQ5XtHm0zRz1ew3Q
         KzWfYGmplkSbYLcCc9+Hq8HKBulk4rm9Yex9ZjMT0J+sdEUDngkTmwp4QGN3qjZYFUxB
         WLeA==
X-Gm-Message-State: AOAM532EhR48lzWfyjCM2R9GVYogHcnt9W1p2FEPriTBDgWt/9ppXDa1
        unRz6KTl18uuEWHA45u4I0N7AK9klRjilw==
X-Google-Smtp-Source: ABdhPJyY+21hHm3KgCPbW0zVL1UOwYRsQQJ23ELqGNWvH7ynDxuixG6ZjCZmGoVNWZF/yu62SglWQQ==
X-Received: by 2002:a05:6402:1cc1:b0:413:2b12:fc49 with SMTP id ds1-20020a0564021cc100b004132b12fc49mr19607705edb.118.1651607796624;
        Tue, 03 May 2022 12:56:36 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-96-149.xnet.hr. [88.207.96.149])
        by smtp.googlemail.com with ESMTPSA id i8-20020aa7c708000000b0042617ba63absm8229270edq.53.2022.05.03.12.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 12:56:36 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        jassisinghbrar@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 4/6] mailbox: qcom-apcs-ipc: add IPQ8074 APSS clock controller support
Date:   Tue,  3 May 2022 21:56:03 +0200
Message-Id: <20220503195605.4015616-4-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503195605.4015616-1-robimarko@gmail.com>
References: <20220503195605.4015616-1-robimarko@gmail.com>
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
2.35.1

