Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BE550B85D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447940AbiDVNZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447929AbiDVNZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:25:13 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696D358392
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:22:19 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id h12so7149052plf.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UmOApO6ixe70PdHEViIKrF0MVsQtQSBHzDTAzdr8K48=;
        b=RDUmUjJOVCU9Gom6PIQB7Om6auvTkQ8MtrvaaFjuQWx+PPVuYsNATY7Sju+1neEH4U
         zuFcEHYhQSKPIvjiLdEmRY0wLcoJFpbvpSP+g1JkKek1hjbpsbmDGVm0gDdYMIRC3g1f
         1fCIld1KjTLpEtyAbXDrx6KjokXhKep17zeHKLgD27bUW1QjWt7vsEKykUWh9s7eTWdk
         FcTliAuQJ2Y+lX72APhDhiGKToK1D+rn0M8ipUbEhli2dcC8O5j1jKru2wIJD6GjF50D
         FyYVhTr+q88S6lNC2I0JyJqZb9LoQ+lsepMfJLddTgYSfS6WbrwyaputeM38AcVtYI7l
         5z+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UmOApO6ixe70PdHEViIKrF0MVsQtQSBHzDTAzdr8K48=;
        b=bZr5ArA+gicHjFqUBWgF7+NAdx+57ODWYQYypbI/Y9ao/ccj7DRIhJfGr8g5G2aljF
         1kQpGd1EOsiCm7pdx/FSFw4YgWii5GI9MWwTHS3TpKsLWS/BYByqKCYpm0oDjofRikzV
         TYPYsL4dX+Ptu51nZBfnqOFHjFgKiOdPHf5oHefx8fMNlGMyKfzyDB4nFZKPNUBNkg/9
         5vwopq83jxL2i+XYOzqZ53HAkd3Xix1pcZC0fRijXnj/g/pCUbpqC7vglRaTgsdgsIp0
         x0XUtQG0mgmFM1KCifHYVn4zcvUkW/6vvrsY6sDV7Z61HLrIQoEP6CpGV9hzFxeBXsEb
         hs7w==
X-Gm-Message-State: AOAM533MfG1fLAKqOU5ZsPLP7EdPrpxDXJWBpfYC+Otn8eMGwFHUuPfX
        NVZAMVk7WOF3O6M9fb1vYZ55eYob8Jo9
X-Google-Smtp-Source: ABdhPJyjSvRzPdzCjO9rxGq3kz927rM2kTVx3GjigPQ8cqLCXqTCHKS1iZuURIg4z6JcfYUsv5Hjuw==
X-Received: by 2002:a17:90b:3b4b:b0:1d2:e3fe:e1a0 with SMTP id ot11-20020a17090b3b4b00b001d2e3fee1a0mr5427666pjb.78.1650633738937;
        Fri, 22 Apr 2022 06:22:18 -0700 (PDT)
Received: from localhost.localdomain ([117.207.28.196])
        by smtp.gmail.com with ESMTPSA id g13-20020a62520d000000b0050a923a7754sm2586840pfb.119.2022.04.22.06.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 06:22:18 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     avri.altman@wdc.com, alim.akhtar@samsung.com,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 4/5] scsi: ufs: core: Remove redundant wmb() in ufshcd_send_command()
Date:   Fri, 22 Apr 2022 18:51:39 +0530
Message-Id: <20220422132140.313390-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220422132140.313390-1-manivannan.sadhasivam@linaro.org>
References: <20220422132140.313390-1-manivannan.sadhasivam@linaro.org>
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

The wmb() inside ufshcd_send_command() is added to make sure that the
doorbell is committed immediately. This leads to couple of expectations:

1. The doorbell write should complete before the function return.
2. The doorbell write should not cross the function boundary.

2nd expectation is fullfilled by the Linux memory model as there is a
guarantee that the critical section won't cross the unlock (release)
operation.

1st expectation is not really needed here as there is no following read/
write that depends on the doorbell to be complete implicitly. Even if the
doorbell write is in a CPUs Write Buffer (WB), wmb() won't flush it. And
there is no real need of a WB flush here as well.

So let's get rid of the wmb() that seems redundant.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/scsi/ufs/ufshcd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 9349557b8a01..ec514a6c5393 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -2116,9 +2116,6 @@ void ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
 	__set_bit(task_tag, &hba->outstanding_reqs);
 	ufshcd_writel(hba, 1 << task_tag, REG_UTP_TRANSFER_REQ_DOOR_BELL);
 	spin_unlock_irqrestore(&hba->outstanding_lock, flags);
-
-	/* Make sure that doorbell is committed immediately */
-	wmb();
 }
 
 /**
-- 
2.25.1

