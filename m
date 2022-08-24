Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E575A000A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 19:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239856AbiHXRFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 13:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239792AbiHXRFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 13:05:41 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AC46F257
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661360739; x=1692896739;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=36fc44OWkRyGtqJ6wjJt1++uMpCEpenRE6j/OCl7tvU=;
  b=TNjaRhZkbIxTVuBF8XFzvmdYPJ67zj2FXcrPtnSRjNNwSWcU/mEAF9Eh
   sk8CulkMXe/ypwZrebXUkBfZvCLkNXHw04eP9SyJS92QYeJHq2YVh/AqL
   qTMNdrXARgQugWIQBRbzQDSkF4IAfpRNxCD3kfMVZRTPZwmYqx+W0RRsM
   YBw/VDUlbdfnYl3HvhCbZK8DkOj+uY5jLwfzL0IjtDLS8VzJgF+EUI9D+
   WGj70IB8DrrALIUFUByMCmpfAzTaBJCBoI3+YOlYKORKA0dncsmTmrYXe
   b1PY3tYSVV5s8idTcMSJyXQ4p7V541Jzn3WGfNEbMD8WGN7K17MGDh+c4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="280996138"
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="280996138"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 10:05:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="713125087"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 24 Aug 2022 10:05:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 882C7174; Wed, 24 Aug 2022 20:05:50 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v1 1/1] test_printf: Refactor fwnode_pointer() to make it more readable
Date:   Wed, 24 Aug 2022 20:05:42 +0300
Message-Id: <20220824170542.18263-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converting fwnode_pointer() to use better swnode API allows to
make code more readable.

While at it, rename full_name to full_name_third to show exact
relation in the hierarchy.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/test_printf.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index fe13de1bed5f..6f7f179dd8f4 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -704,31 +704,29 @@ flags(void)
 
 static void __init fwnode_pointer(void)
 {
-	const struct software_node softnodes[] = {
-		{ .name = "first", },
-		{ .name = "second", .parent = &softnodes[0], },
-		{ .name = "third", .parent = &softnodes[1], },
-		{ NULL /* Guardian */ }
-	};
-	const char * const full_name = "first/second/third";
+	const struct software_node first = { .name = "first" };
+	const struct software_node second = { .name = "second", .parent = &first };
+	const struct software_node third = { .name = "third", .parent = &second };
+	const struct software_node *group[] = { &first, &second, &third, NULL };
 	const char * const full_name_second = "first/second";
+	const char * const full_name_third = "first/second/third";
 	const char * const second_name = "second";
 	const char * const third_name = "third";
 	int rval;
 
-	rval = software_node_register_nodes(softnodes);
+	rval = software_node_register_node_group(group);
 	if (rval) {
 		pr_warn("cannot register softnodes; rval %d\n", rval);
 		return;
 	}
 
-	test(full_name_second, "%pfw", software_node_fwnode(&softnodes[1]));
-	test(full_name, "%pfw", software_node_fwnode(&softnodes[2]));
-	test(full_name, "%pfwf", software_node_fwnode(&softnodes[2]));
-	test(second_name, "%pfwP", software_node_fwnode(&softnodes[1]));
-	test(third_name, "%pfwP", software_node_fwnode(&softnodes[2]));
+	test(full_name_second, "%pfw", software_node_fwnode(&second));
+	test(full_name_third, "%pfw", software_node_fwnode(&third));
+	test(full_name_third, "%pfwf", software_node_fwnode(&third));
+	test(second_name, "%pfwP", software_node_fwnode(&second));
+	test(third_name, "%pfwP", software_node_fwnode(&third));
 
-	software_node_unregister_nodes(softnodes);
+	software_node_unregister_node_group(group);
 }
 
 static void __init fourcc_pointer(void)
-- 
2.35.1

