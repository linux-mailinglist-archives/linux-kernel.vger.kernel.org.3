Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8AAC539B9B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 05:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349365AbiFADXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 23:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349345AbiFADWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 23:22:48 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065B724BEA
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 20:22:46 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1654053764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T89RqJO8IhkqlUZhTFmUMnr0lGbx4N+BTwEYJwR4CFU=;
        b=GZW+p+uZhpOy0qUYu1auGMIS0rxihhuxmXLSVVIJE2TRXyQb2T+UMh3jI3f7pavpSNCp43
        pbG8fdbIEsDJaO4BgvTnIM6th6ZjBheGXrWJJ7i8aqvr8Foj1gva1AgwjiO9jY9KF61kPM
        pRAuSZCeXdlR4mbfFdLEmZGEKdqr7gQ=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Dave Chinner <dchinner@redhat.com>, linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v5 3/6] mm: shrinkers: provide shrinkers with names
Date:   Tue, 31 May 2022 20:22:24 -0700
Message-Id: <20220601032227.4076670-4-roman.gushchin@linux.dev>
In-Reply-To: <20220601032227.4076670-1-roman.gushchin@linux.dev>
References: <20220601032227.4076670-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently shrinkers are anonymous objects. For debugging purposes they
can be identified by count/scan function names, but it's not always
useful: e.g. for superblock's shrinkers it's nice to have at least
an idea of to which superblock the shrinker belongs.

This commit adds names to shrinkers. register_shrinker() and
prealloc_shrinker() functions are extended to take a format and
arguments to master a name.

In some cases it's not possible to determine a good name at the time
when a shrinker is allocated. For such cases shrinker_debugfs_rename()
is provided.

The expected format is:
    <subsystem>-<shrinker_type>[:<instance>]-<id>
For some shrinkers an instance can be encoded as (MAJOR:MINOR) pair.

After this change the shrinker debugfs directory looks like:
  $ cd /sys/kernel/debug/shrinker/
  $ ls
    dquota-cache-16     sb-devpts-28     sb-proc-47       sb-tmpfs-42
    mm-shadow-18        sb-devtmpfs-5    sb-proc-48       sb-tmpfs-43
    mm-zspool:zram0-34  sb-hugetlbfs-17  sb-pstore-31     sb-tmpfs-44
    rcu-kfree-0         sb-hugetlbfs-33  sb-rootfs-2      sb-tmpfs-49
    sb-aio-20           sb-iomem-12      sb-securityfs-6  sb-tracefs-13
    sb-anon_inodefs-15  sb-mqueue-21     sb-selinuxfs-22  sb-xfs:vda1-36
    sb-bdev-3           sb-nsfs-4        sb-sockfs-8      sb-zsmalloc-19
    sb-bpf-32           sb-pipefs-14     sb-sysfs-26      thp-deferred_split-10
    sb-btrfs:vda2-24    sb-proc-25       sb-tmpfs-1       thp-zero-9
    sb-cgroup2-30       sb-proc-39       sb-tmpfs-27      xfs-buf:vda1-37
    sb-configfs-23      sb-proc-41       sb-tmpfs-29      xfs-inodegc:vda1-38
    sb-dax-11           sb-proc-45       sb-tmpfs-35
    sb-debugfs-7        sb-proc-46       sb-tmpfs-40

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 arch/x86/kvm/mmu/mmu.c                        |  2 +-
 drivers/android/binder_alloc.c                |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_shrinker.c  |  3 +-
 drivers/gpu/drm/msm/msm_gem_shrinker.c        |  2 +-
 .../gpu/drm/panfrost/panfrost_gem_shrinker.c  |  2 +-
 drivers/gpu/drm/ttm/ttm_pool.c                |  2 +-
 drivers/md/bcache/btree.c                     |  2 +-
 drivers/md/dm-bufio.c                         |  3 +-
 drivers/md/dm-zoned-metadata.c                |  4 +-
 drivers/md/raid5.c                            |  2 +-
 drivers/misc/vmw_balloon.c                    |  2 +-
 drivers/virtio/virtio_balloon.c               |  2 +-
 drivers/xen/xenbus/xenbus_probe_backend.c     |  2 +-
 fs/btrfs/super.c                              |  2 +
 fs/erofs/utils.c                              |  2 +-
 fs/ext4/extents_status.c                      |  3 +-
 fs/f2fs/super.c                               |  2 +-
 fs/gfs2/glock.c                               |  2 +-
 fs/gfs2/main.c                                |  2 +-
 fs/jbd2/journal.c                             |  3 +-
 fs/mbcache.c                                  |  2 +-
 fs/nfs/nfs42xattr.c                           |  7 ++-
 fs/nfs/super.c                                |  2 +-
 fs/nfsd/filecache.c                           |  2 +-
 fs/nfsd/nfscache.c                            |  3 +-
 fs/quota/dquot.c                              |  2 +-
 fs/super.c                                    |  6 +-
 fs/ubifs/super.c                              |  2 +-
 fs/xfs/xfs_buf.c                              |  3 +-
 fs/xfs/xfs_icache.c                           |  2 +-
 fs/xfs/xfs_qm.c                               |  3 +-
 include/linux/shrinker.h                      | 12 +++-
 kernel/rcu/tree.c                             |  2 +-
 mm/huge_memory.c                              |  4 +-
 mm/shrinker_debug.c                           | 47 ++++++++++++++-
 mm/vmscan.c                                   | 58 ++++++++++++++++++-
 mm/workingset.c                               |  2 +-
 mm/zsmalloc.c                                 |  3 +-
 net/sunrpc/auth.c                             |  2 +-
 39 files changed, 165 insertions(+), 45 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index f9080ee50ffa..6dd2756b91fc 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6283,7 +6283,7 @@ int kvm_mmu_vendor_module_init(void)
 	if (percpu_counter_init(&kvm_total_used_mmu_pages, 0, GFP_KERNEL))
 		goto out;
 
