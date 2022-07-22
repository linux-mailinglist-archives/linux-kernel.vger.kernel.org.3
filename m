Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3997857DF02
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbiGVJo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234643AbiGVJob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:44:31 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EAABB8E0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:38:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id m123-20020a253f81000000b0066ff6484995so3324897yba.22
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0HvoRxN2Vq0/Bi3xt58hq8m4jj9hpFn+i7fw2drMGQc=;
        b=rQP+Tru3fYyh2EUytXVRTQMhbH4x9vMaL4BCxtqbAMHLZeOSnAzZETqPWY1yuNQdt+
         wBT5SXNEJZirRIcmB/75TQkdR8/ZDn7n0zIV8/wfsfQdlVwu3J9gq9UVC+DCEWZcHK9t
         1UQb/rDV1iVdWFKxVVtTMLHp57Dg9AiKDYKElHq0R7xIduVsHkqNjZXJjc1iccHM4fJE
         jfMfmm9Te2uAVd+/y0Gh3MDgcVDs+iTiVxK5LeZU41d0NWfwdBAz5eDI23Mg9auSxrGg
         kLJCrc9E+m/2DFovGiEVLwZUfuBN+hUm6bqypCIroe0/K2DaG1yzoBAc0s4lWceU0IeI
         Jm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0HvoRxN2Vq0/Bi3xt58hq8m4jj9hpFn+i7fw2drMGQc=;
        b=UpvQ/9kM9oPFWP1otYU4Q3PT0y1PYapk75soNqSOywnnG+oBmueH9uHIK/TgIrquyR
         kRVseWaOQbznDusSMHRRXRN/gDtDrS6Cf6ZhAYjilOUC8kflGO+jcuvftk20lbBpLPLo
         y2jp26mQ1P3DMW/Ubzw25y4Oyti2+zYs1g9mxkMxvp8INYLNAvi5YLp94kPEwozlXenX
         FrVPnqMucD2M0ukLXiYWgsHukdWXRA49Yz7a70h3WFhXk+s0TDlof/Wdz0SJDDd/NoHW
         0nIJ8IqwDCh9ABrizqcfkwb5dwtJMPyk6UEN0KJMxJC6CRyHZkCagCysOA63fUDftHl+
         xmqA==
X-Gm-Message-State: AJIora/e9y8P9p0ydiZEiA2lpFo9JG4hgtYCDpJpGGpI7VNj2t7lvuHQ
        pLffzbM+TosUOKGvLBcUKq1dj/Td5TBVyT7woHT9+5YGGv8vrUi9n9RnTrR6HpuBHKgA2FIytOh
        BgGUC/sPtDsMkVsSUyWwjAVNI7rNQT7sJfIOcrnx8efZ5GuMWBn+qMs0xfyzjZkN+QZg=
X-Google-Smtp-Source: AGRyM1vrqyRWf0OgG6fTxyUyuG16olDyk74u0WLdD/aZC47eoaJHVQNRfVoKKDTJI4OkFZyLIEFXkpH0+Q==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a25:fc21:0:b0:670:8160:a9f9 with SMTP id
 v33-20020a25fc21000000b006708160a9f9mr2134064ybd.513.1658482731701; Fri, 22
 Jul 2022 02:38:51 -0700 (PDT)
Date:   Fri, 22 Jul 2022 09:38:22 +0000
In-Reply-To: <20220722093823.4158756-1-nhuck@google.com>
Message-Id: <20220722093823.4158756-3-nhuck@google.com>
Mime-Version: 1.0
References: <20220722093823.4158756-1-nhuck@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH 2/3] dm-bufio: Add DM_BUFIO_GET_CANT_SLEEP
From:   Nathan Huckleberry <nhuck@google.com>
To:     linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Huckleberry <nhuck@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an optional flag that ensures dm_bufio_get does not sleep.  This
allows the dm-bufio cache to be queried from interrupt context.

To ensure that dm-bufio does not sleep, dm-bufio must use a spinlock
instead of a mutex.  Additionally, to avoid deadlocks, special care must
be taken so that dm-bufio does not sleep while holding the spinlock.

