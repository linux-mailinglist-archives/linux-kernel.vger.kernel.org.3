Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5052F4C05E0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 01:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbiBWAWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 19:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbiBWAWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 19:22:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B57494EA31
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 16:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645575702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x9JpIvZGyIbjaqGqR3pG3TowU7Enm3+Ne3Lf/P2NcG4=;
        b=Y3PMzoTzT/czMHK+nfKw8itk8//w/c9W80WI/2zx8FMAPxsDeQGTDdQQ1oXrFBe3fXwn94
        N7wTaAMg4J2rLVzGEq0+0r81zI7mUTVfbpomQmx5ck/pLlNmP4TQ5iR8nCJBUab+40RpYs
        ne0wETbVTMHH+9p3RczcCXicUgELEuo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-Es_ME53UN8Kv8qLFyHtgKQ-1; Tue, 22 Feb 2022 19:21:39 -0500
X-MC-Unique: Es_ME53UN8Kv8qLFyHtgKQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFB14804310;
        Wed, 23 Feb 2022 00:21:37 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A25BC1006914;
        Wed, 23 Feb 2022 00:21:27 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH 2/2] locking/lockdep: Optimize look_up_lock_class()
Date:   Tue, 22 Feb 2022 19:20:53 -0500
Message-Id: <20220223002053.486875-2-longman@redhat.com>
In-Reply-To: <20220223002053.486875-1-longman@redhat.com>
References: <20220223002053.486875-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lockdep_map structure has a built-in cache for the first two
subclasses.  However, when lockdep_init_map_type() is called with a
subclass other than 0, it forces class_cache[0] to hold class for a
non-0 subclass. That messes up the utility of the cache as you never
know if class_cache[0] holds a class for subclass 0.

Use the 1-byte hole in the lockdep_map structure to hold the
subclass information in class_cache[0] so that we can reliably use the
class_cache[] information to get the class based on the given subclass
quicker in look_up_lock_class().

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/lockdep_types.h |  2 +-
 kernel/locking/lockdep.c      | 19 +++++++++++++++++--
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index 9c62d274b71e..2c2a19a0b645 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -176,7 +176,7 @@ struct lockdep_map {
 	u8				wait_type_outer; /* can be taken in this context */
 	u8				wait_type_inner; /* presents this context */
 	u8				lock_type;
-	/* u8				hole; */
+	u8				cache0_subclass; /* class_cache[0] subclass */
 #ifdef CONFIG_LOCK_STAT
 	int				cpu;
 	unsigned long			ip;
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 4a882f83aeb9..0b19d153ffa4 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -881,6 +881,18 @@ look_up_lock_class(const struct lockdep_map *lock, unsigned int subclass)
 	if (unlikely(!lock->key))
 		return NULL;
 
+	/*
+	 * Use the class_cache[] to get the class information if available.
+	 */
+	if (unlikely(lock->cache0_subclass)) {
+		if (subclass == lock->cache0_subclass)
+			return lock->class_cache[0];
+	} else if (likely(subclass < NR_LOCKDEP_CACHING_CLASSES)) {
+		class = lock->class_cache[subclass];
+		if (class)
+			return class;
+	}
+
 	/*
 	 * NOTE: the class-key must be unique. For dynamic locks, a static
 	 * lock_class_key variable is passed in through the mutex_init()
@@ -1335,10 +1347,12 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	graph_unlock();
 
 out_set_class_cache:
-	if (!subclass || force)
+	if (subclass && force) {
 		lock->class_cache[0] = class;
-	else if (subclass < NR_LOCKDEP_CACHING_CLASSES)
+		lock->cache0_subclass = subclass;
+	} else if (subclass < NR_LOCKDEP_CACHING_CLASSES) {
 		lock->class_cache[subclass] = class;
+	}
 
 	/*
 	 * Hash collision, did we smoke some? We found a class with a matching
@@ -4797,6 +4811,7 @@ void lockdep_init_map_type(struct lockdep_map *lock, const char *name,
 	lock->wait_type_outer = outer;
 	lock->wait_type_inner = inner;
 	lock->lock_type = lock_type;
+	lock->cache0_subclass = 0;
 
 	/*
 	 * No key, no joy, we need to hash something.
-- 
2.27.0

