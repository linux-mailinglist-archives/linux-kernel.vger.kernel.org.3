Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17FF52BCCD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237664AbiERNTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 09:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237654AbiERNTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:19:43 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF56F1312AF
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:19:41 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id z7-20020a17090abd8700b001df78c7c209so5601898pjr.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 06:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o0m2cct6gQ1hTU8zWjrJlY1/CzYGMV6aIaj43pzMyHQ=;
        b=umKomzNTnxFS6bZsoFa6ppQZeJt+zfPQytLmumJLs/djqxC49M3mmhYlkyQQngnwyn
         f1UHtTKAviySFJOH931vQd8f+sqmaiLm8zbbFf1ZLLmttwg3ObFbmIqJ7HIMqJjFGz4f
         3rOvpAe0Ronm9jj6M3flcWOBpwZEADpP0FEqTM+Y0t6KPDDOOBOdv+j+ws6PZ90SqxIm
         DhxCFoOvjQgLF0ogB25DjAAQFJqKKnMGUpP8YOfNT5CTYvpH1Rf0StUfMOv68SLfNdEa
         i+1skS1vRbokch1jy3ZPMODZR39KIkDj2C8+cwijleR7EaNKoNQehKCijXPLBkgmKI1h
         vENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o0m2cct6gQ1hTU8zWjrJlY1/CzYGMV6aIaj43pzMyHQ=;
        b=pXKSJY1dGowGhIWaRKkHSDfxXClWDR3fvp8rm+MMmQ+92sTh8YQAK0lisfxwzE04NW
         tb4rSKDiN6vrXXMycXYoRgJSUzy5VO/4ejEpJOyM+Y1tca2GUWtn7YxPigcXxKy5U6Cz
         BlhjdiKdrIdjVTNfiLHUvmRGXqPRdSBCGtFSEYT49v5pBnSNxQCyREbaCcBpwn4Rwyom
         E0Hf6rMingtbAMA9JJJNv4MYdYQO5oipKlo0kXtTAHhDGkcKcuK0CTNMI2iNnZzcAC6C
         iAZCDoTFO+mE7cVjXwhePGbIVM9ZiH+xzDQmmF9/6Svq2S/VpOnv3vFV6pYH26nbzL2R
         iwMg==
X-Gm-Message-State: AOAM533XW7twR4n4ZIwYmTn9K3NcDL0iwWe9VVx5TQkgSCJ2AQr/kZ8X
        wXnhRot2bXc7SBApQNbWOYSg
X-Google-Smtp-Source: ABdhPJyHDXnFThSQ2XZkBGm0ehgt4AjaSs5P8n90+AxqDFvzx/b9+gdrukWw65K8iRuiJeeg7pXjng==
X-Received: by 2002:a17:902:cec9:b0:161:a107:d30a with SMTP id d9-20020a170902cec900b00161a107d30amr9115101plg.105.1652879981149;
        Wed, 18 May 2022 06:19:41 -0700 (PDT)
Received: from localhost.localdomain ([117.217.181.192])
        by smtp.gmail.com with ESMTPSA id b5-20020a170903228500b0015e8d4eb27esm1663908plh.200.2022.05.18.06.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 06:19:40 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bhelgaas@google.com, lorenzo.pieralisi@arm.com, kbusch@kernel.org,
        hch@lst.de
Cc:     linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        svarbanov@mm-sol.com, bjorn.andersson@linaro.org, axboe@fb.com,
        quic_vbadigan@quicinc.com, quic_krichai@quicinc.com,
        quic_nitirawa@quicinc.com, vidyas@nvidia.com, sagi@grimberg.me,
        linux-pm@vger.kernel.org, rafael@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 1/3] PCI: Add a flag to notify PCI drivers about powerdown during suspend
Date:   Wed, 18 May 2022 18:49:11 +0530
Message-Id: <20220518131913.26974-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220518131913.26974-1-manivannan.sadhasivam@linaro.org>
References: <20220518131913.26974-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some systems like Chromebooks based on Qcom SC7280, the PCIe RC
driver or a hardware entity like RPMh may powerdown all PCIe devices
during system suspend for aggressive powersaving. In that case, the
PCI host controller drivers need to notify the PCI device drivers that
the power will be taken off during system suspend so that the drivers
can prepare the devices accordingly.

One prime example is the PCI NVMe driver. This flag can be used by the
driver to shutdown the NVMe device during suspend and recover it during
resume.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v2:

* Changed the comment for the flag to mention the usecase.
* Reworded the commit message to convey how the poweroff happens

 include/linux/pci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 60adf42460ab..3e3a1c4f4559 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -578,6 +578,8 @@ struct pci_host_bridge {
 	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
 	unsigned int	size_windows:1;		/* Enable root bus sizing */
 	unsigned int	msi_domain:1;		/* Bridge wants MSI domain */
+	unsigned int	suspend_poweroff:1;	/* Some platforms like Qcom SC7280 may poweroff
+						   devices during system suspend for power saving */
 
 	/* Resource alignment requirements */
 	resource_size_t (*align_resource)(struct pci_dev *dev,
-- 
2.25.1

