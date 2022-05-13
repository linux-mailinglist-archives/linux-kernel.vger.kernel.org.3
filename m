Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD99526084
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 13:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379695AbiEMLBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 07:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379691AbiEMLBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:01:13 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493EA2CE1E
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 04:01:09 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id s14so7595434plk.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 04:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rZc+ZqV9Fkq91rBB6JPn5eaAWDfpttSNOSYA1C21ZVY=;
        b=pPqBmjnZOoOPlVo0vS3Kq5A1Li96cT/0G84V1o8+RlSNVv7m0HEuPeYvCLSi1nkYoC
         gwTrsOZWLoI+dCHJyxAVf1jg/Hd4WNlFvDvYxmSNF6G6A6m1W3OpWNA5nH8SwZDn0ZGB
         WkTWI60LUZ6oZUKzdcUm0jJIUhayWiBdAR8zv2fsdYbsyNVpkbOowyf/peNBHj3ShshC
         hzONZ0Y92wEv13CmZ1vpoL2VdNLp7mf+h8rkZPXzOK2F5NY/bNIjJqQPbmUtg6RrFI+W
         ClCWj6S5Md5mPvHMMsA9g5485z2ewbeXK1NmqZCNpto4oV04yglFWSJVHnqziIA+yV0A
         spqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rZc+ZqV9Fkq91rBB6JPn5eaAWDfpttSNOSYA1C21ZVY=;
        b=Q9MaPaBySVVoP66llT0MWUvCN7q0Doic6xgQsh+NXzOqoK9wcYi5Riu15D6gadrFlU
         ec6bFVPHS7S0kFn8H2420lAViyIlA4SjNhBX69YDWa03E9CgC6RO6pJguO2RdlSNSf+N
         u68mEeMhMncLn/OBTRieUYBX6qbYa8a8f0w7MI7BVug5o3s9b68A7Jmc+xjCvevVyegf
         lB6r8TCkiQKA6e4cOLAmtfrl4mQRvis/V/XEVwDO3KYalepe9eaS7Sh8IJOt9y25jouH
         960/UB2TpfSTs2jh/0MfIZoJlN21y5qAJMp0+hKVVRMIX1cb3AoCgCRUWiUrONA596g3
         gSMQ==
X-Gm-Message-State: AOAM533Y6hjbwd/evhk0s8vcKLuB6oxxR9MX74cRMbdBaW0Z6MU8J4xY
        +60e+e1BVtSSbNKmtNVLIIQk
X-Google-Smtp-Source: ABdhPJwD0Z+7FM+VHC2wrC77McNhcou7ndf9igJr4nAQPy42aOvFNAEgKU/2wJsekaBdW4P9tQhvCQ==
X-Received: by 2002:a17:90b:1bc2:b0:1de:dac7:6124 with SMTP id oa2-20020a17090b1bc200b001dedac76124mr8423475pjb.162.1652439668454;
        Fri, 13 May 2022 04:01:08 -0700 (PDT)
Received: from localhost.localdomain ([117.202.184.202])
        by smtp.gmail.com with ESMTPSA id u36-20020a631424000000b003db0f2d135esm1322120pgl.49.2022.05.13.04.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 04:01:08 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bhelgaas@google.com, lorenzo.pieralisi@arm.com, kbusch@kernel.org,
        hch@lst.de
Cc:     linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        svarbanov@mm-sol.com, bjorn.andersson@linaro.org, axboe@fb.com,
        quic_vbadigan@quicinc.com, quic_krichai@quicinc.com,
        quic_nitirawa@quicinc.com, vidyas@nvidia.com, sagi@grimberg.me,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/3] nvme-pci: Make use of "suspend_poweroff" flag during system suspend
Date:   Fri, 13 May 2022 16:30:27 +0530
Message-Id: <20220513110027.31015-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513110027.31015-1-manivannan.sadhasivam@linaro.org>
References: <20220513110027.31015-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some platforms, the power to the PCI devices will be taken off during
system suspend. For these platforms, the PCI RC will set the
"system_poweroff" flag to notify the PCI device drivers of the poweroff
scenario.

Hence, make use of the flag in the system suspend path and if set, properly
shutdown the device.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d817ca17463e..381bf0c7cf8d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3238,6 +3238,7 @@ static int nvme_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct nvme_dev *ndev = pci_get_drvdata(pdev);
+	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
 	struct nvme_ctrl *ctrl = &ndev->ctrl;
 	int ret = -EBUSY;
 
@@ -3257,7 +3258,7 @@ static int nvme_suspend(struct device *dev)
 	 * state (which may not be possible if the link is up).
 	 */
 	if (pm_suspend_via_firmware() || !ctrl->npss ||
-	    !pcie_aspm_enabled(pdev) ||
+	    !pcie_aspm_enabled(pdev) || bridge->suspend_poweroff ||
 	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
 		return nvme_disable_prepare_reset(ndev, true);
 
-- 
2.25.1

