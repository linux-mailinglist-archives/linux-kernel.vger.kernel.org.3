Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337154F63E9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbiDFPnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236258AbiDFPnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:43:18 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186E34E6F74;
        Wed,  6 Apr 2022 06:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649250681; x=1680786681;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xrVO3PD15uLGC0xOV5+sEkLrkVM/AfGYyeEPTlYt8Po=;
  b=ZhlbYAiyr4LRl54UxngjZEx8/nKQKs2w8QrjL26baI0/32kOR5qri8Lb
   K/zrERCQjTucs48sZqavlgVzx6IkIbMZsHX39dP3n3HOcrxM2mfWRBC/F
   FX9irX4MRSxHuckcDWgSZ7SpyLcmpt/mwlCLZ/il6pEmdi+U+QlLqQ5WH
   xeIqDY+uqwoG7F2+qkuj0ka/S8AMQXg/5yCJs8Q7uPwyR2nOI0AGYayXF
   pYKhhhA0x4PDWCFHXlRU0C8yO5K+ui4QTY77QH0lf9qAR4HYoXUeZRdST
   2vzYnh99AfkqQ5VqWsDUf5YioeaaPVzOmcKQhbDSQrO5CibciPDZlDjCP
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="261032517"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="261032517"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 06:09:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="642045293"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Apr 2022 06:09:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 626B216D; Wed,  6 Apr 2022 16:05:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Michael Walle <michael@walle.cc>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH v5 1/4] device property: Allow error pointer to be passed to fwnode APIs
Date:   Wed,  6 Apr 2022 16:05:49 +0300
Message-Id: <20220406130552.30930-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the fwnode APIs might return an error pointer instead of NULL
or valid fwnode handle. The result of such API call may be considered
optional and hence the test for it is usually done in a form of

	fwnode = fwnode_find_reference(...);
	if (IS_ERR(fwnode))
		...error handling...

Nevertheless the resulting fwnode may have bumped the reference count
and hence caller of the above API is obliged to call fwnode_handle_put().
Since fwnode may be not valid either as NULL or error pointer the check
has to be performed there. This approach uglifies the code and adds
a point of making a mistake, i.e. forgetting about error point case.

To prevent this, allow an error pointer to be passed to the fwnode APIs.

