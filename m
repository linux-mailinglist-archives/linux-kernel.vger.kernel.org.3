Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C82757DEEC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiGVJpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235286AbiGVJof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:44:35 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90F0BB8F6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:38:54 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31cdce3ed04so35620477b3.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+nB20Wi810hrWlIP5pvDiRZ1VMjjX1lRuMuiUP0CtOE=;
        b=NqWmN2shXmLgw7TB8EYBK+ZlvxKjvonEGl6fvKWYyNnGsNALfDJs3RwdTv9cpF7cQN
         Da/3mS9qAr/skonuFDha5s9UWpMwA7xR2h56VMClowaT7ormfIfhZJpDrYsGpYx4Bux4
         eIuZ0gVc6/uUPk7vrSc/2fzYHqeogHDQPxgV9vDeEkKUyhkaIB91BK1Gozw922XbaBfY
         6DeCuT6aXFU0xHdK2ytnGorB7A5oBYy3uQBqHCQdhSDlCui9c2W77Ob0BaNhVe9ig9+7
         7a28rxquDYbLIKf1SDPYtIJpTqra0+bpHUAYjBh2x17QoF3843DUR7EfonW18iPQcVDY
         hKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+nB20Wi810hrWlIP5pvDiRZ1VMjjX1lRuMuiUP0CtOE=;
        b=m0RS7iNz/wX2qKrkRx9FIP1nIUSoyl6Au/Gipl20NeX+CTtGD+S8Hpufxp6JpeNS3T
         bc3Kikk68FRkSNZu7MYD8fE0MSmX198ngNueUUOX6cs2OgwGzXtsdTeEwLSMP37TYOaZ
         pQjKZ3AYiKr7V4z0vHqtm8Sl6wevekEj8JWTNoospRCUkiE3ZRPx83JoggPcqJ3ULV0q
         BnfnfHaHizkonjFy0SgwvcgjN8WCozLWYuHImoeEaN4azOvJ8fIj1K/1Q49TPjFDx7lj
         S8Bm/rgyc+sTtW0FRbuDRVX8P3LvQGjsSEhkXmUWmEArsqxSneSpltSkfJcCM9Oa0Hyv
         FJsw==
X-Gm-Message-State: AJIora/m3Mvlby9IRpQRfp27Y0dc+KOsHQD2/WPQDf3xK4AsM3KEPBuG
        wfNz2JGcuo5d0GkGbNnCVsgNI5860UraCHLNpx4yxdCDl/adQcufdTqxts0FUa0y7LdyOBmDyhd
        IxRdcUeA6idQH37WQOxA95PrkGS6nfX00a/j+nkJUFqoc29kfSSClAxA+9b+KXxFDXSQ=
X-Google-Smtp-Source: AGRyM1s26ZXo/6tQtihIsdDRm6L/HqasYPcozEjSaAtHWxveiAl9+jglTQqnpl6VN9mDS39c1CYZVGIwyg==
X-Received: from nhuck.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:39cc])
 (user=nhuck job=sendgmr) by 2002:a25:258:0:b0:670:a3b3:b941 with SMTP id
 85-20020a250258000000b00670a3b3b941mr2140164ybc.533.1658482733913; Fri, 22
 Jul 2022 02:38:53 -0700 (PDT)
Date:   Fri, 22 Jul 2022 09:38:23 +0000
In-Reply-To: <20220722093823.4158756-1-nhuck@google.com>
Message-Id: <20220722093823.4158756-4-nhuck@google.com>
Mime-Version: 1.0
References: <20220722093823.4158756-1-nhuck@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH 3/3] dm-verity: Add try_verify_in_tasklet
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

Using tasklets for disk verification can reduce IO latency.  When there are
accelerated hash instructions it is often better to compute the hash immediately
using a tasklet rather than deferring verification to a work-queue.  This
reduces time spent waiting to schedule work-queue jobs, but requires spending
slightly more time in interrupt context.

If the dm-bufio cache does not have the required hashes we fallback to
the work-queue implementation.

The following shows a speed comparison of random reads on a dm-verity device.
The dm-verity device uses a 1G ramdisk for data and a 1G ramdisk for hashes.
One test was run using tasklets and one test was run using the existing
work-queue solution.  Both tests were run when the dm-bufio cache was hot.  The
tasklet implementation performs significantly better since there is no time
waiting for work-queue jobs to be scheduled.

