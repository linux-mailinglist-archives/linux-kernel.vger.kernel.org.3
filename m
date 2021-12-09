Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD3646E87E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237372AbhLIMdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 07:33:44 -0500
Received: from mga18.intel.com ([134.134.136.126]:17036 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229940AbhLIMdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:33:43 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="224954002"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="224954002"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 04:30:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="601541428"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Dec 2021 04:30:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EECA4329; Thu,  9 Dec 2021 14:30:13 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] kernfs: Replace kernel.h with the necessary inclusions
Date:   Thu,  9 Dec 2021 14:30:08 +0200
Message-Id: <20211209123008.3391-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kernel.h is used in the headers it adds a lot into dependency hell,
especially when there are circular dependencies are involved.

Replace kernel.h inclusion with the list of what is really being used.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/kernfs.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 9f650986a81b..861c4f0f8a29 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -6,7 +6,6 @@
 #ifndef __LINUX_KERNFS_H
 #define __LINUX_KERNFS_H
 
-#include <linux/kernel.h>
 #include <linux/err.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
@@ -14,6 +13,8 @@
 #include <linux/lockdep.h>
 #include <linux/rbtree.h>
 #include <linux/atomic.h>
+#include <linux/bug.h>
+#include <linux/types.h>
 #include <linux/uidgid.h>
 #include <linux/wait.h>
 #include <linux/rwsem.h>
@@ -23,6 +24,7 @@ struct dentry;
 struct iattr;
 struct seq_file;
 struct vm_area_struct;
+struct vm_operations_struct;
 struct super_block;
 struct file_system_type;
 struct poll_table_struct;
-- 
2.33.0

