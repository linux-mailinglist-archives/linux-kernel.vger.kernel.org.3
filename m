Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE1656777D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 21:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbiGETNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 15:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbiGETNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 15:13:33 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259F31D0D0;
        Tue,  5 Jul 2022 12:13:31 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g1so8889289edb.12;
        Tue, 05 Jul 2022 12:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1DHr3dlbu11ZSPjOSWP4Cb4EOGiEz88WTyi5xy5SNpg=;
        b=PSTYZ66iuhVFhKZWCuqj5jrqrBH9TGzrmfApPdEz9wuOGH5/arvzREI7P2DABXF3Sn
         OuNmt4hkVTlODCIxe7hl+55vEteCjKFB6HpGsagrnzG/FmtVrgbg0qdz84FecenHnfiY
         +Gi0e3nBZ0x5kiNP4lPme8Oqj/no5S/+hPkoy42yNafI5r1WkOlWKXX5TTar/zHl5vTC
         aIb9DE+TavZy7b0t+FUDcoFhtOgvE/ZOs8v4kkD/vay5kKNK67Cw9+WgYUJ4te1vI8mN
         xmlBQEhkS8xhAjETplJrgNBA4RPpNlexYjFQn+9zLN3HZP50za2GmF76J4Nr9rbOGhRY
         1CHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1DHr3dlbu11ZSPjOSWP4Cb4EOGiEz88WTyi5xy5SNpg=;
        b=yBWsvheKAqS2Shj5rUpiWAxVhKWX85tYrXywfg6cWdjRDi0D5KikJOF4+zxsluNqgn
         Rk8JHQ2y3v6ifyvbwqfxkBCo/8N+0NlPyaxVisR8TomW95xuKtyePgJ53m8GETS+1JMM
         ncgZ5nXTA7OKVUVlT8TTgyGI5EIUdZ4eJKXHkooZ8BJkU/MvWMQTvMOB3wwglmDIQJwu
         6/lLlJZ5rZk7k/HBQV7TzFeaf7qMfPKKBHkARtWcbV79CMDyxIXg62tsGaCBJkfISVSx
         ii3CkhJ2vOfwPBxzB9lLB/OdQNTL+D+f7BnwDddA4hUBk6yIv55CytlqDcvyJbwpsI5L
         rgPw==
X-Gm-Message-State: AJIora/WqOZfQ5ySmrE9VkjO6CDdXxlUgg2kKEsQchTPnfoep4yFPRnW
        wxOoaieHFq0EpeA7gy0On0rVnoIfsNMqDQ==
X-Google-Smtp-Source: AGRyM1ulAHmR54VJt5wjmRJ1Ef1tX9p+B88XgkrxSiFFzChKYLHWxB+bNmhxvy+EtraFHUwPBiCR3w==
X-Received: by 2002:a05:6402:538d:b0:435:7ca6:a136 with SMTP id ew13-20020a056402538d00b004357ca6a136mr49978401edb.268.1657048409696;
        Tue, 05 Jul 2022 12:13:29 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-99-13.xnet.hr. [88.207.99.13])
        by smtp.googlemail.com with ESMTPSA id o19-20020aa7c7d3000000b0043a75f62155sm2480365eds.86.2022.07.05.12.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 12:13:29 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, jassisinghbrar@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v5 1/3] mailbox: qcom-apcs-ipc: add IPQ8074 APSS clock controller support
Date:   Tue,  5 Jul 2022 21:13:25 +0200
Message-Id: <20220705191327.1684277-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
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
updated to 0x5ffc.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v5:
* Use lower case hex for max_register
* Update the APSS clock name to match the new one without commas
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index 80a54d81412e..4ef7e917a911 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -33,6 +33,10 @@ static const struct qcom_apcs_ipc_data ipq6018_apcs_data = {
 	.offset = 8, .clk_name = "qcom,apss-ipq6018-clk"
 };
 
+static const struct qcom_apcs_ipc_data ipq8074_apcs_data = {
+	.offset = 8, .clk_name = "qcom-apss-ipq8074-clk"
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
+	.max_register = 0x5ffc,
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

