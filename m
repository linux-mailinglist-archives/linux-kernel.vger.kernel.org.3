Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29AA5A2D32
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243496AbiHZRQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344450AbiHZRQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:16:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE6E6B8C6;
        Fri, 26 Aug 2022 10:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661534189; x=1693070189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bYEvZrVYncsTx8f79csRdY+X+4yXs90ZO8FXGrSoPmk=;
  b=GTHRq7dsbpFI0lQBl4Dp+eUbQIA0bFWzkLNw6D1Lak1cZpsUwjE/eQgQ
   45FaDUWDWR+VcIzM0jcYtWMeQIUhW7ahk19CDcDTtB8bMQExA9IjUrV2S
   wkTUGhTghoIodftyotKIiUMCkYHmOWrVv5ZbuEOnx58AdaSLEqYJlMCj+
   mZs3AW2TfFr7Xmc2ct9857tJ5K/3rSiPiorB+q5pBnpzG0y+4uaDsV0dM
   DzcHmakxLSTNfI1ubuFYkWP8ReAESeG9G7P60iYdjFqosDC4528Fb11+V
   7h55YOTi++EuEEjUm1u5/421exHTctjo15jDTL8OfZrTogsGFHCSV8owr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="295333128"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="295333128"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 10:16:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="678932980"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 26 Aug 2022 10:16:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 37215174; Fri, 26 Aug 2022 20:16:41 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/2] ACPI: bus: Refactor ACPI matching functions for better readability
Date:   Fri, 26 Aug 2022 20:16:35 +0300
Message-Id: <20220826171635.15652-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220826171635.15652-1-andriy.shevchenko@linux.intel.com>
References: <20220826171635.15652-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With temporary variables for OF and ACPI IDs, it's easier to read
the code. No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: refactored another function (due to drop the rest of the series)
 drivers/acpi/bus.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index f3e868d35144..d466c8195314 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -925,12 +925,13 @@ static const void *acpi_of_device_get_match_data(const struct device *dev)
 
 const void *acpi_device_get_match_data(const struct device *dev)
 {
+	const struct acpi_device_id *acpi_ids = dev->driver->acpi_match_table;
 	const struct acpi_device_id *match;
 
-	if (!dev->driver->acpi_match_table)
+	if (!acpi_ids)
 		return acpi_of_device_get_match_data(dev);
 
-	match = acpi_match_device(dev->driver->acpi_match_table, dev);
+	match = acpi_match_device(acpi_ids, dev);
 	if (!match)
 		return NULL;
 
@@ -948,14 +949,13 @@ EXPORT_SYMBOL(acpi_match_device_ids);
 bool acpi_driver_match_device(struct device *dev,
 			      const struct device_driver *drv)
 {
-	if (!drv->acpi_match_table)
-		return acpi_of_match_device(ACPI_COMPANION(dev),
-					    drv->of_match_table,
-					    NULL);
-
-	return __acpi_match_device(acpi_companion_match(dev),
-				   drv->acpi_match_table, drv->of_match_table,
-				   NULL, NULL);
+	const struct acpi_device_id *acpi_ids = drv->acpi_match_table;
+	const struct of_device_id *of_ids = drv->of_match_table;
+
+	if (!acpi_ids)
+		return acpi_of_match_device(ACPI_COMPANION(dev), of_ids, NULL);
+
+	return __acpi_match_device(acpi_companion_match(dev), acpi_ids, of_ids, NULL, NULL);
 }
 EXPORT_SYMBOL_GPL(acpi_driver_match_device);
 
-- 
2.35.1

