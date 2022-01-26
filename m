Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD2849CAD1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239680AbiAZNag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:30:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57064 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiAZNab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:30:31 -0500
Date:   Wed, 26 Jan 2022 13:30:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643203829;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9XW3Orxsuq4jinxSAlPgYOq2l18Hpru1Rmo+wFEZ+iY=;
        b=kwyP7cmqpsv7QaWtgpEgBsdqJsQHrfSx10WBlP+hY7ezbJAmteRn45F+Oq+J4+iioBOL3O
        aAxvH7qmsHgI5BM+vBMIOHBi2IfcESO8D+BW0qJ4Suc8QHaEPq1g5sa1hLA3r3QPjS1mc7
        xqAqkAlkovkfC755EQPbmf22ZKEsefmRbkkF8BqnB4YE8HgLDpz9RkQFIMPHgCFP5tB3Hp
        J2l6lhMtlbj8vP44az6vBiKkkGkzdOti45HmviOag5aGM+FI9dfGCjiFGEQWkz0WJ4VMef
        wP5moAfkcOp2DIJEtmIvQrY5JjRIdBNlxuai4ATm6hNA/J9Qfg9nPw8sWmUQvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643203829;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9XW3Orxsuq4jinxSAlPgYOq2l18Hpru1Rmo+wFEZ+iY=;
        b=ldEY9tLVLd+haCwcVfjtidyLrVx3Q1VrqMHcOnq4nTe+4AQRBlM3Nz/5IpHSaJPiGLhuXM
        cv0SPkxYYPmrs5AA==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lockdep: Avoid potential access of
 invalid memory in lock_class
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Waiman Long <longman@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Bart Van Assche <bvanassche@acm.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220103023558.1377055-1-longman@redhat.com>
References: <20220103023558.1377055-1-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <164320382890.16921.15972452029466338129.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     61cc4534b6550997c97a03759ab46b29d44c0017
Gitweb:        https://git.kernel.org/tip/61cc4534b6550997c97a03759ab46b29d44c0017
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Sun, 02 Jan 2022 21:35:58 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 25 Jan 2022 22:30:28 +01:00

locking/lockdep: Avoid potential access of invalid memory in lock_class

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lkml.kernel.org/r/20220103023558.1377055-1-longman@redhat.com
---
 kernel/locking/lockdep.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 89b3df5..2e6892e 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -6287,7 +6287,13 @@ void lockdep_reset_lock(struct lockdep_map *lock)
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
@@ -6302,10 +6308,8 @@ void lockdep_unregister_key(struct lock_class_key *key)
 		return;
 
 	raw_local_irq_save(flags);
-	if (!graph_lock())
-		goto out_irq;
+	lockdep_lock();
 
-	pf = get_pending_free();
 	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
 		if (k == key) {
 			hlist_del_rcu(&k->hash_entry);
@@ -6313,11 +6317,13 @@ void lockdep_unregister_key(struct lock_class_key *key)
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