-	ret = register_shrinker(&mmu_shrinker);
+	ret = register_shrinker(&mmu_shrinker, "x86-mmu");
 	if (ret)
 		goto out;
 
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 2ac1008a5f39..213e0094d3ff 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -1084,7 +1084,7 @@ int binder_alloc_shrinker_init(void)
 	int ret = list_lru_init(&binder_alloc_lru);
 
 	if (ret == 0) {
-		ret = register_shrinker(&binder_shrinker);
+		ret = register_shrinker(&binder_shrinker, "android-binder");
 		if (ret)
 			list_lru_destroy(&binder_alloc_lru);
 	}
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shrinker.c b/drivers/gpu/drm/i915/gem/i915_gem_shrinker.c
index 6a6ff98a8746..e43577e03067 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shrinker.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shrinker.c
@@ -426,7 +426,8 @@ void i915_gem_driver_register__shrinker(struct drm_i915_private *i915)
 	i915->mm.shrinker.count_objects = i915_gem_shrinker_count;
 	i915->mm.shrinker.seeks = DEFAULT_SEEKS;
 	i915->mm.shrinker.batch = 4096;
-	drm_WARN_ON(&i915->drm, register_shrinker(&i915->mm.shrinker));
+	drm_WARN_ON(&i915->drm, register_shrinker(&i915->mm.shrinker,
+						  "drm-i915_gem"));
 
 	i915->mm.oom_notifier.notifier_call = i915_gem_shrinker_oom;
 	drm_WARN_ON(&i915->drm, register_oom_notifier(&i915->mm.oom_notifier));
diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c b/drivers/gpu/drm/msm/msm_gem_shrinker.c
index 086dacf2f26a..26e84d2ea6ae 100644
--- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
+++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
@@ -221,7 +221,7 @@ void msm_gem_shrinker_init(struct drm_device *dev)
 	priv->shrinker.count_objects = msm_gem_shrinker_count;
 	priv->shrinker.scan_objects = msm_gem_shrinker_scan;
 	priv->shrinker.seeks = DEFAULT_SEEKS;
-	WARN_ON(register_shrinker(&priv->shrinker));
+	WARN_ON(register_shrinker(&priv->shrinker, "drm-msm_gem"));
 
 	priv->vmap_notifier.notifier_call = msm_gem_shrinker_vmap;
 	WARN_ON(register_vmap_purge_notifier(&priv->vmap_notifier));
diff --git a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c b/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
index 77e7cb6d1ae3..bf0170782f25 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c
@@ -103,7 +103,7 @@ void panfrost_gem_shrinker_init(struct drm_device *dev)
 	pfdev->shrinker.count_objects = panfrost_gem_shrinker_count;
 	pfdev->shrinker.scan_objects = panfrost_gem_shrinker_scan;
 	pfdev->shrinker.seeks = DEFAULT_SEEKS;
