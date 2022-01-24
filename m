Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9441498781
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244832AbiAXSBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:01:08 -0500
Received: from mga14.intel.com ([192.55.52.115]:63147 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241651AbiAXSAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:00:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643047255; x=1674583255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y8ZjakMo/mJ3Wq1rrQTj9HsDSrE7UOgOlZKX2oN9x20=;
  b=Tu35DCZePLJX7x9n2/dtNXueh6Lto/2Pg2jpHz5rNexBx8GZu7DCimUw
   HNGj3yoOF0xB8jK/EA+BPVJNS0vvoCRvIX28LCqb/eEZJZlCybBmE41eP
   5fAzvtHrhFlPo0kIoZDWWL0dm/rSFj7YDUKwH+iJR1T2FDmOQpA2/XYsE
   IqqTLK/SaMHVhwsIkAWBDvQ+nyp1vPrtWJZ9wCaEdsg5AN29V5yJiyXsK
   G2iWoiUcfI7O4IoKJ+UlxunQkHBWfeuq12heF/kO+LqB9eq8tzvwuavzA
   tWTBcZQ0mJ6IVfqYvxCe4LPGaWAI4JroddftcxJSpMIMEQSZZbDm6eTaU
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="246326304"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="246326304"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 10:00:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="695511924"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 24 Jan 2022 10:00:29 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5D751B7; Mon, 24 Jan 2022 20:00:42 +0200 (EET)
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
Subject: [PATCH v2 2/5] nvmem: core: Use devm_add_action_or_reset()
Date:   Mon, 24 Jan 2022 20:00:37 +0200
Message-Id: <20220124180040.50660-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124180040.50660-1-andriy.shevchenko@linux.intel.com>
References: <20220124180040.50660-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Slightly simplify the devm_nvmem_register() by using the
devm_add_action_or_reset().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
 drivers/nvmem/core.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 1a70b3bdb71d..68db7d3303ac 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -907,9 +907,9 @@ void nvmem_unregister(struct nvmem_device *nvmem)
 }
 EXPORT_SYMBOL_GPL(nvmem_unregister);
 
-static void devm_nvmem_release(struct device *dev, void *res)
+static void devm_nvmem_unregister(void *nvmem)
 {
-	nvmem_unregister(*(struct nvmem_device **)res);
+	nvmem_unregister(nvmem);
 }
 
 /**
@@ -926,20 +926,16 @@ static void devm_nvmem_release(struct device *dev, void *res)
 struct nvmem_device *devm_nvmem_register(struct device *dev,
 					 const struct nvmem_config *config)
 {
-	struct nvmem_device **ptr, *nvmem;
-
-	ptr = devres_alloc(devm_nvmem_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return ERR_PTR(-ENOMEM);
+	struct nvmem_device *nvmem;
+	int ret;
 
 	nvmem = nvmem_register(config);
+	if (IS_ERR(nvmem))
+		return nvmem;
 
-	if (!IS_ERR(nvmem)) {
-		*ptr = nvmem;
-		devres_add(dev, ptr);
-	} else {
-		devres_free(ptr);
-	}
+	ret = devm_add_action_or_reset(dev, devm_nvmem_unregister, nvmem);
+	if (ret)
+		return ERR_PTR(ret);
 
 	return nvmem;
 }
-- 
2.34.1

