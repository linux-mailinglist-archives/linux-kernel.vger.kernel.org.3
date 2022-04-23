Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995DD50CAFF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 16:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbiDWOGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 10:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235949AbiDWOGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 10:06:04 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C40328E33
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 07:03:06 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id i63so9601819pge.11
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 07:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8wBJCcWeFRMZgdm9ZKGwA3V3aMKA6XrUHTMKmudVjaQ=;
        b=ZJfQeIg28PhIgYlSvbZ9Wh48Py5c7K6IDYwI2WzajByD7Uz1O6PxxNUblpP0UXpmEg
         CYAWJKjCF/coSnzbzhtODVkDja/ixl+6aVLVt7DPDEFPDV6rVrMUc+ZC9u/V8bMHfPVp
         /lgr9FWaNq5d6qZtjxQ/QcNjSlSlfVYs3ZH4yARbUbp/wuMBt1syWhYdpVC72Uvo9s/M
         wvCl8CD+YHwBiYGmkI854qguElCKgBCqO077yw1cuMrFJNd/eH9EIUpa+vZ7gcT31wmu
         h61slUgFjg/i/o41YD6MFsqT5m4UJ0ziRhOXpi4/0vJdNb08zJFRLRnbude1+YKJy7cl
         ScRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8wBJCcWeFRMZgdm9ZKGwA3V3aMKA6XrUHTMKmudVjaQ=;
        b=t/HKUOuwxScgZKWSWped9gpi6U9Eq5qFwU8T8QHgRhjuwqZaYhEcdE6BqNsmvD5pne
         N812io1Un6UMgLiuelxPAwXLj/Zp1x0LVwzNteGhFV9EfzUrtQP2qEgXyiG4QiRHweNE
         Tv1Lug4TTLSXEi/1kt4VHSQBym/wyjSkQbJwTWINamZ94T+U0JSpVO0o7ZCjObVYSnHC
         cOdX93GrgBKht8Pgfz+aObfzc9DIjLJ/l5tuDU8eup1Eku5FpzKvxr9pjjVGd/7sqqzM
         r0C1mPbatr1dWjBa9dChY8OFOzhjMwKq2ww4YPMgL7u8r84/UMNJXn0FP6iHiDZ0Jtfm
         5OfQ==
X-Gm-Message-State: AOAM530xlVUrSBdXgb7WmIuGE0RQV5BL4ddD2N4inrFrBsXeYp7e7zfV
        oz0YWAd841sYGsxIzFrskZh+
X-Google-Smtp-Source: ABdhPJxpMPOLUAH7WkMWYCk6BEczhu9JqcL+DWFp1uauOsI8ItzDzj+K+J6a/kKaNkmcyxzu6Gq6fg==
X-Received: by 2002:a63:4402:0:b0:39d:a27b:e594 with SMTP id r2-20020a634402000000b0039da27be594mr8051819pga.98.1650722585865;
        Sat, 23 Apr 2022 07:03:05 -0700 (PDT)
Received: from localhost.localdomain ([117.207.28.196])
        by smtp.gmail.com with ESMTPSA id y5-20020a17090a390500b001cd4989ff50sm9452728pjb.23.2022.04.23.07.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 07:03:05 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     avri.altman@wdc.com, alim.akhtar@samsung.com,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, ahalaney@redhat.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 2/5] scsi: ufs: qcom: Simplify handling of devm_phy_get()
Date:   Sat, 23 Apr 2022 19:32:42 +0530
Message-Id: <20220423140245.394092-3-manivannan.sadhasivam@linaro.org>
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

There is no need to call devm_phy_get() if ACPI is used, so skip it.
The "host->generic_phy" pointer should already be NULL due to the kzalloc,
so no need to set it NULL again.

Also, don't print the error message in case of -EPROBE_DEFER and return
the error code directly.

While at it, also remove the comment that has no relationship with
devm_phy_get().

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/scsi/ufs/ufs-qcom.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
index bee81b45299e..6ee33cc0ad09 100644
--- a/drivers/scsi/ufs/ufs-qcom.c
+++ b/drivers/scsi/ufs/ufs-qcom.c
@@ -1022,28 +1022,12 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 		err = 0;
 	}
 
-	/*
-	 * voting/devoting device ref_clk source is time consuming hence
-	 * skip devoting it during aggressive clock gating. This clock
-	 * will still be gated off during runtime suspend.
-	 */
-	host->generic_phy = devm_phy_get(dev, "ufsphy");
-
-	if (host->generic_phy == ERR_PTR(-EPROBE_DEFER)) {
-		/*
-		 * UFS driver might be probed before the phy driver does.
-		 * In that case we would like to return EPROBE_DEFER code.
-		 */
-		err = -EPROBE_DEFER;
-		dev_warn(dev, "%s: required phy device. hasn't probed yet. err = %d\n",
-			__func__, err);
-		goto out_variant_clear;
-	} else if (IS_ERR(host->generic_phy)) {
-		if (has_acpi_companion(dev)) {
-			host->generic_phy = NULL;
-		} else {
+	if (!has_acpi_companion(dev)) {
+		host->generic_phy = devm_phy_get(dev, "ufsphy");
+		if (IS_ERR(host->generic_phy)) {
 			err = PTR_ERR(host->generic_phy);
-			dev_err(dev, "%s: PHY get failed %d\n", __func__, err);
+			if (err != -EPROBE_DEFER)
+				dev_err_probe(dev, err, "Failed to get PHY\n");
 			goto out_variant_clear;
 		}
 	}
-- 
2.25.1

