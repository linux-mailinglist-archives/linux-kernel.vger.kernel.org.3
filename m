Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAB94CDABC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241264AbiCDReF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241222AbiCDRds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:33:48 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4AB1BEB5;
        Fri,  4 Mar 2022 09:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646415166; x=1677951166;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WxH94sQT9bd80kpGay6iFp+GMfyabjLVSaP0PrDfODE=;
  b=g8C3hNPdqoeimuZXNIcuXKdAQNhEcAdtZp7+zd87JL4ORoJU5t3SaxNQ
   JW04lnbhSJMUyAnejCPjGNvSrUT5WPUvZTOIE9Prn6TZPaDAxDqLxdVMp
   qLOfL7TFIRl8pZPyzn8bcNdqcTY6GMavdn96jqSGED34DtAB0e2lHcSYd
   rotV6B6O1t/6ss95WOOIkygnkXrt31R/NsjJibMUNm2jDIhFBdywg4YY3
   8V16ZNqG49FxDo1TDigxczgHAmKRBJC1RuDm7A1aMoshGyVPndGp49ESM
   X8p9hLqI07fJFdwbGFLzzfs9ZL/VU05V8kFhZ93WSKPjris1XyKGdKIf8
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="241445927"
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="241445927"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 09:32:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="552298153"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 04 Mar 2022 09:32:40 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 80034A7; Fri,  4 Mar 2022 19:32:58 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH v2 1/1] device property: Allow error pointer to be passed to fwnode APIs
Date:   Fri,  4 Mar 2022 19:32:56 +0200
Message-Id: <20220304173256.39059-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the fwnode APIs might return an error pointer instead of NULL
or valid fwnode handle. The result of such API call may be considered
optional and hence the test for it is usually done in a form of

	fwnode = fwnode_find_reference(...);
	if (IS_ERR_OR_NULL(fwnode))
		...error handling...

Nevertheless the resulting fwnode may have bumped reference count and
hence caller of the above API is obliged to call fwnode_handle_put().
Since fwnode may be not valid either as NULL or error pointer the check
has to be performed there. This approach uglifies the code and adds
a point of making a mistake, i.e. forgetting about error point case.

To prevent this allow error pointer to be passed to the fwnode APIs.

Fixes: 83b34afb6b79 ("device property: Introduce fwnode_find_reference()")
Reported-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: adjusted the entire fwnode API (Sakari)

Nuno, can you test this with the ltc2983 series, including the IS_ERR_OR_NULL()
fix to it?

 drivers/base/property.c | 45 +++++++++++++++++++++++++----------------
 include/linux/fwnode.h  | 10 ++++-----
 2 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index c0e94cce9c29..1922818470b0 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -9,6 +9,7 @@
 
 #include <linux/acpi.h>
 #include <linux/export.h>
+#include <linux/fwnode.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -45,14 +46,16 @@ EXPORT_SYMBOL_GPL(device_property_present);
 bool fwnode_property_present(const struct fwnode_handle *fwnode,
 			     const char *propname)
 {
-	bool ret;
+	if (IS_ERR_OR_NULL(fwnode))
+		return false;
 
-	ret = fwnode_call_bool_op(fwnode, property_present, propname);
-	if (ret == false && !IS_ERR_OR_NULL(fwnode) &&
-	    !IS_ERR_OR_NULL(fwnode->secondary))
-		ret = fwnode_call_bool_op(fwnode->secondary, property_present,
-					 propname);
-	return ret;
+	if (fwnode_call_bool_op(fwnode, property_present, propname))
+		return true;
+
+	if (IS_ERR_OR_NULL(fwnode->secondary))
+		return false;
+
+	return fwnode_call_bool_op(fwnode->secondary, property_present, propname);
 }
 EXPORT_SYMBOL_GPL(fwnode_property_present);
 
