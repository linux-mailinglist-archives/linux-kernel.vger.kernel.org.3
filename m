Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311A1496519
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 19:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382135AbiAUSdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 13:33:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55754 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343584AbiAUSdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 13:33:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53551B82090;
        Fri, 21 Jan 2022 18:33:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA037C340E1;
        Fri, 21 Jan 2022 18:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642790017;
        bh=//RljZ0jx600nmKTy4kmYHaAXavz9g7lJZTUhiR7hzc=;
        h=From:To:Cc:Subject:Date:From;
        b=o0Gg4l+3bKaQS3knQkgWIX/xTsG7DRXqDjLmvExxfS6mIpOcdvMJOa/gPsofeisK6
         qTXmJGZaF9CiTPdexYePAFZ8pPCKiOL1kEEqMqL51QUp8lQJ361wpZmlnKzbCbl4ys
         2W28Mfr74UehJeN5NYfy6noQoe10ZQkXXMwO7tiblgUWisYb2oVODjNqUS0wdXzzL8
         bHXmR4Sebi6nVBV9DM2SqsVBYq5YlLmg7ZgTjyb5Rn16mRV5e42B1T9/ITwqO//cNz
         Xel3ZRA2q3jBoHfh/pBpASyTDXTYgcAl9WF53MGajU4youhuxv0OeO8k0zcnsMJmcZ
         ppb6/xvKnNseQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Denis Efremov <efremov@linux.com>
Subject: [PATCH v1] PCI: Use PCI_STD_NUM_BARS when checking standard BARs
Date:   Fri, 21 Jan 2022 12:33:30 -0600
Message-Id: <20220121183330.1141702-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

usb_hcd_pci_probe() searches for an I/O BAR using a combination of
PCI_STD_NUM_BARS (to control loop iteration) and PCI_ROM_RESOURCE (to check
whether the loop exits without finding anything).

Use PCI_STD_NUM_BARS consistently.

No functional change since PCI_STD_NUM_BARS == PCI_ROM_RESOURCE, but this
removes a dependency on that relationship and makes the code read better.

Fixes: c9c13ba428ef ("PCI: Add PCI_STD_NUM_BARS for the number of standard
BARs")
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Denis Efremov <efremov@linux.com>
---
 drivers/usb/core/hcd-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
index d630cccd2e6e..784466117c92 100644
--- a/drivers/usb/core/hcd-pci.c
+++ b/drivers/usb/core/hcd-pci.c
@@ -248,7 +248,7 @@ int usb_hcd_pci_probe(struct pci_dev *dev, const struct pci_device_id *id,
 					hcd->rsrc_len, driver->description))
 				break;
 		}
-		if (region == PCI_ROM_RESOURCE) {
+		if (region == PCI_STD_NUM_BARS) {
 			dev_dbg(&dev->dev, "no i/o regions available\n");
 			retval = -EBUSY;
 			goto put_hcd;
-- 
2.25.1

