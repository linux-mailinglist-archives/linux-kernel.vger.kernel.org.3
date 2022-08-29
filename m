Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762635A4EF0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiH2OOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiH2OOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:14:47 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A14AC9;
        Mon, 29 Aug 2022 07:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661782484; x=1693318484;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n5lFkFMiDHmXDh+teOu5BNnWiyJQmubHjavTDdvL20s=;
  b=kURI0VAzfXpsQ/fF5XT3thXKBAtp80MKQVQw180a56YM13Twg+E0wHW+
   cKfu5ca3MmNmxrJJxHyQmvizDOjavhPV7MoWQRPYkAI/heaDqZ5KjevDJ
   FqQYQioUvm+GzA5WkoEbUB9LklVRB6w+qD6cOL5nF5qiKez3oHXZ6kssM
   Q2SnugTeUsZaX1cxs2T6tsAFKe7okGGdU1idgzys+l1jRmueynOU1m7pS
   3QRQSQX5QK1c+8IER3oU1Xnk2U0hUe1bAuaXb1sPOmWnff9lc3jWZnbtO
   iFM8TZ4hU0adx3cvr1F48Uj8mTrzdcyrBPw/vyIvBU7XrMasUemcrHBR8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="274651484"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="274651484"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 07:10:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="787089908"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 29 Aug 2022 07:10:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9C19D19D; Mon, 29 Aug 2022 17:11:04 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 1/4] ACPI: platform: Get rid of redundant 'else'
Date:   Mon, 29 Aug 2022 17:10:57 +0300
Message-Id: <20220829141100.63934-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the snippets like the following

	if (...)
		return / goto / break / continue ...;
	else
		...

the 'else' is redundant. Get rid of it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/acpi_platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 1a1c78b23fba..75e26528056d 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -114,9 +114,9 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
 
 	INIT_LIST_HEAD(&resource_list);
 	count = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
-	if (count < 0) {
+	if (count < 0)
 		return NULL;
-	} else if (count > 0) {
+	if (count > 0) {
 		resources = kcalloc(count, sizeof(struct resource),
 				    GFP_KERNEL);
 		if (!resources) {
-- 
2.35.1

