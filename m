Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC7C50CAFD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 16:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbiDWOGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 10:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235944AbiDWOGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 10:06:01 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA4F30F79
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 07:03:00 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x80so10635254pfc.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 07:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LRqPM8Zvp3lwETnXLMwqMk3HESblR2v/mANOyDUtzYE=;
        b=ClZ7lL4jeueQ6LPS+MkvP4LYpFx6QKXAKMQ/nWGrH/BPWN1U7B+5Zy2+YToXH/+sXu
         xoXP6ICn0kxxG0/g6Em25EVWmqU5oBJthhv27LoLFBo6mwVdEkZSt0OlgwYsAldpIl+l
         vudxxk+nlPU7IgnzRM5FBqNHaw+C552c00wPPvINlzBf/613TlyMyo+1lZeP6o6Ovjie
         rQo9IqHLnUAoGLxWrkgJaUTuvzNbLvQFXYEdLChcELNDg/IyCsYOGeqm61AcBfba8vXJ
         9TloAtSNg2aa03NscUlzwlP9yviINQdp9AJe/Il7CIn6BcRLrCprBZxj2A0Z3zEtdIQk
         cwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LRqPM8Zvp3lwETnXLMwqMk3HESblR2v/mANOyDUtzYE=;
        b=qSKHx2bMQM2Z4lhigLtBs6UEzwyAs53akLsYXVfBE/sUxlu9Rx8mcIlRBWaI6RmXw5
         Cmfwmaq2/Zvov0rLL5ju118sIZwWmaJ8Gc1ownbbHJDu7H8wHS3RITmU1RzSAOVuGCm5
         YJ1//5J1Ux78onnC5kKh7ylyuF7bgsZbFNet1r8ZXJ9DKb5hVPW14J22eWnGHNF1GQJH
         UV6NUm6mM8mWUD+04onE45ZX/uaEO4TjwsVjBgmOg84Gctxcq0z93XERqsae8HS9v6G2
         /z+OwRACchWCQaMWmZK4rNViKKLmTe3hJhZCItczv0g0DoVIy+kiVjuWAETMJ4PvB207
         vTJQ==
X-Gm-Message-State: AOAM533BW5TB2ccioHE82RYxCgJXqXGoB11tKW8b0j5BLdhymuYLwbmG
        R5w5h14cath+X+DyTP1WhjhY
X-Google-Smtp-Source: ABdhPJxHEooxiAMgCN+mdGbrtkZj+De/PaSn1cJauQes/0iCd1DlY0VSWrBwC7oI3Qap/3/hakrEeQ==
X-Received: by 2002:a65:5286:0:b0:398:dad:c3d8 with SMTP id y6-20020a655286000000b003980dadc3d8mr8175325pgp.228.1650722580237;
        Sat, 23 Apr 2022 07:03:00 -0700 (PDT)
Received: from localhost.localdomain ([117.207.28.196])
        by smtp.gmail.com with ESMTPSA id y5-20020a17090a390500b001cd4989ff50sm9452728pjb.23.2022.04.23.07.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 07:02:59 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     avri.altman@wdc.com, alim.akhtar@samsung.com,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, ahalaney@redhat.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 1/5] scsi: ufs: qcom: Fix acquiring the optional reset control line
Date:   Sat, 23 Apr 2022 19:32:41 +0530
Message-Id: <20220423140245.394092-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220423140245.394092-1-manivannan.sadhasivam@linaro.org>
References: <20220423140245.394092-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Qcom UFS platforms, the reset control line seems to be optional
(for SoCs like MSM8996 and probably for others too). The current logic
tries to mimic the `devm_reset_control_get_optional()` API but it also
continues the probe if there is an error with the declared reset line in
DT/ACPI.

In an ideal case, if the reset line is not declared in DT/ACPI, the probe
should continue. But if there is problem in acquiring the declared reset
line (like EPROBE_DEFER) it should fail and return the appropriate error
code.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/scsi/ufs/ufs-qcom.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
index 0d2e950d0865..bee81b45299e 100644
--- a/drivers/scsi/ufs/ufs-qcom.c
+++ b/drivers/scsi/ufs/ufs-qcom.c
@@ -1002,13 +1002,13 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 	host->hba = hba;
 	ufshcd_set_variant(hba, host);
 
-	/* Setup the reset control of HCI */
-	host->core_reset = devm_reset_control_get(hba->dev, "rst");
+	/* Setup the optional reset control of HCI */
+	host->core_reset = devm_reset_control_get_optional(hba->dev, "rst");
 	if (IS_ERR(host->core_reset)) {
 		err = PTR_ERR(host->core_reset);
-		dev_warn(dev, "Failed to get reset control %d\n", err);
-		host->core_reset = NULL;
-		err = 0;
+		if (err != -EPROBE_DEFER)
+			dev_err_probe(dev, err, "Failed to get reset control\n");
+		goto out_variant_clear;
 	}
 
 	/* Fire up the reset controller. Failure here is non-fatal. */
-- 
2.25.1

