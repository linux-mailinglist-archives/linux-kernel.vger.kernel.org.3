Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A27D4EE8C2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 09:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343673AbiDAHGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 03:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343644AbiDAHGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 03:06:18 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273266A06D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 00:04:29 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KV9zV1g9QzBrvk;
        Fri,  1 Apr 2022 15:00:22 +0800 (CST)
Received: from dggpeml500009.china.huawei.com (7.185.36.209) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 15:04:27 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500009.china.huawei.com
 (7.185.36.209) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 1 Apr
 2022 15:04:27 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <yuyufen@huawei.com>
Subject: [PATCH 5/5] f2fs: update doc for f2fs fault injection
Date:   Fri, 1 Apr 2022 15:19:09 +0800
Message-ID: <20220401071909.505086-6-yuyufen@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220401071909.505086-1-yuyufen@huawei.com>
References: <20220401071909.505086-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500009.china.huawei.com (7.185.36.209)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just update doc for fault injection.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 Documentation/filesystems/f2fs.rst | 118 ++++++++++++++++++++++-------
 1 file changed, 90 insertions(+), 28 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 4a2426f0485a..e8dfe1541613 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -172,34 +172,6 @@ reserve_root=%d		 Support configuring reserved space which is used for
 			 gid, unit: 4KB, the default limit is 0.2% of user blocks.
 resuid=%d		 The user ID which may use the reserved blocks.
 resgid=%d		 The group ID which may use the reserved blocks.
-fault_injection=%d	 Enable fault injection in all supported types with
-			 specified injection rate.
-fault_type=%d		 Support configuring fault injection type, should be
-			 enabled with fault_injection option, fault type value
-			 is shown below, it supports single or combined type.
-
-			 ===================	  ===========
-			 Type_Name		  Type_Value
-			 ===================	  ===========
-			 FAULT_KMALLOC		  0x000000001
-			 FAULT_KVMALLOC		  0x000000002
-			 FAULT_PAGE_ALLOC	  0x000000004
-			 FAULT_PAGE_GET		  0x000000008
-			 FAULT_ALLOC_BIO	  0x000000010 (obsolete)
-			 FAULT_ALLOC_NID	  0x000000020
-			 FAULT_ORPHAN		  0x000000040
-			 FAULT_BLOCK		  0x000000080
-			 FAULT_DIR_DEPTH	  0x000000100
-			 FAULT_EVICT_INODE	  0x000000200
-			 FAULT_TRUNCATE		  0x000000400
-			 FAULT_READ_IO		  0x000000800
-			 FAULT_CHECKPOINT	  0x000001000
-			 FAULT_DISCARD		  0x000002000
-			 FAULT_WRITE_IO		  0x000004000
-			 FAULT_SLAB_ALLOC	  0x000008000
-			 FAULT_DQUOT_INIT	  0x000010000
-			 FAULT_LOCK_OP		  0x000020000
-			 ===================	  ===========
 mode=%s			 Control block allocation mode which supports "adaptive"
 			 and "lfs". In "lfs" mode, there should be no random
 			 writes towards main area.
@@ -367,6 +339,96 @@ The files in each per-device directory are shown in table below.
 Files in /sys/fs/f2fs/<devname>
 (see also Documentation/ABI/testing/sysfs-fs-f2fs)
 
+Fault Injection
+=============
+/sys/kernel/debug/f2fs/<devname>/fault_inject contains fault_inject control.
+
+Support configuring fault injection type by writing value to
+/sys/kernel/debug/f2fs/<devname>/fault_inject/inject_type.
+The values are shown below. They support single or combined type.
+
+			 ===================	  ===========
+			 Type_Name		  Type_Value
+			 ===================	  ===========
+			 FAULT_KMALLOC		  0x000000001
+			 FAULT_KVMALLOC		  0x000000002
+			 FAULT_PAGE_ALLOC	  0x000000004
+			 FAULT_PAGE_GET		  0x000000008
+			 FAULT_ALLOC_BIO	  0x000000010 (obsolete)
+			 FAULT_ALLOC_NID	  0x000000020
+			 FAULT_ORPHAN		  0x000000040
+			 FAULT_BLOCK		  0x000000080
+			 FAULT_DIR_DEPTH	  0x000000100
+			 FAULT_EVICT_INODE	  0x000000200
+			 FAULT_TRUNCATE		  0x000000400
+			 FAULT_READ_IO		  0x000000800
+			 FAULT_CHECKPOINT	  0x000001000
+			 FAULT_DISCARD		  0x000002000
+			 FAULT_WRITE_IO		  0x000004000
+			 FAULT_SLAB_ALLOC	  0x000008000
+			 FAULT_DQUOT_INIT	  0x000010000
+			 FAULT_LOCK_OP		  0x000020000
+			 ===================	  ===========
+
+Example: Inject write io fail
+---------------------------------------------------
+
+::
+
+    mount /dev/sda /mnt
+    echo 0x000000800 > /sys/kernel/debug/f2fs/sda/fault_inject/inject_type
+    echo 1 > /sys/kernel/debug/f2fs/sda/fault_inject/times
+    echo 100 > /sys/kernel/debug/f2fs/sda/fault_inject/probability
+    cp /mnt/file .
+
+Expected Result::
+
+    cat: /mnt/file: Input/output error
+
+Message from dmesg::
+
+    FAULT_INJECTION: forcing a failure.
+    name fault_inject, interval 1, probability 100, space 0, times 1
+    CPU: 30 PID: 0 Comm: swapper/30 Not tainted 5.17.0-rc8 #6
+    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190727_073836-build
+    Call Trace:
+     <IRQ>
+     ? dump_stack_lvl+0x73/0x9f
+     ? dump_stack+0x13/0x1b
+     ? should_fail.cold+0x4a/0x57
+     ? f2fs_should_fail+0x3e/0x60
+     ? f2fs_read_end_io+0x94/0x230
+     ? bio_endio+0x15d/0x2d0
+     ? blk_update_request+0x188/0x5b0
+     ? kfree+0x138/0x4a0
+     ? scsi_end_request+0x2f/0x230
+     ? scsi_io_completion+0x86/0x9a0
+     ? scsi_dec_host_busy+0xc6/0xe0
+     ? scsi_finish_command+0xf0/0x160
+     ? scsi_complete+0x9f/0x160
+     ? blk_complete_reqs+0x5a/0x70
+     ? blk_done_softirq+0x34/0x40
+     ? __do_softirq+0x14f/0x4ef
+     ? irq_exit_rcu+0x1a7/0x210
+     ? common_interrupt+0xa4/0xc0
+     </IRQ>
+     <TASK>
+     ? asm_common_interrupt+0x1e/0x40
+     ? default_idle+0x38/0x50
+     ? arch_cpu_idle+0x13/0x20
+     ? default_idle_call+0x82/0x270
+     ? do_idle+0x37c/0x4a0
+     ? swake_up_locked+0x38/0x80
+     ? _raw_spin_unlock_irqrestore+0x4b/0x90
+     ? cpu_startup_entry+0x31/0x40
+     ? start_secondary+0x222/0x280
+     ? secondary_startup_64_no_verify+0xc3/0xcb
+     </TASK>
+    F2FS-fs (sda) : inject read IO error in f2fs_read_end_io of bio_endio+0x15d/0x2d0
+
+Files in /sys/kernel/debug/f2fs/<devname>/fault_inject
+(see also Documentation/fault-injection/fault-injection.rst)
+
 Usage
 =====
 
-- 
2.31.1

