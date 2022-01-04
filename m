Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B82648429F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbiADNiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:38:46 -0500
Received: from mga07.intel.com ([134.134.136.100]:25811 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233663AbiADNij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:38:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641303519; x=1672839519;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iKpVHqbLjmy+GnZIzKt6LP0hTcWqlU2qKV4ybnoaZ5Y=;
  b=B3vBSms37MREx8C/cBFTA2e9CdmrVL10xiFtdNFbY3Rmd35Wqz8pO0A4
   V8xnf0Aq+z8t18MhuQEfKPYmfz2OJGm6d5lp1s1HHoyTiOKsvMRxmFA3o
   ZFlbt5tfpp9KzQBEJAKv9NVw0uJYw6Qrra3UbTu9CD4sICnAjkU1OGyO1
   r1c3xMBh9QL1VJdZHs+ZadkPHNVsP/5ERaYR5Ex0ksEFv2AXStV38dkNY
   3eO7uL3SG8TU9xbSmat9tJEg1ux5076yiLXd3uPiOAFgLtM0pVnPKxrsL
   3aKQDw/fGH89dJuvrZ7cNVcs1LgVgz2nbYHsXvrW0j/ZxbFoL/0P5w8Ou
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="305576180"
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="305576180"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 05:38:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="590678804"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 04 Jan 2022 05:38:35 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D87DC18E; Tue,  4 Jan 2022 15:38:45 +0200 (EET)
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
Subject: [PATCH v1 2/5] nvmem: core: Use devm_add_action_or_reset()
Date:   Tue,  4 Jan 2022 15:38:40 +0200
Message-Id: <20220104133843.44272-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220104133843.44272-1-andriy.shevchenko@linux.intel.com>
References: <20220104133843.44272-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Slightly simplify the devm_nvmem_register() by using the
devm_add_action_or_reset().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/nvmem/core.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index fbf7dec775fb..6946d14876dc 100644
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

