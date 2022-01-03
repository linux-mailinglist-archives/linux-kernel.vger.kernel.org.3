Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60BFD482D91
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 03:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiACCgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 21:36:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33341 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229647AbiACCgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 21:36:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641177394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VDx03SuBQubF3lONsbFtyx0KLs3ccMl9lEB9t6K9Q1Q=;
        b=EMpB7MVMukLWkus8csrCGxvYxJtuMcmmc8yckDvBpI+PulE83Fqt2i6FM4eZ9TiBB8+vGz
        q1zCcfglwZ9H30gJ7rOg/rpAYX5BVuXbcbTgethE35BM8TQUmk2geJhdj2oSKUkrOTFaIs
        madR1cvzo+ejQw/yfqjcm5CPAzjSlqA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-118-yQThVD1GPAScaLu9d8d36w-1; Sun, 02 Jan 2022 21:36:31 -0500
X-MC-Unique: yQThVD1GPAScaLu9d8d36w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2B8E1898293;
        Mon,  3 Jan 2022 02:36:30 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 58FEAE2C4;
        Mon,  3 Jan 2022 02:36:22 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] locking/lockdep: Avoid potential access of invalid memory in lock_class
Date:   Sun,  2 Jan 2022 21:35:58 -0500
Message-Id: <20220103023558.1377055-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was found that reading /proc/lockdep after a lockdep splat may
potentially cause an access to freed memory if lockdep_unregister_key()
is called after the splat but before access to /proc/lockdep [1]. This
is due to the fact that graph_lock() call in lockdep_unregister_key()
fails after the clearing of debug_locks by the splat process.

After lockdep_unregister_key() is called, the lock_name may be freed
but the corresponding lock_class structure still have a reference to
it. That invalid memory pointer will then be accessed when /proc/lockdep
is read by a user and a use-after-free (UAF) error will be reported if
KASAN is enabled.

To fix this problem, lockdep_unregister_key() is now modified to always
search for a matching key irrespective of the debug_locks state and
zap the corresponding lock class if a matching one is found.

[1] https://lore.kernel.org/lkml/77f05c15-81b6-bddd-9650-80d5f23fe330@i-love.sakura.ne.jp/

Fixes: 8b39adbee805 ("locking/lockdep: Make lockdep_unregister_key() honor 'debug_locks' again")
Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lockdep.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 2270ec68f10a..d4252b5c9863 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -6288,7 +6288,13 @@ void lockdep_reset_lock(struct lockdep_map *lock)
 		lockdep_reset_lock_reg(lock);
 }
 
-/* Unregister a dynamically allocated key. */
+/*
+ * Unregister a dynamically allocated key.
+ *
+ * Unlike lockdep_register_key(), a search is always done to find a matching
+ * key irrespective of debug_locks to avoid potential invalid access to freed
+ * memory in lock_class entry.
+ */
 void lockdep_unregister_key(struct lock_class_key *key)
 {
 	struct hlist_head *hash_head = keyhashentry(key);
@@ -6303,10 +6309,8 @@ void lockdep_unregister_key(struct lock_class_key *key)
 		return;
 
 	raw_local_irq_save(flags);
-	if (!graph_lock())
-		goto out_irq;
+	lockdep_lock();
 
-	pf = get_pending_free();
 	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
 		if (k == key) {
 			hlist_del_rcu(&k->hash_entry);
@@ -6314,11 +6318,13 @@ void lockdep_unregister_key(struct lock_class_key *key)
 			break;
 		}
 	}
-	WARN_ON_ONCE(!found);
-	__lockdep_free_key_range(pf, key, 1);
-	call_rcu_zapped(pf);
-	graph_unlock();
-out_irq:
+	WARN_ON_ONCE(!found && debug_locks);
+	if (found) {
+		pf = get_pending_free();
+		__lockdep_free_key_range(pf, key, 1);
+		call_rcu_zapped(pf);
+	}
+	lockdep_unlock();
 	raw_local_irq_restore(flags);
 
 	/* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
-- 
2.27.0

