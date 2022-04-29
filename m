Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC44514874
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358690AbiD2LrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358637AbiD2Lq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:46:59 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528ABB2468;
        Fri, 29 Apr 2022 04:43:39 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v12so10405102wrv.10;
        Fri, 29 Apr 2022 04:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FkZyMHsY41xT/CmWQtmq+DH5943q52c4v6gNy4xAhCo=;
        b=gmRiWhNnfWopUPIetq+gmZDn7SeOQn4wg/jmCWUDofXXW6m2p9f8jkKDEgQo6MH/Tu
         Sk28kxgsJZewy3x3XBf1OFoDDy0UsSnHEjHZpPhl1eCavNxNZ9QBfI9WcM9hvp4NZgUn
         GG7RlTr7yjGMol6gHu3sHcvSd5PH+be7Q5XVHl3mb1EoWU3r+TOtfAhgEGugVRAD6URj
         xW3FOhQPIJQjnVCZrDmskQGzkolwmRUMGaoJLxtB1c+ciWCH9JePq8eRGYPNPDl3MSgn
         rc94vQltAxWU2qKWrQBuyt3DqD5slc50Yw/ebTopenAl7a5dhfxDlKEw1S2ejeRqMjK3
         jewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FkZyMHsY41xT/CmWQtmq+DH5943q52c4v6gNy4xAhCo=;
        b=Wij209GoN6PLvbkEI6vsCqVbSu61yDSCFBg71M81qAf2BBJbz6sTS7PBk4BoCe+iqZ
         S8HFStb7pm7xQqem5UJDTFo9PArEqE8XG4t19sir0n+t0mBt+IHyU8G0B52kdkfcluY4
         Jxo+/1NFZ/1EstrVLPf9wdlN343QRbGYTi8duTyhXqOyv6FWz+hYG/5QsX/aXj52e0Fb
         NHfkccgaGPmklgrPXbQJP+TrduVfPkZ178/IqZxabC4SWgGggk8UpOJYHR/SHcutDi8W
         QUeMDz0htyujEa4nqPU6QxdC08Iq7w+GGKCw3gzUZPIocgKdhYeGYlFajeYdGyNT2fOm
         rFhA==
X-Gm-Message-State: AOAM531f0Q9HFm6CioE/u/kgZ29hw9Hf9Kyl/2N0wE3ZpDsF3CjO/u9i
        Nv6pQUgu4tNC8q4dyT5yGv0=
X-Google-Smtp-Source: ABdhPJxVXyOAzN3psh/XeHPH8vMpPOmTwdBXilcG39svUm7sK09S/GKKItMrarXMyg1fgS8ggvEWkQ==
X-Received: by 2002:adf:ecc1:0:b0:20a:e019:e184 with SMTP id s1-20020adfecc1000000b0020ae019e184mr17230209wro.99.1651232617884;
        Fri, 29 Apr 2022 04:43:37 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-99-183.xnet.hr. [88.207.99.183])
        by smtp.googlemail.com with ESMTPSA id l6-20020a1c2506000000b0038e6fe8e8d8sm2990900wml.5.2022.04.29.04.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 04:43:37 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        jassisinghbrar@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 4/6] mailbox: qcom-apcs-ipc: add IPQ8074 APSS clock controller support
Date:   Fri, 29 Apr 2022 13:43:28 +0200
Message-Id: <20220429114330.59026-4-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429114330.59026-1-robimarko@gmail.com>
References: <20220429114330.59026-1-robimarko@gmail.com>
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

