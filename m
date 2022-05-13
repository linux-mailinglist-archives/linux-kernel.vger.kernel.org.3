Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC7F52607E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 13:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379679AbiEMLBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 07:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379660AbiEMLA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:00:57 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D38C1C91F
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 04:00:55 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c11so7566986plg.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 04:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uGswQ0aP97Suern/pqvhLGTEOIpF5J5h2MoXW5LuuBU=;
        b=ZF7r2l+HwxQm5PA8mve2cF+rBwKjnM+0fSfGGdoNA3T0LJdycXkCGWLrykpa8sL/oD
         08lIP8dZt0wAe2tK+75oTRz1risNDIOCOSiRaW+GZokpCuhe+9MrL2YynteMMnYHDR3H
         ItIDcdINQ82V0AG+st+raJapxxBHOih2yAPagaFk64puhsJ/iztuWI2Rf4eKJ19ZFuSX
         YL/pLIatMsl2o8QBgjy0eNGResBVvt2NP3Y80kDYZiv7AA+gsRPYm0wGgSd7CPa4mYRN
         F4q7pPFCxNNeVHCsbD+3J+hjPwmsRQyClY9uud0L4zXlaFzZ+hz0uXVv3kgKtKaDXw60
         Pa+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uGswQ0aP97Suern/pqvhLGTEOIpF5J5h2MoXW5LuuBU=;
        b=a2Jj7r5JP+SJVfibAd6VN2gZmMlw0Vuj1LH1KeYOOQC/eT/7cwjH04g3udrrqXCeOP
         bM3QXBLl4w7URMdcwlADGymxhnrolsXTIOVDzPkxTsIuHrj4tbcLC4opGnXrULm1fDST
         sbOpJrahp/u0xuTxLqt5MvuahklCcuyxYJ9Cn456M9OW/cmqi2wAKaM3praU4FOhUpGA
         7+aJd9q/mF5myxdHWswjPPdv2pz8/CW//nwY47W8TZZpSfYxC98t3nX8feDIk0qDmsSD
         iBq2GWjr0p4gbIJBHn1PVCmZ7dSfJgOKc2j1/0knWwF5uoUqCtN5izjady8EwD8KPUL2
         I8SQ==
X-Gm-Message-State: AOAM530dCwA653JWkvHHYJ5Cc+8ZsmPpXEmbEaESXKR4ZP1pwWNBxunK
        /HJ3g3knpaRFN+DyCB3vjFgh
X-Google-Smtp-Source: ABdhPJyTPQtQvf4t/ey8cvG54O7pCIiYbK85D35VbK5tYExzPBijKVc7qymid6BgehggfTgPgOcVnw==
X-Received: by 2002:a17:902:7586:b0:15e:c2fe:bad0 with SMTP id j6-20020a170902758600b0015ec2febad0mr3948667pll.72.1652439654573;
        Fri, 13 May 2022 04:00:54 -0700 (PDT)
Received: from localhost.localdomain ([117.202.184.202])
        by smtp.gmail.com with ESMTPSA id u36-20020a631424000000b003db0f2d135esm1322120pgl.49.2022.05.13.04.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 04:00:54 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bhelgaas@google.com, lorenzo.pieralisi@arm.com, kbusch@kernel.org,
        hch@lst.de
Cc:     linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        svarbanov@mm-sol.com, bjorn.andersson@linaro.org, axboe@fb.com,
        quic_vbadigan@quicinc.com, quic_krichai@quicinc.com,
        quic_nitirawa@quicinc.com, vidyas@nvidia.com, sagi@grimberg.me,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/3] PCI: Add a flag to notify PCI drivers about powerdown during suspend
Date:   Fri, 13 May 2022 16:30:25 +0530
Message-Id: <20220513110027.31015-2-manivannan.sadhasivam@linaro.org>
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

On some systems like Chromebooks based on Qcom chipsets, the OS may
powerdown all PCIe devices during system suspend for aggressive
powersaving. In that case, the PCI host controller drivers need to notify
the PCI device drivers that the power will be taken off during system
suspend so that the drivers can prepare the devices accordingly.

One prime example is the PCI NVMe driver. This flag can be used by the
driver to shutdown the NVMe device during suspend and recover it during
resume.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 include/linux/pci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 60adf42460ab..069caf1fe88d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -578,6 +578,7 @@ struct pci_host_bridge {
 	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
 	unsigned int	size_windows:1;		/* Enable root bus sizing */
 	unsigned int	msi_domain:1;		/* Bridge wants MSI domain */
+	unsigned int	suspend_poweroff:1;	/* OS may poweroff devices during system suspend */
 
 	/* Resource alignment requirements */
 	resource_size_t (*align_resource)(struct pci_dev *dev,
-- 
2.25.1

