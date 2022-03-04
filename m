Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250454CCBAA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 03:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237663AbiCDCU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 21:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236722AbiCDCU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 21:20:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6B1170D4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 18:20:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0AD55B82701
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 02:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AB4C004E1;
        Fri,  4 Mar 2022 02:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646360406;
        bh=3b0cLQyDCqM0TDt3vJsTsrKxsQmAHGD01Z3OiT/e01Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UbW9s459ecjdA534L+ORHl+e7av8fMKEU8P0l+yQfX6Rh8new88cvTe4y3aAuXfzO
         K3bdiRvAkCK/Bg40Olc+lQ+tmzJXwkf7NVk+K84JXsyJIggFuHQP7Q5P4+ozPDDTyY
         JqZiPGZP2+Ff3XPM6r+Lo8xCMGOxJkE4K+Np2NJx0n9nTKnJjQYRRgE3raPdHTwe26
         c6zw3Ev4YLGs8j9ZcAQRASHhNkGczxu37JvD5GgVJWTf4Y5ULYurLt+IePWt2dQt6h
         GfrxFM+n9BZa9oJv6QgfAOP8KIhJvsRHTAq7iee/LIKgoSQBNYi4V7/1yw+ahxDzjy
         9yFJ/tZCCwvzQ==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH 2/2] f2fs: introduce F2FS_UNFAIR_RWSEM to support unfair rwsem
Date:   Thu,  3 Mar 2022 18:19:55 -0800
Message-Id: <20220304021955.2524246-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
In-Reply-To: <20220304021955.2524246-1-jaegeuk@kernel.org>
References: <20220304021955.2524246-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unfair rwsem should be used when blk-cg is on. Otherwise, there is regression.

FYI, we noticed a -26.7% regression of aim7.jobs-per-min due to commit:

commit: e4544b63a7ee49e7fbebf35ece0a6acd3b9617ae ("f2fs: move f2fs to use reader-unfair rwsems")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

in testcase: aim7
on test machine: 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz with 128G memory
with following parameters:

	disk: 4BRD_12G
	md: RAID0
	fs: f2fs
	test: sync_disk_rw
	load: 100
	cpufreq_governor: performance
	ucode: 0x500320a

test-description: AIM7 is a traditional UNIX system level benchmark suite which is used to test and measure the performance of multiuser system.
test-url: https://sourceforge.net/projects/aimbench/files/aim-suite7/

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/Kconfig |  7 +++++++
 fs/f2fs/f2fs.h  | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/fs/f2fs/Kconfig b/fs/f2fs/Kconfig
index f46a7339d6cf..03ef087537c7 100644
--- a/fs/f2fs/Kconfig
+++ b/fs/f2fs/Kconfig
@@ -143,3 +143,10 @@ config F2FS_IOSTAT
 	  Support getting IO statistics through sysfs and printing out periodic
 	  IO statistics tracepoint events. You have to turn on "iostat_enable"
 	  sysfs node to enable this feature.
+
+config F2FS_UNFAIR_RWSEM
+	bool "F2FS unfair rw_semaphore"
+	depends on F2FS_FS && BLK_CGROUP
+	help
+	  Use unfair rw_semaphore, if system configured IO priority by block
+	  cgroup.
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index efc4f1fe2ffd..68d791ec8b27 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -132,7 +132,9 @@ typedef u32 nid_t;
 
 struct f2fs_rwsem {
         struct rw_semaphore internal_rwsem;
+#ifdef CONFIG_F2FS_UNFAIR_RWSEM
         wait_queue_head_t read_waiters;
+#endif
 };
 
 struct f2fs_mount_info {
@@ -2131,7 +2133,9 @@ static inline void __init_f2fs_rwsem(struct f2fs_rwsem *sem,
 		const char *sem_name, struct lock_class_key *key)
 {
 	__init_rwsem(&sem->internal_rwsem, sem_name, key);
+#ifdef CONFIG_F2FS_UNFAIR_RWSEM
 	init_waitqueue_head(&sem->read_waiters);
+#endif
 }
 
 static inline int f2fs_rwsem_is_locked(struct f2fs_rwsem *sem)
@@ -2146,7 +2150,11 @@ static inline int f2fs_rwsem_is_contended(struct f2fs_rwsem *sem)
 
 static inline void f2fs_down_read(struct f2fs_rwsem *sem)
 {
+#ifdef CONFIG_F2FS_UNFAIR_RWSEM
 	wait_event(sem->read_waiters, down_read_trylock(&sem->internal_rwsem));
+#else
+	down_read(&sem->internal_rwsem);
+#endif
 }
 
 static inline int f2fs_down_read_trylock(struct f2fs_rwsem *sem)
@@ -2181,7 +2189,9 @@ static inline int f2fs_down_write_trylock(struct f2fs_rwsem *sem)
 static inline void f2fs_up_write(struct f2fs_rwsem *sem)
 {
 	up_write(&sem->internal_rwsem);
+#ifdef CONFIG_F2FS_UNFAIR_RWSEM
 	wake_up_all(&sem->read_waiters);
+#endif
 }
 
 static inline void f2fs_lock_op(struct f2fs_sb_info *sbi)
-- 
2.35.1.616.g0bdcbb4464-goog

