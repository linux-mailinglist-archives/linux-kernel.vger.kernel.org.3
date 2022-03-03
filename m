Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E9E4CC0A8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 16:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbiCCPGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 10:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbiCCPGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:06:46 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E596E1903EA;
        Thu,  3 Mar 2022 07:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646319960; x=1677855960;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sq62BHoXUaup7pv3oVeZGgsTh/q+BKWpk8Ud/vZNcsk=;
  b=i2n9E5TLKlpkeSnGRJ8g7w3B7Mp7LtKGeqdGACbvvC8boK8bGQWkAen/
   iytN5neGLMuIojqHPdLMshpCtGc/SFq9IQH0/DBvH9uAJbG/xIQ9SJ7Q/
   92KqZMhb5DukCpj7RGnPKKiBKc2MeMu46olJ9w9Hx+2DRBvoY482/+WLx
   9IaBHoCLM0KyNXmF8O7MRKj3UpkeSq4+qnxngvcRu+sm2fVYfxEMR+cxb
   LGn+Bewxdp6BJk9tJZG2FLl1xX6DTgfN+VU4IqO3nX+d9+WikpTQd0b7r
   LaFpE4x6750tm7NKwB95CuJ00IMts8lG70p2bP8DQAChZVcWPl/hNDdT5
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="278378617"
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="278378617"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2022 07:06:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,151,1643702400"; 
   d="scan'208";a="576517025"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 03 Mar 2022 07:05:57 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A37D8183; Thu,  3 Mar 2022 17:06:15 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH v1 1/1] device property: Allow error pointer for fwnode_handle_{get,put}()
Date:   Thu,  3 Mar 2022 17:06:10 +0200
Message-Id: <20220303150610.47596-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

To prevent this allow error pointer for fwnode_handle_get() and
fwnode_handle_put().

Fixes: 83b34afb6b79 ("device property: Introduce fwnode_find_reference()")
Reported-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 2d70392fc982..df7b8c7ad264 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -776,7 +776,7 @@ EXPORT_SYMBOL_GPL(device_get_named_child_node);
  */
 struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode)
 {
-	if (!fwnode_has_op(fwnode, get))
+	if (IS_ERR(fwnode) || !fwnode_has_op(fwnode, get))
 		return fwnode;
 
 	return fwnode_call_ptr_op(fwnode, get);
@@ -793,6 +793,9 @@ EXPORT_SYMBOL_GPL(fwnode_handle_get);
  */
 void fwnode_handle_put(struct fwnode_handle *fwnode)
 {
+	if (IS_ERR(fwnode) || !fwnode_has_op(fwnode, put))
+		return;
+
 	fwnode_call_void_op(fwnode, put);
 }
 EXPORT_SYMBOL_GPL(fwnode_handle_put);
-- 
2.34.1

