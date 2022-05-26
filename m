Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C05535235
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 18:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbiEZQhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 12:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344564AbiEZQge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 12:36:34 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C231948E61;
        Thu, 26 May 2022 09:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=XV1DXWrKKUyaYd2rc55uj5hiPcVYzJEV2A7rBcUZk4Q=; b=MAm+qCnVxM/C65FlKFwRk9eaTh
        sHUhQOA8U1pN6j1RcbR64Gi1JDtEar1gF/WD8Il1BKzm/JyEOXD++tsl+9zJkCbCh2ttIx73vjZai
        2M/nf7Xw+NOwPQZPtcnU2gsqcmDJdvdO5SjYWqHwEV28TMpGDWbaGyytQP7W8Qt6RJ0KJkejcvi7S
        Woy3kIHq73SNuRSW8SllyaZfDQhlTh3xRGZGgDFFiSUPMydlYdXjZ7a17c3iW50NeSxV4OKT2E1Qy
        jV8OoPeKKzibrwASWzwOX9g4bB9VS8GV03qUolDYhJVGl8E9Qo3n7DjavVILftIUwx85jLowSWSMq
        vkbqAHcw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nuGTF-008A7V-RK; Thu, 26 May 2022 10:36:22 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1nuGTA-0008Xj-6S; Thu, 26 May 2022 10:36:16 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Donald Buczek <buczek@molgen.mpg.de>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 26 May 2022 10:35:59 -0600
Message-Id: <20220526163604.32736-13-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220526163604.32736-1-logang@deltatee.com>
References: <20220526163604.32736-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, buczek@molgen.mpg.de, guoqing.jiang@linux.dev, xni@redhat.com, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v2 12/17] md/raid5-cache: Move struct r5l_log definition to raid5-log.h
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move struct r5l_log definition to raid5-log.h. While this reduces
encapsulation, it is necessary for the definition of r5l_log to be
public so that rcu_access_pointer() can be used on conf-log in the
next patch.

rcu_access_pointer(p) doesn't technically dereference the log pointer
however, it does use typeof(*p) and some older GCC versions (anything
earlier than gcc-10) will wrongly try to dereference the structure:

    include/linux/rcupdate.h:384:9: error: dereferencing pointer to
                 incomplete type ‘struct r5l_log’

      typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
           ^

    include/linux/rcupdate.h:495:31: note: in expansion of
                  macro ‘__rcu_access_pointer’

       #define rcu_access_pointer(p) __rcu_access_pointer((p),
       __UNIQUE_ID(rcu), __rcu)

To prevent this, simply provide the definition where
rcu_access_pointer() may be used.