@@ -232,10 +235,12 @@ static int fwnode_property_read_int_array(const struct fwnode_handle *fwnode,
 {
 	int ret;
 
+	if (IS_ERR_OR_NULL(fwnode))
+		return -EINVAL;
+
 	ret = fwnode_call_int_op(fwnode, property_read_int_array, propname,
 				 elem_size, val, nval);
-	if (ret == -EINVAL && !IS_ERR_OR_NULL(fwnode) &&
-	    !IS_ERR_OR_NULL(fwnode->secondary))
+	if (ret == -EINVAL && !IS_ERR_OR_NULL(fwnode->secondary))
 		ret = fwnode_call_int_op(
 			fwnode->secondary, property_read_int_array, propname,
 			elem_size, val, nval);
@@ -371,10 +376,12 @@ int fwnode_property_read_string_array(const struct fwnode_handle *fwnode,
 {
 	int ret;
 
+	if (IS_ERR_OR_NULL(fwnode))
+		return -EINVAL;
+
 	ret = fwnode_call_int_op(fwnode, property_read_string_array, propname,
 				 val, nval);
-	if (ret == -EINVAL && !IS_ERR_OR_NULL(fwnode) &&
-	    !IS_ERR_OR_NULL(fwnode->secondary))
+	if (ret == -EINVAL && !IS_ERR_OR_NULL(fwnode->secondary))
 		ret = fwnode_call_int_op(fwnode->secondary,
 					 property_read_string_array, propname,
 					 val, nval);
@@ -480,11 +487,12 @@ int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
 {
 	int ret;
 
+	if (IS_ERR_OR_NULL(fwnode))
+		return -ENOENT;
+
 	ret = fwnode_call_int_op(fwnode, get_reference_args, prop, nargs_prop,
 				 nargs, index, args);
-
-	if (ret < 0 && !IS_ERR_OR_NULL(fwnode) &&
-	    !IS_ERR_OR_NULL(fwnode->secondary))
+	if (ret < 0 && !IS_ERR_OR_NULL(fwnode->secondary))
 		ret = fwnode_call_int_op(fwnode->secondary, get_reference_args,
 					 prop, nargs_prop, nargs, index, args);
 
@@ -798,6 +806,9 @@ EXPORT_SYMBOL_GPL(fwnode_handle_put);
  */
 bool fwnode_device_is_available(const struct fwnode_handle *fwnode)
 {
+	if (IS_ERR_OR_NULL(fwnode))
+		return false;
+
 	if (!fwnode_has_op(fwnode, device_is_available))
 		return true;
 
@@ -988,11 +999,11 @@ fwnode_graph_get_next_endpoint(const struct fwnode_handle *fwnode,
 		parent = fwnode_graph_get_port_parent(prev);
 	else
 		parent = fwnode;
+	if (IS_ERR_OR_NULL(parent))
+		return NULL;
 
 	ep = fwnode_call_ptr_op(parent, graph_get_next_endpoint, prev);
-
-	if (IS_ERR_OR_NULL(ep) &&
-	    !IS_ERR_OR_NULL(parent) && !IS_ERR_OR_NULL(parent->secondary))
+	if (!ep && !IS_ERR_OR_NULL(parent->secondary))
 		ep = fwnode_graph_get_next_endpoint(parent->secondary, NULL);
 
 	return ep;
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 3a532ba66f6c..7defac04f9a3 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -148,12 +148,12 @@ struct fwnode_operations {
 	int (*add_links)(struct fwnode_handle *fwnode);
 };
 
-#define fwnode_has_op(fwnode, op)				\
-	((fwnode) && (fwnode)->ops && (fwnode)->ops->op)
+#define fwnode_has_op(fwnode, op)					\
+	(!IS_ERR_OR_NULL(fwnode) && (fwnode)->ops && (fwnode)->ops->op)
+
 #define fwnode_call_int_op(fwnode, op, ...)				\
-	(fwnode ? (fwnode_has_op(fwnode, op) ?				\
-		   (fwnode)->ops->op(fwnode, ## __VA_ARGS__) : -ENXIO) : \
-	 -EINVAL)
+	(fwnode_has_op(fwnode, op) ?					\
+	 (fwnode)->ops->op(fwnode, ## __VA_ARGS__) : (IS_ERR_OR_NULL(fwnode) ? -EINVAL : -ENXIO))
 
 #define fwnode_call_bool_op(fwnode, op, ...)		\
 	(fwnode_has_op(fwnode, op) ?			\
-- 
2.34.1

