Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA8756A9C2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236393AbiGGRhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 13:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236415AbiGGRhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:37:40 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CFA33A3E;
        Thu,  7 Jul 2022 10:37:39 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id os14so3424944ejb.4;
        Thu, 07 Jul 2022 10:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+2iUJRSSFPeKtqt+m5PTxHkXVeupFaLc8VFbsLkL0Yg=;
        b=TqT2JcUKveYN3USi0cvSIV2c6xKPkBjMJf1F2HoAG7o42uej3xUKN148plcp7SkYEx
         lTBMaCw50UkmyE5bC6Fl39wzx3oVnrJ7cErzczZAFzuJrxHNvPZ723aJTBkHB0BPA+Tg
         JtKjeyG9PBsZ+zwCbhOvPo7gOzmnH7fJX/48GJ/ae5tJB7vQuAMfQERQxEZssCT9FnsM
         iilO+fcG7j/GElbfw4Y77LrR1l99zorCovZlRMItFd2Sik2JWAeTwAYTuJbsZai2eElC
         H+rWxOYfCWmRZINVhVsB3syqbD9jDsZNSIWwTsWj0qVfptJGgnIp9UDwm21jFVKW+c1F
         9ckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+2iUJRSSFPeKtqt+m5PTxHkXVeupFaLc8VFbsLkL0Yg=;
        b=lc5Xwc6PkQg00IGm0XagaWZCJKzle6rAv1canWlP7jNtOFNBxzzDfhOOENvzVDK7kV
         zW8KlsqBqhudFJbSfWIfKo4buU77Ap2Wq+uTkXQHQchsWY4phGj3OnOoC21jD2pF1ox/
         EGAuty+wV+57hy7+pEO1230L3oJSgSYyxGwYpZmqtnZMHiqWZl4EWuxiNT8kgLM84kPy
         K5ri8YzwmYTY00L8yOj9PBSAubg13W3SLrZoPnggKpT8lyN1H+f79Ubu0/hVYhdlzQxn
         7hZh87P9s8DFJJAshK0WxTiNfbn+4+LsO6J38LWaac50vW+3AlWaTKuWEilPIVhqIv67
         1Mng==
X-Gm-Message-State: AJIora8NKv686SNHBe6JKAxhqZZAXs37ta6iSCHmaw7HS4tjOCWVz719
        DFPJ/LJMv0Le9pTkrLbKfetfmBAfAH1xqA==
X-Google-Smtp-Source: AGRyM1uvUEM6FG+lZXZgLl5wJCJO9bsr/KFOlyaNrcZo9G5TvrRMCULVC2+5Jc9pktchW1OKO073+g==
X-Received: by 2002:a17:907:3e84:b0:6fe:8c5f:d552 with SMTP id hs4-20020a1709073e8400b006fe8c5fd552mr45879895ejc.710.1657215457737;
        Thu, 07 Jul 2022 10:37:37 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-96-250.xnet.hr. [88.207.96.250])
        by smtp.googlemail.com with ESMTPSA id l10-20020a1709060cca00b0072b16ea4795sm674715ejh.48.2022.07.07.10.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 10:37:37 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, jassisinghbrar@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v6 2/4] mailbox: qcom-apcs-ipc: add IPQ8074 APSS clock controller support
Date:   Thu,  7 Jul 2022 19:37:31 +0200
Message-Id: <20220707173733.404947-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707173733.404947-1-robimarko@gmail.com>
References: <20220707173733.404947-1-robimarko@gmail.com>
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

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v6:
* Adjust max_register value using match data instead of globally

Changes in v5:
* Use lower case hex for max_register
* Update the APSS clock name to match the new one without commas
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index c05f3276d02c..5d6b41fa6256 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -34,6 +34,12 @@ static const struct qcom_apcs_ipc_data ipq6018_apcs_data = {
 	.offset = 8, .clk_name = "qcom,apss-ipq6018-clk"
 };
 
+static const struct qcom_apcs_ipc_data ipq8074_apcs_data = {
+	.offset = 8,
+	.max_register = 0x5ffc,
+	.clk_name = "qcom-apss-ipq8074-clk"
+};
+
 static const struct qcom_apcs_ipc_data msm8916_apcs_data = {
 	.offset = 8, .clk_name = "qcom-apcs-msm8916-clk"
 };
@@ -148,7 +154,7 @@ static int qcom_apcs_ipc_remove(struct platform_device *pdev)
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

