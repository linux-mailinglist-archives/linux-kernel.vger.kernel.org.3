Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7945D46A3D0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346424AbhLFSQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243979AbhLFSQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:16:52 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A713FC0613F8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 10:13:23 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id e128so14018417iof.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 10:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=qsGHWKlRL0FcytNASgJPybxWZUvk7wsCcsRkqLUsBNA=;
        b=M3Dzy91tXYVnStLIjGWmyPEViP5WZW1F+ELSj8BCWlk59JJrEzRWBZnhzAptQY46JX
         /7F1KhaSQNUyS2jVH/m3Xo1jzqMFHIXX2m9M6SLFqVSgipRb9rSW1qUD3+mP3SK9QAHQ
         ka09taEtIG4EfPceBC9OpBuKdPMRThat0bvshmLq97ixK6k/uZZeRoRQtC3ZoM+gmdQr
         0xEGti9a+3tYDHxABzpcRybBXHap0U6y8gfplUP/U1HTEWF4B5DZrCeAHFZOAOmdr5Ds
         GoeitWo4y4D+KvM7JPaMi6rdcNdvbIvqUk4194ZXwsleCHnJpZ/m6GAsAouzxekpydQ0
         F3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=qsGHWKlRL0FcytNASgJPybxWZUvk7wsCcsRkqLUsBNA=;
        b=Q+0+wm2d2vRJ58Mw1MwhkJor0tCbOUFF7lwnd6fDDGs1kYgwvvVuyPOX2aLjkNH29v
         roDtZEu8EIqVQ5NncVrf6xn+qkYDYl/35siTa+iQrD4+Jj/FlE0Gsd3E2Gm0Z9JQDzeL
         Bko1nrsynhvAMWw4mZCFsN05DsA6Vw7DqwqeSkamaKb8Hh6s0UsVUyxutQY3HSdqtD71
         9rVWjcM6JqxO2MYWdZ5NdP+u/Dv8e4WzUUynzr4cCJw8c0FgFXrTeGE82+c4wmknrTBs
         CkrsropU7/WXVEoGVou+wFfDzrYypgUPrIkhG1gfGro3a7bxjC6lEab5orz5BDcD8blS
         8nnA==
X-Gm-Message-State: AOAM531OFS0bVpeGsVHAz97Ifa+OFqgiwfd4CU92Ri6BE4XkY0TgRBbh
        5UZUOz0CCIkzwdhDCYyfTLJ3jA0WWwRKmm/b
X-Google-Smtp-Source: ABdhPJzCxuGA96FQWyqv142ozJMMndel16hQNoB8CFdFAYiPlk2KCZzyUHIS6Y5MqH4N02fqmiTOHw==
X-Received: by 2002:a5d:8888:: with SMTP id d8mr34848467ioo.217.1638814402772;
        Mon, 06 Dec 2021 10:13:22 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id l3sm8510973ilv.37.2021.12.06.10.13.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 10:13:21 -0800 (PST)
Subject: Re: [PATCH] block: switch to atomic_t for request references
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org>
 <Ya3KZiLg5lYjsGcQ@hirez.programming.kicks-ass.net>
 <CAHk-=wjXmGt9-JQp-wvup4y2tFNUCVjvx2W7MHzuAaxpryP4mg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <282666e2-93d4-0302-b2d0-47d03395a6d4@kernel.dk>
Date:   Mon, 6 Dec 2021 11:13:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjXmGt9-JQp-wvup4y2tFNUCVjvx2W7MHzuAaxpryP4mg@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------5E8153C5F8A865ED65BA2BE8"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5E8153C5F8A865ED65BA2BE8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 12/6/21 10:35 AM, Linus Torvalds wrote:
> On Mon, Dec 6, 2021 at 12:31 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> Quite; and for something that pretends to be about performance, it also
>> lacks any actual numbers to back that claim.
>>
>> The proposed implementation also doesn't do nearly as much as the
>> refcount_t one does.
> 
> Stop pretending refcoutn_t is that great.
> 
> It's horrid. The code it generators is disgusting. It should never
> have been inlines in the first place, and the design decsisions were
> questionable to begin with.
> 
> There's a reason core stuff (like the page counters) DO NOT USE REFCOUNT_T.
> 
> I seriously believe that refcount_t should be used for things like
> device reference counting or similar issues, and not for _any_ truly
> core code.

