Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF5F571695
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbiGLKHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbiGLKHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:07:41 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8253AAB38;
        Tue, 12 Jul 2022 03:07:39 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id eq6so9464372edb.6;
        Tue, 12 Jul 2022 03:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ddZjIbYll5j1xU/Makkx5ivXMXtzYaZP4m3U3y8uUKo=;
        b=NzskHhXO51lXDBi6AdCQr9mBok7tmEQ1LHlNiZSLQiAOymWKp6RapyCR0Y4XHTk+wm
         /ii0vY1vbEHv2opZIpBrPlBPpJk/xX/u/Xd2w+4oq/Km8l4XJXwJBXxtJp7xTHiIXBfC
         kZC0e2tkUi6xAeEiJOHYRmayt4OYMjg7XGJgUiF+h7VEqemA18nT2vqDN//X0HO/eMBB
         RVIEfngvoRJ/Mtd08EM/ueMhiYl09JNGFslshhafLuQol0SMHv+gnsPjKf7TrIt3O4n5
         ASgt3VoSC4gWB9tbuAwjVKBKOKsuMXF2SybJBR+TJ5E//h/yaKp3Jb6nE2vDSQiQETsG
         yqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ddZjIbYll5j1xU/Makkx5ivXMXtzYaZP4m3U3y8uUKo=;
        b=w5bUV1mZHrzWRglH9Z+s+FQflnIv/w5C+erq1nW4K/Vgz2pOWDSbIZQ+kDQk1n4tCR
         SzEZ59zs4et99URum+p5ZdByKczO3si4Sc78h2oXBMxxs4mlXUjpVwwg44Taa1wBF5E7
         53RKcLauUfO4lDU/O4kxfpahEq6+bqhKIi5psiiSv+efo5CGc2tq58EYuhDIdjeEiUCy
         aSkcvdgrfLfOM22eQTc3zcB5roYtwQjj6FieKGZ8NC096x50TA4MCu705UqWZiKRakyB
         cXiJQfMRHEy+Aq+/afEdhPXGFPUcZ9ztEpcpbgbM49/Luk1245ehTjT3Bo7SFzhYnpuL
         zblw==
X-Gm-Message-State: AJIora9fbKICUFAMHxr8xntgQwNRopF/sKsGKIBxgE64G8bmnpnZRCQW
        Q8FDR7SoInQSJhhIMkrW8WA=
X-Google-Smtp-Source: AGRyM1u8t/MUsOEkf/rCSRi9bfIxxrCIMu4Ad6ddi60UTU7OB4bh0FFaMndqUpZYZCBziExmKvih5A==
X-Received: by 2002:a05:6402:2743:b0:43a:7f92:8e30 with SMTP id z3-20020a056402274300b0043a7f928e30mr29838578edd.168.1657620458496;
        Tue, 12 Jul 2022 03:07:38 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-104.zg.cable.xnet.hr. [94.253.165.104])
        by smtp.googlemail.com with ESMTPSA id bd27-20020a056402207b00b0043a21e3b4a5sm5799675edb.40.2022.07.12.03.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 03:07:38 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, jassisinghbrar@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v8 3/4] mailbox: qcom-apcs-ipc: add IPQ8074 APSS clock support
Date:   Tue, 12 Jul 2022 12:07:32 +0200
Message-Id: <20220712100733.34261-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220712100733.34261-1-robimarko@gmail.com>
References: <20220712100733.34261-1-robimarko@gmail.com>
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
IPQ6018.

IPQ6018 and IPQ8074 use the same controller and driver, so just utilize
IPQ6018 match data for IPQ8074.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v7:
* Dont max_register modifications
* Drop custom IPQ8074 match data and use IPQ6018 one as they share the
controller and driver

Changes in v5:
* Use lower case hex for max_register
* Update the APSS clock name to match the new one without commas
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index 80a54d81412e..f1f0e87a79e6 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -142,7 +142,7 @@ static int qcom_apcs_ipc_remove(struct platform_device *pdev)
 /* .data is the offset of the ipc register within the global block */
 static const struct of_device_id qcom_apcs_ipc_of_match[] = {
 	{ .compatible = "qcom,ipq6018-apcs-apps-global", .data = &ipq6018_apcs_data },
-	{ .compatible = "qcom,ipq8074-apcs-apps-global", .data = &msm8994_apcs_data },
+	{ .compatible = "qcom,ipq8074-apcs-apps-global", .data = &ipq6018_apcs_data },
 	{ .compatible = "qcom,msm8916-apcs-kpss-global", .data = &msm8916_apcs_data },
 	{ .compatible = "qcom,msm8939-apcs-kpss-global", .data = &msm8916_apcs_data },
 	{ .compatible = "qcom,msm8953-apcs-kpss-global", .data = &msm8994_apcs_data },
-- 
2.36.1

