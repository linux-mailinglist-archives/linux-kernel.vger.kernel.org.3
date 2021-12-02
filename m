Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A43465A6D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354057AbhLBAL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354115AbhLBAKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:10:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE29C061748;
        Wed,  1 Dec 2021 16:06:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5942B82197;
        Thu,  2 Dec 2021 00:06:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB97C53FCD;
        Thu,  2 Dec 2021 00:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638403604;
        bh=VjNR49LnW02H+3em+t5/r2vNCxgf3darabSoDaRDLNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PkpsUzJcYMzroApwPQrqJEsvZtvzwNOu/wPJcFJLMkWKIw6XhWiKWY46QqW/Jyy1Y
         JLryfB5emr6nvIlFM/UYup2ReNs43G+9RpDXzk+Bf5KN3vInDP8RhQhIAju1ESXj8l
         FEXBDOsan0hauahsDgIQgum+RoEbzityAhOr5A0+GIiq0/mcbCY73gRlDAsiglS7wx
         ITs2NPx78C2JxUbrTwdTD62dQ9Hsk1lWSC3SaVAryiZRQihhv5nFJfeRn/Pbxaac+T
         ZFZbfaLwkDcluODPFn+kyR5XGKDsaAd/5JAzOfHEW1s9BKDimPasgoDtabnkEL1fn8
         RKaRJ+Qyqj+AQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 546915C1108; Wed,  1 Dec 2021 16:06:44 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, NeilBrown <neilb@suse.de>,
        Akira Yokosawa <akiyks@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/3] doc: Add refcount analogy to What is RCU
Date:   Wed,  1 Dec 2021 16:06:41 -0800
Message-Id: <20211202000642.3126064-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202000540.GA3125972@paulmck-ThinkPad-P17-Gen-1>
References: <20211202000540.GA3125972@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: NeilBrown <neilb@suse.de>

The reader-writer-lock analogy is a useful way to think about RCU, but
it is not always applicable.  It is useful to have other analogies to
work with, and particularly to emphasise that no single analogy is
perfect.

This patch add a "RCU as reference count" to the "what is RCU" document.

See https://lwn.net/Articles/872559/

[ paulmck: Apply Akira Yokosawa feedback. ]
Reviewed-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/whatisRCU.rst | 90 ++++++++++++++++++++++++++++++---
 1 file changed, 82 insertions(+), 8 deletions(-)

diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index 17e95ab2a2014..c34d2212eaca2 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -39,9 +39,11 @@ different paths, as follows:
 
 :ref:`6.	ANALOGY WITH READER-WRITER LOCKING <6_whatisRCU>`
 
-:ref:`7.	FULL LIST OF RCU APIs <7_whatisRCU>`
+:ref:`7.	ANALOGY WITH REFERENCE COUNTING <7_whatisRCU>`
 
-:ref:`8.	ANSWERS TO QUICK QUIZZES <8_whatisRCU>`
+:ref:`8.	FULL LIST OF RCU APIs <8_whatisRCU>`
+
+:ref:`9.	ANSWERS TO QUICK QUIZZES <9_whatisRCU>`
 
 People who prefer starting with a conceptual overview should focus on
 Section 1, though most readers will profit by reading this section at
@@ -677,7 +679,7 @@ Quick Quiz #1:
 		occur when using this algorithm in a real-world Linux
 		kernel?  How could this deadlock be avoided?
 
-:ref:`Answers to Quick Quiz <8_whatisRCU>`
+:ref:`Answers to Quick Quiz <9_whatisRCU>`
 
 5B.  "TOY" EXAMPLE #2: CLASSIC RCU
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
@@ -732,7 +734,7 @@ Quick Quiz #2:
 		Give an example where Classic RCU's read-side
 		overhead is **negative**.
 
-:ref:`Answers to Quick Quiz <8_whatisRCU>`
+:ref:`Answers to Quick Quiz <9_whatisRCU>`
 
 .. _quiz_3:
 
@@ -741,7 +743,7 @@ Quick Quiz #3:
 		critical section, what the heck do you do in
 		CONFIG_PREEMPT_RT, where normal spinlocks can block???
 
