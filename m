Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34584555200
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377102AbiFVRKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377163AbiFVRKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:10:04 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABA041F91;
        Wed, 22 Jun 2022 10:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655917752; x=1687453752;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GuhujeoTeqcnmWPVCbag/SuSIX6nu8OxcQUPGZZah2E=;
  b=NvxdOht+KONCsIYJrsOb4xikuq1b8c35EPdrp5drTN1H6v67mIC1dHXY
   pxAmDshbaJOlFx23mbMpLi9MZoYl6jSriKTGIv2f9nuS5KaVPeHWZROdB
   ySIbJDVRWIxTGfBennRivR01t9kHHvqj3KPyDccZMUm+yvFz4HAo1oHjc
   tyTiq9DweDDd1dVbY77wq/eYMCbYTFXjQLMwqkZ6OeamwZHkR0JKPVD43
   I7ypNOPA5/y1A+tFoIB/4z0RymjUD4k0ReOv1IvuQnN7WRmDnjYlrRR3j
   LU1x8hJasge8AeovYbN+Ygs/YcH6GwaDKkIfpQYxujs9rqk2ZXtXkdgbR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="278026643"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="278026643"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 10:09:12 -0700
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="644296730"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 10:09:12 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Darren Hart <darren@os.amperecomputing.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Doug Rady <dcrady@os.amperecomputing.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH] ACPI/APEI: Better fix to avoid spamming the console with old error logs
Date:   Wed, 22 Jun 2022 10:09:06 -0700
Message-Id: <20220622170906.33759-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <YqpX9npa/wR7mafR@agluck-desk3.sc.intel.com>
References: <YqpX9npa/wR7mafR@agluck-desk3.sc.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fix in commit 3f8dec116210 ("ACPI/APEI: Limit printable size of BERT
table data") does not work as intended on systems where the BIOS has a
fixed size block of memory for the BERT table, relying on s/w to quit
when it finds a record with estatus->block_status == 0. On these systems
all errors are suppressed because the check:

	if (region_len < ACPI_BERT_PRINT_MAX_LEN)

always fails.

New scheme skips individual CPER records that are too large, and also
limits the total number of records that will be printed to 5.

Fixes: 3f8dec116210 ("ACPI/APEI: Limit printable size of BERT table data")
Cc: stable@vger.kernel.org
Signed-off-by: Tony Luck <tony.luck@intel.com>
---

Now in PATCH format with a real commit comment. This version fixes
the issues seen by Intel's validation team.

 drivers/acpi/apei/bert.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/apei/bert.c b/drivers/acpi/apei/bert.c
index 598fd19b65fa..45973aa6e06d 100644
--- a/drivers/acpi/apei/bert.c
+++ b/drivers/acpi/apei/bert.c
@@ -29,16 +29,26 @@
 
 #undef pr_fmt
 #define pr_fmt(fmt) "BERT: " fmt
+
+#define ACPI_BERT_PRINT_MAX_RECORDS 5
 #define ACPI_BERT_PRINT_MAX_LEN 1024
 
 static int bert_disable;
 
+/*
+ * Print "all" the error records in the BERT table, but avoid huge spam to
+ * the console if the BIOS included oversize records, or too many records.
+ * Skipping some records here does not lose anything because the full
+ * data is available to user tools in:
+ *	/sys/firmware/acpi/tables/data/BERT
+ */
 static void __init bert_print_all(struct acpi_bert_region *region,
 				  unsigned int region_len)
 {
 	struct acpi_hest_generic_status *estatus =
 		(struct acpi_hest_generic_status *)region;
 	int remain = region_len;
+	int printed = 0, skipped = 0;
 	u32 estatus_len;
 
 	while (remain >= sizeof(struct acpi_bert_region)) {
@@ -46,24 +56,26 @@ static void __init bert_print_all(struct acpi_bert_region *region,
 		if (remain < estatus_len) {
 			pr_err(FW_BUG "Truncated status block (length: %u).\n",
 			       estatus_len);
-			return;
+			break;
 		}
 
 		/* No more error records. */
 		if (!estatus->block_status)
-			return;
+			break;
 
 		if (cper_estatus_check(estatus)) {
 			pr_err(FW_BUG "Invalid error record.\n");
-			return;
+			break;
 		}
 
-		pr_info_once("Error records from previous boot:\n");
-		if (region_len < ACPI_BERT_PRINT_MAX_LEN)
+		if (estatus_len < ACPI_BERT_PRINT_MAX_LEN &&
+		    printed < ACPI_BERT_PRINT_MAX_RECORDS) {
+			pr_info_once("Error records from previous boot:\n");
 			cper_estatus_print(KERN_INFO HW_ERR, estatus);
-		else
-			pr_info_once("Max print length exceeded, table data is available at:\n"
-				     "/sys/firmware/acpi/tables/data/BERT");
+			printed++;
+		} else {
+			skipped++;
+		}
 
 		/*
 		 * Because the boot error source is "one-time polled" type,
@@ -75,6 +87,9 @@ static void __init bert_print_all(struct acpi_bert_region *region,
 		estatus = (void *)estatus + estatus_len;
 		remain -= estatus_len;
 	}
+
+	if (skipped)
+		pr_info(HW_ERR "Skipped %d error records\n", skipped);
 }
 
 static int __init setup_bert_disable(char *str)
-- 
2.35.3

