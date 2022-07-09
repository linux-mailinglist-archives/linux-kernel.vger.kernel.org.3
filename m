Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9617F56CB8C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 23:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiGIVRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 17:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGIVQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 17:16:52 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35B5EE00;
        Sat,  9 Jul 2022 14:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657401411; x=1688937411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pNbMH3+R3AuT6h4yg6R/1iGHeyPPnIt46pxqiB/zgeQ=;
  b=Sg9nOTvJb3EBbPUlwgXPkEmDeCpb5yUvY8P6PzURwQwg0inpO8GBy9rj
   o5EnkQKLfrrZj7Rfdj5fVAIO2SFltcl4/U1McXnMhqjhTrWEUR77BRxGo
   ZtYtBqyK7jUOWGdgHhJq4y2+ThxCIRXT9E8J8AnQpVvQVBlKqsf5TG7ES
   fPjrz39XwtuQFSbbK4Y+LOz8D2WfvVjiIAZcV3M64U8PFHnU4H/qxlKLO
   CXPkcP2npSXPd7i/fwBNrLp2rEhiXWhlbwjJbgo+zP1sXMV7+wN5mUBRO
   Pu4GjuzscfOFkYkRuBVsPaBQwuXdA6qzoFgf22kQYNXhCUMB1OswiI2Rf
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="264872821"
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="264872821"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 14:16:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="591884919"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 09 Jul 2022 14:16:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E1B8B739; Sun, 10 Jul 2022 00:16:54 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 6/6] platform/x86: serial-multi-instantiate: Sort ACPI IDs by HID
Date:   Sun, 10 Jul 2022 00:16:53 +0300
Message-Id: <20220709211653.18938-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220709211653.18938-1-andriy.shevchenko@linux.intel.com>
References: <20220709211653.18938-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's easier to maintain the sorted table.
Keep the sorting order in sync with one in drivers/acpi/scan.c.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
v2: added tag (Hans)
 drivers/platform/x86/serial-multi-instantiate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
index 24f915bbdec1..67feed25c9db 100644
--- a/drivers/platform/x86/serial-multi-instantiate.c
+++ b/drivers/platform/x86/serial-multi-instantiate.c
@@ -324,8 +324,8 @@ static const struct smi_node cs35l41_hda = {
 static const struct acpi_device_id smi_acpi_ids[] = {
 	{ "BSG1160", (unsigned long)&bsg1160_data },
 	{ "BSG2150", (unsigned long)&bsg2150_data },
-	{ "INT3515", (unsigned long)&int3515_data },
 	{ "CSC3551", (unsigned long)&cs35l41_hda },
+	{ "INT3515", (unsigned long)&int3515_data },
 	/* Non-conforming _HID for Cirrus Logic already released */
 	{ "CLSA0100", (unsigned long)&cs35l41_hda },
 	{ }
-- 
2.35.1