Fixes: 83b34afb6b79 ("device property: Introduce fwnode_find_reference()")
Reported-by: Nuno Sá <nuno.sa@analog.com>
Tested-by: Nuno Sá <nuno.sa@analog.com>
Acked-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v5: fixed return value in _get_reference_args() for secondary check (Michael)
 drivers/base/property.c | 89 +++++++++++++++++++++++------------------
 include/linux/fwnode.h  | 10 ++---
 2 files changed, 56 insertions(+), 43 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index c0e94cce9c29..3376d3971a93 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -47,12 +47,14 @@ bool fwnode_property_present(const struct fwnode_handle *fwnode,
 {
 	bool ret;
 
+	if (IS_ERR_OR_NULL(fwnode))
+		return false;
+
 	ret = fwnode_call_bool_op(fwnode, property_present, propname);
-	if (ret == false && !IS_ERR_OR_NULL(fwnode) &&
-	    !IS_ERR_OR_NULL(fwnode->secondary))
-		ret = fwnode_call_bool_op(fwnode->secondary, property_present,
-					 propname);
-	return ret;
+	if (ret)
+		return ret;
+
+	return fwnode_call_bool_op(fwnode->secondary, property_present, propname);
 }
 EXPORT_SYMBOL_GPL(fwnode_property_present);
 
@@ -232,15 +234,16 @@ static int fwnode_property_read_int_array(const struct fwnode_handle *fwnode,
 {
 	int ret;
 
+	if (IS_ERR_OR_NULL(fwnode))
+		return -EINVAL;
+
 	ret = fwnode_call_int_op(fwnode, property_read_int_array, propname,
 				 elem_size, val, nval);
-	if (ret == -EINVAL && !IS_ERR_OR_NULL(fwnode) &&
-	    !IS_ERR_OR_NULL(fwnode->secondary))
-		ret = fwnode_call_int_op(
-			fwnode->secondary, property_read_int_array, propname,
-			elem_size, val, nval);
+	if (ret != -EINVAL)
+		return ret;
 
-	return ret;
+	return fwnode_call_int_op(fwnode->secondary, property_read_int_array, propname,
+				  elem_size, val, nval);
 }
 
 /**
@@ -371,14 +374,16 @@ int fwnode_property_read_string_array(const struct fwnode_handle *fwnode,
 {
 	int ret;
 
+	if (IS_ERR_OR_NULL(fwnode))
+		return -EINVAL;
+
 	ret = fwnode_call_int_op(fwnode, property_read_string_array, propname,
 				 val, nval);
-	if (ret == -EINVAL && !IS_ERR_OR_NULL(fwnode) &&
-	    !IS_ERR_OR_NULL(fwnode->secondary))
-		ret = fwnode_call_int_op(fwnode->secondary,
-					 property_read_string_array, propname,
-					 val, nval);
-	return ret;
+	if (ret != -EINVAL)
+		return ret;
+
+	return fwnode_call_int_op(fwnode->secondary, property_read_string_array, propname,
+				  val, nval);
 }
 EXPORT_SYMBOL_GPL(fwnode_property_read_string_array);
 
@@ -480,15 +485,19 @@ int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
 {
 	int ret;
 
+	if (IS_ERR_OR_NULL(fwnode))
+		return -ENOENT;
+
 	ret = fwnode_call_int_op(fwnode, get_reference_args, prop, nargs_prop,
 				 nargs, index, args);
+	if (ret == 0)
+		return ret;
 
-	if (ret < 0 && !IS_ERR_OR_NULL(fwnode) &&
-	    !IS_ERR_OR_NULL(fwnode->secondary))
-		ret = fwnode_call_int_op(fwnode->secondary, get_reference_args,
-					 prop, nargs_prop, nargs, index, args);
+	if (IS_ERR_OR_NULL(fwnode->secondary))
+		return -ENOENT;
 
-	return ret;
+	return fwnode_call_int_op(fwnode->secondary, get_reference_args, prop, nargs_prop,
+				  nargs, index, args);
 }
 EXPORT_SYMBOL_GPL(fwnode_property_get_reference_args);
 
@@ -635,12 +644,13 @@ EXPORT_SYMBOL_GPL(fwnode_count_parents);
 struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwnode,
 					    unsigned int depth)
 {
-	unsigned int i;
-
 	fwnode_handle_get(fwnode);
 
-	for (i = 0; i < depth && fwnode; i++)
+	do {
+		if (depth-- == 0)
+			break;
 		fwnode = fwnode_get_next_parent(fwnode);
+	} while (fwnode);
 
 	return fwnode;
 }
@@ -659,17 +669,17 @@ EXPORT_SYMBOL_GPL(fwnode_get_nth_parent);
 bool fwnode_is_ancestor_of(struct fwnode_handle *test_ancestor,
 				  struct fwnode_handle *test_child)
 {
-	if (!test_ancestor)
+	if (IS_ERR_OR_NULL(test_ancestor))
 		return false;
 
 	fwnode_handle_get(test_child);
-	while (test_child) {
+	do {
 		if (test_child == test_ancestor) {
 			fwnode_handle_put(test_child);
 			return true;
 		}
 		test_child = fwnode_get_next_parent(test_child);
-	}
+	} while (test_child);
 	return false;
 }
 
@@ -698,7 +708,7 @@ fwnode_get_next_available_child_node(const struct fwnode_handle *fwnode,
 {
 	struct fwnode_handle *next_child = child;
 
-	if (!fwnode)
+	if (IS_ERR_OR_NULL(fwnode))
 		return NULL;
 
 	do {
@@ -722,16 +732,16 @@ struct fwnode_handle *device_get_next_child_node(struct device *dev,
 	const struct fwnode_handle *fwnode = dev_fwnode(dev);
 	struct fwnode_handle *next;
 
+	if (IS_ERR_OR_NULL(fwnode))
+		return NULL;
+
 	/* Try to find a child in primary fwnode */
 	next = fwnode_get_next_child_node(fwnode, child);
 	if (next)
 		return next;
 
 	/* When no more children in primary, continue with secondary */
-	if (fwnode && !IS_ERR_OR_NULL(fwnode->secondary))
-		next = fwnode_get_next_child_node(fwnode->secondary, child);
-
-	return next;
+	return fwnode_get_next_child_node(fwnode->secondary, child);
 }
 EXPORT_SYMBOL_GPL(device_get_next_child_node);
 
@@ -798,6 +808,9 @@ EXPORT_SYMBOL_GPL(fwnode_handle_put);
  */
 bool fwnode_device_is_available(const struct fwnode_handle *fwnode)
 {
+	if (IS_ERR_OR_NULL(fwnode))
+		return false;
+
 	if (!fwnode_has_op(fwnode, device_is_available))
 		return true;
 
@@ -988,14 +1001,14 @@ fwnode_graph_get_next_endpoint(const struct fwnode_handle *fwnode,
 		parent = fwnode_graph_get_port_parent(prev);
 	else
 		parent = fwnode;
+	if (IS_ERR_OR_NULL(parent))
+		return NULL;
 
 	ep = fwnode_call_ptr_op(parent, graph_get_next_endpoint, prev);
+	if (ep)
+		return ep;
 
-	if (IS_ERR_OR_NULL(ep) &&
-	    !IS_ERR_OR_NULL(parent) && !IS_ERR_OR_NULL(parent->secondary))
-		ep = fwnode_graph_get_next_endpoint(parent->secondary, NULL);
-
-	return ep;
+	return fwnode_graph_get_next_endpoint(parent->secondary, NULL);
 }
 EXPORT_SYMBOL_GPL(fwnode_graph_get_next_endpoint);
 
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
2.35.1

