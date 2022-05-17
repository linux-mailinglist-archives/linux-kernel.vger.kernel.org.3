Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8DC52AD0F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 22:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353085AbiEQUyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 16:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353030AbiEQUxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 16:53:51 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817FA5251E;
        Tue, 17 May 2022 13:53:50 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ks9so21109ejb.2;
        Tue, 17 May 2022 13:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DzxGK66oNP5EqUefEbuvx65uQZvfKjOjhE65FjoDOMc=;
        b=jFx+eOUrtBX0It6ajfqu1uIzRH3UnVFO/1Mnopjj/nUuZIoyOC9d5tFcb7gmx9dws5
         Ctjx/imbEMf72FrjYAjplGZJvZ6p2tIK3+sZE+CxQ6/u2uWw+QvnWeybQYCvQzFw9+SE
         EVw4WrFfydipXPVJb2HOaGN+RI9CZ12Js2Y9kVWejXTlcwBWtXncJ27yCC7Nuwc6y1Cf
         cZb/foFxPVLGbYUNlkz9xrcTb67CXOw4MxGtRJbYiuJw8MWBzk5N3GwLI6wxT2xHhxrR
         TuMfDrgw3tjkaEvaGt/sFP4rsnJfzTBfRZoeS3eWyLErIyat/H4UxUqKp8WyMUqqwfV9
         MxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DzxGK66oNP5EqUefEbuvx65uQZvfKjOjhE65FjoDOMc=;
        b=tg9d/C0xMTaUgNMy6ypVMPNYVszkvnGmo+X1HwUBL///YN+VdRvxm2ylDPC0csv35d
         jiZiUiX5qMOuqu2rvUy+yR4IdRSWLs59KKtw6RyS15cZ2um4SHi0upKs8Gi7wEtkOpud
         iD8TjcW6rSz+bekRpnAAA5fU1ArgvHcSAo2Q1QrAMPI9jxEbgx/tIsjl5hba9aHqTSy0
         WV6+4LY6/K1QJsN9ihzU0+kyO9MA6T0bFAuzVJIXel7Pg+ovWapnGGhhyePcN+WBQv2t
         v3CHmttW8OirgnXPu1NjKRLS9kLiN8a5mfO8gYGPiWYrh0q6w9/3vvpqoZXVW/nAnsKI
         YERA==
X-Gm-Message-State: AOAM533aoQxPn8mzZfcEFFBbw4VREPB/bPn65IaFMzyZx+wT9/49o1dX
        /KaQHxvsuxcumFDK3GgR3Ig=
X-Google-Smtp-Source: ABdhPJzzAHznHiSVhGeGdTPNpnEvZ19PbgB4f+CXgV0iYW+IvTSMG4o35apslTEXyc93dsUMsVyXOQ==
X-Received: by 2002:a17:907:d0a:b0:6f4:98fb:f407 with SMTP id gn10-20020a1709070d0a00b006f498fbf407mr20983877ejc.219.1652820829124;
        Tue, 17 May 2022 13:53:49 -0700 (PDT)
Received: from fedora.robimarko.hr ([188.252.220.143])
        by smtp.googlemail.com with ESMTPSA id v22-20020a17090651d600b006f3ef214e10sm120907ejk.118.2022.05.17.13.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 13:53:48 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 4/6] regulator: qcom_spmi: Add support for PMP8074 regulators
Date:   Tue, 17 May 2022 22:53:39 +0200
Message-Id: <20220517205341.536587-4-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220517205341.536587-1-robimarko@gmail.com>
References: <20220517205341.536587-1-robimarko@gmail.com>
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

