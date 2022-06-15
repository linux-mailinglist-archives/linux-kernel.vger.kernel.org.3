Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8067F54D439
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 00:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346743AbiFOWGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 18:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238652AbiFOWGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 18:06:49 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B23C563A5;
        Wed, 15 Jun 2022 15:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655330808; x=1686866808;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1F3Ip+Ag85q874qUWiUpOUFx42ubled3GFsealoyUEY=;
  b=jLUJsN6ZtepAXju18mabDHtlsOTrwJKoAAW2mOQN2BTvL6sUwJEBtQoK
   VwUfv8n0XgmCPfVidAcYfvTeksy0A+wSwMeWhYpTnpZEpG0rH3tEiMtLD
   /h/5V4UBSgnWoJWBcFUirJv4EGakYOpqAlzRU1sxeIloqmR+r+JoxWrmP
   bCdNhFfIdttJSeXN2L70hUhnV395ufuwuKcHVeTxB67eagtVpFPHsOw7E
   TB7QDdd0S2sbyWa+cVg7Lqj/9Ui1fkeIbz7BEY8t0qu2xu6Ue/QnFuG5D
   93wBHdZIpT/mrnkxzwXjUbzgJqzRKqfcR7JegijcfjouYpmfF+3z8OYex
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="259573532"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="259573532"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 15:06:48 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="583398809"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 15:06:47 -0700
Date:   Wed, 15 Jun 2022 15:06:46 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Darren Hart <darren@os.amperecomputing.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Doug Rady <dcrady@os.amperecomputing.com>
Subject: Re: [PATCH] ACPI/APEI: Limit printable size of BERT table data
Message-ID: <YqpX9npa/wR7mafR@agluck-desk3.sc.intel.com>
References: <43dfaba0646d498fe94c1a8479b812346133f438.1646765290.git.darren@os.amperecomputing.com>
 <CAJZ5v0gMh2ed+ZWOnd-t_uTrZtm=AUfxOAkAKWT7WQK3=gf+7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gMh2ed+ZWOnd-t_uTrZtm=AUfxOAkAKWT7WQK3=gf+7w@mail.gmail.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 07:42:26PM +0100, Rafael J. Wysocki wrote:
> On Tue, Mar 8, 2022 at 7:51 PM Darren Hart

> Not that I have a particularly strong opinion here, but this looks
> reasonable to me, so I've queued it up for 5.18.
> 
> APEI reviewers, please chime in if you disagree with the above.

It looked reasonable to me when I skimmed it in March. But the
reality check now needs cashing because some validation team
here is complaining that they don't see any errors printed from
their BERT tests. :-(

So I looked again. This test inside the loop seems bogus:

	if (region_len < ACPI_BERT_PRINT_MAX_LEN) {

because "region_len" isn't updated inside the loop. If it is too big
then it will prevent Linux from printing any/all of the records in the
BERT table (and the test could have been done before the loop).

Maybe below patch is better? It avoids printing individual CPER
records that are too large (checking estatus_len instead of region_len).

I also added a limit to how many records to print (I randomly picked "5" as
the limit ... the specific failing test only want to print one).

-Tony

[I will write up a proper commit message and add a Signed-off-by if
this looks to be a reasonable direction]

diff --git a/drivers/acpi/apei/bert.c b/drivers/acpi/apei/bert.c
index 598fd19b65fa..4e894a728c02 100644
--- a/drivers/acpi/apei/bert.c
+++ b/drivers/acpi/apei/bert.c
@@ -29,6 +29,8 @@
 
 #undef pr_fmt
 #define pr_fmt(fmt) "BERT: " fmt
+
+#define ACPI_BERT_PRINT_MAX_RECORDS 5
 #define ACPI_BERT_PRINT_MAX_LEN 1024
 
 static int bert_disable;
@@ -39,6 +41,7 @@ static void __init bert_print_all(struct acpi_bert_region *region,
 	struct acpi_hest_generic_status *estatus =
 		(struct acpi_hest_generic_status *)region;
 	int remain = region_len;
+	int ncper = 0, skipped = 0;
 	u32 estatus_len;
 
 	while (remain >= sizeof(struct acpi_bert_region)) {
@@ -46,24 +49,23 @@ static void __init bert_print_all(struct acpi_bert_region *region,
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
 
 		pr_info_once("Error records from previous boot:\n");
-		if (region_len < ACPI_BERT_PRINT_MAX_LEN)
+		if (ncper++ < ACPI_BERT_PRINT_MAX_RECORDS && estatus_len < ACPI_BERT_PRINT_MAX_LEN)
 			cper_estatus_print(KERN_INFO HW_ERR, estatus);
 		else
-			pr_info_once("Max print length exceeded, table data is available at:\n"
-				     "/sys/firmware/acpi/tables/data/BERT");
+			skipped++;
 
 		/*
 		 * Because the boot error source is "one-time polled" type,
@@ -75,6 +77,9 @@ static void __init bert_print_all(struct acpi_bert_region *region,
 		estatus = (void *)estatus + estatus_len;
 		remain -= estatus_len;
 	}
+	if (skipped)
+		pr_info("Skipped %d error records, full table data is available at:\n"
+			"/sys/firmware/acpi/tables/data/BERT", skipped);
 }
 
 static int __init setup_bert_disable(char *str)
