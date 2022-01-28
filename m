Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3469B49FA8B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348918AbiA1NTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348657AbiA1NTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:19:09 -0500
Received: from server.lespinasse.org (server.lespinasse.org [IPv6:2001:470:82ab::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120A7C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 05:19:08 -0800 (PST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-52-ed;
 t=1643375406; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=G/sA6eDUTFkJatHlYWtCSRczmeD8GU3nVA1OA3tvlIA=;
 b=tuPOkcHJ7H0s/Mhca9LNqtBRVRnxk4Z1cxNgHh1WZEWb3QpuUGtcwZy4f8DWLk1PcUhmd
 rcUhZq0JYrenQUACw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-52-rsa; t=1643375406; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=G/sA6eDUTFkJatHlYWtCSRczmeD8GU3nVA1OA3tvlIA=;
 b=UUc/5KznUB/vjclApSqjaIYr8v/XO5q9CLULFAyaUUfl+3xsPLAkaGNCYMBA/yCy1uyGt
 khyVk+i8AVLLJuTiB6TzU0juIZ1Hqx5PbrWz6PgZT+z8dA2YweCyKOCY4KfyM4oz8MkTdaC
 TLKiY6x/E97IBRpjLe+NlLjpsFLk/x/H/gE+NBVz2t4ygqbfZ+AYzexTQOWJYnANhm4Dmq9
 iI76H58ibXNib1XjCLS24jDqARW3/Se1x2aCqNfaB7+YHyRH6+64ZqOQSfEI4KTm0oM1Ka3
 KrdnBvUw5MTunj6/frgh0lu6raOrHSZpeU7fm77fXPGm4F14ivu3vbS/637Q==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id DECE5160950;
        Fri, 28 Jan 2022 05:10:06 -0800 (PST)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id C8AC720330; Fri, 28 Jan 2022 05:10:06 -0800 (PST)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-team@fb.com, Laurent Dufour <ldufour@linux.ibm.com>,
        Jerome Glisse <jglisse@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [PATCH v2 03/35] mmap locking API: name the return values
Date:   Fri, 28 Jan 2022 05:09:34 -0800
Message-Id: <20220128131006.67712-4-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220128131006.67712-1-michel@lespinasse.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the mmap locking API, the *_killable() functions return an error
(or 0 on success), and the *_trylock() functions return a boolean
(true on success).

Rename the return values "int error" and "bool ok", respectively,
rather than using "ret" for both cases which I find less readable.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 include/linux/mmap_lock.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index db9785e11274..1b14468183d7 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -81,22 +81,22 @@ static inline void mmap_write_lock_nested(struct mm_struct *mm, int subclass)
 
 static inline int mmap_write_lock_killable(struct mm_struct *mm)
 {
-	int ret;
+	int error;
 
 	__mmap_lock_trace_start_locking(mm, true);
-	ret = down_write_killable(&mm->mmap_lock);
-	__mmap_lock_trace_acquire_returned(mm, true, ret == 0);
-	return ret;
+	error = down_write_killable(&mm->mmap_lock);
+	__mmap_lock_trace_acquire_returned(mm, true, !error);
+	return error;
 }
 
 static inline bool mmap_write_trylock(struct mm_struct *mm)
 {
-	bool ret;
+	bool ok;
 
 	__mmap_lock_trace_start_locking(mm, true);
-	ret = down_write_trylock(&mm->mmap_lock) != 0;
-	__mmap_lock_trace_acquire_returned(mm, true, ret);
-	return ret;
+	ok = down_write_trylock(&mm->mmap_lock) != 0;
+	__mmap_lock_trace_acquire_returned(mm, true, ok);
+	return ok;
 }
 
 static inline void mmap_write_unlock(struct mm_struct *mm)
@@ -120,22 +120,22 @@ static inline void mmap_read_lock(struct mm_struct *mm)
 
 static inline int mmap_read_lock_killable(struct mm_struct *mm)
 {
-	int ret;
+	int error;
 
 	__mmap_lock_trace_start_locking(mm, false);
-	ret = down_read_killable(&mm->mmap_lock);
-	__mmap_lock_trace_acquire_returned(mm, false, ret == 0);
-	return ret;
+	error = down_read_killable(&mm->mmap_lock);
+	__mmap_lock_trace_acquire_returned(mm, false, !error);
+	return error;
 }
 
 static inline bool mmap_read_trylock(struct mm_struct *mm)
 {
-	bool ret;
+	bool ok;
 
 	__mmap_lock_trace_start_locking(mm, false);
-	ret = down_read_trylock(&mm->mmap_lock) != 0;
-	__mmap_lock_trace_acquire_returned(mm, false, ret);
-	return ret;
+	ok = down_read_trylock(&mm->mmap_lock) != 0;
+	__mmap_lock_trace_acquire_returned(mm, false, ok);
+	return ok;
 }
 
 static inline void mmap_read_unlock(struct mm_struct *mm)
-- 
2.20.1