Maybe we just need to embrace it generically, took a quick stab at it
which is attached. Totally untested...

-- 
Jens Axboe


--------------5E8153C5F8A865ED65BA2BE8
Content-Type: text/x-patch; charset=UTF-8;
 name="0004-mm-convert-to-using-atomic-ref.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0004-mm-convert-to-using-atomic-ref.patch"

From 2a755b779681c300261ec38007b482ae8257cfc1 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Mon, 6 Dec 2021 11:11:36 -0700
Subject: [PATCH 4/4] mm: convert to using atomic-ref

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/mm.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a7e4a9e7d807..954a74492b5a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -32,6 +32,7 @@
 #include <linux/sched.h>
 #include <linux/pgtable.h>
 #include <linux/kasan.h>
+#include <linux/atomic-ref.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -1181,10 +1182,6 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
 		page->pgmap->type == MEMORY_DEVICE_PCI_P2PDMA;
 }
 
-/* 127: arbitrary random number, small enough to assemble well */
-#define folio_ref_zero_or_close_to_overflow(folio) \
-	((unsigned int) folio_ref_count(folio) + 127u <= 127u)
-
 /**
  * folio_get - Increment the reference count on a folio.
  * @folio: The folio.
@@ -1195,7 +1192,7 @@ static inline bool is_pci_p2pdma_page(const struct page *page)
  */
 static inline void folio_get(struct folio *folio)
 {
-	VM_BUG_ON_FOLIO(folio_ref_zero_or_close_to_overflow(folio), folio);
+	VM_BUG_ON_FOLIO(atomic_ref_zero_or_close_to_overflow(&folio->page._refcount), folio);
 	folio_ref_inc(folio);
 }
 
-- 
2.34.1


--------------5E8153C5F8A865ED65BA2BE8
Content-Type: text/x-patch; charset=UTF-8;
 name="0003-block-convert-to-using-atomic-ref.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0003-block-convert-to-using-atomic-ref.patch"

From 784487e60aceb37cf0b6664e8949a87ea27a0cd2 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Mon, 6 Dec 2021 11:11:19 -0700
Subject: [PATCH 3/4] block: convert to using atomic-ref

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-flush.c      |  4 ++--
 block/blk-mq-tag.c     |  2 +-
 block/blk-mq.c         | 12 ++++++------
 block/blk.h            | 31 -------------------------------
 include/linux/blk-mq.h |  1 +
 5 files changed, 10 insertions(+), 40 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index e4df894189ce..e957902af17c 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -229,7 +229,7 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 	/* release the tag's ownership to the req cloned from */
 	spin_lock_irqsave(&fq->mq_flush_lock, flags);
 
