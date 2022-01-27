Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E56249E96F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244909AbiA0R4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:56:20 -0500
Received: from mga06.intel.com ([134.134.136.31]:16774 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244858AbiA0Rz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306127; x=1674842127;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0+NRkt4jFtorhkBaictzxf0Z79rbBKCqDV6xhB7GtYA=;
  b=PVowpxuDFLOb5IinzrjYUdYJv8hftxyJ+XS0dMGSX+PxXuQzz+EXuJuD
   69lT4Dvl6Dl/P0YmQla1Od0XRrDYz2LAU6y1wnw4Di/94hlCVKpqnJScZ
   dFuspR1NLIWcdP3OCfkUTyX+EOXHizCoc4XWAstPyeLljdHIG5m9lmyUn
   4K90nPgx8K6qB4BYuExdSMLuzOjiuOszWTrNneSGJmandbc5HUYdQxr+0
   3ZZG7BkgRDgpdgOT//jIsKT5DVJI+xgIhJ2YuHab/Jn3WCvYyT7VNm2sL
   nZaLkdMlQpCWpxh7bfOm+GqYerPsR3Up3LaG1YFVnDP6RXhJ9BcK+LfQs
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="307637000"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="307637000"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796218"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:14 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 44/44] devdax: Enable stray access protection
Date:   Thu, 27 Jan 2022 09:55:05 -0800
Message-Id: <20220127175505.851391-45-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Device dax is primarily accessed through user space and kernel access is
controlled through the kmap interfaces.

Now that all valid kernel initiated access to dax devices have been
accounted for, turn on PGMAP_PKEYS_PROTECT for device dax.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V8
	Rebase to 5.17-rc1
	Use pgmap_protection_available()
	s/PGMAP_PKEYS_PROTECT/PGMAP_PROTECTION/
---
 drivers/dax/device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index d33a0613ed0c..cee375ef2cac 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -452,6 +452,8 @@ int dev_dax_probe(struct dev_dax *dev_dax)
 	if (dev_dax->align > PAGE_SIZE)
 		pgmap->vmemmap_shift =
 			order_base_2(dev_dax->align >> PAGE_SHIFT);
+	if (pgmap_protection_available())
+		pgmap->flags |= PGMAP_PROTECTION;
 	addr = devm_memremap_pages(dev, pgmap);
 	if (IS_ERR(addr))
 		return PTR_ERR(addr);
-- 
2.31.1

