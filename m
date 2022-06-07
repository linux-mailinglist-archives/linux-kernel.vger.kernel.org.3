Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69565542717
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442992AbiFHCBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 22:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1840369AbiFHAFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 20:05:06 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A881D0BEA;
        Tue,  7 Jun 2022 13:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654633261; x=1686169261;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TOBWj/d3INrH0x6zLmSNwJlgmp7Kh2t/gQb1rcSIgAs=;
  b=R86wmGQA1M3jPdWDkfYGln+kT0wQufVxSzZ1R9k3lEhpKSEjLoXCNBnR
   FaYxzb8sGieVxkTtjq/HWCd9hiffCxOw6IjpQWKWZqzwtM6xOJeJ+NBSI
   NkW2VLP9Foy9GEtCCGyj1eyrd+/ajeJfjIctPBXdrZ1+lmPjFX+wcQrTo
   +h9sA25BAa52zmjCppP7NU8CED7oMtUi20ozg/58N7qUBNkQnTHOUeIih
   UQVeUdsV1Q93poQ+cJUr756u9g0kKoz62l36DhIlhOndKJAphMDUBsfVy
   patpfPx3BmfYDjZIUdOrb2RuiAsUftOxKXk0OcVsCIhnV5ozdwcX6RZyO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="257187474"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="257187474"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 13:21:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="709631225"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 07 Jun 2022 13:20:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1DD3F109; Tue,  7 Jun 2022 23:21:01 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] driver core: Introduce device_find_first_child() helper
Date:   Tue,  7 Jun 2022 23:20:57 +0300
Message-Id: <20220607202058.8304-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several places in the kernel where this kind of functionality is
being used. Provide a generic helper for such cases.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/core.c    | 24 ++++++++++++++++++++++++
 include/linux/device.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 7cd789c4985d..972bfe975cd0 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3832,6 +3832,30 @@ struct device *device_find_child_by_name(struct device *parent,
 }
 EXPORT_SYMBOL_GPL(device_find_child_by_name);
 
+/**
+ * device_find_first_child - device iterator for locating the fist child device.
+ * @parent: parent struct device
+ *
+ * This is similar to the device_find_child() function above, but it
+ * returns a reference to the first child device.
+ *
+ * NOTE: you will need to drop the reference with put_device() after use.
+ */
+struct device *device_find_first_child(struct device *parent)
+{
+	struct klist_iter i;
+	struct device *child;
+
+	if (!parent)
+		return NULL;
+
+	klist_iter_init(&parent->p->klist_children, &i);
+	child = get_device(next_device(&i));
+	klist_iter_exit(&i);
+	return child;
+}
+EXPORT_SYMBOL_GPL(device_find_first_child);
+
 int __init devices_init(void)
 {
 	devices_kset = kset_create_and_add("devices", &device_uevent_ops, NULL);
diff --git a/include/linux/device.h b/include/linux/device.h
index dc941997795c..20171a4358df 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -905,6 +905,7 @@ struct device *device_find_child(struct device *dev, void *data,
 				 int (*match)(struct device *dev, void *data));
 struct device *device_find_child_by_name(struct device *parent,
 					 const char *name);
+struct device *device_find_first_child(struct device *parent);
 int device_rename(struct device *dev, const char *new_name);
 int device_move(struct device *dev, struct device *new_parent,
 		enum dpm_order dpm_order);
-- 
2.35.1

