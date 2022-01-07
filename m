Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86CB487F1F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 23:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiAGWy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 17:54:59 -0500
Received: from mga18.intel.com ([134.134.136.126]:7113 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbiAGWyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 17:54:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641596089; x=1673132089;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uPvz7HDFF+nK6rd3cra9vwO1yKtl5eFfnQFtN4S7Jvo=;
  b=QUFTGeQr1ZcC3UYjh0d2qwd/e8HlmkBhAw+plFdP9SiockDDiq88/60b
   Viccr8KnUpEXG7x5thMFtOIKNQ8utVIP2m06grHDcUfQ+xKpl1XrQN8aJ
   GzmzjTs46WKCM8dgJj1HILfkuQ2RuNw7cqvtd3Mlj22vWm41vty1yjtVP
   NA22VAelL7fKPogG857N7lhf90LWbZ/2jQvsX31JYLML0dzY1xobuLyfm
   Nvc8aTioAElOLkd67nmEqqPr3Tn8EpYlNz612yt3M/wdu1MdeQBWoLdrI
   JqY2MuE+h8J5n97RIaFwRhof3ksqeJEFGQJjRy8yn6mzFVLWIoZ9cqmna
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="229762188"
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="229762188"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 14:54:48 -0800
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="471452465"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 14:54:48 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Smita Koralahalli Channabasappa 
        <smita.koralahallichannabasappa@amd.com>,
        Wei Huang <wei.huang2@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH 4/5] x86/sysfs: Add format parameter to macro defining "show" functions for proc
Date:   Fri,  7 Jan 2022 14:54:41 -0800
Message-Id: <20220107225442.1690165-5-tony.luck@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220107225442.1690165-1-tony.luck@intel.com>
References: <20220107225442.1690165-1-tony.luck@intel.com>
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

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/base/topology.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 8f2b641d0b8c..793c592e533a 100644
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
@@ -42,16 +42,16 @@ static ssize_t name##_list_read(struct file *file, struct kobject *kobj,	\
 					off, count);				\
 }
 
-define_id_show_func(physical_package_id);
+define_id_show_func(physical_package_id, "%d");
 static DEVICE_ATTR_RO(physical_package_id);
 
-define_id_show_func(die_id);
+define_id_show_func(die_id, "%d");
 static DEVICE_ATTR_RO(die_id);
 
-define_id_show_func(cluster_id);
+define_id_show_func(cluster_id, "%d");
 static DEVICE_ATTR_RO(cluster_id);
 
-define_id_show_func(core_id);
+define_id_show_func(core_id, "%d");
 static DEVICE_ATTR_RO(core_id);
 
 define_siblings_read_func(thread_siblings, sibling_cpumask);
@@ -79,7 +79,7 @@ static BIN_ATTR_RO(package_cpus, 0);
 static BIN_ATTR_RO(package_cpus_list, 0);
 
 #ifdef CONFIG_SCHED_BOOK
-define_id_show_func(book_id);
+define_id_show_func(book_id, "%d");
 static DEVICE_ATTR_RO(book_id);
 define_siblings_read_func(book_siblings, book_cpumask);
 static BIN_ATTR_RO(book_siblings, 0);
@@ -87,7 +87,7 @@ static BIN_ATTR_RO(book_siblings_list, 0);
 #endif
 
 #ifdef CONFIG_SCHED_DRAWER
-define_id_show_func(drawer_id);
+define_id_show_func(drawer_id, "%d");
 static DEVICE_ATTR_RO(drawer_id);
 define_siblings_read_func(drawer_siblings, drawer_cpumask);
 static BIN_ATTR_RO(drawer_siblings, 0);
-- 
2.31.1

