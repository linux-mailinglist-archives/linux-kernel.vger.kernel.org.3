Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34B5566A11
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbiGELnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbiGELnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:43:18 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844EC17058
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 04:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657021397; x=1688557397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y310cvIMTK9zFP0m805qiHOhQfwK46n1+io9S8eQEdg=;
  b=U9Dabk3E63ttGQcjNHjwl/GK5Nl+LxZ7CiFPmMwWnyZt0sbSezsP6fpo
   cT7t/d8g6BB+UuDZg4D80bjc1wZ9GMVrumyI+jAOcsDDFLZtG3KJjDzsX
   k1KN+OM3TUVYBTvjkJr/6q2EKGA9p1ebmCK5xZW41yIQ4S9LIuclSBEDh
   oQFwphWbno+GTCr8o94Gc9ASQO+ZO6fCB9Q6LkCQbh+XiesNFnirugmi0
   PE6HOIlZtScomLrE2hmT4XKDtEU07u8qaFcaoEsfbaytAxvkkTktdvW0e
   seQBAA1RMgwC2Y7CvoYI2nlCJnXtLMMrAQBTME2jCsWeY+N5kzRSSJP4I
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="280883996"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="280883996"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 04:43:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="695633708"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 05 Jul 2022 04:43:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id ABDEF481; Tue,  5 Jul 2022 14:43:22 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     john.garry@huawei.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/4] bus: hisi_lpc: Don't guard ACPI IDs with ACPI_PTR()
Date:   Tue,  5 Jul 2022 14:43:12 +0300
Message-Id: <20220705114312.86164-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220705114312.86164-1-andriy.shevchenko@linux.intel.com>
References: <20220705114312.86164-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OF is not guarded neither ACPI needs. The IDs do not depend
to the configuration. Hence drop ACPI_PTR() from the code and
move ID table closer to its user.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/bus/hisi_lpc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index a6513a571d7b..74f4448bff9d 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -589,11 +589,6 @@ static int hisi_lpc_acpi_probe(struct device *hostdev)
 
 	return ret;
 }
-
-static const struct acpi_device_id hisi_lpc_acpi_match[] = {
-	{"HISI0191"},
-	{}
-};
 #else
 static int hisi_lpc_acpi_probe(struct device *dev)
 {
@@ -688,11 +683,16 @@ static const struct of_device_id hisi_lpc_of_match[] = {
 	{}
 };
 
+static const struct acpi_device_id hisi_lpc_acpi_match[] = {
+	{"HISI0191"},
+	{}
+};
+
 static struct platform_driver hisi_lpc_driver = {
 	.driver = {
 		.name           = DRV_NAME,
 		.of_match_table = hisi_lpc_of_match,
-		.acpi_match_table = ACPI_PTR(hisi_lpc_acpi_match),
+		.acpi_match_table = hisi_lpc_acpi_match,
 	},
 	.probe = hisi_lpc_probe,
 	.remove = hisi_lpc_remove,
-- 
2.35.1

