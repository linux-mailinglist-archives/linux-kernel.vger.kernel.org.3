Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076A24F9D3F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239007AbiDHSvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238958AbiDHSvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:51:40 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4C81C9B5C;
        Fri,  8 Apr 2022 11:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649443775; x=1680979775;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MJFpHccOxFxoyHrddoOZl2W35Dl1fotu10a86Vp+YiQ=;
  b=RkGAViThbAlNmub91Fze1Vbp/vO8U+3RZcRQvSXMKKCcGWa5q0AYnv59
   7n9JxtxpUWWaUxwEPYrRQNGuMwRpsiCjgI5V32r3gcySHFJe7dCYIM5zI
   KQ9t+28Au64lbhD8GnKzj2CxSFXTfjxwJOdBpfIMa2RXzCgBYnMn8kAbT
   5pGJuieLU6zmGdoMuSjg/fFs4eJoSGt8K9HMMm9l/SNllIYfspN3Jmq8y
   Z6BevQy2TmWV5BIQ74G5KA/aHg35yvXniKwMfDOLp3W8pYgdHww30Auvb
   NAcOS0cBzNWz4CvTfuBUtHs53mWvAaTvi2EG6H1Z6R46Ja1M2WUedVi8x
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="241602058"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="241602058"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 11:49:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="557883589"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 08 Apr 2022 11:49:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5F7B6449; Fri,  8 Apr 2022 21:48:46 +0300 (EEST)
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
Subject: [PATCH v6 5/5] device property: Constify fwnode APIs that uses fwnode_get_next_parent()
Date:   Fri,  8 Apr 2022 21:48:44 +0300
Message-Id: <20220408184844.22829-5-andriy.shevchenko@linux.intel.com>
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

Due to fwnode_get_next_parent() used to be called against the parameters
of some of fwnode APIs those parameters have no const qualifier. However,
after switching to fwnode_for_each_parent_node() API now it's possible to
constify the parameters. Do it for good.

The affected functions are:

	fwnode_get_next_parent_dev()
	fwnode_get_nth_parent()
	fwnode_is_ancestor_of()

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
v6: added tag (Sakari), since previous patch no warnings anymore (LKP)
 drivers/base/property.c  | 7 +++----
 include/linux/property.h | 9 ++++-----
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 1ad4b37cd312..f289f582209c 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -594,7 +594,7 @@ EXPORT_SYMBOL_GPL(fwnode_get_next_parent);
  * The caller of this function is expected to call put_device() on the returned
  * device when they are done.
  */
-struct device *fwnode_get_next_parent_dev(struct fwnode_handle *fwnode)
+struct device *fwnode_get_next_parent_dev(const struct fwnode_handle *fwnode)
 {
 	struct fwnode_handle *parent;
 	struct device *dev;
@@ -639,8 +639,7 @@ EXPORT_SYMBOL_GPL(fwnode_count_parents);
  * The caller is responsible for calling fwnode_handle_put() for the returned
  * node.
  */
-struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwnode,
-					    unsigned int depth)
+struct fwnode_handle *fwnode_get_nth_parent(const struct fwnode_handle *fwnode, unsigned int depth)
 {
 	struct fwnode_handle *parent;
 
@@ -664,7 +663,7 @@ EXPORT_SYMBOL_GPL(fwnode_get_nth_parent);
  *
  * Returns true if @ancestor is an ancestor of @child. Otherwise, returns false.
  */
-bool fwnode_is_ancestor_of(struct fwnode_handle *ancestor, struct fwnode_handle *child)
+bool fwnode_is_ancestor_of(const struct fwnode_handle *ancestor, const struct fwnode_handle *child)
 {
 	struct fwnode_handle *parent;
 
diff --git a/include/linux/property.h b/include/linux/property.h
index c631ee7fd161..e3390401dd63 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -91,11 +91,10 @@ struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode);
 	for (parent = fwnode_get_parent(fwnode); parent;	\
 	     parent = fwnode_get_next_parent(parent))
 
-struct device *fwnode_get_next_parent_dev(struct fwnode_handle *fwnode);
-unsigned int fwnode_count_parents(const struct fwnode_handle *fwn);
-struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwn,
-					    unsigned int depth);
-bool fwnode_is_ancestor_of(struct fwnode_handle *ancestor, struct fwnode_handle *child);
+struct device *fwnode_get_next_parent_dev(const struct fwnode_handle *fwnode);
+unsigned int fwnode_count_parents(const struct fwnode_handle *fwnode);
+struct fwnode_handle *fwnode_get_nth_parent(const struct fwnode_handle *fwnode, unsigned int depth);
+bool fwnode_is_ancestor_of(const struct fwnode_handle *ancestor, const struct fwnode_handle *child);
 struct fwnode_handle *fwnode_get_next_child_node(
 	const struct fwnode_handle *fwnode, struct fwnode_handle *child);
 struct fwnode_handle *fwnode_get_next_available_child_node(
-- 
2.35.1