-	WARN_ON(register_shrinker(&pfdev->shrinker));
+	WARN_ON(register_shrinker(&pfdev->shrinker, "drm-panfrost"));
 }
 
 /**
diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 1bba0a0ed3f9..21b61631f73a 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -722,7 +722,7 @@ int ttm_pool_mgr_init(unsigned long num_pages)
 	mm_shrinker.count_objects = ttm_pool_shrinker_count;
 	mm_shrinker.scan_objects = ttm_pool_shrinker_scan;
 	mm_shrinker.seeks = 1;
-	return register_shrinker(&mm_shrinker);
+	return register_shrinker(&mm_shrinker, "drm-ttm_pool");
 }
 
 /**
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index ad9f16689419..c7a381bd0c24 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -812,7 +812,7 @@ int bch_btree_cache_alloc(struct cache_set *c)
 	c->shrink.seeks = 4;
 	c->shrink.batch = c->btree_pages * 2;
 
-	if (register_shrinker(&c->shrink))
+	if (register_shrinker(&c->shrink, "md-bcache:%pU", c->set_uuid))
 		pr_warn("bcache: %s: could not register shrinker\n",
 				__func__);
 
diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index e9cbc70d5a0e..9e1f4f331f9c 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -1807,7 +1807,8 @@ struct dm_bufio_client *dm_bufio_client_create(struct block_device *bdev, unsign
 	c->shrinker.scan_objects = dm_bufio_shrink_scan;
 	c->shrinker.seeks = 1;
 	c->shrinker.batch = 0;
-	r = register_shrinker(&c->shrinker);
+	r = register_shrinker(&c->shrinker, "md-%s:(%u:%u)", slab_name,
+			      MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev));
 	if (r)
 		goto bad;
 
diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
index d1ea66114d14..46648f6100fb 100644
--- a/drivers/md/dm-zoned-metadata.c
+++ b/drivers/md/dm-zoned-metadata.c
@@ -2944,7 +2944,9 @@ int dmz_ctr_metadata(struct dmz_dev *dev, int num_dev,
 	zmd->mblk_shrinker.seeks = DEFAULT_SEEKS;
 
 	/* Metadata cache shrinker */
