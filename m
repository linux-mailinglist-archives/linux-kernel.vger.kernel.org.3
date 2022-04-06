Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B974F652E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237623AbiDFQYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237641AbiDFQX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:23:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341AF3C8D6A;
        Wed,  6 Apr 2022 06:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649252795; x=1680788795;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ly37bf7KE1/2e2jYQWJyGiJWGtDdYuEz5soj2EbR73k=;
  b=cPJE0XNvEiehtOo4xJ4VgzTbmDjbCma9rGl2XgVXg3BYYViPvBWu0IF2
   oUVu0D1Gsjw4mBL21E+5PhNvT+NX9BIMgFi5w7XJdCY/o0j5CSRr21iLl
   C0BKfCqsXJvQN7brp0RmUH9KqJpE998XbhvIZmoMXPYCpae7Qj5oisldb
   TeptIGpmJ4bq7wdd06oMSQPkBCUdf687pCFRmVah+jjwx65vQiiixtGBX
   hAKefV8E9LdqCWjRyevxOp4akwx1HqEvufmAspBDprrWj7YaRxi6nmqV5
   mg+0lNrCfzmARlsK/mxn9iC5G12iVY/XVZcClo+nvvC3UWLhZQJHHG6BQ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="259873395"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="259873395"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 06:09:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="556951803"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 06 Apr 2022 06:09:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6DDA212B; Wed,  6 Apr 2022 16:05:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Michael Walle <michael@walle.cc>
Subject: [PATCH v5 2/4] device property: Introduce fwnode_for_each_parent_node()
Date:   Wed,  6 Apr 2022 16:05:50 +0300
Message-Id: <20220406130552.30930-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406130552.30930-1-andriy.shevchenko@linux.intel.com>
References: <20220406130552.30930-1-andriy.shevchenko@linux.intel.com>
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

In a few cases the functionality of fwnode_for_each_parent_node()
is already in use. Introduce a common helper macro for it.

It may be used by others as well in the future.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v5: new patch
 drivers/base/property.c  | 56 +++++++++++++++++++++-------------------
 include/linux/property.h |  9 +++++--
 2 files changed, 36 insertions(+), 29 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 3376d3971a93..bca9a28ce271 100644
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

