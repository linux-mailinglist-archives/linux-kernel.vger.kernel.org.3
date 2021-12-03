Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE584676BC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 12:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380579AbhLCLyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 06:54:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:55608 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231944AbhLCLyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:54:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638532274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7EomsQQW2YFliNqEz8wa0S+y1X7DhgjPLXb/e8gkVb0=;
        b=izrDxBhZuOsRUm5p7t7q2nLcCGHeoerntyouBj28ygzqOxRDpxTU8yQr3gcWDT4ke4tXae
        Ihjsd8NMW7Irx2KHedilHQ+laqbs/8zRITn+mzV6iqdwYE+PaJzVrVY0ECimAUxlSzyhCW
        z+3bbikwkuROnb71gOW0WYWJA+rIK4o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-OfCERDAAMNmKkp3QovxYqw-1; Fri, 03 Dec 2021 06:51:13 -0500
X-MC-Unique: OfCERDAAMNmKkp3QovxYqw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 606FD1853028;
        Fri,  3 Dec 2021 11:51:11 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48C0B60622;
        Fri,  3 Dec 2021 11:51:09 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
        Dan Scally <djrscally@gmail.com>, Kate Hsuan <hpa@redhat.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2] mfd: intel-lpss: Fix I2C4 not being available on the Microsoft Surface Go & Go 2
Date:   Fri,  3 Dec 2021 12:51:08 +0100
Message-Id: <20211203115108.89661-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many DSDTs for Kaby Lake and Kaby Lake Refresh models contain a
_SB.PCI0.GEXP ACPI Device node describing an I2C attached PCA953x
GPIO expander.

This seems to be something which is copy and pasted from the DSDT
from some reference design since this ACPI Device is present even on
models where no such GPIO expander is used at all, such as on the
Microsoft Surface Go & Go 2.

This ACPI Device is a problem because it contains a SystemMemory
OperationRegion which covers the MMIO for the I2C4 I2C controller. This
causes the MFD cell for the I2C4 controller to not be instantiated due
to a resource conflict, requiring the use of acpi_enforce_resources=lax
to work around this.

I have done an extensive analysis of all the ACPI tables on the
Microsoft Surface Go and the _SB.PCI0.GEXP ACPI Device's methods are
not used by any code in the ACPI tables, neither are any of them
directly called by any Linux kernel code. This is unsurprising since
running i2cdetect on the I2C4 bus shows that there is no GPIO
expander chip present on these devices at all.

This commit adds a PCI subsystem vendor:device table listing PCI devices
where it is known to be safe to ignore resource conflicts with ACPI
declared SystemMemory regions.

This makes the I2C4 bus work out of the box on the Microsoft Surface
Go & Go 2, which is necessary for the cameras on these devices to work.

Cc: Dan Scally <djrscally@gmail.com>
Cc: Kate Hsuan <hpa@redhat.com>
Cc: Maximilian Luz <luzmaximilian@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Use PCI_VENDOR_ID_INTEL instead of 0x8086
- Small tweaks to commit message
- Added Laurent's and Andy's Reviewed-by
---
 drivers/mfd/intel-lpss-pci.c | 12 ++++++++++++
 drivers/mfd/intel-lpss.c     |  1 +
 drivers/mfd/intel-lpss.h     |  1 +
 3 files changed, 14 insertions(+)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index a872b4485eac..81185d17d9c9 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -17,6 +17,15 @@
 
 #include "intel-lpss.h"
 
+/* Some DSDTs have an unused GEXP ACPI device conflicting with I2C4 resources */
+static const struct pci_device_id ignore_resource_conflicts_ids[] = {
+	/* Microsoft Surface Go (version 1) I2C4 */
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1182), },
+	/* Microsoft Surface Go 2 I2C4 */
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1237), },
+	{ }
+};
+
 static int intel_lpss_pci_probe(struct pci_dev *pdev,
 				const struct pci_device_id *id)
 {
@@ -35,6 +44,9 @@ static int intel_lpss_pci_probe(struct pci_dev *pdev,
 	info->mem = &pdev->resource[0];
 	info->irq = pdev->irq;
 
+	if (pci_match_id(ignore_resource_conflicts_ids, pdev))
+		info->ignore_resource_conflicts = true;
+
 	pdev->d3cold_delay = 0;
 
 	/* Probably it is enough to set this for iDMA capable devices only */
diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index 0e15afc39f54..cfbee2cfba6b 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -401,6 +401,7 @@ int intel_lpss_probe(struct device *dev,
 		return ret;
 
 	lpss->cell->swnode = info->swnode;
+	lpss->cell->ignore_resource_conflicts = info->ignore_resource_conflicts;
 
 	intel_lpss_init_dev(lpss);
 
diff --git a/drivers/mfd/intel-lpss.h b/drivers/mfd/intel-lpss.h
index 22dbc4aed793..062ce95b68b9 100644
--- a/drivers/mfd/intel-lpss.h
+++ b/drivers/mfd/intel-lpss.h
@@ -19,6 +19,7 @@ struct software_node;
 
 struct intel_lpss_platform_info {
 	struct resource *mem;
+	bool ignore_resource_conflicts;
 	int irq;
 	unsigned long clk_rate;
 	const char *clk_con_id;
-- 
2.33.1

