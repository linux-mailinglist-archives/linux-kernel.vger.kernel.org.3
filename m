Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8083B5863C7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 07:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239647AbiHAFju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 01:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239521AbiHAFjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 01:39:48 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59CA13F4F
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 22:39:47 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q7-20020a17090a7a8700b001f300db8677so10839067pjf.5
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 22:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bK3ffccH1fVKGdnPGCRAtkt42Wf60dNaubgu4zbH/QE=;
        b=R7wIijg6UqgC51QKzgYM+vqPLlnFy33kQHxrvJZU7amiOq6yloPBLuaPtJT1tVmwcn
         yExCIyAzE+9pXTJUo6b8OpD1Ar4DjUUb3rtuXDeyFGb2yYsF0NDOOkNr8KyYlgMW4pCQ
         /VoZ358V4DSRV994rLXiQ9UhF1GqDjWAWDRTNbfn49yiEiBUu7suN4p4jUHRiB4FfMm3
         a1qSxLaFONIOxA3bp5/RXzRqk+UtyZCKhF0hWpLO6M/170nas1R/zAL3nB58Grm386jM
         UyotNquauqgvrgC9iV6E3YGf+GP13oNxMibjQ+KdUUtTTpNtjBVoG0ozYAWMvKajiKpR
         kZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bK3ffccH1fVKGdnPGCRAtkt42Wf60dNaubgu4zbH/QE=;
        b=PVDBsm4UKU5Gyab2HSN9AAOT1FaWz0gYnadpbo7/JKruXUPEUsGD9dGJNMcDGx9DMv
         7nNZ1rWdWnw0LvuPbxxhhOMmG4/d+sATfX0aDbBs2mvuaWPKvyw9XWG+8GUjdCCVmKbS
         yY5CWfxQuIRCMzR32I4+JvKLCA00OLoTMHL3TXoDhM33EXMqIiVf6aT5YwP5Fxro60WB
         zKaJ7ZNNKbQpHEbStV9A+EJI3OcfJ8gpyQsM1wy4JYawX/N8sHyA2JR3/MsBjMJmd4MW
         UA+wpy+nz6sDKOE+esgjlOK5T/GrIHGW1qiV2AmJryZOm4U04S5O5XmD1wONw+dZLlSB
         SqUg==
X-Gm-Message-State: ACgBeo1EB6YpQ9UE39l+9KPM2qMk4AJ+ltUJOW4dvmsxxz3C/KWV0aCF
        o5Y/w3HOKtZmOae4yxBxT/0J
X-Google-Smtp-Source: AA6agR7a+aiwVQ+4lt8Lp6WgYBz9MoWFqsl8C1TQiqDHDjRJ+hMnI98pDF8OjGyFpmbPcPhbP0XU+g==
X-Received: by 2002:a17:902:f785:b0:16a:4f3b:a20c with SMTP id q5-20020a170902f78500b0016a4f3ba20cmr15435726pln.118.1659332387013;
        Sun, 31 Jul 2022 22:39:47 -0700 (PDT)
Received: from localhost.localdomain ([117.217.185.73])
        by smtp.gmail.com with ESMTPSA id s20-20020a63dc14000000b00411b3d2bcadsm6666994pgg.25.2022.07.31.22.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 22:39:46 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2] remoteproc: qcom_q6v5_pas: Do not fail if regulators are not found
Date:   Mon,  1 Aug 2022 11:09:39 +0530
Message-Id: <20220801053939.12556-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_regulator_get_optional() API will return -ENODEV if the regulator was
not found. For the optional supplies CX, PX we should not fail in that case
but rather continue. So let's catch that error and continue silently if
those regulators are not found.

The commit 3f52d118f992 ("remoteproc: qcom_q6v5_pas: Deal silently with
optional px and cx regulators") was supposed to do the same but it missed
the fact that devm_regulator_get_optional() API returns -ENODEV when the
regulator was not found.

Cc: Abel Vesa <abel.vesa@linaro.org>
Fixes: 3f52d118f992 ("remoteproc: qcom_q6v5_pas: Deal silently with optional px and cx regulators")
Reported-by: Steev Klimaszewski <steev@kali.org>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Steev Klimaszewski <steev@kali.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v2:

* Removed comment in error path
* Returned px error code directly
* Collected tags

 drivers/remoteproc/qcom_q6v5_pas.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 98f133f9bb60..6afd0941e552 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -362,13 +362,25 @@ static int adsp_init_clock(struct qcom_adsp *adsp)
 static int adsp_init_regulator(struct qcom_adsp *adsp)
 {
 	adsp->cx_supply = devm_regulator_get_optional(adsp->dev, "cx");
-	if (IS_ERR(adsp->cx_supply))
-		return PTR_ERR(adsp->cx_supply);
+	if (IS_ERR(adsp->cx_supply)) {
+		if (PTR_ERR(adsp->cx_supply) == -ENODEV)
+			adsp->cx_supply = NULL;
+		else
+			return PTR_ERR(adsp->cx_supply);
+	}
 
-	regulator_set_load(adsp->cx_supply, 100000);
+	if (adsp->cx_supply)
+		regulator_set_load(adsp->cx_supply, 100000);
 
 	adsp->px_supply = devm_regulator_get_optional(adsp->dev, "px");
-	return PTR_ERR_OR_ZERO(adsp->px_supply);
+	if (IS_ERR(adsp->px_supply)) {
+		if (PTR_ERR(adsp->px_supply) == -ENODEV)
+			adsp->px_supply = NULL;
+		else
+			return PTR_ERR(adsp->px_supply);
+	}
+
+	return 0;
 }
 
 static int adsp_pds_attach(struct device *dev, struct device **devs,
-- 
2.25.1

