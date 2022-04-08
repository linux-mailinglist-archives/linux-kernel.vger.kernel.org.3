Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979B64F9D41
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239033AbiDHSwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238968AbiDHSvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:51:41 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BB51C7BB4;
        Fri,  8 Apr 2022 11:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649443777; x=1680979777;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l8z8ftbks1EAwb7W96SGXJ+GE4XMqxepqwuGNCmGlpA=;
  b=C8scYBY8v/c43OMKZGlWwCSFgvsTwPzpbxalQyYhawuxRq5zjsdabrhj
   BWeN2yP0veQefdd+GJadijwMO1nU5fBPy1+wjtDym4WLqRqfyW/3DsCpI
   1gGsYihaNxB5P7KvT1CDoV8vYTXmgyamDJ5g8Rhn39wPwmIJFdsVdoR7j
   8B1M/2is1z/PhZ7MfkESmS8SbkbRksQVUVUaM4i5q7X+TCDdAV6mm6uJk
   uUBArkVZNGdG16d3RHhJLMKoFDbPNLsCGLPkXhkVUSTdLADmOjeFiXYz8
   vWGO8A3oHHlGLvOSq+sTjKKK3o+375hrpiL5IToRb51rsg4y4D/296+ij
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="241602056"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="241602056"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 11:49:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="557883587"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 08 Apr 2022 11:49:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3C321120; Fri,  8 Apr 2022 21:48:46 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v6 2/5] device property: Introduce fwnode_for_each_parent_node()
Date:   Fri,  8 Apr 2022 21:48:41 +0300
Message-Id: <20220408184844.22829-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220408184844.22829-1-andriy.shevchenko@linux.intel.com>
References: <20220408184844.22829-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a few cases the functionality of fwnode_for_each_parent_node()
is already in use. Introduce a common helper macro for it.

It may be used by others as well in the future.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
v6: added tag (Sakari)
 drivers/base/property.c  | 56 +++++++++++++++++++++-------------------
 include/linux/property.h |  9 +++++--
 2 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 6ecc1398b0ba..f0ac31d28798 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -596,17 +596,17 @@ EXPORT_SYMBOL_GPL(fwnode_get_next_parent);
  */
 struct device *fwnode_get_next_parent_dev(struct fwnode_handle *fwnode)
 {
+	struct fwnode_handle *parent;
 	struct device *dev;
 
-	fwnode_handle_get(fwnode);
-	do {
-		fwnode = fwnode_get_next_parent(fwnode);
-		if (!fwnode)
-			return NULL;
+	fwnode_for_each_parent_node(fwnode, parent) {
 		dev = get_dev_from_fwnode(fwnode);
-	} while (!dev);
-	fwnode_handle_put(fwnode);
-	return dev;
+		if (dev) {
+			fwnode_handle_put(parent);
+			return dev;
+		}
+	}
+	return NULL;
 }
 
 /**
@@ -617,13 +617,11 @@ struct device *fwnode_get_next_parent_dev(struct fwnode_handle *fwnode)
  */
 unsigned int fwnode_count_parents(const struct fwnode_handle *fwnode)
 {
-	struct fwnode_handle *__fwnode;
-	unsigned int count;
-
-	__fwnode = fwnode_get_parent(fwnode);
+	struct fwnode_handle *parent;
+	unsigned int count = 0;
 
-	for (count = 0; __fwnode; count++)
-		__fwnode = fwnode_get_next_parent(__fwnode);
+	fwnode_for_each_parent_node(fwnode, parent)
+		count++;
 
 	return count;
 }
@@ -644,15 +642,16 @@ EXPORT_SYMBOL_GPL(fwnode_count_parents);
 struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwnode,
 					    unsigned int depth)
 {
-	fwnode_handle_get(fwnode);
+	struct fwnode_handle *parent;
 
-	do {
-		if (depth-- == 0)
-			break;
-		fwnode = fwnode_get_next_parent(fwnode);
-	} while (fwnode);
+	if (depth == 0)
+		return fwnode_handle_get(fwnode);
 
-	return fwnode;
+	fwnode_for_each_parent_node(fwnode, parent) {
+		if (--depth == 0)
+			return parent;
+	}
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(fwnode_get_nth_parent);
 
@@ -669,17 +668,20 @@ EXPORT_SYMBOL_GPL(fwnode_get_nth_parent);
 bool fwnode_is_ancestor_of(struct fwnode_handle *test_ancestor,
 				  struct fwnode_handle *test_child)
 {
+	struct fwnode_handle *parent;
+
 	if (IS_ERR_OR_NULL(test_ancestor))
 		return false;
 
-	fwnode_handle_get(test_child);
-	do {
-		if (test_child == test_ancestor) {
-			fwnode_handle_put(test_child);
+	if (test_child == test_ancestor)
+		return true;
+
+	fwnode_for_each_parent_node(test_child, parent) {
+		if (parent == test_ancestor) {
+			fwnode_handle_put(parent);
 			return true;
 		}
-		test_child = fwnode_get_next_parent(test_child);
-	} while (test_child);
+	}
 	return false;
 }
 
diff --git a/include/linux/property.h b/include/linux/property.h
index 4cd4b326941f..15d6863ae962 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -83,9 +83,14 @@ struct fwnode_handle *fwnode_find_reference(const struct fwnode_handle *fwnode,
 
 const char *fwnode_get_name(const struct fwnode_handle *fwnode);
 const char *fwnode_get_name_prefix(const struct fwnode_handle *fwnode);
+
 struct fwnode_handle *fwnode_get_parent(const struct fwnode_handle *fwnode);
-struct fwnode_handle *fwnode_get_next_parent(
-	struct fwnode_handle *fwnode);
+struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode);
+
+#define fwnode_for_each_parent_node(fwnode, parent)		\
+	for (parent = fwnode_get_parent(fwnode); parent;	\
+	     parent = fwnode_get_next_parent(parent))
+
 struct device *fwnode_get_next_parent_dev(struct fwnode_handle *fwnode);
 unsigned int fwnode_count_parents(const struct fwnode_handle *fwn);
 struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwn,
-- 
2.35.1

