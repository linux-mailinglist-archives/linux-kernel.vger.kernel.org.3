Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B324A77D3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 19:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346624AbiBBSXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 13:23:22 -0500
Received: from mga14.intel.com ([192.55.52.115]:3008 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346593AbiBBSXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 13:23:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643826199; x=1675362199;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xFhmPdUAlKzbe2/npbitPjG/cXTyNVW3JhbWXb9WY6k=;
  b=dhPiMHNghjF+pRVWS1dOujUZpcgUtqjELLXj1tBuilfJZ8WwOxjYNHSL
   3aEm9jZohNwtbxB8ny08qc8iJc2Hy7ZaYUEAlSNgm6Bvj3RaPkiWH4obC
   wUStI8mqleE0EQNhtTV4EXGrvin2r669yTb56jHEn9N1LKCkhSKV7UL92
   DGGcuv7H1R64bzhREDkGEKIpOYY9auRGHYji1c46mFcLgsQIM7s9EGFD1
   u7pOgjkpXySU5FyhJXhfjgDZT3SWM1o5c1mEpIN0g7ypx5EbNXoHILeMx
   WXeAvBgsXuUyOvcyKz6ScCtuTNYZqoFxjMZ5yVr0fTZ6bpDwsKZVemRHf
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="248210312"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="248210312"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 10:23:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="627166535"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 02 Feb 2022 10:23:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8E5FF3B7; Wed,  2 Feb 2022 20:23:27 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] power: supply: core: Use device_property_string_array_count()
Date:   Wed,  2 Feb 2022 20:23:25 +0200
Message-Id: <20220202182325.54680-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use device_property_string_array_count() to get number of strings
in a string array property.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/power/supply/power_supply_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index df4471e50d33..fb638774577e 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -283,8 +283,7 @@ static int power_supply_check_supplies(struct power_supply *psy)
 	if (!psy->dev.parent)
 		return 0;
 
-	nval = device_property_read_string_array(psy->dev.parent,
-						 "supplied-from", NULL, 0);
+	nval = device_property_string_array_count(psy->dev.parent, "supplied-from");
 	if (nval <= 0)
 		return 0;
 
-- 
2.34.1

