Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106EC5A4F60
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiH2Ofz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiH2Oft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:35:49 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FC982D2D;
        Mon, 29 Aug 2022 07:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661783748; x=1693319748;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=THXhtpBhqc0ktjuo3yxTQHD7L1JNjyR+0rrDZS5Xj+I=;
  b=gSkcew6lD8vR3pamIOslbMyxNcJv4/f6CnhJVBMGEOVTjSl6f0+Pnmpy
   coW57se+Omrs87bdiEWT+QwXLaXbuhOmxJsjd5mfYtVHh4skfxu7P3KDX
   iUBulOngYkeoQf4jwMuEh269D1CpGw7zTkSPpFJWZoLv0NR/E3ny+sUcT
   5v0Sjwlf1Nv+i+mhdab9awG0Z4I1JRA2MIDP9I6DZvcMEkhT2xzKNR4tN
   dvRKyhPCvgBqPa+uVbstW6kOEoI6CItOOEEZ+7XH8E6bVWREWlF/hPRmN
   gTHA6Zhi2CAAhcfRYDXUQX4c/qYQ0ClrC1efNZujOoxz1mTFnlx6IWxO5
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="275305516"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="275305516"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 07:10:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="640949904"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 29 Aug 2022 07:10:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B1268238; Mon, 29 Aug 2022 17:11:04 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 3/4] ACPI: platform: Use sizeof(*pointer) instead of sizeof(type)
Date:   Mon, 29 Aug 2022 17:10:59 +0300
Message-Id: <20220829141100.63934-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220829141100.63934-1-andriy.shevchenko@linux.intel.com>
References: <20220829141100.63934-1-andriy.shevchenko@linux.intel.com>
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

It is preferred to use sizeof(*pointer) instead of sizeof(type).
The type of the variable can change and one needs not change
the former (unlike the latter). No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
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

