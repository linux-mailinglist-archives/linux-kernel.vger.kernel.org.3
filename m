Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33EF4F9D3E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239017AbiDHSvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbiDHSvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:51:40 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506871CA385;
        Fri,  8 Apr 2022 11:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649443776; x=1680979776;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/L4XLibjcZhivIukWvKIpgtxKvWbpx+6gdYLGgMSaY8=;
  b=jZmWaEcjDVKhvg/++X+D/Xia3Zvz7HSMlUg2l8x6KZrV595E06JpGqOF
   eunmW0zDMNmw+jGOUF6b7BDbLEHN39wpfbpLoQP1/PGlq9CNsJVSablVA
   7pBlVX2SQGTNuiD5sIGkQAlxqkh0SJxrjwp+v+r99iNGKp6IADNoZMldS
   6Jb476GC2wXSVQm/eUB6qkZVlfAKR+xHhMGNmCkXnjj9GarSJ72MrWyql
   Q9sKQThQ/fBapchwKobQp2+2nnrG0u5yq8GWqVX2KuXkYFNJotUucHUEt
   MMgMnYeb25BqVgnq7+XLfjIMZUJXoMx9SAY33HThKPhdYh6eo9WpWOqVP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="242258599"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="242258599"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 11:49:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="698279335"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Apr 2022 11:49:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4E763328; Fri,  8 Apr 2022 21:48:46 +0300 (EEST)
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
Subject: [PATCH v6 4/5] device property: Constify fwnode_handle_get()
Date:   Fri,  8 Apr 2022 21:48:43 +0300
Message-Id: <20220408184844.22829-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220408184844.22829-1-andriy.shevchenko@linux.intel.com>
References: <20220408184844.22829-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As to_of_node() suggests and the way the code in the OF and software node
back ends actually uses the fwnode handle, it may be constified. Do this
for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v6: new patch
 drivers/base/property.c  | 2 +-
 drivers/base/swnode.c    | 2 +-
 drivers/of/property.c    | 2 +-
 include/linux/fwnode.h   | 2 +-
 include/linux/property.h | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 36401cfe432c..1ad4b37cd312 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -776,7 +776,7 @@ EXPORT_SYMBOL_GPL(device_get_named_child_node);
  *
  * Returns the fwnode handle.
  */
-struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode)
+struct fwnode_handle *fwnode_handle_get(const struct fwnode_handle *fwnode)
 {
 	if (!fwnode_has_op(fwnode, get))
 		return fwnode;
diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index b0bbd1805970..84a11008ffb8 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -363,7 +363,7 @@ EXPORT_SYMBOL_GPL(property_entries_free);
 /* -------------------------------------------------------------------------- */
 /* fwnode operations */
 
-static struct fwnode_handle *software_node_get(struct fwnode_handle *fwnode)
+static struct fwnode_handle *software_node_get(const struct fwnode_handle *fwnode)
 {
 	struct swnode *swnode = to_swnode(fwnode);
 
diff --git a/drivers/of/property.c b/drivers/of/property.c
index 9a50ad25906e..8d06282af8e4 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -858,7 +858,7 @@ struct device_node *of_graph_get_remote_node(const struct device_node *node,
 }
 EXPORT_SYMBOL(of_graph_get_remote_node);
 
-static struct fwnode_handle *of_fwnode_get(struct fwnode_handle *fwnode)
+static struct fwnode_handle *of_fwnode_get(const struct fwnode_handle *fwnode)
 {
 	return of_fwnode_handle(of_node_get(to_of_node(fwnode)));
 }
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 9a81c4410b9f..a94bd47192a3 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -108,7 +108,7 @@ struct fwnode_reference_args {
  *		zero on success, a negative error code otherwise.
  */
 struct fwnode_operations {
-	struct fwnode_handle *(*get)(struct fwnode_handle *fwnode);
+	struct fwnode_handle *(*get)(const struct fwnode_handle *fwnode);
 	void (*put)(struct fwnode_handle *fwnode);
 	bool (*device_is_available)(const struct fwnode_handle *fwnode);
 	const void *(*device_get_match_data)(const struct fwnode_handle *fwnode,
diff --git a/include/linux/property.h b/include/linux/property.h
index fc24d45632eb..c631ee7fd161 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -121,7 +121,7 @@ struct fwnode_handle *fwnode_get_named_child_node(
 struct fwnode_handle *device_get_named_child_node(struct device *dev,
 						  const char *childname);
 
-struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode);
+struct fwnode_handle *fwnode_handle_get(const struct fwnode_handle *fwnode);
 void fwnode_handle_put(struct fwnode_handle *fwnode);
 
 int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index);
-- 
2.35.1

