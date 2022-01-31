Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81834A52CB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 00:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbiAaXBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 18:01:33 -0500
Received: from mga03.intel.com ([134.134.136.65]:53702 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235774AbiAaXBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 18:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643670079; x=1675206079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IPbq71KTo4yhzvGZvTZl4Fs2bjq1kiEYwJBMLRbd8X0=;
  b=gA+nS1kcJEx0K+IDHNLIL0FV6ddXyXhmiK9/XeBR9zDEvQqLHAMQoMSS
   mvIpZVb0hWbGF+vOGTvArVhxelcyFYFtrhoUFEGQdAGmD1zk7lpifVyy5
   xVyy7KHQIawJMnMCYwIgUAqZjrKbYAYSSrpavg6HeHGGiNeOMQxl+PuWj
   ljOiJWVyyYXtLvA7HDXdhXpqWf+R/pAskZO/p1fOPNtivI6JWhZpF25W2
   LtYNBuNX/lRErVPAh5YlpkcWLRFfnNsijCOKfJa9LFjMfrjRW7+lwVXjr
   enD9hFPfjUfznKVarE2KwzPEOJYF1/7+JCfYfl2H+NP3ydD6PVegkTJGa
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="247521231"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="247521231"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 15:01:18 -0800
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="522831347"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 15:01:18 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Smita Koralahalli Channabasappa 
        <smita.koralahallichannabasappa@amd.com>,
        Wei Huang <wei.huang2@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 4/5] topology/sysfs: Add format parameter to macro defining "show" functions for proc
Date:   Mon, 31 Jan 2022 15:01:10 -0800
Message-Id: <20220131230111.2004669-5-tony.luck@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220131230111.2004669-1-tony.luck@intel.com>
References: <20220121174743.1875294-1-tony.luck@intel.com>
 <20220131230111.2004669-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the simple (non-mask and non-list files in
/sys/devices/system/cpu/cpu0/topology/ are currently printed as decimal
integers.

Refactor the macro that generates the "show" functions to take a format
parameter to allow future files to display in other formats.

No functional change.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/base/topology.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index fc24e89f9592..044f3664f8f2 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -14,11 +14,11 @@
 #include <linux/hardirq.h>
 #include <linux/topology.h>
 
-#define define_id_show_func(name)					\
+#define define_id_show_func(name, fmt)					\
 static ssize_t name##_show(struct device *dev,				\
 			   struct device_attribute *attr, char *buf)	\
 {									\
-	return sysfs_emit(buf, "%d\n", topology_##name(dev->id));	\
+	return sysfs_emit(buf, fmt "\n", topology_##name(dev->id));	\
 }
 
 #define define_siblings_read_func(name, mask)					\
@@ -42,20 +42,20 @@ static ssize_t name##_list_read(struct file *file, struct kobject *kobj,	\
 					off, count);				\
 }
 
-define_id_show_func(physical_package_id);
+define_id_show_func(physical_package_id, "%d");
 static DEVICE_ATTR_RO(physical_package_id);
 
 #ifdef TOPOLOGY_DIE_SYSFS
-define_id_show_func(die_id);
+define_id_show_func(die_id, "%d");
 static DEVICE_ATTR_RO(die_id);
 #endif
 
 #ifdef TOPOLOGY_CLUSTER_SYSFS
-define_id_show_func(cluster_id);
+define_id_show_func(cluster_id, "%d");
 static DEVICE_ATTR_RO(cluster_id);
 #endif
 
-define_id_show_func(core_id);
+define_id_show_func(core_id, "%d");
 static DEVICE_ATTR_RO(core_id);
 
 define_siblings_read_func(thread_siblings, sibling_cpumask);
@@ -87,7 +87,7 @@ static BIN_ATTR_RO(package_cpus, 0);
 static BIN_ATTR_RO(package_cpus_list, 0);
 
 #ifdef TOPOLOGY_BOOK_SYSFS
-define_id_show_func(book_id);
+define_id_show_func(book_id, "%d");
 static DEVICE_ATTR_RO(book_id);
 define_siblings_read_func(book_siblings, book_cpumask);
 static BIN_ATTR_RO(book_siblings, 0);
@@ -95,7 +95,7 @@ static BIN_ATTR_RO(book_siblings_list, 0);
 #endif
 
 #ifdef TOPOLOGY_DRAWER_SYSFS
-define_id_show_func(drawer_id);
+define_id_show_func(drawer_id, "%d");
 static DEVICE_ATTR_RO(drawer_id);
 define_siblings_read_func(drawer_siblings, drawer_cpumask);
 static BIN_ATTR_RO(drawer_siblings, 0);
-- 
2.31.1