# /data/fio /data/tasklet.fio | grep READ
   READ: bw=181MiB/s (190MB/s), 181MiB/s-181MiB/s (190MB/s-190MB/s), io=512MiB
   (537MB), run=2827-2827msec
# /data/fio /data/workqueue.fio | grep READ
   READ: bw=23.6MiB/s (24.8MB/s), 23.6MiB/s-23.6MiB/s (24.8MB/s-24.8MB/s),
   io=512MiB (537MB), run=21688-21688msec

Signed-off-by: Nathan Huckleberry <nhuck@google.com>
---
 drivers/md/dm-bufio.c         | 14 +++---
 drivers/md/dm-verity-target.c | 87 ++++++++++++++++++++++++++++++-----
 drivers/md/dm-verity.h        |  5 ++
 3 files changed, 87 insertions(+), 19 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index 3edeca7cfca6..039f39c29594 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -92,7 +92,7 @@ struct dm_bufio_client {
 	s8 sectors_per_block_bits;
 	void (*alloc_callback)(struct dm_buffer *);
 	void (*write_callback)(struct dm_buffer *);
-	bool may_sleep;
+	bool get_may_sleep;
 
 	struct kmem_cache *slab_buffer;
 	struct kmem_cache *slab_cache;
@@ -170,7 +170,7 @@ struct dm_buffer {
 
 static void dm_bufio_lock(struct dm_bufio_client *c)
 {
-	if (c->may_sleep)
+	if (c->get_may_sleep)
 		mutex_lock_nested(&c->lock, dm_bufio_in_request());
 	else
 		spin_lock_irqsave_nested(&c->spinlock, c->spinlock_flags, dm_bufio_in_request());
@@ -178,7 +178,7 @@ static void dm_bufio_lock(struct dm_bufio_client *c)
 
 static int dm_bufio_trylock(struct dm_bufio_client *c)
 {
-	if (c->may_sleep)
+	if (c->get_may_sleep)
 		return mutex_trylock(&c->lock);
 	else
 		return spin_trylock_irqsave(&c->spinlock, c->spinlock_flags);
@@ -186,7 +186,7 @@ static int dm_bufio_trylock(struct dm_bufio_client *c)
 
 static void dm_bufio_unlock(struct dm_bufio_client *c)
 {
-	if (c->may_sleep)
+	if (c->get_may_sleep)
 		mutex_unlock(&c->lock);
 	else
 		spin_unlock_irqrestore(&c->spinlock, c->spinlock_flags);
@@ -890,7 +890,7 @@ static struct dm_buffer *__alloc_buffer_wait_no_callback(struct dm_bufio_client
 	 * be allocated.
 	 */
 	while (1) {
-		if (dm_bufio_cache_size_latch != 1 && c->may_sleep) {
+		if (dm_bufio_cache_size_latch != 1 && c->get_may_sleep) {
 			b = alloc_buffer(c, GFP_NOWAIT | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
 			if (b)
 				return b;
@@ -1761,9 +1761,9 @@ struct dm_bufio_client *dm_bufio_client_create(struct block_device *bdev, unsign
 	c->alloc_callback = alloc_callback;
 	c->write_callback = write_callback;
 
-	c->may_sleep = true;
+	c->get_may_sleep = true;
 	if (flags & DM_BUFIO_GET_CANT_SLEEP)
-		c->may_sleep = false;
+		c->get_may_sleep = false;
 
 	for (i = 0; i < LIST_SIZE; i++) {
 		INIT_LIST_HEAD(&c->lru[i]);
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 5d3fc58a3c34..e4d1b674a278 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -34,6 +34,7 @@
 #define DM_VERITY_OPT_PANIC		"panic_on_corruption"
 #define DM_VERITY_OPT_IGN_ZEROES	"ignore_zero_blocks"
 #define DM_VERITY_OPT_AT_MOST_ONCE	"check_at_most_once"
+#define DM_VERITY_OPT_TASKLET_VERIFY	"try_verify_in_tasklet"
 
 #define DM_VERITY_OPTS_MAX		(3 + DM_VERITY_OPTS_FEC + \
 					 DM_VERITY_ROOT_HASH_VERIFICATION_OPTS)
@@ -286,7 +287,20 @@ static int verity_verify_level(struct dm_verity *v, struct dm_verity_io *io,
 
 	verity_hash_at_level(v, block, level, &hash_block, &offset);
 
-	data = dm_bufio_read(v->bufio, hash_block, &buf);
+	if (io->in_tasklet)
+		data = dm_bufio_get(v->bufio, hash_block, &buf);
+	else
+		data = dm_bufio_read(v->bufio, hash_block, &buf);
+
+	if (data == NULL) {
+		/*
+		 * We're running as a tasklet and the hash was not in the bufio
+		 * cache.  Return early and resume execution from a work-queue
+		 * so that we can read the hash from disk.
+		 */
+		return -EAGAIN;
+	}
+
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
@@ -307,6 +321,14 @@ static int verity_verify_level(struct dm_verity *v, struct dm_verity_io *io,
 		if (likely(memcmp(verity_io_real_digest(v, io), want_digest,
 				  v->digest_size) == 0))
 			aux->hash_verified = 1;
+		else if (io->in_tasklet) {
+			/*
+			 * FEC code cannot be run in a tasklet since it may
+			 * sleep.  We need to resume execution in a work-queue
+			 * to handle FEC.
+			 */
+			return -EAGAIN;
+		}
 		else if (verity_fec_decode(v, io,
 					   DM_VERITY_BLOCK_TYPE_METADATA,
 					   hash_block, data, NULL) == 0)
@@ -474,13 +496,12 @@ static int verity_verify_io(struct dm_verity_io *io)
 	bool is_zero;
 	struct dm_verity *v = io->v;
 	struct bvec_iter start;
-	unsigned b;
 	struct crypto_wait wait;
 	struct bio *bio = dm_bio_from_per_bio_data(io, v->ti->per_io_data_size);
 
-	for (b = 0; b < io->n_blocks; b++) {
+	for (; io->block_idx < io->n_blocks; io->block_idx++) {
 		int r;
-		sector_t cur_block = io->block + b;
+		sector_t cur_block = io->block + io->block_idx;
 		struct ahash_request *req = verity_io_hash_req(v, io);
 
 		if (v->validated_blocks &&
@@ -527,6 +548,13 @@ static int verity_verify_io(struct dm_verity_io *io)
 			if (v->validated_blocks)
 				set_bit(cur_block, v->validated_blocks);
 			continue;
+		} else if (io->in_tasklet) {
+			/*
+			 * FEC code cannot be run in a tasklet since it may
+			 * sleep.  We need to resume execution in a work-queue
+			 * to handle FEC.
+			 */
+			return -EAGAIN;
 		}
 		else if (verity_fec_decode(v, io, DM_VERITY_BLOCK_TYPE_DATA,
 					   cur_block, NULL, &start) == 0)
@@ -567,7 +595,8 @@ static void verity_finish_io(struct dm_verity_io *io, blk_status_t status)
 	bio->bi_end_io = io->orig_bi_end_io;
 	bio->bi_status = status;
 
-	verity_fec_finish_io(io);
+	if (!io->in_tasklet)
+		verity_fec_finish_io(io);
 
 	bio_endio(bio);
 }
@@ -575,8 +604,28 @@ static void verity_finish_io(struct dm_verity_io *io, blk_status_t status)
 static void verity_work(struct work_struct *w)
 {
 	struct dm_verity_io *io = container_of(w, struct dm_verity_io, work);
+	int err;
+
+	io->in_tasklet = false;
+	err = verity_verify_io(io);
 
-	verity_finish_io(io, errno_to_blk_status(verity_verify_io(io)));
+	verity_finish_io(io, errno_to_blk_status(err));
+}
+
+static void verity_tasklet(unsigned long data)
+{
+	struct dm_verity_io *io = (struct dm_verity_io *) data;
+	int err;
+
+	io->in_tasklet = true;
+	err = verity_verify_io(io);
+	if (err) {
+		INIT_WORK(&io->work, verity_work);
+		queue_work(io->v->verify_wq, &io->work);
+		return;
+	}
+
+	verity_finish_io(io, errno_to_blk_status(err));
 }
 
 static void verity_end_io(struct bio *bio)
@@ -589,8 +638,14 @@ static void verity_end_io(struct bio *bio)
 		return;
 	}
 
-	INIT_WORK(&io->work, verity_work);
-	queue_work(io->v->verify_wq, &io->work);
+	io->block_idx = 0;
+	if (io->v->use_tasklet) {
+		tasklet_init(&io->tasklet, verity_tasklet, (unsigned long)io);
+		tasklet_schedule(&io->tasklet);
+	} else {
+		INIT_WORK(&io->work, verity_work);
+		queue_work(io->v->verify_wq, &io->work);
+	}
 }
 
 /*
@@ -1012,7 +1067,12 @@ static int verity_parse_opt_args(struct dm_arg_set *as, struct dm_verity *v,
 				return r;
 			continue;
 
-		} else if (verity_is_fec_opt_arg(arg_name)) {
+		} else if (!strcasecmp(arg_name, DM_VERITY_OPT_TASKLET_VERIFY)) {
+			v->use_tasklet = true;
+			continue;
+		}
+
+		else if (verity_is_fec_opt_arg(arg_name)) {
 			r = verity_fec_parse_opt_args(as, v, &argc, arg_name);
 			if (r)
 				return r;
@@ -1068,6 +1128,7 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 	}
 	ti->private = v;
 	v->ti = ti;
+	v->use_tasklet = false;
 
 	r = verity_fec_ctr_alloc(v);
 	if (r)
@@ -1156,7 +1217,7 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 		goto bad;
 	}
 
-	v->tfm = crypto_alloc_ahash(v->alg_name, 0, 0);
+	v->tfm = crypto_alloc_ahash(v->alg_name, 0, CRYPTO_ALG_ASYNC);
 	if (IS_ERR(v->tfm)) {
 		ti->error = "Cannot initialize hash function";
 		r = PTR_ERR(v->tfm);
@@ -1266,7 +1327,8 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 
 	v->bufio = dm_bufio_client_create(v->hash_dev->bdev,
 		1 << v->hash_dev_block_bits, 1, sizeof(struct buffer_aux),
-		dm_bufio_alloc_callback, NULL, 0);
+		dm_bufio_alloc_callback, NULL, v->use_tasklet ?
+		DM_BUFIO_GET_CANT_SLEEP : 0);
 	if (IS_ERR(v->bufio)) {
 		ti->error = "Cannot initialize dm-bufio";
 		r = PTR_ERR(v->bufio);
@@ -1281,7 +1343,8 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 	}
 
 	/* WQ_UNBOUND greatly improves performance when running on ramdisk */
-	v->verify_wq = alloc_workqueue("kverityd", WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM | WQ_UNBOUND, num_online_cpus());
+	v->verify_wq = alloc_workqueue("kverityd", WQ_HIGHPRI | WQ_MEM_RECLAIM |
+						   WQ_UNBOUND, num_online_cpus());
 	if (!v->verify_wq) {
 		ti->error = "Cannot allocate workqueue";
 		r = -ENOMEM;
diff --git a/drivers/md/dm-verity.h b/drivers/md/dm-verity.h
index 4e769d13473a..4e65f93bd8d6 100644
--- a/drivers/md/dm-verity.h
+++ b/drivers/md/dm-verity.h
@@ -13,6 +13,7 @@
 
 #include <linux/dm-bufio.h>
 #include <linux/device-mapper.h>
+#include <linux/interrupt.h>
 #include <crypto/hash.h>
 
 #define DM_VERITY_MAX_LEVELS		63
@@ -50,6 +51,7 @@ struct dm_verity {
 	unsigned char hash_dev_block_bits;	/* log2(hash blocksize) */
 	unsigned char hash_per_block_bits;	/* log2(hashes in hash block) */
 	unsigned char levels;	/* the number of tree levels */
+	bool use_tasklet;	/* try to verify in tasklet before work-queue */
 	unsigned char version;
 	unsigned digest_size;	/* digest size for the current hash algorithm */
 	unsigned int ahash_reqsize;/* the size of temporary space for crypto */
@@ -76,10 +78,13 @@ struct dm_verity_io {
 
 	sector_t block;
 	unsigned n_blocks;
+	unsigned int block_idx;
+	bool in_tasklet;
 
 	struct bvec_iter iter;
 
 	struct work_struct work;
+	struct tasklet_struct tasklet;
 
 	/*
 	 * Three variably-size fields follow this struct:
-- 
2.37.1.359.gd136c6c3e2-goog

