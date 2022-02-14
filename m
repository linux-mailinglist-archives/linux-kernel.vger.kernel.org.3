Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576EB4B5364
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355165AbiBNOc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:32:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbiBNOcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:32:52 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B4F4AE2A;
        Mon, 14 Feb 2022 06:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644849164; x=1676385164;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VG/LXZ8qtbLnm0aGyCPiHCWpO4Syl62OgLqN5jIzZ8I=;
  b=etnRUoSARL/EeeJrmsYguzXpwI/BqO1f175DrJKN75QzDFbHMJGbVIVk
   nnU9t0eOxwLA+1cDhK8lx0otQ2mTZ7ZrEZwauGkmy98ZwK0Euad+JilSx
   5dAJQ4Hzqc2WuHMl9FDwG/2jPySph6rxEpXtvLfEVT0wZadSP/j0roKuP
   56fK26NfwNqv4KN1qh2QLZX9guY+mygKpHQu1plZhqkTAOiLWl4EM7zgr
   Vh8S4L3dMra/Lz9RmPLoYMh1DJ4ZnFF2to40flGC6BLRbriU6uYpDpM9i
   wCA+y1rgf9eQkh3MzHvLrk0cDTFZ/0ZxiKlgTDiPBKxY1Gk3Qh6Kly4rj
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="237509741"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="237509741"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 06:32:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="773072677"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 14 Feb 2022 06:32:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 585FD143; Mon, 14 Feb 2022 16:32:57 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] driver core: add a wrapper to device probe log helper to return pointer
Date:   Mon, 14 Feb 2022 16:32:47 +0200
Message-Id: <20220214143248.502-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes the ->probe() function can be split to the core and actual probe
parts. In such cases the core one may return a pointer to the allocated
resource, or error pointer in unsuccessful scenario. Allow that kind of
core function to use dev_err_probe_ptr(), so the following excerpt

	ret = bar(...);
	if (ret) {
		dev_err_probe(dev, ret, ...);
		return ERR_PTR(ret);
	}

can be replaced with

	ret = bar(...);
	if (ret)
		return dev_err_probe_ptr(dev, ret, ...);

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/device.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 93459724dcde..8650d3afbe7c 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -14,6 +14,7 @@
 
 #include <linux/dev_printk.h>
 #include <linux/energy_model.h>
+#include <linux/err.h>
 #include <linux/ioport.h>
 #include <linux/kobject.h>
 #include <linux/klist.h>
@@ -982,6 +983,13 @@ void device_links_supplier_sync_state_resume(void);
 extern __printf(3, 4)
 int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
 
+/* As above, but returns error pointer */
+static inline __printf(3, 0)
+void *dev_err_probe_ptr(const struct device *dev, int err, const char *fmt, va_list args)
+{
+	return ERR_PTR(dev_err_probe(dev, err, fmt, args));
+}
+
 /* Create alias, so I can be autoloaded. */
 #define MODULE_ALIAS_CHARDEV(major,minor) \
 	MODULE_ALIAS("char-major-" __stringify(major) "-" __stringify(minor))
-- 
2.34.1