-:ref:`Answers to Quick Quiz <8_whatisRCU>`
+:ref:`Answers to Quick Quiz <9_whatisRCU>`
 
 .. _6_whatisRCU:
 
@@ -872,7 +874,79 @@ be used in place of synchronize_rcu().
 
 .. _7_whatisRCU:
 
-7.  FULL LIST OF RCU APIs
+7.  ANALOGY WITH REFERENCE COUNTING
+-----------------------------------
+
+The reader-writer analogy (illustrated by the previous section) is not
+always the best way to think about using RCU.  Another helpful analogy
+considers RCU an effective reference count on everything which is
+protected by RCU.
+
+A reference count typically does not prevent the referenced object's
+values from changing, but does prevent changes to type -- particularly the
+gross change of type that happens when that object's memory is freed and
+re-allocated for some other purpose.  Once a type-safe reference to the
+object is obtained, some other mechanism is needed to ensure consistent
+access to the data in the object.  This could involve taking a spinlock,
+but with RCU the typical approach is to perform reads with SMP-aware
+operations such as smp_load_acquire(), to perform updates with atomic
+read-modify-write operations, and to provide the necessary ordering.
+RCU provides a number of support functions that embed the required
+operations and ordering, such as the list_for_each_entry_rcu() macro
+used in the previous section.
+
+A more focused view of the reference counting behavior is that,
+between rcu_read_lock() and rcu_read_unlock(), any reference taken with
+rcu_dereference() on a pointer marked as ``__rcu`` can be treated as
+though a reference-count on that object has been temporarily increased.
+This prevents the object from changing type.  Exactly what this means
+will depend on normal expectations of objects of that type, but it
+typically includes that spinlocks can still be safely locked, normal
+reference counters can be safely manipulated, and ``__rcu`` pointers
+can be safely dereferenced.
+
+Some operations that one might expect to see on an object for
+which an RCU reference is held include:
+
+ - Copying out data that is guaranteed to be stable by the object's type.
+ - Using kref_get_unless_zero() or similar to get a longer-term
+   reference.  This may fail of course.
+ - Acquiring a spinlock in the object, and checking if the object still
+   is the expected object and if so, manipulating it freely.
+
+The understanding that RCU provides a reference that only prevents a
+change of type is particularly visible with objects allocated from a
+slab cache marked ``SLAB_TYPESAFE_BY_RCU``.  RCU operations may yield a
+reference to an object from such a cache that has been concurrently
+freed and the memory reallocated to a completely different object,
+though of the same type.  In this case RCU doesn't even protect the
+identity of the object from changing, only its type.  So the object
+found may not be the one expected, but it will be one where it is safe
+to take a reference or spinlock and then confirm that the identity
+matches the expectations.
+
+With traditional reference counting -- such as that implemented by the
+kref library in Linux -- there is typically code that runs when the last
+reference to an object is dropped.  With kref, this is the function
+passed to kref_put().  When RCU is being used, such finalization code
+must not be run until all ``__rcu`` pointers referencing the object have
+been updated, and then a grace period has passed.  Every remaining
+globally visible pointer to the object must be considered to be a
+potential counted reference, and the finalization code is typically run
+using call_rcu() only after all those pointers have been changed.
+
+To see how to choose between these two analogies -- of RCU as a
+reader-writer lock and RCU as a reference counting system -- it is useful
+to reflect on the scale of the thing being protected.  The reader-writer
+lock analogy looks at larger multi-part objects such as a linked list
+and shows how RCU can facilitate concurrency while elements are added
+to, and removed from, the list.  The reference-count analogy looks at
+the individual objects and looks at how they can be accessed safely
+within whatever whole they are a part of.
+
+.. _8_whatisRCU:
+
+8.  FULL LIST OF RCU APIs
 -------------------------
 
 The RCU APIs are documented in docbook-format header comments in the
@@ -1035,9 +1109,9 @@ g.	Otherwise, use RCU.
 Of course, this all assumes that you have determined that RCU is in fact
 the right tool for your job.
 
-.. _8_whatisRCU:
+.. _9_whatisRCU:
 
-8.  ANSWERS TO QUICK QUIZZES
+9.  ANSWERS TO QUICK QUIZZES
 ----------------------------
 
 Quick Quiz #1:
-- 
2.31.1.189.g2e36527f23

