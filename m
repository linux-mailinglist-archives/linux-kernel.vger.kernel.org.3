Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B282D47CAB2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 02:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240691AbhLVBVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 20:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238386AbhLVBVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 20:21:16 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33970C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 17:21:16 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w9-20020a25c709000000b00608a9489fc1so1145432ybe.20
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 17:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DwpZcxuVvjMBelijxmj7V7prl1AvJJJLN05hWBHgA/4=;
        b=Yj23OWiqKBvrbnd/TZd2sZhlzi3hGVLhMyJ7iprLLOt4brrPpG+thhJdevr1M/0ZG2
         zIdXVnMYyq1eRVOq7e/tyLe35Yu8aGzLBOQgtR+zO+PJecaTcV4HiJO1qLBQF1IP7cYF
         N1eRv4SlqbX9vehtnG0YioYyS1ZDAG2jxbmTgNuefmy4D5TmUIaEQRWfTyaCbYbjG8JL
         YXfXzB4tw+RXuA9SqgEdr4EXsqBSf9IuN/M9+R0ynUPJVod0gtMcmDG3qFalCYGKc6La
         q/DS9oMZuSPd7y6RopEwLDCfNvwJPJAnDfDUx/9p+SHUsuJKB/PHdF07hnlgv56eEA1f
         GL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DwpZcxuVvjMBelijxmj7V7prl1AvJJJLN05hWBHgA/4=;
        b=D3zWHL3IkLhlBnGm3IOxuYIeDFQedlKGYrHa/JklHap7KGez/kmWaCuPW7VDmsys+G
         CckK+sIOeulCfLt/0EJQRvQLFsClLXEQPO/c/Ff7zAdlep1ohcU2pAAMUEu73ILr2UjD
         OarQuRCH1shssCoh2Dmik0yxOJROOLXqCj+chfBHTDVrrFJc92ncUdgIKtS504ulWwBl
         UtOLdjWwdMzADJv8XYft/yJz8KTFKgyOJcnRYMBxp+/Ci3T99K8ejLauXtWpDr1HKK+0
         jPRc8SWS6ecld8a5c6vF5vG3gSkcj3ZcOsySJmVLF2fX+CsVWkPNKi8MDqmSXsSWbMI/
         dZeA==
X-Gm-Message-State: AOAM530LKSLPS+lIdhXKLIjg10gedC2xQh3y6pZfOT19isl/oeBupwsj
        ZYbId1Qb3A2VJotf09Hav2IYfILf7Gll
X-Google-Smtp-Source: ABdhPJzCGyz0Ud16ne2hFP17GWS2MfOEfgjKuE2i65+M21EG8Ii4sjCKsWomCl7zypcm8PsHT4lJVr7O4KaH
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:8d27:feea:1b0b:3782])
 (user=rajatja job=sendgmr) by 2002:a25:ba05:: with SMTP id
 t5mr1349092ybg.675.1640136075440; Tue, 21 Dec 2021 17:21:15 -0800 (PST)
Date:   Tue, 21 Dec 2021 17:21:05 -0800
Message-Id: <20211222012105.3438916-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH] pci: Make DWORD accesses while saving / restoring LTR state
From:   Rajat Jain <rajatja@google.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, kw@linux.com,
        Rajat Jain <rajatja@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices have an errata such that they only support DWORD accesses
to some registers.

For e.g. this Bayhub O2 device ([VID:DID] = [0x1217:0x8621]) only
supports DWORD accesses to LTR latency registers and L1 PM substates
control registers:
https://github.com/rajatxjain/public_shared/blob/main/OZ711LV2_appnote.pdf

Since L1 PM substate control registers are DWORD sized, and hence their
access in the kernel is already DWORD sized, so we don't need to do
anything for them.

However, the LTR registers being WORD sized, are in need of a solution.
This patch converts the WORD sized accesses to these registers, into
DWORD sized accesses, while saving and restoring them.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/pci/pci.c       | 24 ++++++++++++++++--------
 drivers/pci/pcie/aspm.c |  1 +
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 3d2fb394986a..efa8cd16827f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1556,7 +1556,7 @@ static void pci_save_ltr_state(struct pci_dev *dev)
 {
 	int ltr;
 	struct pci_cap_saved_state *save_state;
-	u16 *cap;
+	u32 *cap;
 
 	if (!pci_is_pcie(dev))
 		return;
@@ -1571,25 +1571,33 @@ static void pci_save_ltr_state(struct pci_dev *dev)
 		return;
 	}
 
-	cap = (u16 *)&save_state->cap.data[0];
-	pci_read_config_word(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, cap++);
-	pci_read_config_word(dev, ltr + PCI_LTR_MAX_NOSNOOP_LAT, cap++);
+	/*
+	 * We deliberately do a dword access to save both PCI_LTR_MAX_SNOOP_LAT
+	 * and PCI_LTR_MAX_NOSNOOP_LAT together since some devices only support
+	 * dword accesses to these registers.
+	 */
+	cap = &save_state->cap.data[0];
+	pci_read_config_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, cap);
 }
 
 static void pci_restore_ltr_state(struct pci_dev *dev)
 {
 	struct pci_cap_saved_state *save_state;
 	int ltr;
-	u16 *cap;
+	u32 *cap;
 
 	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
 	ltr = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
 	if (!save_state || !ltr)
 		return;
 
-	cap = (u16 *)&save_state->cap.data[0];
-	pci_write_config_word(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, *cap++);
-	pci_write_config_word(dev, ltr + PCI_LTR_MAX_NOSNOOP_LAT, *cap++);
+	/*
+	 * We deliberately do a dword access to restore both
+	 * PCI_LTR_MAX_SNOOP_LAT and PCI_LTR_MAX_NOSNOOP_LAT together since
+	 * some devices only support dword accesses to these registers.
+	 */
+	cap = &save_state->cap.data[0];
+	pci_write_config_dword(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, *cap);
 }
 
 /**
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 52c74682601a..083f47a7b69b 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -496,6 +496,7 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 	encode_l12_threshold(l1_2_threshold, &scale, &value);
 	ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
 
+	/* Always make DWORD sized accesses to these registers */
 	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1, &pctl1);
 	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2, &pctl2);
 	pci_read_config_dword(child, child->l1ss + PCI_L1SS_CTL1, &cctl1);
-- 
2.34.1.307.g9b7440fafd-goog

