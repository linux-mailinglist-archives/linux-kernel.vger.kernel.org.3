Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03F95A16D6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243093AbiHYQlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240039AbiHYQlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:41:07 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6014B9FB0;
        Thu, 25 Aug 2022 09:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661445663; x=1692981663;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MwVIs/zJ7mRuBvOdPKfAl5h+2iG+pF9LW6lI3yel2kw=;
  b=EIxOwHzvMukt2zpAvGifDX2ZUEWHeYHilLhvBMVwqMZxxOMWa2jaEPdc
   bRwFuMzlINlr2cnT47M58yb3bZc4GtnHOexlAYdpBcvhuSAqB8gddTgEq
   wtnRrAHZ4/i/5FifklEVVHmetAck3w5bEUuau/Guq2ZO/eTFGLF25Fd10
   s739vn+nJhCSwor2gLsv9cmESZfpzf9BIpPzx6/jQF02QCtEIojrW8Bsq
   /Flv2Wfeu9s3Seve1ZiLjzDQkYOUdphPzF4L1iyNXR4z/Ripg1aLQxRV3
   8fL4jO23QQW/Ff0SFscXG4rtnbugULywDE77f1ezcECmyYYO5TwPSz7G5
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="356013486"
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="356013486"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 09:41:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="613228127"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 25 Aug 2022 09:41:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9BD4B49F; Thu, 25 Aug 2022 19:41:15 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 5/5] ACPI: bus: Use the matching table, if ACPI driver has it
Date:   Thu, 25 Aug 2022 19:41:03 +0300
Message-Id: <20220825164103.27694-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220825164103.27694-1-andriy.shevchenko@linux.intel.com>
References: <20220825164103.27694-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case we have an ACPI driver, check its ID table for matching,
This allows to use some generic device property APIs in such
drivers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/bus.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 3c0f2d050d47..17c98e826bde 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1049,14 +1049,30 @@ static const void *acpi_of_device_get_match_data(const struct device *dev)
 	return match->data;
 }
 
+static const struct acpi_device_id *acpi_device_get_ids(const struct device *dev)
+{
+	if (dev->driver->acpi_match_table)
+		return dev->driver->acpi_match_table;
+
+	if (dev_is_acpi(dev)) {
+		struct acpi_driver *drv = to_acpi_driver(dev->driver);
+
+		if (drv->ids)
+			return drv->ids;
+	}
+
+	return NULL;
+}
+
 const void *acpi_device_get_match_data(const struct device *dev)
 {
+	const struct acpi_device_id *ids = acpi_device_get_ids(dev);
 	const struct acpi_device_id *match;
 
-	if (!dev->driver->acpi_match_table)
+	if (!ids)
 		return acpi_of_device_get_match_data(dev);
 
-	match = acpi_match_device(dev->driver->acpi_match_table, dev);
+	match = acpi_match_device(ids, dev);
 	if (!match)
 		return NULL;
 
-- 
2.35.1

