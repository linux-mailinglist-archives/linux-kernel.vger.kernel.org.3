Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E8747402F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 11:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbhLNKNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 05:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbhLNKNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 05:13:36 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D81CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 02:13:36 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id l18so12255232pgj.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 02:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2rug4EuC9Ad8IFEiNCmMA6aYrYVML8F4r4iVetDTwr0=;
        b=mwUnYoVqZeRIOlk3PSDwFfqhSLX+8xyxryjI6XRaL0TW8dzaheEvY6tw9NYijXSK53
         bQRc9WqmUyRYE01lzA8RwVVwxfDhpHVeWFlT0UG2kEzMgxxFv1CvdN1OZ4tiz/YEML9l
         Abd9VfhQkm46A2wnXsyf+HlGNK9+j416yRIbNeniVmIbitHlRqVF/cObYjvqywKKZKJq
         jilG0TK5mofdbqF4US4Ka5bKSfnX/9U3J6l5MV/uYEM7aKTisIbVOfOoi79+OBqwgTq2
         HAkTAEqe+I5+XfjqNc4AxpYzYDg1Lz3JL9YrTrEsJMKTB+Xwph7IA5kwImdd2oIwCp7L
         0fPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2rug4EuC9Ad8IFEiNCmMA6aYrYVML8F4r4iVetDTwr0=;
        b=e+hZWNXbzpf0ww8/vj2oqgw/myAlA4Cj1SJzrt/srgTqw+HJFObPdeCV1uckJ66axw
         mOPHlnOjYpgXXswoVI3RSoO82qd7MMaRQIXWbSOagKdeieTNczgFTCYvwxB9kWEXETrK
         u4VBkMZvV+QmBvb/VesaL6/+keYowh2RUkNVM1mZmKd6zNFbfL64hsIgO2O7D7yquou0
         t8ZpUwyzJOeEz1osZrh+I1ZWch1hepcxhjPicHtk9jbSPm7O6UkkSCciFLMUhiHA/qcm
         Va+iZXPenkh1qkVhHsZ9ZRwQQKrEMJXJb8iMJ4Sd+r4ya4c6RdzQAim405rLkouzjjkE
         wBjw==
X-Gm-Message-State: AOAM532pDDrn8mBYF5HYvlVevaqH/V0gw7udCpGPiwQTaFc7rJZEUT71
        nVY7MDomuWdtwpt7brxhfjEj
X-Google-Smtp-Source: ABdhPJxDKkg6hQUK1gsiN0fln+nUoRMFYCqFfoMwgPUn4A3o6KYCEMUlQqhnVT0bpXwTtmU4JUO7CA==
X-Received: by 2002:a63:754c:: with SMTP id f12mr3173578pgn.161.1639476815884;
        Tue, 14 Dec 2021 02:13:35 -0800 (PST)
Received: from localhost.localdomain ([117.193.214.199])
        by smtp.gmail.com with ESMTPSA id s3sm1922229pjk.41.2021.12.14.02.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 02:13:35 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lorenzo.pieralisi@arm.com, bhelgaas@google.com
Cc:     svarbanov@mm-sol.com, bjorn.andersson@linaro.org, robh@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] PCI: qcom: Add support for handling MSIs from 8 endpoints
Date:   Tue, 14 Dec 2021 15:43:19 +0530
Message-Id: <20211214101319.25258-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DWC controller used in the Qcom Platforms are capable of addressing the
MSIs generated from 8 different endpoints each with 32 vectors (256 in
total). Currently the driver is using the default value of addressing the
MSIs from 1 endpoint only. Extend it by passing the MAX_MSI_IRQS to the
num_vectors field of pcie_port structure.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 1c3d1116bb60..8a4c08d815a5 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1550,6 +1550,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
 	pp = &pci->pp;
+	pp->num_vectors = MAX_MSI_IRQS;
 
 	pcie->pci = pci;
 
-- 
2.25.1

