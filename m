Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6F44F9D40
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239024AbiDHSv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiDHSvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:51:40 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1021CA392;
        Fri,  8 Apr 2022 11:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649443776; x=1680979776;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IOK0eBB42zfrFsk9z68bt/8zGkVc4UZHBRMEjnKHHS8=;
  b=eRvVZSrQa3sYARtU2XxDXzoaSXdA74GF0VxTfm2AykwDIH07lcNioMUE
   53JP405zzMi5VWFKYx+UNL6GDarepkoFdcFeBaqz4ME3SA0LU36WQELvu
   G2yLypYFi4x6wMrwBfuIBbuMMZ2J6AKLU6kVUSUwuuTglNhMNIzwMzliX
   RDGFewDd5fO906D1lgB9/2oRlJ+rX7sjwRDS95MTjqTVopBTG6K4nkQHA
   MLnJtiQw+QCUB9ktt7q38xritZOTx54bok1B8TqxwHY+Iw4IHebtu+rQv
   Ub0AploKyKQV/+8X42wjGs2K4RI6m4zM6XyBNxz9W10qHKgJS8uccaPTq
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="261841908"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="261841908"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 11:49:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="524881630"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 08 Apr 2022 11:49:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 47FB318E; Fri,  8 Apr 2022 21:48:46 +0300 (EEST)
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
Subject: [PATCH v6 3/5] device property: Drop 'test' prefix in parameters of fwnode_is_ancestor_of()
Date:   Fri,  8 Apr 2022 21:48:42 +0300
Message-Id: <20220408184844.22829-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220408184844.22829-1-andriy.shevchenko@linux.intel.com>
References: <20220408184844.22829-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The part 'is' in the function name implies the test against something.
Drop unnecessary 'test' prefix in the fwnode_is_ancestor_of() parameters.

No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
v6: added tag (Sakari)
 drivers/base/property.c  | 20 +++++++++-----------
 include/linux/property.h |  3 +--
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index f0ac31d28798..36401cfe432c 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -656,28 +656,26 @@ struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwnode,
 EXPORT_SYMBOL_GPL(fwnode_get_nth_parent);
 
 /**
- * fwnode_is_ancestor_of - Test if @test_ancestor is ancestor of @test_child
- * @test_ancestor: Firmware which is tested for being an ancestor
- * @test_child: Firmware which is tested for being the child
+ * fwnode_is_ancestor_of - Test if @ancestor is ancestor of @child
+ * @ancestor: Firmware which is tested for being an ancestor
+ * @child: Firmware which is tested for being the child
  *
  * A node is considered an ancestor of itself too.
  *
- * Returns true if @test_ancestor is an ancestor of @test_child.
- * Otherwise, returns false.
+ * Returns true if @ancestor is an ancestor of @child. Otherwise, returns false.
  */
-bool fwnode_is_ancestor_of(struct fwnode_handle *test_ancestor,
-				  struct fwnode_handle *test_child)
+bool fwnode_is_ancestor_of(struct fwnode_handle *ancestor, struct fwnode_handle *child)
 {
 	struct fwnode_handle *parent;
 
-	if (IS_ERR_OR_NULL(test_ancestor))
+	if (IS_ERR_OR_NULL(ancestor))
 		return false;
 
-	if (test_child == test_ancestor)
+	if (child == ancestor)
 		return true;
 
-	fwnode_for_each_parent_node(test_child, parent) {
-		if (parent == test_ancestor) {
+	fwnode_for_each_parent_node(child, parent) {
+		if (parent == ancestor) {
 			fwnode_handle_put(parent);
 			return true;
 		}
diff --git a/include/linux/property.h b/include/linux/property.h
index 15d6863ae962..fc24d45632eb 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -95,8 +95,7 @@ struct device *fwnode_get_next_parent_dev(struct fwnode_handle *fwnode);
 unsigned int fwnode_count_parents(const struct fwnode_handle *fwn);
 struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwn,
 					    unsigned int depth);
-bool fwnode_is_ancestor_of(struct fwnode_handle *test_ancestor,
-				  struct fwnode_handle *test_child);
+bool fwnode_is_ancestor_of(struct fwnode_handle *ancestor, struct fwnode_handle *child);
 struct fwnode_handle *fwnode_get_next_child_node(
 	const struct fwnode_handle *fwnode, struct fwnode_handle *child);
 struct fwnode_handle *fwnode_get_next_available_child_node(
-- 
2.35.1