-	if (!req_ref_put_and_test(flush_rq)) {
+	if (!atomic_ref_put_and_test(&flush_rq->ref)) {
 		fq->rq_status = error;
 		spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
 		return;
@@ -349,7 +349,7 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 	 * and READ flush_rq->end_io
 	 */
 	smp_wmb();
-	req_ref_set(flush_rq, 1);
+	atomic_set(&flush_rq->ref, 1);
 
 	blk_flush_queue_rq(flush_rq, false);
 }
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 380e2dd31bfc..d9f961320652 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -228,7 +228,7 @@ static struct request *blk_mq_find_and_get_req(struct blk_mq_tags *tags,
 
 	spin_lock_irqsave(&tags->lock, flags);
 	rq = tags->rqs[bitnr];
-	if (!rq || rq->tag != bitnr || !req_ref_inc_not_zero(rq))
+	if (!rq || rq->tag != bitnr || !atomic_ref_inc_not_zero(&rq->ref))
 		rq = NULL;
 	spin_unlock_irqrestore(&tags->lock, flags);
 	return rq;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0bf3523dd1f5..2be5557a77c9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -386,7 +386,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	INIT_LIST_HEAD(&rq->queuelist);
 	/* tag was already set */
 	WRITE_ONCE(rq->deadline, 0);
-	req_ref_set(rq, 1);
+	atomic_set(&rq->ref, 1);
 
 	if (rq->rq_flags & RQF_ELV) {
 		struct elevator_queue *e = data->q->elevator;
@@ -634,7 +634,7 @@ void blk_mq_free_request(struct request *rq)
 	rq_qos_done(q, rq);
 
 	WRITE_ONCE(rq->state, MQ_RQ_IDLE);
-	if (req_ref_put_and_test(rq))
+	if (atomic_ref_put_and_test(&rq->ref))
 		__blk_mq_free_request(rq);
 }
 EXPORT_SYMBOL_GPL(blk_mq_free_request);
@@ -930,7 +930,7 @@ void blk_mq_end_request_batch(struct io_comp_batch *iob)
 		rq_qos_done(rq->q, rq);
 
 		WRITE_ONCE(rq->state, MQ_RQ_IDLE);
-		if (!req_ref_put_and_test(rq))
+		if (!atomic_ref_put_and_test(&rq->ref))
 			continue;
 
 		blk_crypto_free_request(rq);
@@ -1373,7 +1373,7 @@ void blk_mq_put_rq_ref(struct request *rq)
 {
 	if (is_flush_rq(rq))
 		rq->end_io(rq, 0);
-	else if (req_ref_put_and_test(rq))
+	else if (atomic_ref_put_and_test(&rq->ref))
 		__blk_mq_free_request(rq);
 }
 
@@ -3005,7 +3005,7 @@ static void blk_mq_clear_rq_mapping(struct blk_mq_tags *drv_tags,
 			unsigned long rq_addr = (unsigned long)rq;
 
 			if (rq_addr >= start && rq_addr < end) {
-				WARN_ON_ONCE(req_ref_read(rq) != 0);
+				WARN_ON_ONCE(atomic_read(&rq->ref) != 0);
 				cmpxchg(&drv_tags->rqs[i], rq, NULL);
 			}
 		}
@@ -3339,7 +3339,7 @@ static void blk_mq_clear_flush_rq_mapping(struct blk_mq_tags *tags,
 	if (!tags)
 		return;
 
-	WARN_ON_ONCE(req_ref_read(flush_rq) != 0);
+	WARN_ON_ONCE(atomic_read(&flush_rq->ref) != 0);
 
 	for (i = 0; i < queue_depth; i++)
 		cmpxchg(&tags->rqs[i], flush_rq, NULL);
diff --git a/block/blk.h b/block/blk.h
index 7ccb7c7d86b3..0114e18b9903 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -469,35 +469,4 @@ static inline bool should_fail_request(struct block_device *part,
 }
 #endif /* CONFIG_FAIL_MAKE_REQUEST */
 
-/*
- * Optimized request reference counting. Ideally we'd make timeouts be more
- * clever, as that's the only reason we need references at all... But until
- * this happens, this is faster than using refcount_t. Also see:
- *
- * abc54d634334 ("io_uring: switch to atomic_t for io_kiocb reference count")
- */
-#define req_ref_zero_or_close_to_overflow(req)	\
-	((unsigned int) atomic_read(&(req->ref)) + 127u <= 127u)
-
-static inline bool req_ref_inc_not_zero(struct request *req)
-{
-	return atomic_inc_not_zero(&req->ref);
-}
-
-static inline bool req_ref_put_and_test(struct request *req)
-{
-	WARN_ON_ONCE(req_ref_zero_or_close_to_overflow(req));
-	return atomic_dec_and_test(&req->ref);
-}
-
-static inline void req_ref_set(struct request *req, int value)
-{
-	atomic_set(&req->ref, value);
-}
-
-static inline int req_ref_read(struct request *req)
-{
-	return atomic_read(&req->ref);
-}
-
 #endif /* BLK_INTERNAL_H */
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index ecdc049b52fa..02abf08f5765 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -7,6 +7,7 @@
 #include <linux/lockdep.h>
 #include <linux/scatterlist.h>
 #include <linux/prefetch.h>
+#include <linux/atomic-ref.h>
 
 struct blk_mq_tags;
 struct blk_flush_queue;
-- 
2.34.1


--------------5E8153C5F8A865ED65BA2BE8
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-io_uring-convert-to-using-atomic-ref.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0002-io_uring-convert-to-using-atomic-ref.patch"

From a2e04d4d855f85faa913399f4fadedf45d09142a Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Mon, 6 Dec 2021 11:11:00 -0700
Subject: [PATCH 2/4] io_uring: convert to using atomic-ref

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 59fd8b785262..2ce076fd85dc 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -81,6 +81,7 @@
 #include <linux/tracehook.h>
 #include <linux/audit.h>
 #include <linux/security.h>
+#include <linux/atomic-ref.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/io_uring.h>
@@ -1170,17 +1171,10 @@ static inline void io_tw_lock(struct io_ring_ctx *ctx, bool *locked)
 #define io_for_each_link(pos, head) \
 	for (pos = (head); pos; pos = pos->link)
 
-/*
- * Shamelessly stolen from the mm implementation of page reference checking,
- * see commit f958d7b528b1 for details.
- */
-#define req_ref_zero_or_close_to_overflow(req)	\
-	((unsigned int) atomic_read(&(req->refs)) + 127u <= 127u)
-
 static inline bool req_ref_inc_not_zero(struct io_kiocb *req)
 {
 	WARN_ON_ONCE(!(req->flags & REQ_F_REFCOUNT));
-	return atomic_inc_not_zero(&req->refs);
+	return atomic_ref_inc_not_zero(&req->refs);
 }
 
 static inline bool req_ref_put_and_test(struct io_kiocb *req)
@@ -1188,21 +1182,19 @@ static inline bool req_ref_put_and_test(struct io_kiocb *req)
 	if (likely(!(req->flags & REQ_F_REFCOUNT)))
 		return true;
 
-	WARN_ON_ONCE(req_ref_zero_or_close_to_overflow(req));
-	return atomic_dec_and_test(&req->refs);
+	return atomic_ref_put_and_test(&req->refs);
 }
 
 static inline void req_ref_put(struct io_kiocb *req)
 {
 	WARN_ON_ONCE(!(req->flags & REQ_F_REFCOUNT));
-	WARN_ON_ONCE(req_ref_put_and_test(req));
+	atomic_ref_put(&req->refs);
 }
 
 static inline void req_ref_get(struct io_kiocb *req)
 {
 	WARN_ON_ONCE(!(req->flags & REQ_F_REFCOUNT));
-	WARN_ON_ONCE(req_ref_zero_or_close_to_overflow(req));
-	atomic_inc(&req->refs);
+	atomic_ref_get(&req->refs);
 }
 
 static inline void io_submit_flush_completions(struct io_ring_ctx *ctx)
-- 
2.34.1


--------------5E8153C5F8A865ED65BA2BE8
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-atomic-ref-add-basic-infrastructure-for-atomic-refs-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-atomic-ref-add-basic-infrastructure-for-atomic-refs-.pa";
 filename*1="tch"

From cfec670a6240b84173f3b3719a24df9a4c7424e5 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Mon, 6 Dec 2021 10:54:55 -0700
Subject: [PATCH 1/4] atomic-ref: add basic infrastructure for atomic refs
 based on atomic_t

Make the atomic_t reference counting from commit f958d7b528b1 generic
and available for other users.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/atomic-ref.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 include/linux/atomic-ref.h

diff --git a/include/linux/atomic-ref.h b/include/linux/atomic-ref.h
new file mode 100644
index 000000000000..dfba69dd9d37
--- /dev/null
+++ b/include/linux/atomic-ref.h
@@ -0,0 +1,33 @@
+#ifndef LINUX_ATOMIC_REF_H
+#define LINUX_ATOMIC_REF_H
+
+/*
+ * Shamelessly stolen from the mm implementation of page reference checking,
+ * see commit f958d7b528b1 for details.
+ */
+#define atomic_ref_zero_or_close_to_overflow(ref)	\
+	((unsigned int) atomic_read(ref) + 127u <= 127u)
+
+static inline bool atomic_ref_inc_not_zero(atomic_t *ref)
+{
+	return atomic_inc_not_zero(ref);
+}
+
+static inline bool atomic_ref_put_and_test(atomic_t *ref)
+{
+	WARN_ON_ONCE(atomic_ref_zero_or_close_to_overflow(ref));
+	return atomic_dec_and_test(ref);
+}
+
+static inline void atomic_ref_put(atomic_t *ref)
+{
+	WARN_ON_ONCE(atomic_ref_put_and_test(ref));
+}
+
+static inline void atomic_ref_get(atomic_t *ref)
+{
+	WARN_ON_ONCE(atomic_ref_zero_or_close_to_overflow(ref));
+	atomic_inc(ref);
+}
+
+#endif
-- 
2.34.1


--------------5E8153C5F8A865ED65BA2BE8--
