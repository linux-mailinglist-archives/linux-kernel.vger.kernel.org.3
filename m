Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13FB4F6425
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236502AbiDFPv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236488AbiDFPvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:51:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D3F1587A0;
        Wed,  6 Apr 2022 06:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649250693; x=1680786693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dhKZFE7l+zk7iULmf3peuVOi1f+iSF+Jfyv10og7Xqg=;
  b=K+B+TTuPShb+CIS2OhycOLA0rPPpcVS8C1jshFWIZBOJVeVTK8tvvV9v
   RzKXDAziLWqC+QXEO6hbGsq7a7u4RimL4Y6+RZoF/1Czk+nKAc09DqNL7
   0Oyevl9S3XamrbbYZJ41mThbu9FmUwJiN6FQ4sDIQyjVzp3hBpD3W0BwS
   AWK3iTD9gV4qv10rLHU7zen0O0zBIsY0GO3DTQHg7CCKCcrMrrwrL0bLu
   c2sB97wGzsLzjDGCTVb57gJuYjskHqRL7RIducPPqLiMnfEvqJeRu0SxZ
   RF7Pskf6fqxVPGaZKct15pwk78xYsXSSEVPlD4tjhoWQpDd6Sq6YsHD1w
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="324208113"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="324208113"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 06:09:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="697364975"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 06 Apr 2022 06:09:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8585B405; Wed,  6 Apr 2022 16:05:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Michael Walle <michael@walle.cc>
Subject: [PATCH v5 4/4] device property: Constify fwnode APIs that uses fwnode_get_next_parent()
Date:   Wed,  6 Apr 2022 16:05:52 +0300
Message-Id: <20220406130552.30930-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406130552.30930-1-andriy.shevchenko@linux.intel.com>
References: <20220406130552.30930-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
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

Due to fwnode_get_next_parent() used to be called against the parameters
of some of fwnode APIs those parameters have no const qualifier. However,
after switching to fwnode_for_each_parent_node() API now it's possible to
constify the parameters. Do it for good.

The affected functions are:

	fwnode_get_next_parent_dev()
	fwnode_get_nth_parent()
	fwnode_is_ancestor_of()

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v5: new patch
 drivers/base/property.c  | 7 +++----
 include/linux/property.h | 9 ++++-----
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 839ee7f3ee12..79e0adfa1e24 100644
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
index fc24d45632eb..119bf7d6a02f 100644
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