-	ret = register_shrinker(&zmd->mblk_shrinker);
+	ret = register_shrinker(&zmd->mblk_shrinker, "md-meta:(%u:%u)",
+				MAJOR(dev->bdev->bd_dev),
+				MINOR(dev->bdev->bd_dev));
 	if (ret) {
 		dmz_zmd_err(zmd, "Register metadata cache shrinker failed");
 		goto err;
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 351d341a1ffa..394650f3806d 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7383,7 +7383,7 @@ static struct r5conf *setup_conf(struct mddev *mddev)
 	conf->shrinker.count_objects = raid5_cache_count;
 	conf->shrinker.batch = 128;
 	conf->shrinker.flags = 0;
-	if (register_shrinker(&conf->shrinker)) {
+	if (register_shrinker(&conf->shrinker, "md-raid5:%s", mdname(mddev))) {
 		pr_warn("md/raid:%s: couldn't register shrinker.\n",
 			mdname(mddev));
 		goto abort;
diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index f1d8ba6d4857..9dd06e4dcd6b 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -1587,7 +1587,7 @@ static int vmballoon_register_shrinker(struct vmballoon *b)
 	b->shrinker.count_objects = vmballoon_shrinker_count;
 	b->shrinker.seeks = DEFAULT_SEEKS;
 
-	r = register_shrinker(&b->shrinker);
+	r = register_shrinker(&b->shrinker, "vmw-balloon");
 
 	if (r == 0)
 		b->shrinker_registered = true;
diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index f4c34a2a6b8e..3a3b15a4bf02 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -875,7 +875,7 @@ static int virtio_balloon_register_shrinker(struct virtio_balloon *vb)
 	vb->shrinker.count_objects = virtio_balloon_shrinker_count;
 	vb->shrinker.seeks = DEFAULT_SEEKS;
 
-	return register_shrinker(&vb->shrinker);
+	return register_shrinker(&vb->shrinker, "virtio-balloon");
 }
 
 static int virtballoon_probe(struct virtio_device *vdev)
diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
index 5abded97e1a7..9c09f89d8278 100644
--- a/drivers/xen/xenbus/xenbus_probe_backend.c
+++ b/drivers/xen/xenbus/xenbus_probe_backend.c
@@ -305,7 +305,7 @@ static int __init xenbus_probe_backend_init(void)
 
 	register_xenstore_notifier(&xenstore_notifier);
 
-	if (register_shrinker(&backend_memory_shrinker))
+	if (register_shrinker(&backend_memory_shrinker, "xen-backend"))
 		pr_warn("shrinker registration failed\n");
 
 	return 0;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index b228efe8ab6e..ba0bf210895d 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1790,6 +1790,8 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 			error = -EBUSY;
 	} else {
 		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
+		shrinker_debugfs_rename(&s->s_shrink, "sb-%s:%s", fs_type->name,
+					s->s_id);
 		btrfs_sb(s)->bdev_holder = fs_type;
 		if (!strstr(crc32c_impl(), "generic"))
 			set_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags);
diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index ec9a1d780dc1..46627cb69abe 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -282,7 +282,7 @@ static struct shrinker erofs_shrinker_info = {
 
 int __init erofs_init_shrinker(void)
 {
-	return register_shrinker(&erofs_shrinker_info);
+	return register_shrinker(&erofs_shrinker_info, "erofs-shrinker");
 }
 
 void erofs_exit_shrinker(void)
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 9a3a8996aacf..23167efda95e 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -1654,7 +1654,8 @@ int ext4_es_register_shrinker(struct ext4_sb_info *sbi)
 	sbi->s_es_shrinker.scan_objects = ext4_es_scan;
 	sbi->s_es_shrinker.count_objects = ext4_es_count;
 	sbi->s_es_shrinker.seeks = DEFAULT_SEEKS;
-	err = register_shrinker(&sbi->s_es_shrinker);
+	err = register_shrinker(&sbi->s_es_shrinker, "ext4-es:%s",
+				sbi->s_sb->s_id);
 	if (err)
 		goto err4;
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 4368f90571bd..67bced91a72c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4579,7 +4579,7 @@ static int __init init_f2fs_fs(void)
 	err = f2fs_init_sysfs();
 	if (err)
 		goto free_garbage_collection_cache;
-	err = register_shrinker(&f2fs_shrinker_info);
+	err = register_shrinker(&f2fs_shrinker_info, "f2fs-shrinker");
 	if (err)
 		goto free_sysfs;
 	err = register_filesystem(&f2fs_fs_type);
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 630c6550eacf..32a0650f801d 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2530,7 +2530,7 @@ int __init gfs2_glock_init(void)
 		return -ENOMEM;
 	}
 
-	ret = register_shrinker(&glock_shrinker);
+	ret = register_shrinker(&glock_shrinker, "gfs2-glock");
 	if (ret) {
 		destroy_workqueue(gfs2_delete_workqueue);
 		destroy_workqueue(glock_workqueue);
diff --git a/fs/gfs2/main.c b/fs/gfs2/main.c
index 28d0eb23e18e..f7405742d379 100644
--- a/fs/gfs2/main.c
+++ b/fs/gfs2/main.c
@@ -150,7 +150,7 @@ static int __init init_gfs2_fs(void)
 	if (!gfs2_trans_cachep)
 		goto fail_cachep8;
 
-	error = register_shrinker(&gfs2_qd_shrinker);
+	error = register_shrinker(&gfs2_qd_shrinker, "gfs2-qd");
 	if (error)
 		goto fail_shrinker;
 
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index fcacafa4510d..9bb3e30da6df 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1418,7 +1418,8 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	if (percpu_counter_init(&journal->j_checkpoint_jh_count, 0, GFP_KERNEL))
 		goto err_cleanup;
 
-	if (register_shrinker(&journal->j_shrinker)) {
+	if (register_shrinker(&journal->j_shrinker, "jbd2-journal:(%u:%u)",
+			      MAJOR(bdev->bd_dev), MINOR(bdev->bd_dev))) {
 		percpu_counter_destroy(&journal->j_checkpoint_jh_count);
 		goto err_cleanup;
 	}
diff --git a/fs/mbcache.c b/fs/mbcache.c
index 97c54d3a2227..0b833da0a9a5 100644
--- a/fs/mbcache.c
+++ b/fs/mbcache.c
@@ -367,7 +367,7 @@ struct mb_cache *mb_cache_create(int bucket_bits)
 	cache->c_shrink.count_objects = mb_cache_count;
 	cache->c_shrink.scan_objects = mb_cache_scan;
 	cache->c_shrink.seeks = DEFAULT_SEEKS;
-	if (register_shrinker(&cache->c_shrink)) {
+	if (register_shrinker(&cache->c_shrink, "mbcache-shrinker")) {
 		kfree(cache->c_hash);
 		kfree(cache);
 		goto err_out;
diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
index e7b34f7e0614..a9bf09fdf2c3 100644
--- a/fs/nfs/nfs42xattr.c
+++ b/fs/nfs/nfs42xattr.c
@@ -1017,15 +1017,16 @@ int __init nfs4_xattr_cache_init(void)
 	if (ret)
 		goto out2;
 
-	ret = register_shrinker(&nfs4_xattr_cache_shrinker);
+	ret = register_shrinker(&nfs4_xattr_cache_shrinker, "nfs-xattr_cache");
 	if (ret)
 		goto out1;
 
-	ret = register_shrinker(&nfs4_xattr_entry_shrinker);
+	ret = register_shrinker(&nfs4_xattr_entry_shrinker, "nfs-xattr_entry");
 	if (ret)
 		goto out;
 
-	ret = register_shrinker(&nfs4_xattr_large_entry_shrinker);
+	ret = register_shrinker(&nfs4_xattr_large_entry_shrinker,
+				"nfs-xattr_large_entry");
 	if (!ret)
 		return 0;
 
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 6ab5eeb000dc..82944e14fcea 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -149,7 +149,7 @@ int __init register_nfs_fs(void)
 	ret = nfs_register_sysctl();
 	if (ret < 0)
 		goto error_2;
-	ret = register_shrinker(&acl_shrinker);
+	ret = register_shrinker(&acl_shrinker, "nfs-acl");
 	if (ret < 0)
 		goto error_3;
 #ifdef CONFIG_NFS_V4_2
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 2c1b027774d4..9a11a4ed866f 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -666,7 +666,7 @@ nfsd_file_cache_init(void)
 		goto out_err;
 	}
 
-	ret = register_shrinker(&nfsd_file_shrinker);
+	ret = register_shrinker(&nfsd_file_shrinker, "nfsd-filecache");
 	if (ret) {
 		pr_err("nfsd: failed to register nfsd_file_shrinker: %d\n", ret);
 		goto out_lru;
diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index 0b3f12aa37ff..f9c04db1388c 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -176,7 +176,8 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
 	nn->nfsd_reply_cache_shrinker.scan_objects = nfsd_reply_cache_scan;
 	nn->nfsd_reply_cache_shrinker.count_objects = nfsd_reply_cache_count;
 	nn->nfsd_reply_cache_shrinker.seeks = 1;
-	status = register_shrinker(&nn->nfsd_reply_cache_shrinker);
+	status = register_shrinker(&nn->nfsd_reply_cache_shrinker,
+				   "nfsd-reply:%s", nn->nfsd_name);
 	if (status)
 		goto out_stats_destroy;
 
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index a74aef99bd3d..07ced73a6d1a 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2985,7 +2985,7 @@ static int __init dquot_init(void)
 	pr_info("VFS: Dquot-cache hash table entries: %ld (order %ld,"
 		" %ld bytes)\n", nr_hash, order, (PAGE_SIZE << order));
 
-	if (register_shrinker(&dqcache_shrinker))
+	if (register_shrinker(&dqcache_shrinker, "dquota-cache"))
 		panic("Cannot register dquot shrinker");
 
 	return 0;
diff --git a/fs/super.c b/fs/super.c
index f1d4a193602d..4ce867ab1f4e 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -265,7 +265,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	s->s_shrink.count_objects = super_cache_count;
 	s->s_shrink.batch = 1024;
 	s->s_shrink.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE;
-	if (prealloc_shrinker(&s->s_shrink))
+	if (prealloc_shrinker(&s->s_shrink, "sb-%s", type->name))
 		goto fail;
 	if (list_lru_init_memcg(&s->s_dentry_lru, &s->s_shrink))
 		goto fail;
@@ -1288,6 +1288,8 @@ int get_tree_bdev(struct fs_context *fc,
 	} else {
 		s->s_mode = mode;
 		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
+		shrinker_debugfs_rename(&s->s_shrink, "sb-%s:%s",
+					fc->fs_type->name, s->s_id);
 		sb_set_blocksize(s, block_size(bdev));
 		error = fill_super(s, fc);
 		if (error) {
@@ -1363,6 +1365,8 @@ struct dentry *mount_bdev(struct file_system_type *fs_type,
 	} else {
 		s->s_mode = mode;
 		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
+		shrinker_debugfs_rename(&s->s_shrink, "sb-%s:%s",
+					fs_type->name, s->s_id);
 		sb_set_blocksize(s, block_size(bdev));
 		error = fill_super(s, data, flags & SB_SILENT ? 1 : 0);
 		if (error) {
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index bad67455215f..0d75451514e8 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -2430,7 +2430,7 @@ static int __init ubifs_init(void)
 	if (!ubifs_inode_slab)
 		return -ENOMEM;
 
-	err = register_shrinker(&ubifs_shrinker_info);
+	err = register_shrinker(&ubifs_shrinker_info, "ubifs-slab");
 	if (err)
 		goto out_slab;
 
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index bf4e60871068..4aa9c9cf5b6e 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1986,7 +1986,8 @@ xfs_alloc_buftarg(
 	btp->bt_shrinker.scan_objects = xfs_buftarg_shrink_scan;
 	btp->bt_shrinker.seeks = DEFAULT_SEEKS;
 	btp->bt_shrinker.flags = SHRINKER_NUMA_AWARE;
-	if (register_shrinker(&btp->bt_shrinker))
+	if (register_shrinker(&btp->bt_shrinker, "xfs-buf:%s",
+			      mp->m_super->s_id))
 		goto error_pcpu;
 	return btp;
 
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index bffd6eb0b298..07a9bfae0dd3 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -2198,5 +2198,5 @@ xfs_inodegc_register_shrinker(
 	shrink->flags = SHRINKER_NONSLAB;
 	shrink->batch = XFS_INODEGC_SHRINKER_BATCH;
 
-	return register_shrinker(shrink);
+	return register_shrinker(shrink, "xfs-inodegc:%s", mp->m_super->s_id);
 }
diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
index f165d1a3de1d..8e6de4396eec 100644
--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -686,7 +686,8 @@ xfs_qm_init_quotainfo(
 	qinf->qi_shrinker.seeks = DEFAULT_SEEKS;
 	qinf->qi_shrinker.flags = SHRINKER_NUMA_AWARE;
 
-	error = register_shrinker(&qinf->qi_shrinker);
+	error = register_shrinker(&qinf->qi_shrinker, "xfs-qm:%s",
+				  mp->m_super->s_id);
 	if (error)
 		goto out_free_inos;
 
diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 2ced8149c513..64416f3e0a1f 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -75,6 +75,7 @@ struct shrinker {
 #endif
 #ifdef CONFIG_SHRINKER_DEBUG
 	int debugfs_id;
+	const char *name;
 	struct dentry *debugfs_entry;
 #endif
 	/* objs pending delete, per node */
@@ -92,9 +93,9 @@ struct shrinker {
  */
 #define SHRINKER_NONSLAB	(1 << 3)
 
-extern int prealloc_shrinker(struct shrinker *shrinker);
+extern int prealloc_shrinker(struct shrinker *shrinker, const char *fmt, ...);
 extern void register_shrinker_prepared(struct shrinker *shrinker);
-extern int register_shrinker(struct shrinker *shrinker);
+extern int register_shrinker(struct shrinker *shrinker, const char *fmt, ...);
 extern void unregister_shrinker(struct shrinker *shrinker);
 extern void free_prealloced_shrinker(struct shrinker *shrinker);
 extern void synchronize_shrinkers(void);
@@ -102,6 +103,8 @@ extern void synchronize_shrinkers(void);
 #ifdef CONFIG_SHRINKER_DEBUG
 extern int shrinker_debugfs_add(struct shrinker *shrinker);
 extern void shrinker_debugfs_remove(struct shrinker *shrinker);
+extern int shrinker_debugfs_rename(struct shrinker *shrinker,
+				   const char *fmt, ...);
 #else /* CONFIG_SHRINKER_DEBUG */
 static inline int shrinker_debugfs_add(struct shrinker *shrinker)
 {
@@ -110,5 +113,10 @@ static inline int shrinker_debugfs_add(struct shrinker *shrinker)
 static inline void shrinker_debugfs_remove(struct shrinker *shrinker)
 {
 }
+static inline int shrinker_debugfs_rename(struct shrinker *shrinker,
+					  const char *fmt, ...)
+{
+	return 0;
+}
 #endif /* CONFIG_SHRINKER_DEBUG */
 #endif /* _LINUX_SHRINKER_H */
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a4b8189455d5..92ee97c7a2cd 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4776,7 +4776,7 @@ static void __init kfree_rcu_batch_init(void)
 		INIT_DELAYED_WORK(&krcp->page_cache_work, fill_page_cache_func);
 		krcp->initialized = true;
 	}
-	if (register_shrinker(&kfree_rcu_shrinker))
+	if (register_shrinker(&kfree_rcu_shrinker, "rcu-kfree"))
 		pr_err("Failed to register kfree_rcu() shrinker!\n");
 }
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c468fee595ff..e64d9a51404b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -429,10 +429,10 @@ static int __init hugepage_init(void)
 	if (err)
 		goto err_slab;
 
-	err = register_shrinker(&huge_zero_page_shrinker);
+	err = register_shrinker(&huge_zero_page_shrinker, "thp-zero");
 	if (err)
 		goto err_hzp_shrinker;
-	err = register_shrinker(&deferred_split_shrinker);
+	err = register_shrinker(&deferred_split_shrinker, "thp-deferred_split");
 	if (err)
 		goto err_split_shrinker;
 
diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index 1a70556bd46c..781ecbd3d608 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -102,7 +102,7 @@ DEFINE_SHOW_ATTRIBUTE(shrinker_debugfs_count);
 int shrinker_debugfs_add(struct shrinker *shrinker)
 {
 	struct dentry *entry;
-	char buf[16];
+	char buf[128];
 	int id;
 
 	lockdep_assert_held(&shrinker_rwsem);
@@ -116,7 +116,7 @@ int shrinker_debugfs_add(struct shrinker *shrinker)
 		return id;
 	shrinker->debugfs_id = id;
 
-	snprintf(buf, sizeof(buf), "%d", id);
+	snprintf(buf, sizeof(buf), "%s-%d", shrinker->name, id);
 
 	/* create debugfs entry */
 	entry = debugfs_create_dir(buf, shrinker_debugfs_root);
@@ -131,10 +131,53 @@ int shrinker_debugfs_add(struct shrinker *shrinker)
 	return 0;
 }
 
+int shrinker_debugfs_rename(struct shrinker *shrinker, const char *fmt, ...)
+{
+	struct dentry *entry;
+	char buf[128];
+	const char *new, *old;
+	va_list ap;
+	int ret = 0;
+
+	va_start(ap, fmt);
+	new = kvasprintf_const(GFP_KERNEL, fmt, ap);
+	va_end(ap);
+
+	if (!new)
+		return -ENOMEM;
+
+	down_write(&shrinker_rwsem);
+
+	old = shrinker->name;
+	shrinker->name = new;
+
+	if (shrinker->debugfs_entry) {
+		snprintf(buf, sizeof(buf), "%s-%d", shrinker->name,
+			 shrinker->debugfs_id);
+
+		entry = debugfs_rename(shrinker_debugfs_root,
+				       shrinker->debugfs_entry,
+				       shrinker_debugfs_root, buf);
+		if (IS_ERR(entry))
+			ret = PTR_ERR(entry);
+		else
+			shrinker->debugfs_entry = entry;
+	}
+
+	up_write(&shrinker_rwsem);
+
+	kfree_const(old);
+
+	return ret;
+}
+EXPORT_SYMBOL(shrinker_debugfs_rename);
+
 void shrinker_debugfs_remove(struct shrinker *shrinker)
 {
 	lockdep_assert_held(&shrinker_rwsem);
 
+	kfree_const(shrinker->name);
+
 	if (!shrinker->debugfs_entry)
 		return;
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index f54df1ce9312..fd8a472b6501 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -612,7 +612,7 @@ static unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru,
 /*
  * Add a shrinker callback to be called from the vm.
  */
-int prealloc_shrinker(struct shrinker *shrinker)
+static int __prealloc_shrinker(struct shrinker *shrinker)
 {
 	unsigned int size;
 	int err;
@@ -636,8 +636,36 @@ int prealloc_shrinker(struct shrinker *shrinker)
 	return 0;
 }
 
+#ifdef CONFIG_SHRINKER_DEBUG
+int prealloc_shrinker(struct shrinker *shrinker, const char *fmt, ...)
+{
+	va_list ap;
+	int err;
+
+	va_start(ap, fmt);
+	shrinker->name = kvasprintf_const(GFP_KERNEL, fmt, ap);
+	va_end(ap);
+	if (!shrinker->name)
+		return -ENOMEM;
+
+	err = __prealloc_shrinker(shrinker);
+	if (err)
+		kfree_const(shrinker->name);
+
+	return err;
+}
+#else
+int prealloc_shrinker(struct shrinker *shrinker, const char *fmt, ...)
+{
+	return __prealloc_shrinker(shrinker);
+}
+#endif
+
 void free_prealloced_shrinker(struct shrinker *shrinker)
 {
+#ifdef CONFIG_SHRINKER_DEBUG
+	kfree_const(shrinker->name);
+#endif
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
 		down_write(&shrinker_rwsem);
 		unregister_memcg_shrinker(shrinker);
@@ -658,15 +686,39 @@ void register_shrinker_prepared(struct shrinker *shrinker)
 	up_write(&shrinker_rwsem);
 }
 
-int register_shrinker(struct shrinker *shrinker)
+static int __register_shrinker(struct shrinker *shrinker)
 {
-	int err = prealloc_shrinker(shrinker);
+	int err = __prealloc_shrinker(shrinker);
 
 	if (err)
 		return err;
 	register_shrinker_prepared(shrinker);
 	return 0;
 }
+
+#ifdef CONFIG_SHRINKER_DEBUG
+int register_shrinker(struct shrinker *shrinker, const char *fmt, ...)
+{
+	va_list ap;
+	int err;
+
+	va_start(ap, fmt);
+	shrinker->name = kvasprintf_const(GFP_KERNEL, fmt, ap);
+	va_end(ap);
+	if (!shrinker->name)
+		return -ENOMEM;
+
+	err = __register_shrinker(shrinker);
+	if (err)
+		kfree_const(shrinker->name);
+	return err;
+}
+#else
+int register_shrinker(struct shrinker *shrinker, const char *fmt, ...)
+{
+	return __register_shrinker(shrinker);
+}
+#endif
 EXPORT_SYMBOL(register_shrinker);
 
 /*
diff --git a/mm/workingset.c b/mm/workingset.c
index 592569a8974c..a5e84862fc86 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -625,7 +625,7 @@ static int __init workingset_init(void)
 	pr_info("workingset: timestamp_bits=%d max_order=%d bucket_order=%u\n",
 	       timestamp_bits, max_order, bucket_order);
 
-	ret = prealloc_shrinker(&workingset_shadow_shrinker);
+	ret = prealloc_shrinker(&workingset_shadow_shrinker, "mm-shadow");
 	if (ret)
 		goto err;
 	ret = __list_lru_init(&shadow_nodes, true, &shadow_nodes_key,
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 9152fbde33b5..90f6769258f6 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -2188,7 +2188,8 @@ static int zs_register_shrinker(struct zs_pool *pool)
 	pool->shrinker.batch = 0;
 	pool->shrinker.seeks = DEFAULT_SEEKS;
 
-	return register_shrinker(&pool->shrinker);
+	return register_shrinker(&pool->shrinker, "mm-zspool:%s",
+				 pool->name);
 }
 
 /**
diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
index 682fcd24bf43..04e7b55fe0d9 100644
--- a/net/sunrpc/auth.c
+++ b/net/sunrpc/auth.c
@@ -874,7 +874,7 @@ int __init rpcauth_init_module(void)
 	err = rpc_init_authunix();
 	if (err < 0)
 		goto out1;
-	err = register_shrinker(&rpc_cred_shrinker);
+	err = register_shrinker(&rpc_cred_shrinker, "sunrpc_cred");
 	if (err < 0)
 		goto out2;
 	return 0;
-- 
2.35.3

