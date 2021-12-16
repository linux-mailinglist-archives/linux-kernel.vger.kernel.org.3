Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F75A477F6C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242755AbhLPVnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 16:43:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57270 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242147AbhLPVlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:41:15 -0500
Date:   Thu, 16 Dec 2021 21:41:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639690872;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s2fgd+FTO2hchiMn8ovSu4ZUGbca9j3e+HJk7xx+uT8=;
        b=EXlv2+B08M7nBdnMi2cidai013LdzZi4gFvLaS5V5CBqO0bL8KnayH24gVTOy7rY2CF77k
        Z+UZIozF00iVPydZXxx2TBXZM6TdJdLYpgdYm0e8G+HkXObhGjQkA4xJWJA7TtRNGs+anc
        zjzGEYqWiRYLxh/DoRPS7MmHYLr2cS0RRKjnXYXVtfsPBf9o7CuTsFRC5g8ucUOrcvW/Bg
        R91CBAtgvcvnPg3n7w650a6MglyikCTGuGq1MHBX/UWnoYgTpbNYchimwa8D15CMhMewEX
        0qV2yMRxwmUoG5HSr8I0fXZn3ADvWGAtvGPN3AIuNyV6GKVT9pnCuyH9UYQmEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639690872;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s2fgd+FTO2hchiMn8ovSu4ZUGbca9j3e+HJk7xx+uT8=;
        b=EAA1AJ8CpxxIb4UBM42ynJFjffypa04w/x4keHRIdi2j9g7Iy7vGldDZsOGgKo39g2llpZ
        ZSkYoZKuad2+IfBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] powerpc/pseries/msi: Use PCI device properties
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211210221813.556202506@linutronix.de>
References: <20211210221813.556202506@linutronix.de>
MIME-Version: 1.0
Message-ID: <163969087174.23020.3972970702277481795.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     ed1533b5810141aceed2c2a3f13a17736f40e7fa
Gitweb:        https://git.kernel.org/tip/ed1533b5810141aceed2c2a3f13a17736f40e7fa
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 10 Dec 2021 23:18:52 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Dec 2021 22:16:38 +01:00

powerpc/pseries/msi: Use PCI device properties

instead of fiddling with MSI descriptors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20211210221813.556202506@linutronix.de

---
 arch/powerpc/platforms/pseries/msi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index 8e28720..dc8cf36 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -448,8 +448,7 @@ static int pseries_msi_ops_prepare(struct irq_domain *domain, struct device *dev
 				   int nvec, msi_alloc_info_t *arg)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	struct msi_desc *desc = first_pci_msi_entry(pdev);
-	int type = desc->pci.msi_attrib.is_msix ? PCI_CAP_ID_MSIX : PCI_CAP_ID_MSI;
+	int type = pdev->msix_enabled ? PCI_CAP_ID_MSIX : PCI_CAP_ID_MSI;
 
 	return rtas_prepare_msi_irqs(pdev, nvec, type, arg);
 }
