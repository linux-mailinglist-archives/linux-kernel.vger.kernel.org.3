Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36D852A105
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345681AbiEQMAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345713AbiEQMAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:00:19 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821234C43C;
        Tue, 17 May 2022 05:00:08 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ch13so34137891ejb.12;
        Tue, 17 May 2022 05:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DzxGK66oNP5EqUefEbuvx65uQZvfKjOjhE65FjoDOMc=;
        b=O1XqqJDdR2eKJn/3+OmYQ8rAWfD4lpv59KEyW9LqI5Xv3yM95R0odaM6rY6AJ8Wzf7
         gthXPzyZjbt/tmmUwoYQsxPZtYHjG0bp/WPjm+Eqo9IOjT+pzF107RMGE7ePVstiUK04
         8e+XwrfEQeAeFooHrsV49qZuAr80wGOvxNey1OIaUjVM6mOEPxI99SSivwIppHcjKc2j
         FayCvvMFnOo/+TZYHJ1fFRZGw2/9zjVKC9Mho6wJtml0b4McXU2kFzOeKcaLaJ4xBZb2
         6dj6W9PMBZI0Rpe7BOZ0ghzLxX2KHdNaH+QvTYnJT6q5RqIcesTwLvZ5p97f7+wevmsh
         UiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DzxGK66oNP5EqUefEbuvx65uQZvfKjOjhE65FjoDOMc=;
        b=US+fAqdhoAoEmzfzpLWbE3Eu0mWq9hycjQu0zqO672y91KbGV389nYS+SXuWQdPnF2
         lj0EJTGGw+NNwdDcTpnQOZNZXVhJim0IZLEGK46C2TKUU2MvkVsvLt7p0lCl1mfNSxHJ
         zKnt5pbDqpXvo5BhjXlB+Z1r/VcHM7dfel8U4JGT1BKueKFUHhXzxqE4RgroSdpRmILK
         M19Rid/BDgzfosEAr96p+ELdwwcZH5HcV6bdKyr83vSNyBfJBHoLg9mmGe9F1rqQ5sIc
         oJHGtOsjngLuvpgBoN+MWyNex6SjjHd3+un0ILmj1TJblWH7cj16sjZbmvTFI5J2CY0b
         ICGw==
X-Gm-Message-State: AOAM531zjzkczMruDqFTKvE9cJ6KAeqLQ9bNHCIwsJsghr1y4O9047Mk
        m9zj++8v9D7svd9f9yY1BGM=
X-Google-Smtp-Source: ABdhPJy5lPqbw1Cp4jdlGAc/DEDvey5xejh9pUs7hRyiTR6u33fGRoBQ4S4v04bAYQG4DlXFeiGmeQ==
X-Received: by 2002:a17:907:8c06:b0:6f4:9935:9049 with SMTP id ta6-20020a1709078c0600b006f499359049mr19792354ejc.517.1652788806982;
        Tue, 17 May 2022 05:00:06 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-105.xnet.hr. [88.207.98.105])
        by smtp.googlemail.com with ESMTPSA id hg16-20020a1709072cd000b006f3ef214e20sm948793ejc.134.2022.05.17.05.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 05:00:06 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 4/6] regulator: qcom_spmi: Add support for PMP8074 regulators
Date:   Tue, 17 May 2022 13:59:58 +0200
Message-Id: <20220517120000.71048-4-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220517120000.71048-1-robimarko@gmail.com>
References: <20220517120000.71048-1-robimarko@gmail.com>
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

PMP8074 is a companion PMIC for the Qualcomm IPQ8074 WiSoC-s.

It features 5 HF-SMPS and 13 LDO regulators.

This commit adds support for S3 and S4 HF-SMPS buck regulators of
the HFS430 type and LDO11 of the HT_P150 type.
S3 is the CPU cluster voltage supply, S4 supplies the UBI32 NPU cores
and LDO11 is the SDIO/eMMC I/O voltage regulator required for high speeds.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/regulator/qcom_spmi-regulator.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 38bbc70241ae..696b088aae40 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -2137,6 +2137,13 @@ static const struct spmi_regulator_data pms405_regulators[] = {
 	{ }
 };
 
+static const struct spmi_regulator_data pmp8074_regulators[] = {
+	{ "s3", 0x1a00, "vdd_s3"},
+	{ "s4", 0x1d00, "vdd_s4"},
+	{ "l11", 0x4a00, "vdd_l10_l11_l12_l13"},
+	{ }
+};
+
 static const struct of_device_id qcom_spmi_regulator_match[] = {
 	{ .compatible = "qcom,pm8004-regulators", .data = &pm8004_regulators },
 	{ .compatible = "qcom,pm8005-regulators", .data = &pm8005_regulators },
@@ -2150,6 +2157,7 @@ static const struct of_device_id qcom_spmi_regulator_match[] = {
 	{ .compatible = "qcom,pm660-regulators", .data = &pm660_regulators },
 	{ .compatible = "qcom,pm660l-regulators", .data = &pm660l_regulators },
 	{ .compatible = "qcom,pms405-regulators", .data = &pms405_regulators },
+	{ .compatible = "qcom,pmp8074-regulators", .data = &pmp8074_regulators },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_spmi_regulator_match);
-- 
2.36.1

