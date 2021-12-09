Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80E646EA7A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 15:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239083AbhLIPDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:03:11 -0500
Received: from mga05.intel.com ([192.55.52.43]:47029 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230312AbhLIPDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:03:10 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="324375277"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="324375277"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 06:59:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="503518966"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 09 Dec 2021 06:59:33 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2033015C; Thu,  9 Dec 2021 16:59:40 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH v1 1/2] ata: libahci_platform: Get rid of dup message when IRQ can't be retrieved
Date:   Thu,  9 Dec 2021 16:59:36 +0200
Message-Id: <20211209145937.77719-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq() will print a message when it fails.
No need to repeat this.

While at it, drop redundant check for 0 as platform_get_irq() spills
out a big WARN() in such case.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/libahci_platform.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 0910441321f7..1af642c84e7b 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -579,13 +579,8 @@ int ahci_platform_init_host(struct platform_device *pdev,
 	int i, irq, n_ports, rc;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		if (irq != -EPROBE_DEFER)
-			dev_err(dev, "no irq\n");
+	if (irq < 0)
 		return irq;
-	}
-	if (!irq)
-		return -EINVAL;
 
 	hpriv->irq = irq;
 
-- 
2.33.0

