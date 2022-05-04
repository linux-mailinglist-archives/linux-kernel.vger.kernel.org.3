Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2811F519A25
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346537AbiEDIqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346507AbiEDIqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:46:01 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA46B24960
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 01:42:25 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id qe3-20020a17090b4f8300b001dc24e4da73so3269275pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 01:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jvFCRlCjBMgPf5hAFpHc9zQbLQ5BVzGLk4EI13vVODg=;
        b=v5tFf9EmJW+BrMhN/JlKVvAfBKyWpOSBIbSY9r9fkCwwlm2R5gwNOT5uiDPmDfVuxw
         9wstU7IGub4N0PtC5aCVVVY74FotQ8nLobC3j4IRLF4qkkHx9aUiI2awBMETGsmYKHID
         7uv/LJn0rbpAzMsZBTruyZ7IW+SzPoy4YaBpvKEaV9TshS8VP8A2Lvilf0tsGwgp1upH
         fqFH0iHZh0bWzeB/Kpw3teXCZVhGrzH9b4yMriL7wbkh7+erpasN8QPEBMPsUDVKwglw
         m1l55qepuB+sPRmUPr5/01eRkobWdbnhV6tQ8wpoTm0SvWq/2VqWoaUxuAdSCTGGzX18
         3Grg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jvFCRlCjBMgPf5hAFpHc9zQbLQ5BVzGLk4EI13vVODg=;
        b=ODzZ9jVuKW4FWJFZaAiQVwbazGUUyrRDTHmROhAalmA4RHImB06zwfcZB0xLKPXKjn
         MHhIC/EGHSEZUG8Nsmovhg9bIF651SmDbss43FzYgMlalY6rX5rkzaRhioVHDHkit7TO
         ypgF6rN9E0Sv5AvZ1ESEFwu+hdzRT1zLCMUp2iS5UvUVfQsVnVYPCPSbqjSbdpWqzzc9
         GtuM2kLUOP23lliCQIJshFDdDOKFI01cuddM2PCvvfoVeZVx3mDxrn0PtuFwK8eiCcm7
         3HtyRsuoC9F8ax7kb8r2IeZuiOL707TeMLuG+mhsqhhImmGmAuAFxl+uMqQwVs7j1awd
         tCEQ==
X-Gm-Message-State: AOAM530Ghlaq13RpX3QXIILM3LS8ALP88dSQZWevMK+PmcWe4mIAnYRM
        /LDQDr6ouu3Z7T3AkFT02bSG
X-Google-Smtp-Source: ABdhPJwzte6tnj3o4ehJEi8t+m4u0RNbwDA5S+HTA91nT4VQQl9sjL7VYTPkdMV+BHeugSqr8mvsJA==
X-Received: by 2002:a17:902:a613:b0:156:b53d:c137 with SMTP id u19-20020a170902a61300b00156b53dc137mr20444445plq.73.1651653745422;
        Wed, 04 May 2022 01:42:25 -0700 (PDT)
Received: from localhost.localdomain ([27.111.75.248])
        by smtp.gmail.com with ESMTPSA id i10-20020a170902c94a00b0015e8d4eb278sm1386561pla.194.2022.05.04.01.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 01:42:25 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     avri.altman@wdc.com, alim.akhtar@samsung.com,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, ahalaney@redhat.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 1/5] scsi: ufs: qcom: Fix acquiring the optional reset control line
Date:   Wed,  4 May 2022 14:12:08 +0530
Message-Id: <20220504084212.11605-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220504084212.11605-1-manivannan.sadhasivam@linaro.org>
References: <20220504084212.11605-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/scsi/ufs/ufs-qcom.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
index 0d2e950d0865..9e69b9ac58f9 100644
--- a/drivers/scsi/ufs/ufs-qcom.c
+++ b/drivers/scsi/ufs/ufs-qcom.c
@@ -1002,13 +1002,12 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 	host->hba = hba;
 	ufshcd_set_variant(hba, host);
 
-	/* Setup the reset control of HCI */
-	host->core_reset = devm_reset_control_get(hba->dev, "rst");
+	/* Setup the optional reset control of HCI */
+	host->core_reset = devm_reset_control_get_optional(hba->dev, "rst");
 	if (IS_ERR(host->core_reset)) {
-		err = PTR_ERR(host->core_reset);
-		dev_warn(dev, "Failed to get reset control %d\n", err);
-		host->core_reset = NULL;
-		err = 0;
+		err = dev_err_probe(dev, PTR_ERR(host->core_reset),
+				    "Failed to get reset control\n");
+		goto out_variant_clear;
 	}
 
 	/* Fire up the reset controller. Failure here is non-fatal. */
-- 
2.25.1

