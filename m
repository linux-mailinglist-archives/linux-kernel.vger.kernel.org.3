Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F47446ECBC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241157AbhLIQL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:11:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40208 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240944AbhLIQKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:10:47 -0500
Date:   Thu, 09 Dec 2021 16:07:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639066033;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YwJMbIA0J4qqNnbHfw/h0m5MVV0q4U0mOlISW9HdIvg=;
        b=qQk5LaejLIRiWouSFQyHz5LoHRMvTaxrFmfBNn3XVwYvj14TmInQS8LyTvNWTTTT/x3X42
        RBahs0YObnjiIQUB8opxd4UN7JG1Tu/0Qg2X7U8Flc/sAKq8zpYm10HuzlUew+WBfpprhN
        5HL3zoSzdCZfYitvGBBfwbz2o0Ff+LZNIdCjp1Y1jkSoub374Mnd4Eiohg8FAPAPVLQGnG
        zjk0eRnVmLDHA52wB4K9srsKmreTu77o+eaBpoUbe9Afh5uSjbO8i63oC1XT7U7MXRg1Bh
        JPynz108DyZQ7JG32bsB2h0VHsIJZ20dCzo2f1ZLpM6t1w6a7aomWM0bqV4buw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639066033;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YwJMbIA0J4qqNnbHfw/h0m5MVV0q4U0mOlISW9HdIvg=;
        b=kkBo5uaFCMIzTuXsRfxJYM+na5fUmdoPgc6VSLAJrLEEZxYYRqH4zgtiv6pCS9wQ6Algw7
        XOgHg513GwR7yRAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/msi: Guard sysfs code
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211206210223.985907940@linutronix.de>
References: <20211206210223.985907940@linutronix.de>
MIME-Version: 1.0
Message-ID: <163906603220.11128.3589171489286442756.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     1197528aaea79ed4909aba695d18fdecc5387a36
Gitweb:        https://git.kernel.org/tip/1197528aaea79ed4909aba695d18fdecc5387a36
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:27:28 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 09 Dec 2021 11:52:20 +01:00

genirq/msi: Guard sysfs code

No point in building unused code when CONFIG_SYSFS=n.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20211206210223.985907940@linutronix.de

---
 include/linux/msi.h | 10 ++++++++++
 kernel/irq/msi.c    |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index e616f94..d43b946 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -239,9 +239,19 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void pci_msi_mask_irq(struct irq_data *data);
 void pci_msi_unmask_irq(struct irq_data *data);
 
+#ifdef CONFIG_SYSFS
 const struct attribute_group **msi_populate_sysfs(struct device *dev);
 void msi_destroy_sysfs(struct device *dev,
 		       const struct attribute_group **msi_irq_groups);
+#else
+static inline const struct attribute_group **msi_populate_sysfs(struct device *dev)
+{
+	return NULL;
+}
+static inline void msi_destroy_sysfs(struct device *dev, const struct attribute_group **msi_irq_groups)
+{
+}
+#endif
 
 /*
  * The arch hooks to setup up msi irqs. Default functions are implemented
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 7f350ae..a8a0dae 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -72,6 +72,7 @@ void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg)
 }
 EXPORT_SYMBOL_GPL(get_cached_msi_msg);
 
+#ifdef CONFIG_SYSFS
 static ssize_t msi_mode_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
@@ -204,6 +205,7 @@ void msi_destroy_sysfs(struct device *dev, const struct attribute_group **msi_ir
 		kfree(msi_irq_groups);
 	}
 }
+#endif
 
 #ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
 static inline void irq_chip_write_msi_msg(struct irq_data *data,
