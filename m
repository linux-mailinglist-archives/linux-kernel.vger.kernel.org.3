Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEC34696EF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244465AbhLFN2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:28:02 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:32880 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241389AbhLFN2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:28:01 -0500
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J74045l9hzcbmZ;
        Mon,  6 Dec 2021 21:24:20 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 6 Dec
 2021 21:24:31 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <glider@google.com>, <elver@google.com>, <dvyukov@google.com>,
        <akpm@linux-foundation.org>, <viro@zeniv.linux.org.uk>
CC:     <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <libaokun1@huawei.com>,
        <yukuai3@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] kfence: fix memory leak when cat kfence objects
Date:   Mon, 6 Dec 2021 21:36:28 +0800
Message-ID: <20211206133628.2822545-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hulk robot reported a kmemleak problem:
-----------------------------------------------------------------------
unreferenced object 0xffff93d1d8cc02e8 (size 248):
  comm "cat", pid 23327, jiffies 4624670141 (age 495992.217s)
  hex dump (first 32 bytes):
    00 40 85 19 d4 93 ff ff 00 10 00 00 00 00 00 00  .@..............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000db5610b3>] seq_open+0x2a/0x80
    [<00000000d66ac99d>] full_proxy_open+0x167/0x1e0
    [<00000000d58ef917>] do_dentry_open+0x1e1/0x3a0
    [<0000000016c91867>] path_openat+0x961/0xa20
    [<00000000909c9564>] do_filp_open+0xae/0x120
    [<0000000059c761e6>] do_sys_openat2+0x216/0x2f0
    [<00000000b7a7b239>] do_sys_open+0x57/0x80
    [<00000000e559d671>] do_syscall_64+0x33/0x40
    [<000000000ea1fbfd>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
unreferenced object 0xffff93d419854000 (size 4096):
  comm "cat", pid 23327, jiffies 4624670141 (age 495992.217s)
  hex dump (first 32 bytes):
    6b 66 65 6e 63 65 2d 23 32 35 30 3a 20 30 78 30  kfence-#250: 0x0
    30 30 30 30 30 30 30 37 35 34 62 64 61 31 32 2d  0000000754bda12-
  backtrace:
    [<000000008162c6f2>] seq_read_iter+0x313/0x440
    [<0000000020b1b3e3>] seq_read+0x14b/0x1a0
    [<00000000af248fbc>] full_proxy_read+0x56/0x80
    [<00000000f97679d1>] vfs_read+0xa5/0x1b0
    [<000000000ed8a36f>] ksys_read+0xa0/0xf0
    [<00000000e559d671>] do_syscall_64+0x33/0x40
    [<000000000ea1fbfd>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
-----------------------------------------------------------------------

I find that we can easily reproduce this problem with the following
commands:
	`cat /sys/kernel/debug/kfence/objects`
	`echo scan > /sys/kernel/debug/kmemleak`
	`cat /sys/kernel/debug/kmemleak`

The leaked memory is allocated in the stack below:
----------------------------------
do_syscall_64
  do_sys_open
    do_dentry_open
      full_proxy_open
        seq_open            ---> alloc seq_file
  vfs_read
    full_proxy_read
      seq_read
        seq_read_iter
          traverse          ---> alloc seq_buf
----------------------------------

And it should have been released in the following process:
----------------------------------
do_syscall_64
  syscall_exit_to_user_mode
    exit_to_user_mode_prepare
      task_work_run
        ____fput
          __fput
            full_proxy_release  ---> free here
----------------------------------

However, the release function corresponding to file_operations is not
implemented in kfence. As a result, a memory leak occurs. Therefore,
the solution to this problem is to implement the corresponding
release function.

Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 mm/kfence/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 46103a7628a6..186838f062b2 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -684,6 +684,7 @@ static const struct file_operations objects_fops = {
 	.open = open_objects,
 	.read = seq_read,
 	.llseek = seq_lseek,
+	.release = seq_release,
 };
 
 static int __init kfence_debugfs_init(void)
-- 
2.31.1

