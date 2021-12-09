Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C47046EA78
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 15:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239069AbhLIPDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:03:10 -0500
Received: from mga09.intel.com ([134.134.136.24]:59272 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230312AbhLIPDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:03:09 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="237919747"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="237919747"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 06:59:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="463258687"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 09 Dec 2021 06:59:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E24C2329; Thu,  9 Dec 2021 16:59:40 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH v1 2/2] ata: libahci_platform: Remove bogus 32-bit DMA mask attempt
Date:   Thu,  9 Dec 2021 16:59:37 +0200
Message-Id: <20211209145937.77719-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211209145937.77719-1-andriy.shevchenko@linux.intel.com>
References: <20211209145937.77719-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 64-bit mask attempt fails, the 32-bit will fail by the very same reason.
Don't even try the latter. It's a continuation of the changes that contains,
e.g. dcc02c19cc06 ("sata_sil24: use dma_set_mask_and_coherent").

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/libahci_platform.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 1af642c84e7b..972f5ec86a27 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -637,13 +637,8 @@ int ahci_platform_init_host(struct platform_device *pdev,
 	if (hpriv->cap & HOST_CAP_64) {
 		rc = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(64));
 		if (rc) {
-			rc = dma_coerce_mask_and_coherent(dev,
-							  DMA_BIT_MASK(32));
-			if (rc) {
-				dev_err(dev, "Failed to enable 64-bit DMA.\n");
-				return rc;
-			}
-			dev_warn(dev, "Enable 32-bit DMA instead of 64-bit.\n");
+			dev_err(dev, "Failed to enable 64-bit DMA.\n");
+			return rc;
 		}
 	}
 
-- 
2.33.0

