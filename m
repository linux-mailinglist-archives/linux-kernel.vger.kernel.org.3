Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB8048429C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbiADNil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:38:41 -0500
Received: from mga14.intel.com ([192.55.52.115]:55154 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233656AbiADNij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:38:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641303519; x=1672839519;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1faGgl1n5RMDy4eY/oAFnPrRhLAJ+Ie+KfhM2G1o9gw=;
  b=DGssk2yTp8y3WVpLVgil4oiS0/T6QP6I7zO6DwkI6XCgweSZyX+QyBqJ
   t99UdgHvrgOFtRKDad8yRK94tfAlDxm+7V/DtpZnCUqJS/qC0AduyRS1W
   2bBlzon9UYbrVuO2nC3hiJqOIm8Drf1Qozm4V/J2nqxISUN6XvxPMmYz+
   nTlYmen3h12rXJ2O7qF/5c8m2X40AW4hWHEBQrdbZq4ERC/nhBiyG10wb
   EMIUzpzIrnkID60cRHmkxBpf2sWitcE2bwMW03OeQeu9hOYBUR8N7pyEa
   bN4Nv2fk0WRJfPGYNRonIis1y6EfyUeFB1npNX/0tmihnyEWJmOdcfGuj
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="242430114"
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="242430114"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 05:38:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="556169291"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 04 Jan 2022 05:38:35 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CFCB41F8; Tue,  4 Jan 2022 15:38:45 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>
Subject: [PATCH v1 1/5] nvmem: core: Remove unused devm_nvmem_unregister()
Date:   Tue,  4 Jan 2022 15:38:39 +0200
Message-Id: <20220104133843.44272-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no users and seems no will come of the devm_nvmem_unregister().
Remove the function.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/nvmem/core.c           | 15 ---------------
 include/linux/nvmem-provider.h |  8 --------
 2 files changed, 23 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 23a38dcf0fc4..fbf7dec775fb 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -952,21 +952,6 @@ static int devm_nvmem_match(struct device *dev, void *res, void *data)
 	return *r == data;
 }
 
-/**
- * devm_nvmem_unregister() - Unregister previously registered managed nvmem
- * device.
- *
- * @dev: Device that uses the nvmem device.
- * @nvmem: Pointer to previously registered nvmem device.
- *
- * Return: Will be negative on error or zero on success.
- */
-int devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
-{
-	return devres_release(dev, devm_nvmem_release, devm_nvmem_match, nvmem);
-}
-EXPORT_SYMBOL(devm_nvmem_unregister);
-
 static struct nvmem_device *__nvmem_device_get(void *data,
 			int (*match)(struct device *dev, const void *data))
 {
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 98efb7b5660d..99c01c43d7a8 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -133,8 +133,6 @@ void nvmem_unregister(struct nvmem_device *nvmem);
 struct nvmem_device *devm_nvmem_register(struct device *dev,
 					 const struct nvmem_config *cfg);
 
-int devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem);
-
 void nvmem_add_cell_table(struct nvmem_cell_table *table);
 void nvmem_del_cell_table(struct nvmem_cell_table *table);
 
@@ -153,12 +151,6 @@ devm_nvmem_register(struct device *dev, const struct nvmem_config *c)
 	return nvmem_register(c);
 }
 
-static inline int
-devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline void nvmem_add_cell_table(struct nvmem_cell_table *table) {}
 static inline void nvmem_del_cell_table(struct nvmem_cell_table *table) {}
 
-- 
2.34.1

