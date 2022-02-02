Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB9B4A6BEB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 07:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245168AbiBBGx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 01:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244777AbiBBGwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 01:52:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79552C06176A;
        Tue,  1 Feb 2022 22:31:16 -0800 (PST)
Date:   Wed, 02 Feb 2022 06:31:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643783474;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hWYLi1lhaR0yb+rubNPEjL4UvtpQb8v5CSoORHyb/kE=;
        b=xRa0UBkiEAgLxIeKNMLf/CF2ADiT+00yz/9duUcOOPayaZFEmAYL+b4nfnQnBEgAwjKEsy
        FkeAvx85Rtf3kFO6NTqAvwX1zqzuB0A2YY05j+esHRlnqvbcbxbJImM70yKn3H3OjJhjes
        MAo9E68x8YX6i//b7Eex4nDaMf9RFwYgMZibvQVRrv1f0E0CAGW+WEadoCHHB9rk9l06fg
        UAUsdZ4QnRazLyQOCmIzsXsHiVG0aiblsIciX5zhw5Av9JcP6AyR8iD45pCD46hJQBFzxY
        7kcIhnZ+TL2ZqaC+8NXAPCaaHITto96Tdunf3t7BrwH+WPPQ3N5E6WQCmHcD8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643783474;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hWYLi1lhaR0yb+rubNPEjL4UvtpQb8v5CSoORHyb/kE=;
        b=vucxJZoc0x/hD6Epy1DWaKBPbEgUhwQhOkS3IPKDMGtMjlLuw6g1TLjDMwcdx7b+woL6ZU
        AmaDLkRlgLgZzqBw==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] topology/sysfs: Add format parameter to macro defining
 "show" functions for proc
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220131230111.2004669-5-tony.luck@intel.com>
References: <20220131230111.2004669-5-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <164378347350.16921.2664263656218408970.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     182ecfaf757de234a5262f51c0e699bec7258a67
Gitweb:        https://git.kernel.org/tip/182ecfaf757de234a5262f51c0e699bec7258a67
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Mon, 31 Jan 2022 15:01:10 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 01 Feb 2022 16:35:21 +01:00

topology/sysfs: Add format parameter to macro defining "show" functions for proc

All the simple (non-mask and non-list files in
/sys/devices/system/cpu/cpu0/topology/ are currently printed as decimal
integers.

Refactor the macro that generates the "show" functions to take a format
parameter to allow future files to display in other formats.

No functional change.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20220131230111.2004669-5-tony.luck@intel.com
---
 drivers/base/topology.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index fc24e89..044f366 100644
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