DM_BUFIO_GET_CANT_SLEEP is useful in some contexts, such as dm-verity,
so that we can query the dm-bufio cache in a tasklet.  If the required
data is cached, processing can be handled immediately in the tasklet
instead of waiting for a work-queue job to be scheduled.  This can
reduce latency when there is high CPU load and memory pressure.

Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 drivers/md/dm-bufio.c    | 26 ++++++++++++++++++++++----
 include/linux/dm-bufio.h |  5 +++++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index ad5603eb12e3..3edeca7cfca6 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -81,6 +81,8 @@
  */
 struct dm_bufio_client {
 	struct mutex lock;
+	spinlock_t spinlock;
+	unsigned long spinlock_flags;
 
 	struct list_head lru[LIST_SIZE];
 	unsigned long n_buffers[LIST_SIZE];
@@ -90,6 +92,7 @@ struct dm_bufio_client {
 	s8 sectors_per_block_bits;
 	void (*alloc_callback)(struct dm_buffer *);
 	void (*write_callback)(struct dm_buffer *);
+	bool may_sleep;
 
 	struct kmem_cache *slab_buffer;
 	struct kmem_cache *slab_cache;
@@ -167,17 +170,26 @@ struct dm_buffer {
 
 static void dm_bufio_lock(struct dm_bufio_client *c)
 {
-	mutex_lock_nested(&c->lock, dm_bufio_in_request());
+	if (c->may_sleep)
+		mutex_lock_nested(&c->lock, dm_bufio_in_request());
+	else
+		spin_lock_irqsave_nested(&c->spinlock, c->spinlock_flags, dm_bufio_in_request());
 }
 
 static int dm_bufio_trylock(struct dm_bufio_client *c)
 {
-	return mutex_trylock(&c->lock);
+	if (c->may_sleep)
+		return mutex_trylock(&c->lock);
+	else
+		return spin_trylock_irqsave(&c->spinlock, c->spinlock_flags);
 }
 
 static void dm_bufio_unlock(struct dm_bufio_client *c)
 {
-	mutex_unlock(&c->lock);
+	if (c->may_sleep)
+		mutex_unlock(&c->lock);
+	else
+		spin_unlock_irqrestore(&c->spinlock, c->spinlock_flags);
 }
 
 /*----------------------------------------------------------------*/
@@ -878,7 +890,7 @@ static struct dm_buffer *__alloc_buffer_wait_no_callback(struct dm_bufio_client
 	 * be allocated.
 	 */
 	while (1) {
-		if (dm_bufio_cache_size_latch != 1) {
+		if (dm_bufio_cache_size_latch != 1 && c->may_sleep) {
 			b = alloc_buffer(c, GFP_NOWAIT | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
 			if (b)
 				return b;
@@ -1041,6 +1053,7 @@ static struct dm_buffer *__bufio_new(struct dm_bufio_client *c, sector_t block,
 	if (nf == NF_GET && unlikely(test_bit(B_READING, &b->state)))
 		return NULL;
 
+
 	b->hold_count++;
 	__relink_lru(b, test_bit(B_DIRTY, &b->state) ||
 		     test_bit(B_WRITING, &b->state));
@@ -1748,12 +1761,17 @@ struct dm_bufio_client *dm_bufio_client_create(struct block_device *bdev, unsign
 	c->alloc_callback = alloc_callback;
 	c->write_callback = write_callback;
 
+	c->may_sleep = true;
+	if (flags & DM_BUFIO_GET_CANT_SLEEP)
+		c->may_sleep = false;
+
 	for (i = 0; i < LIST_SIZE; i++) {
 		INIT_LIST_HEAD(&c->lru[i]);
 		c->n_buffers[i] = 0;
 	}
 
 	mutex_init(&c->lock);
+	spin_lock_init(&c->spinlock);
 	INIT_LIST_HEAD(&c->reserved_buffers);
 	c->need_reserved_buffers = reserved_buffers;
 
diff --git a/include/linux/dm-bufio.h b/include/linux/dm-bufio.h
index e21480715255..2a78f0cb8e71 100644
--- a/include/linux/dm-bufio.h
+++ b/include/linux/dm-bufio.h
@@ -17,6 +17,11 @@
 struct dm_bufio_client;
 struct dm_buffer;
 
+/*
+ * Flags for dm_bufio_client_create
+ */
+#define DM_BUFIO_GET_CANT_SLEEP 0x1
+
 /*
  * Create a buffered IO cache on a given device
  */
-- 
2.37.1.359.gd136c6c3e2-goog

