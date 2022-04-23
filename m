Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18ED50CB0B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 16:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbiDWOHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 10:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236031AbiDWOGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 10:06:23 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A752D49CA7
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 07:03:26 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id g3so9001919pgg.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 07:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TXe/ovrkI7fs6LC2tjCTZfX1Ul0aLn/Ph3vkYUG1yIE=;
        b=pBYpKeLNNz9UJKbPyLegaam6xQE0qXPpLHBre8/awiGathRi0z7faz4NVjoDa88GX+
         o02St+7prs+AP7oohfNK0PWdwti16F+iyMiZqUg6LShe2EcXT+ss0YZK55HR7V/or8CV
         aLP4EfeztGm6iejKsAXpI5tNxSHTcrwcUX1Rk76FxvWGfZOAl3MNOwnJyLOt9vN8zhdx
         FDLsIxu7PuMfP1oOTSbZpqfwmdIS890IIVbidxv534hHZ38pHDwaEzEHZbwa2otdqsqu
         +3LlU9w9A22X1tP4wfGxZ3JqWeDF1neAJMwk381UniffqcRH1XVp9jp45g/byTmdOzHI
         j4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TXe/ovrkI7fs6LC2tjCTZfX1Ul0aLn/Ph3vkYUG1yIE=;
        b=x011V4WaQgv/DWsdemVmAhlAGkbErY4eY9O1wsmn9sLCmYj31ebxW5NvyOEN96KOuJ
         eZNPjBuOBjBJrYAA+RLjydk6PXr6xRllFf0WY/KojtXdnbh4SdiVPzig6GCeZyRDVJdG
         jiKAgoGDK5RoqmdekmHdoE76/Eiew/lSCC5ZrUFBgtgGop0LUCSjK6irABBy3jYJKNmP
         j8tzleIaS7TIuPyo+aFmScksWUMKPoK9xOvY/m9ppfTfddBnIz4jgPsxPeGqVgVsXgkL
         OEGgE/vEWdlNMheLp29PhMOuMKskPqyvEWpZdL1NBpAFQw+oOM62r1o8xMVHXH+W+g22
         0lPA==
X-Gm-Message-State: AOAM533VnQ43Xes3Z7oVNH8Vqc6wFbD6OC10/bN+xLQEX0O6ShZvPLT8
        lxLKev3r4DFy7wBhbROxb9Iq
X-Google-Smtp-Source: ABdhPJxJAOAG8NmzNVkTpYxQYuZXHx7JPnHKupSJCc/0tGqV0o7D496eAD72QeyTJ91weR0/vtnBJQ==
X-Received: by 2002:a05:6a00:8c8:b0:4fe:ecb:9b8f with SMTP id s8-20020a056a0008c800b004fe0ecb9b8fmr10157304pfu.55.1650722606131;
        Sat, 23 Apr 2022 07:03:26 -0700 (PDT)
Received: from localhost.localdomain ([117.207.28.196])
        by smtp.gmail.com with ESMTPSA id y5-20020a17090a390500b001cd4989ff50sm9452728pjb.23.2022.04.23.07.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 07:03:25 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     avri.altman@wdc.com, alim.akhtar@samsung.com,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bvanassche@acm.org, ahalaney@redhat.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 5/5] scsi: ufs: qcom: Enable RPM_AUTOSUSPEND for runtime PM
Date:   Sat, 23 Apr 2022 19:32:45 +0530
Message-Id: <20220423140245.394092-6-manivannan.sadhasivam@linaro.org>
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

In order to allow the block devices to enter autosuspend mode during
runtime, thereby allowing the ufshcd host driver to also runtime suspend,
let's make use of the RPM_AUTOSUSPEND flag.

Without this flag, userspace needs to enable the autosuspend feature of
the block devices through sysfs.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/scsi/ufs/ufs-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
index f47a16b7cff5..34c5970db445 100644
--- a/drivers/scsi/ufs/ufs-qcom.c
+++ b/drivers/scsi/ufs/ufs-qcom.c
@@ -876,6 +876,7 @@ static void ufs_qcom_set_caps(struct ufs_hba *hba)
 	hba->caps |= UFSHCD_CAP_WB_EN;
 	hba->caps |= UFSHCD_CAP_CRYPTO;
 	hba->caps |= UFSHCD_CAP_AGGR_POWER_COLLAPSE;
+	hba->caps |= UFSHCD_CAP_RPM_AUTOSUSPEND;
 
 	if (host->hw_ver.major >= 0x2) {
 		host->caps = UFS_QCOM_CAP_QUNIPRO |
-- 
2.25.1

