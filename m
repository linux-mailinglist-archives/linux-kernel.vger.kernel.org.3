Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF58749F5DC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 10:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbiA1JDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 04:03:31 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:31250 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbiA1JD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:03:28 -0500
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JlWgb0MQpzbkCc;
        Fri, 28 Jan 2022 17:02:35 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme752-chm.china.huawei.com
 (10.3.19.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.21; Fri, 28
 Jan 2022 17:03:26 +0800
From:   h00486469 <hewenliang4@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <punit.agrawal@arm.com>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <hewenliang4@huawei.com>, <hejingxian@huawei.com>
Subject: [PATCH] arm64: fix slab-out-of-bounds in emulation_proc_handler when accessing concurrently
Date:   Fri, 28 Jan 2022 17:03:24 +0800
Message-ID: <20220128090324.2727688-1-hewenliang4@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: hewenliang <hewenliang4@huawei.com>

SAN reports an issue of slab-out-of-bounds in emulation_proc_handler
when we try to read/write the interfaces in /proc/sys/abi concurrently.
So we need to add emulation_proc_lock to protect table->data and insn
from data corruption in emulation_proc_handler.

The stack is follows:
Call trace:
 dump_backtrace+0x0/0x310
 show_stack+0x28/0x38
 dump_stack+0xec/0x15c
 print_address_description+0x68/0x2d0
 kasan_report+0x130/0x2f0
 __asan_load4+0x88/0xb0
 emulation_proc_handler+0x58/0x158
 proc_sys_call_handler+0x1dc/0x228
 proc_sys_read+0x44/0x58
 __vfs_read+0xe0/0x320
 vfs_read+0xbc/0x1c0
 __arm64_sys_read+0x50/0x60
 el0_svc_common+0xc8/0x2b8
 el0_svc_handler+0xf8/0x160
 el0_svc+0x10/0x218

Allocated by task 1:
 kasan_kmalloc+0xe0/0x190
 kmem_cache_alloc_trace+0x18c/0x418
 register_insn_emulation+0x4c/0x2b0
 armv8_deprecated_init+0x40/0x108
 do_one_initcall+0xb4/0x508
 kernel_init_freeable+0x7d0/0x8e0
 kernel_init+0x20/0x1a8
 ret_from_fork+0x10/0x18

Mmeory state around the buggy address:
>ffff8026dacf0b00: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc

Fixes: 587064b610c7 ("arm64: Add framework for legacy instruction emulation")
Signed-off-by: hewenliang <hewenliang4@huawei.com>
Signed-off-by: hejingxian <hejingxian@huawei.com>
Signed-off-by: fulin <fulin@huawei.com>
---
 arch/arm64/kernel/armv8_deprecated.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index 6875a16b09d2..d2ac483b0dd8 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -59,6 +59,7 @@ struct insn_emulation {
 static LIST_HEAD(insn_emulation);
 static int nr_insn_emulated __initdata;
 static DEFINE_RAW_SPINLOCK(insn_emulation_lock);
+static DEFINE_MUTEX(emulation_proc_lock);
 
 static void register_emulation_hooks(struct insn_emulation_ops *ops)
 {
@@ -207,9 +208,12 @@ static int emulation_proc_handler(struct ctl_table *table, int write,
 				  loff_t *ppos)
 {
 	int ret = 0;
-	struct insn_emulation *insn = (struct insn_emulation *) table->data;
-	enum insn_emulation_mode prev_mode = insn->current_mode;
+	struct insn_emulation *insn;
+	enum insn_emulation_mode prev_mode;
 
+	mutex_lock(&emulation_proc_lock);
+	insn = (struct insn_emulation *) table->data;
+	prev_mode = insn->current_mode;
 	table->data = &insn->current_mode;
 	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
 
@@ -224,6 +228,7 @@ static int emulation_proc_handler(struct ctl_table *table, int write,
 	}
 ret:
 	table->data = insn;
+	mutex_unlock(&emulation_proc_lock);
 	return ret;
 }
 
-- 
2.27.0

