Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B016D4838B2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 23:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiACWJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 17:09:15 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113]:42976 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229525AbiACWJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 17:09:14 -0500
Received: from MUA
        by vps-vb.mhejs.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1n4VVo-0001la-7e; Mon, 03 Jan 2022 23:09:04 +0100
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/zswap.c: allow handling just same-value filled pages
Date:   Mon,  3 Jan 2022 23:08:58 +0100
Message-Id: <7dbafa963e8bab43608189abbe2067f4b9287831.1641247624.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Zswap has an ability to efficiently store same-value filled pages, which
can be turned on and off using the "same_filled_pages_enabled" parameter.

However, there is currently no way to enable just this (lightweight)
functionality, while not making use of the whole compressed page storage
machinery.

Add a "non_same_filled_pages_enabled" parameter which allows disabling
handling of pages that aren't same-value filled.
This way zswap can be run in such lightweight same-value filled pages only
mode.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 Documentation/admin-guide/mm/zswap.rst | 22 +++++++++++++++++++---
 mm/zswap.c                             | 15 ++++++++++++++-
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/admin-guide/mm/zswap.rst
index 8edb8d578caf..6e6f7b0d6562 100644
--- a/Documentation/admin-guide/mm/zswap.rst
+++ b/Documentation/admin-guide/mm/zswap.rst
@@ -130,9 +130,25 @@ attribute, e.g.::
 	echo 1 > /sys/module/zswap/parameters/same_filled_pages_enabled
 
 When zswap same-filled page identification is disabled at runtime, it will stop
-checking for the same-value filled pages during store operation. However, the
-existing pages which are marked as same-value filled pages remain stored
-unchanged in zswap until they are either loaded or invalidated.
+checking for the same-value filled pages during store operation.
+In other words, every page will be then considered non-same-value filled.
+However, the existing pages which are marked as same-value filled pages remain
+stored unchanged in zswap until they are either loaded or invalidated.
+
+In some circumstances it might be advantageous to make use of just the zswap
+ability to efficiently store same-filled pages without enabling the whole
+compressed page storage.
+In this case the handling of non-same-value pages by zswap (enabled by default)
+can be disabled by setting the ``non_same_filled_pages_enabled`` attribute
+to 0, e.g. ``zswap.non_same_filled_pages_enabled=0``.
+It can also be enabled and disabled at runtime using the sysfs
+``non_same_filled_pages_enabled`` attribute, e.g.::
+
+	echo 1 > /sys/module/zswap/parameters/non_same_filled_pages_enabled
+
+Disabling both ``zswap.same_filled_pages_enabled`` and
+``zswap.non_same_filled_pages_enabled`` effectively disables accepting any new
+pages by zswap.
 
 To prevent zswap from shrinking pool when zswap is full and there's a high
 pressure on swap (this will result in flipping pages in and out zswap pool
diff --git a/mm/zswap.c b/mm/zswap.c
index 7944e3e57e78..7584ab85c7c7 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -120,11 +120,19 @@ static unsigned int zswap_accept_thr_percent = 90; /* of max pool size */
 module_param_named(accept_threshold_percent, zswap_accept_thr_percent,
 		   uint, 0644);
 
-/* Enable/disable handling same-value filled pages (enabled by default) */
+/*
+ * Enable/disable handling same-value filled pages (enabled by default).
+ * If disabled every page is considered non-same-value filled.
+ */
 static bool zswap_same_filled_pages_enabled = true;
 module_param_named(same_filled_pages_enabled, zswap_same_filled_pages_enabled,
 		   bool, 0644);
 
+/* Enable/disable handling non-same-value filled pages (enabled by default) */
+static bool zswap_non_same_filled_pages_enabled = true;
+module_param_named(non_same_filled_pages_enabled, zswap_non_same_filled_pages_enabled,
+		   bool, 0644);
+
 /*********************************
 * data structures
 **********************************/
@@ -1147,6 +1155,11 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 		kunmap_atomic(src);
 	}
 
+	if (!zswap_non_same_filled_pages_enabled) {
+		ret = -EINVAL;
+		goto freepage;
+	}
+
 	/* if entry is successfully added, it keeps the reference */
 	entry->pool = zswap_pool_current_get();
 	if (!entry->pool) {
