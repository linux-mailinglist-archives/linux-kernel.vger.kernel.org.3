Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F54D4F63CC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbiDFPpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236502AbiDFPoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:44:10 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF214DBFD0;
        Wed,  6 Apr 2022 06:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649250611; x=1680786611;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yw0fQih9tXF/247W2afpZYqH7VzQIZItG2AyzEHXwk4=;
  b=XgpIo6Jm5VdGRs3Zg4Xcmzw7TPr7IY44ewIPg732B7JILdGDESLbeiYW
   SXbcuW9T8Xu1jgKhuaahTTfNQWu1Xf0XM0Prfy7ETeNgtz+NdXGfZ45RF
   HXlTHWh/XWRPIvPKTSfQSS5BDCzzNr/AwPzaJpvAZALp/kDDn6OGqJT17
   6EwGsprYvvEp9HB7Ti4Mi//d5zNmzU+0JL1J+Jju442uIhjejQLaocHoK
   npsbS1vy1c0nNwyI71szycX9vG/lNKIMBaSREeEyXz0rx5xvM8JpSolMY
   ZcG4sclF3draygJOt4GajL0D8oHbHh0NpvbIYoXrBPQMkiVKHjO/OCyGU
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="258628717"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="258628717"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 06:09:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="588363716"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 06 Apr 2022 06:09:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 79BC12FB; Wed,  6 Apr 2022 16:05:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Michael Walle <michael@walle.cc>
Subject: [PATCH v5 3/4] device property: Drop 'test' prefix in parameters of fwnode_is_ancestor_of()
Date:   Wed,  6 Apr 2022 16:05:51 +0300
Message-Id: <20220406130552.30930-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406130552.30930-1-andriy.shevchenko@linux.intel.com>
References: <20220406130552.30930-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The part 'is' in the function name implies the test against something.
Drop unnecessary 'test' prefix in the fwnode_is_ancestor_of() parameters.

No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v5: new patch
 drivers/base/property.c  | 20 +++++++++-----------
 include/linux/property.h |  3 +--
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index bca9a28ce271..839ee7f3ee12 100644
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

