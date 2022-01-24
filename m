Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32151498780
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbiAXSBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:01:06 -0500
Received: from mga14.intel.com ([192.55.52.115]:63121 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244856AbiAXSAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:00:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643047242; x=1674583242;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BQSospdD4gesHVIwJjnamUSWWSLW6vXQL72nOd9YKGI=;
  b=TA2JAN2DVMPmfmWo5QitF5YwhQSauZWIrXi5sPUPbm9OPI4t/CXt+jAr
   VqmvkwJrzQXSzXCQaWDfn5zmEh2N0Ven5UnjxaRkfAwJ2rF8wrwSHC/lT
   rKX8u/0TYsbCD8j/+dN32jBfErggjJXD9auoR13SqwtgVP3W+ww0rSLFD
   d+4evnZQ3Gmkf5zup9KQmfn6MoaimVBQgm6/3kk02z2myk1Hx2Wq3o54R
   OTZmG6efBz5U/kWdCijIUwgs1QiSFeCiXWJPqzF9HxlqexIoEqJewoFvs
   4Wq4LZ4r/n81LiIHfo4xFzVZEfwzLf49FBvKVQuT+Jey3nQjyxkTor7gW
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="246326299"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="246326299"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 10:00:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="624164228"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jan 2022 10:00:29 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 52C3D178; Mon, 24 Jan 2022 20:00:42 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: [PATCH v2 1/5] nvmem: core: Remove unused devm_nvmem_unregister()
Date:   Mon, 24 Jan 2022 20:00:36 +0200
Message-Id: <20220124180040.50660-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no users and seems no will come of the devm_nvmem_unregister().
Remove the function and remove the unused devm_nvmem_match() along with it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: removed unused devm_nvmem_match() (lkp)
 drivers/nvmem/core.c           | 22 ----------------------
 include/linux/nvmem-provider.h |  8 --------
 2 files changed, 30 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 23a38dcf0fc4..1a70b3bdb71d 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -945,28 +945,6 @@ struct nvmem_device *devm_nvmem_register(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_nvmem_register);
 
-static int devm_nvmem_match(struct device *dev, void *res, void *data)
-{
-	struct nvmem_device **r = res;
-
-	return *r == data;
-}
-
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

