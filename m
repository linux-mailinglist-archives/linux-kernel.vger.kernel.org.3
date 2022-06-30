Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1487A56235C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 21:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236911AbiF3Tnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 15:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236382AbiF3Tne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 15:43:34 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFA624F25;
        Thu, 30 Jun 2022 12:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656618213; x=1688154213;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pIgHqbTPvdZQRFyBm2TkG/rvzqkdS8PX64Z2/SY+C1U=;
  b=Uo1P8pLV48AKE/EQkWEhnSKWtQcHDIxyDT9i9o7L6n+RE3rvC1AD0gdQ
   IiFftra4m1AXsT8wCvw7nToD68CIg/X6toor9+DuwYDM+EDQYEQFjdzRJ
   RM+wn5MzKTuVRoayNfzZHsZGYNwR3tgskKlUyb2BtQPBVpIdXUTcE2b7a
   g9pVCDohc8bwy7Bgd6A7vbcTbx7h8QZFpkZrmZlUYykd8Nl3qzwr44bNd
   oO6SfEbZx6yGlC+gBIf7C8L/6igUTcJwKIMPWjM9YG8QY86ijZI8BSX/L
   AgsHv7qNPEPqcHpch+RuH5J6F4/Xtd/Jfa9YgqvpJP2/YDwR0Eul54bgN
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="282481179"
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="282481179"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 12:43:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="694196407"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 30 Jun 2022 12:43:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 337CC11E; Thu, 30 Jun 2022 22:43:37 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Subject: [PATCH v1 1/1] platform/x86: xo15-ebook: Replace open coded acpi_match_device()
Date:   Thu, 30 Jun 2022 22:43:35 +0300
Message-Id: <20220630194335.3730-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace open coded acpi_match_device() in ebook_switch_add().

Note, while it is a bit longer it is more robust in case more ID
are coming.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/xo15-ebook.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/xo15-ebook.c b/drivers/platform/x86/xo15-ebook.c
index 97440462aa25..40b2dd4ae5ea 100644
--- a/drivers/platform/x86/xo15-ebook.c
+++ b/drivers/platform/x86/xo15-ebook.c
@@ -81,9 +81,9 @@ static SIMPLE_DEV_PM_OPS(ebook_switch_pm, NULL, ebook_switch_resume);
 
 static int ebook_switch_add(struct acpi_device *device)
 {
+	const struct acpi_device_id *id;
 	struct ebook_switch *button;
 	struct input_dev *input;
-	const char *hid = acpi_device_hid(device);
 	char *name, *class;
 	int error;
 
@@ -102,8 +102,9 @@ static int ebook_switch_add(struct acpi_device *device)
 	name = acpi_device_name(device);
 	class = acpi_device_class(device);
 
-	if (strcmp(hid, XO15_EBOOK_HID)) {
-		pr_err("Unsupported hid [%s]\n", hid);
+	id = acpi_match_device(device, ebook_device_ids);
+	if (!id) {
+		dev_err(&device->dev, "Unsupported hid\n");
 		error = -ENODEV;
 		goto err_free_input;
 	}
@@ -111,7 +112,7 @@ static int ebook_switch_add(struct acpi_device *device)
 	strcpy(name, XO15_EBOOK_DEVICE_NAME);
 	sprintf(class, "%s/%s", XO15_EBOOK_CLASS, XO15_EBOOK_SUBCLASS);
 
-	snprintf(button->phys, sizeof(button->phys), "%s/button/input0", hid);
+	snprintf(button->phys, sizeof(button->phys), "%s/button/input0", id->id);
 
 	input->name = name;
 	input->phys = button->phys;
-- 
2.35.1

