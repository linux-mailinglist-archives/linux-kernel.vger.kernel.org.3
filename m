Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037FA51EA1D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 22:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447066AbiEGUk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 16:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387365AbiEGUkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 16:40:17 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F0415A06;
        Sat,  7 May 2022 13:36:29 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id p18so12159614edr.7;
        Sat, 07 May 2022 13:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FkZyMHsY41xT/CmWQtmq+DH5943q52c4v6gNy4xAhCo=;
        b=BspjtWFGrEehHsEi4JeItiYnPanytAKwZMRx/zgBs2ZcA5GBVvHE0rKv08Fd7jf/PD
         mUz1vcfgxQjunfmrKSIE9sXR8Q034t4jkQYXZaC8J9NDUrJL4jFqltuxPleHaDF2dBqj
         u3QFb4LdEJ8G/bmcLhBwJFvv1o8whZqAaniCCS9PwzSDt8m+9SiOHngXdMizlyA1x/85
         iqwjhCpUxncYGikKzLeDy9Xbx0gvGMPvtNqG2jScbE0ed0wmEGZ836AWFF5E4G+tjqsI
         D/8CpMYBPT8J8HblrjGkUuYQZJ5dqCyKUYF+BVpoxpIcsi2Q0Nypbn3QQB9XLzqLjcVO
         Urpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FkZyMHsY41xT/CmWQtmq+DH5943q52c4v6gNy4xAhCo=;
        b=KRD61B8ZSxqV5kIxaslFkjWDV2IsM0pqYixqWPheXJwop3/JJlOx1vJxDWCW/1x2yP
         iq5n0dku7HJwl2T9AX2Qe2mzjpz2kWsvft36saS0EpQ7T0LHUBsBnlVTnv+zircCyPcS
         aKR9yrmz0ITseLdeZVWFUQx9csaTpcFdzBidSCgtF6zj4V4VLTSmioUKxByF5gV78xs4
         QG+fzW/lB57vMZPudOfMfgQaeJx8nNbpJ/Vb/a8wLLNQE3aCDnLQgv7GVQYjAo3SvJFx
         qWdgUd+VLoobG6CJG7yUTaQ87OwtWiawG+Qo8tn9+GReWBxT4W27E78DtqPBMeWKYmXS
         DBsA==
X-Gm-Message-State: AOAM532r0DOhimJHR4zkEnsUt39rjT2L74DoJ9m37OmziwpTpoqp1SgX
        wifNTZ/IBlQ1mQWhVR6SM2U=
X-Google-Smtp-Source: ABdhPJzsQSX33H5+r8vHaXoRG0AKXQVJsZ57TvzaHOdmuLrguI5sY+grOSk/Lo1phBHc7Vy9Dsj28A==
X-Received: by 2002:aa7:da12:0:b0:427:b434:a374 with SMTP id r18-20020aa7da12000000b00427b434a374mr9748992eds.408.1651955788265;
        Sat, 07 May 2022 13:36:28 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-244-cbl.xnet.hr. [94.253.144.244])
        by smtp.googlemail.com with ESMTPSA id eb20-20020a170907281400b006f4c557b7d2sm3283456ejc.203.2022.05.07.13.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 13:36:27 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, jassisinghbrar@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 4/6] mailbox: qcom-apcs-ipc: add IPQ8074 APSS clock controller support
Date:   Sat,  7 May 2022 22:36:18 +0200
Message-Id: <20220507203620.399028-4-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220507203620.399028-1-robimarko@gmail.com>
References: <20220507203620.399028-1-robimarko@gmail.com>
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