Reported-by: Donald Buczek <buczek@molgen.mpg.de>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5-cache.c | 75 ----------------------------------------
 drivers/md/raid5-log.h   | 75 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+), 75 deletions(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index a3c4d43d6deb..6349cfaae2c8 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -79,81 +79,6 @@ static char *r5c_journal_mode_str[] = {"write-through",
  *	- return IO for pending writes
  */
 
-struct r5l_log {
-	struct md_rdev *rdev;
-
-	u32 uuid_checksum;
-
-	sector_t device_size;		/* log device size, round to
-					 * BLOCK_SECTORS */
-	sector_t max_free_space;	/* reclaim run if free space is at
-					 * this size */
-
-	sector_t last_checkpoint;	/* log tail. where recovery scan
-					 * starts from */
-	u64 last_cp_seq;		/* log tail sequence */
-
-	sector_t log_start;		/* log head. where new data appends */
-	u64 seq;			/* log head sequence */
-
-	sector_t next_checkpoint;
-
-	struct mutex io_mutex;
-	struct r5l_io_unit *current_io;	/* current io_unit accepting new data */
-
-	spinlock_t io_list_lock;
-	struct list_head running_ios;	/* io_units which are still running,
-					 * and have not yet been completely
-					 * written to the log */
-	struct list_head io_end_ios;	/* io_units which have been completely
-					 * written to the log but not yet written
-					 * to the RAID */
-	struct list_head flushing_ios;	/* io_units which are waiting for log
-					 * cache flush */
-	struct list_head finished_ios;	/* io_units which settle down in log disk */
-	struct bio flush_bio;
-
-	struct list_head no_mem_stripes;   /* pending stripes, -ENOMEM */
-
-	struct kmem_cache *io_kc;
-	mempool_t io_pool;
-	struct bio_set bs;
-	mempool_t meta_pool;
-
-	struct md_thread *reclaim_thread;
-	unsigned long reclaim_target;	/* number of space that need to be
-					 * reclaimed.  if it's 0, reclaim spaces
-					 * used by io_units which are in
-					 * IO_UNIT_STRIPE_END state (eg, reclaim
-					 * dones't wait for specific io_unit
-					 * switching to IO_UNIT_STRIPE_END
-					 * state) */
-	wait_queue_head_t iounit_wait;
-
-	struct list_head no_space_stripes; /* pending stripes, log has no space */
-	spinlock_t no_space_stripes_lock;
-
-	bool need_cache_flush;
-
-	/* for r5c_cache */
-	enum r5c_journal_mode r5c_journal_mode;
-
-	/* all stripes in r5cache, in the order of seq at sh->log_start */
-	struct list_head stripe_in_journal_list;
-
-	spinlock_t stripe_in_journal_lock;
-	atomic_t stripe_in_journal_count;
-
-	/* to submit async io_units, to fulfill ordering of flush */
-	struct work_struct deferred_io_work;
-	/* to disable write back during in degraded mode */
-	struct work_struct disable_writeback_work;
-
-	/* to for chunk_aligned_read in writeback mode, details below */
-	spinlock_t tree_lock;
-	struct radix_tree_root big_stripe_tree;
-};
-
 /*
  * Enable chunk_aligned_read() with write back cache.
  *
diff --git a/drivers/md/raid5-log.h b/drivers/md/raid5-log.h
index 1c184fe20939..5948c41f1f2e 100644
--- a/drivers/md/raid5-log.h
+++ b/drivers/md/raid5-log.h
@@ -2,6 +2,81 @@
 #ifndef _RAID5_LOG_H
 #define _RAID5_LOG_H
 
+struct r5l_log {
+	struct md_rdev *rdev;
+
+	u32 uuid_checksum;
+
+	sector_t device_size;		/* log device size, round to
+					 * BLOCK_SECTORS */
+	sector_t max_free_space;	/* reclaim run if free space is at
+					 * this size */
+
+	sector_t last_checkpoint;	/* log tail. where recovery scan
+					 * starts from */
+	u64 last_cp_seq;		/* log tail sequence */
+
+	sector_t log_start;		/* log head. where new data appends */
+	u64 seq;			/* log head sequence */
+
+	sector_t next_checkpoint;
+
+	struct mutex io_mutex;
+	struct r5l_io_unit *current_io;	/* current io_unit accepting new data */
+
+	spinlock_t io_list_lock;
+	struct list_head running_ios;	/* io_units which are still running,
+					 * and have not yet been completely
+					 * written to the log */
+	struct list_head io_end_ios;	/* io_units which have been completely
+					 * written to the log but not yet written
+					 * to the RAID */
+	struct list_head flushing_ios;	/* io_units which are waiting for log
+					 * cache flush */
+	struct list_head finished_ios;	/* io_units which settle down in log disk */
+	struct bio flush_bio;
+
+	struct list_head no_mem_stripes;   /* pending stripes, -ENOMEM */
+
+	struct kmem_cache *io_kc;
+	mempool_t io_pool;
+	struct bio_set bs;
+	mempool_t meta_pool;
+
+	struct md_thread *reclaim_thread;
+	unsigned long reclaim_target;	/* number of space that need to be
+					 * reclaimed.  if it's 0, reclaim spaces
+					 * used by io_units which are in
+					 * IO_UNIT_STRIPE_END state (eg, reclaim
+					 * dones't wait for specific io_unit
+					 * switching to IO_UNIT_STRIPE_END
+					 * state) */
+	wait_queue_head_t iounit_wait;
+
+	struct list_head no_space_stripes; /* pending stripes, log has no space */
+	spinlock_t no_space_stripes_lock;
+
+	bool need_cache_flush;
+
+	/* for r5c_cache */
+	enum r5c_journal_mode r5c_journal_mode;
+
+	/* all stripes in r5cache, in the order of seq at sh->log_start */
+	struct list_head stripe_in_journal_list;
+
+	spinlock_t stripe_in_journal_lock;
+	atomic_t stripe_in_journal_count;
+
+	/* to submit async io_units, to fulfill ordering of flush */
+	struct work_struct deferred_io_work;
+	/* to disable write back during in degraded mode */
+	struct work_struct disable_writeback_work;
+
+	/* to for chunk_aligned_read in writeback mode, details below */
+	spinlock_t tree_lock;
+	struct radix_tree_root big_stripe_tree;
+};
+
 int r5l_init_log(struct r5conf *conf, struct md_rdev *rdev);
 void r5l_exit_log(struct r5conf *conf);
 int r5l_write_stripe(struct r5conf *conf, struct stripe_head *head_sh);
-- 
2.30.2

