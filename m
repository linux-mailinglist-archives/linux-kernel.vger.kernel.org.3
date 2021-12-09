Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DA246ECAF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240903AbhLIQK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:10:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40098 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240835AbhLIQKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:10:39 -0500
Date:   Thu, 09 Dec 2021 16:07:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639066025;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P91S7wLpB0Uc8sVbh5LbQfyZGxUkGtiZXczHWdeqhZ0=;
        b=kvi7i3jJkZ6LAQadk7PGVkSvA0qW3kYxsXSBv8f/Y9Fy8tF1sIAwNyVs0BxZj/GXO3kn7v
        wVZCPktlLfrQ/aPT21fzLG5NE8ezKkZP+ePNbdhy2RZ7nxSlNvCGesTs6TH1wAv/y3FA5O
        0Cc7jM5lH2zI4fZAVGi1zRW1OzDLwHtLAHAfN7RI2lgiOVhc+gSrR/4C2jN6k3nag2LH6d
        vdA7smBd+d3bOKgs9Kn5INfrhuWZtoiBhvTvtvJcBWbQYnmPXAHW8KmjSUZknsKdDcrkDp
        61GuNes4DZ0MsPL8m/32YIeEeX+qO766GdjvERyHHCDdjwMIzxLHNvdk6fl7Jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639066025;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P91S7wLpB0Uc8sVbh5LbQfyZGxUkGtiZXczHWdeqhZ0=;
        b=y3cC5dltZ+zwxXoqoExyo8SYNsPBgY/Os9l37Y+DbCNw7x/GBpGyIXwIki2fIZflS0LyuF
        qB6R9h57q+Sjb2DA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI/MSI: Make msix_update_entries() smarter
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211206210224.600351129@linutronix.de>
References: <20211206210224.600351129@linutronix.de>
MIME-Version: 1.0
Message-ID: <163906602397.11128.4835509365516033620.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     7112158d97a1539b217c360d379724ac3ee99fa3
Gitweb:        https://git.kernel.org/tip/7112158d97a1539b217c360d379724ac3ee99fa3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 06 Dec 2021 23:27:46 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 09 Dec 2021 11:52:21 +01:00

PCI/MSI: Make msix_update_entries() smarter

No need to walk the descriptors and check for each one whether the entries
pointer function argument is NULL. Do it once.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20211206210224.600351129@linutronix.de

---
 drivers/pci/msi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index a76fcf4..1573091 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -642,8 +642,8 @@ static void msix_update_entries(struct pci_dev *dev, struct msix_entry *entries)
 {
 	struct msi_desc *entry;
 
-	for_each_pci_msi_entry(entry, dev) {
-		if (entries) {
+	if (entries) {
+		for_each_pci_msi_entry(entry, dev) {
 			entries->vector = entry->irq;
 			entries++;
 		}
