Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688DD5A7F79
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiHaODS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiHaODQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:03:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA80D5EB8;
        Wed, 31 Aug 2022 07:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661954595; x=1693490595;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RbY/aWnpX9nBBwm/4aR1TT5UBpgs0Ub5zqkXni9Jkno=;
  b=C+hhsvwgk+cvEYSxGuf9X3jSov0NpC8Pyc8DMwiy+lcL5MUEtqjKtQlI
   3X0hvDdL2GGQTKLpq0mlaMdcHddGV58vxkkhTVi1XLYhKKViqSR3T9f7K
   ssaTQu1Q6RkoGBJHUB4wiAhFcSYN6P0AT6YA6wp4ikf9thVNBU32wV0rJ
   j2eNI3POxQ7q8YaJpWbobxGg/ifvQM0sX8fdYAxZsHxQRZxfihNAGZ0mA
   tCNPdw2in37DvOeA9laI/6U6bku4n1/2HZK3U2xdRFir9En71NsJF8eVN
   IQ0xREFMQ1sUyhj2cHhj3SWM8SE+0RsAM4v2wSLtfgPph5W0/G7SEDb1i
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="294192360"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="294192360"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 07:03:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="673363568"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 31 Aug 2022 07:03:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C48AA174; Wed, 31 Aug 2022 17:03:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v2 1/4] ACPI: platform: Get rid of redundant 'else'
Date:   Wed, 31 Aug 2022 17:03:24 +0300
Message-Id: <20220831140327.79149-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

In the snippets like the following

	if (...)
		return / goto / break / continue ...;
	else
		...

the 'else' is redundant. Get rid of it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
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

