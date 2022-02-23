Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21A64C204D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 00:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245095AbiBWX4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 18:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbiBWX4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 18:56:39 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024FB5D657;
        Wed, 23 Feb 2022 15:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645660571; x=1677196571;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=K28DReeIhznAH38GKKop75KLShcLLga3wrGWpjXOAd0=;
  b=ESzwuFyxMffP8l0jLXDx3ruwn19yZZLvliqKhwLFYUNYMbHnkI3heFJ6
   O+vm4sB5Vkn7RLvvzoAcQz9d6SHlrVIv42j5qWJrUxcBlJz5cLBhK0r5c
   6kvbRLdbd88xlaDa33Jm/9HD53s2GIo+YM/b3QLIzNG2VM9KG2w6tQUR/
   UAr8uYEVMGVV+0P5W545mTZMbf1NJcE0g5/Xg7st5L3RfWdTdFDzQ73CP
   wjWaIKnU5rsNMS/SawYvgx0XuWbK/ins7SF2rovPDtrD/x7qeidyaOlIV
   etYCpEHpn3Wt6XzJuFjiFVtAWuzNCFZUJD++EVeJS+pf6t9EHzo6bS2Jw
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="250938106"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="250938106"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 15:56:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="776865742"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 23 Feb 2022 15:56:09 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D409C94; Thu, 24 Feb 2022 01:56:25 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 1/3] ACPI: platform: Constify properties parameter in acpi_create_platform_device()
Date:   Thu, 24 Feb 2022 01:56:20 +0200
Message-Id: <20220223235622.19555-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Properties are not and should not be changed in the callee, hence constify
properties parameter in acpi_create_platform_device().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/acpi_platform.c | 2 +-
 include/linux/acpi.h         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 78d621290a35..de3cbf152dee 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -95,7 +95,7 @@ static void acpi_platform_fill_resource(struct acpi_device *adev,
  * Name of the platform device will be the same as @adev's.
  */
 struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
-					struct property_entry *properties)
+						    const struct property_entry *properties)
 {
 	struct platform_device *pdev = NULL;
 	struct platform_device_info pdevinfo;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 6274758648e3..9ac545379447 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -691,7 +691,7 @@ int acpi_device_uevent_modalias(struct device *, struct kobj_uevent_env *);
 int acpi_device_modalias(struct device *, char *, int);
 
 struct platform_device *acpi_create_platform_device(struct acpi_device *,
-						    struct property_entry *);
+						    const struct property_entry *);
 #define ACPI_PTR(_ptr)	(_ptr)
 
 static inline void acpi_device_set_enumerated(struct acpi_device *adev)
@@ -930,7 +930,7 @@ static inline int acpi_device_modalias(struct device *dev,
 
 static inline struct platform_device *
 acpi_create_platform_device(struct acpi_device *adev,
-			    struct property_entry *properties)
+			    const struct property_entry *properties)
 {
 	return NULL;
 }
-- 
2.34.1

