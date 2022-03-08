Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FC94D1805
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 13:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240574AbiCHMjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 07:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347202AbiCHMiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 07:38:02 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F533483A2;
        Tue,  8 Mar 2022 04:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646743022; x=1678279022;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uDWmEpDZ9RZ0usVF5VnizShjyWiESSSwrgU+oXCPnMI=;
  b=RCiZ03J10w9eS5lLhkt5PMsBGaQDZhbd2MwuvyKtPz1JdiTU/lwbo+1L
   FFKFXeB0zWQHyvGUP5BFxq+ZuaGtp/OO5QL31M2lZCPbIVmE/eHospMH1
   PaBRWHUBM18VA+XVFUuioyH9L/Y97NkEGuh3FFThPeyXEr/SmHuCfhdTN
   MyvnH7dZhgxCKDuZVliPgnmzw8TQ95SedFzNuKg8H91MDkEv/xcHKe3LU
   5uBIza12JVymF/9ABa89G8WrUifC8WwaogaC67qVs73S0xjqtJm4ikc3B
   +BC9SuZohoAYj4OvUZot/oXqESwIlFLR3alPqNReazg/D1TygjUlqBG3a
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="234626781"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="234626781"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 04:37:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="495437019"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 08 Mar 2022 04:36:59 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 970941D6; Tue,  8 Mar 2022 14:37:17 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH v4 1/1] device property: Allow error pointer to be passed to fwnode APIs
Date:   Tue,  8 Mar 2022 14:37:12 +0200
Message-Id: <20220308123712.18613-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
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
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Nuno Sá <nuno.sa@analog.com>
---
v4: dropped unneeded fwnode.h and ' == true' part (Sakari), added tag (Sakari)
 drivers/base/property.c | 75 +++++++++++++++++++++++------------------
 include/linux/fwnode.h  | 10 +++---
 2 files changed, 47 insertions(+), 38 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index c0e94cce9c29..4fbdb14cdec4 100644
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
 
@@ -480,15 +485,16 @@ int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
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
-
-	return ret;
+	return fwnode_call_int_op(fwnode->secondary, get_reference_args, prop, nargs_prop,
+				  nargs, index, args);
 }
 EXPORT_SYMBOL_GPL(fwnode_property_get_reference_args);
 
@@ -698,7 +704,7 @@ fwnode_get_next_available_child_node(const struct fwnode_handle *fwnode,
 {
 	struct fwnode_handle *next_child = child;
 
-	if (!fwnode)
+	if (IS_ERR_OR_NULL(fwnode))
 		return NULL;
 
 	do {
@@ -722,16 +728,16 @@ struct fwnode_handle *device_get_next_child_node(struct device *dev,
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
 
@@ -798,6 +804,9 @@ EXPORT_SYMBOL_GPL(fwnode_handle_put);
  */
 bool fwnode_device_is_available(const struct fwnode_handle *fwnode)
 {
+	if (IS_ERR_OR_NULL(fwnode))
+		return false;
+
 	if (!fwnode_has_op(fwnode, device_is_available))
 		return true;
 
@@ -988,14 +997,14 @@ fwnode_graph_get_next_endpoint(const struct fwnode_handle *fwnode,
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
2.34.1

