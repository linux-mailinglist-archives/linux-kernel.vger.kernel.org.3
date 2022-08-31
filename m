Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100B05A7F7A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiHaODW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiHaODQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:03:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B37CD5DDE;
        Wed, 31 Aug 2022 07:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661954596; x=1693490596;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6EwmQveao5l0Fwty8NY+Z7wsdjEwNp5091Gc7ah/CRU=;
  b=igyePLAtkuP+tPf0S+3BuAUd4PgQsMLbqp3vxQXPq4ZxVAxK32v68l1d
   p1f5T9AasqbqNw3FlgOav4PCXqRZjfVxRtwGZLG7oOoKSorH15txL2YK0
   RVJxnjjE5QtA1CQRj1WABl3eKUCSdSmbcVCiyLK/+VVDZoGtybRoULhZ3
   MwnjSe4TDvSYlMjHvFPBhMgdraJi8LDHMELCdSaHjBytre8w+/e6udG9P
   BMCYbaIDCM5QWuBuhLM2BPg1peIUXVcMHjgDVJ+rZjU37BxXtKQVlwXGc
   gB+wepWExZJLSazFe8YLLPRAj/fZzkL/EZsr9bYJ+UeIcM10ZujIisbNZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="282425885"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="282425885"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 07:03:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="940443522"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 31 Aug 2022 07:03:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D8D3119D; Wed, 31 Aug 2022 17:03:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v2 3/4] ACPI: platform: Use sizeof(*pointer) instead of sizeof(type)
Date:   Wed, 31 Aug 2022 17:03:26 +0300
Message-Id: <20220831140327.79149-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220831140327.79149-1-andriy.shevchenko@linux.intel.com>
References: <20220831140327.79149-1-andriy.shevchenko@linux.intel.com>
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

It is preferred to use sizeof(*pointer) instead of sizeof(type).
The type of the variable can change and one needs not change
the former (unlike the latter). No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
 drivers/acpi/acpi_platform.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 042f80588c18..0d812fe248d4 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -117,8 +117,7 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
 	if (count < 0)
 		return NULL;
 	if (count > 0) {
-		resources = kcalloc(count, sizeof(struct resource),
-				    GFP_KERNEL);
+		resources = kcalloc(count, sizeof(*resources), GFP_KERNEL);
 		if (!resources) {
 			acpi_dev_free_resource_list(&resource_list);
 			return ERR_PTR(-ENOMEM);
-- 
2.35.1

