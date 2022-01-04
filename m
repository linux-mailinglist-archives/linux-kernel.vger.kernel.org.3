Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B144842A4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbiADNix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:38:53 -0500
Received: from mga11.intel.com ([192.55.52.93]:44752 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233657AbiADNij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:38:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641303519; x=1672839519;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dk8eR+nk6aw16X9+1NKLpwmWVQ9jkxr8X5sDpD7O+wM=;
  b=ecSmSn/OQ8Ql0SMXgw4At0IhSq3BF/MzRnGIpSF1Rf3BjVAx9ONaHuaV
   W0+cA6a/G8hS4eWvpSVvocgvqXfStqAs5uAWn650vq7JXtTBE51a2I9s+
   2gelofG9x/wwL3ayY4FRVCsJe94j5iVZFXn/F9eUuCkPm8mLsSK7lfv0O
   ohHJf1Z8A0S5trMZ0DvRAYLkAnQdbKSWRvL7x6EQQKUHtzvYTTbLSsUIX
   liNmazfJ/pivPaG0lbKegvgPa6+j/RDHlwPb5sFXFolX3V1zd/BydBdRE
   r965IV8YwAy4NngaXYdnE1wEkP/kiPAzi5fL04DJB7P9XL4e2JsrHeHpJ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="239765011"
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="239765011"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 05:38:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="472066537"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 04 Jan 2022 05:38:35 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EC8F449B; Tue,  4 Jan 2022 15:38:45 +0200 (EET)
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
Subject: [PATCH v1 4/5] mtd: core: Drop duplicate NULL checks around nvmem_unregister()
Date:   Tue,  4 Jan 2022 15:38:42 +0200
Message-Id: <20220104133843.44272-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220104133843.44272-1-andriy.shevchenko@linux.intel.com>
References: <20220104133843.44272-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since nvmem_unregister() checks for NULL, no need to repeat in
the caller. Drop duplicate NULL checks.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mtd/mtdcore.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 70f492dce158..010ffc34532a 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -742,8 +742,7 @@ int del_mtd_device(struct mtd_info *mtd)
 		debugfs_remove_recursive(mtd->dbg.dfs_dir);
 
 		/* Try to remove the NVMEM provider */
-		if (mtd->nvmem)
-			nvmem_unregister(mtd->nvmem);
+		nvmem_unregister(mtd->nvmem);
 
 		device_unregister(&mtd->dev);
 
@@ -921,8 +920,7 @@ static int mtd_otp_nvmem_add(struct mtd_info *mtd)
 	return 0;
 
 err:
-	if (mtd->otp_user_nvmem)
-		nvmem_unregister(mtd->otp_user_nvmem);
+	nvmem_unregister(mtd->otp_user_nvmem);
 	return err;
 }
 
@@ -1026,11 +1024,8 @@ int mtd_device_unregister(struct mtd_info *master)
 		memset(&master->reboot_notifier, 0, sizeof(master->reboot_notifier));
 	}
 
-	if (master->otp_user_nvmem)
-		nvmem_unregister(master->otp_user_nvmem);
-
-	if (master->otp_factory_nvmem)
-		nvmem_unregister(master->otp_factory_nvmem);
+	nvmem_unregister(master->otp_user_nvmem);
+	nvmem_unregister(master->otp_factory_nvmem);
 
 	err = del_mtd_partitions(master);
 	if (err)
-- 
2.34.1

