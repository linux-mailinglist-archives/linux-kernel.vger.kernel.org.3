Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD13464F79
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349842AbhLAOWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:22:42 -0500
Received: from mga02.intel.com ([134.134.136.20]:27566 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242777AbhLAOWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:22:37 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="223695193"
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="223695193"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 06:18:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="654801718"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 01 Dec 2021 06:18:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3B63C17D; Wed,  1 Dec 2021 16:18:29 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        heikki.krogerus@linux.intel.com
Subject: [PATCH v1 1/1] list: Introduce list_is_head() helper and re-use it in list.h
Date:   Wed,  1 Dec 2021 16:18:24 +0200
Message-Id: <20211201141824.81400-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce list_is_head() in the similar (*) way as it's done for
list_entry_is_head(). Make use of it in the list.h.

*) it's done as inliner and not a macro to be aligned with other
   list_is_*() APIs; while at it, make all three to have the same
   style.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/list.h | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index 6636fc07f918..dd6c2041d09c 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -258,8 +258,7 @@ static inline void list_bulk_move_tail(struct list_head *head,
  * @list: the entry to test
  * @head: the head of the list
  */
-static inline int list_is_first(const struct list_head *list,
-					const struct list_head *head)
+static inline int list_is_first(const struct list_head *list, const struct list_head *head)
 {
 	return list->prev == head;
 }
@@ -269,12 +268,21 @@ static inline int list_is_first(const struct list_head *list,
  * @list: the entry to test
  * @head: the head of the list
  */
-static inline int list_is_last(const struct list_head *list,
-				const struct list_head *head)
+static inline int list_is_last(const struct list_head *list, const struct list_head *head)
 {
 	return list->next == head;
 }
 
+/**
+ * list_is_head - tests whether @list is the list @head
+ * @list: the entry to test
+ * @head: the head of the list
+ */
+static inline int list_is_head(const struct list_head *list, const struct list_head *head)
+{
+	return list == head;
+}
+
 /**
  * list_empty - tests whether a list is empty
  * @head: the list to test.
@@ -318,7 +326,7 @@ static inline void list_del_init_careful(struct list_head *entry)
 static inline int list_empty_careful(const struct list_head *head)
 {
 	struct list_head *next = smp_load_acquire(&head->next);
-	return (next == head) && (next == head->prev);
+	return list_is_head(next, head) && (next == head->prev);
 }
 
 /**
@@ -393,10 +401,9 @@ static inline void list_cut_position(struct list_head *list,
 {
 	if (list_empty(head))
 		return;
-	if (list_is_singular(head) &&
-		(head->next != entry && head != entry))
+	if (list_is_singular(head) && !list_is_head(entry, head) && (entry != head->next))
 		return;
-	if (entry == head)
+	if (list_is_head(entry, head))
 		INIT_LIST_HEAD(list);
 	else
 		__list_cut_position(list, head, entry);
@@ -570,7 +577,7 @@ static inline void list_splice_tail_init(struct list_head *list,
  * @head:	the head for your list.
  */
 #define list_for_each(pos, head) \
-	for (pos = (head)->next; pos != (head); pos = pos->next)
+	for (pos = (head)->next; !list_is_head(pos, (head)); pos = pos->next)
 
 /**
  * list_for_each_continue - continue iteration over a list
@@ -580,7 +587,7 @@ static inline void list_splice_tail_init(struct list_head *list,
  * Continue to iterate over a list, continuing after the current position.
  */
 #define list_for_each_continue(pos, head) \
-	for (pos = pos->next; pos != (head); pos = pos->next)
+	for (pos = pos->next; !list_is_head(pos, (head)); pos = pos->next)
 
 /**
  * list_for_each_prev	-	iterate over a list backwards
@@ -588,7 +595,7 @@ static inline void list_splice_tail_init(struct list_head *list,
  * @head:	the head for your list.
  */
 #define list_for_each_prev(pos, head) \
-	for (pos = (head)->prev; pos != (head); pos = pos->prev)
+	for (pos = (head)->prev; !list_is_head(pos, (head)); pos = pos->prev)
 
 /**
  * list_for_each_safe - iterate over a list safe against removal of list entry
@@ -597,8 +604,9 @@ static inline void list_splice_tail_init(struct list_head *list,
  * @head:	the head for your list.
  */
 #define list_for_each_safe(pos, n, head) \
-	for (pos = (head)->next, n = pos->next; pos != (head); \
-		pos = n, n = pos->next)
+	for (pos = (head)->next, n = pos->next; \
+	     !list_is_head(pos, (head)); \
+	     pos = n, n = pos->next)
 
 /**
  * list_for_each_prev_safe - iterate over a list backwards safe against removal of list entry
@@ -608,7 +616,7 @@ static inline void list_splice_tail_init(struct list_head *list,
  */
 #define list_for_each_prev_safe(pos, n, head) \
 	for (pos = (head)->prev, n = pos->prev; \
-	     pos != (head); \
+	     !list_is_head(pos, (head)); \
 	     pos = n, n = pos->prev)
 
 /**
-- 
2.33.0

