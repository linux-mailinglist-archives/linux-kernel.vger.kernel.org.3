Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604325B1969
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 11:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiIHJ4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 05:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIHJ4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:56:10 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC49A6F27E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 02:56:01 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 2889sVUL014413
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Thu, 8 Sep 2022 17:54:31 +0800 (CST)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.74.65) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 8 Sep 2022 17:54:32 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        <linux-kernel@vger.kernel.org>, <ke.wang@unisoc.com>
Subject: [Resend PATCH] fs: use kvmalloc for big coredump file
Date:   Thu, 8 Sep 2022 17:54:12 +0800
Message-ID: <1662630852-12277-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.74.65]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 2889sVUL014413
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

High order page allocation observed which even introduce kernel panic when generating
coredump file, use kvmalloc_array instead of kmalloc_array

[68058.982108] init: Untracked pid 3847 exited with status 0
[68058.982343] init: Untracked pid 3847 did not have an associated service entry and will not be reaped
[68059.038127] warn_alloc: 29 callbacks suppressed
[68059.038132] TimerThread: page allocation failure: order:7, mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), nodemask=(null),cpuset=foreground,mems_allowed=0
[68059.038155] CPU: 6 PID: 3597 Comm: TimerThread Tainted: G        W  OE     5.15.41-android13-8-01198-g03458ee9a090-ab000039 #1
[68059.038159] Hardware name: Unisoc UMS9620-base Board (DT)
[68059.038161] Call trace:
[68059.038163]  dump_backtrace.cfi_jt+0x0/0x8
[68059.038169]  dump_stack_lvl+0x98/0xe8
[68059.038174]  warn_alloc+0x164/0x200
[68059.038180]  __alloc_pages_slowpath+0x9d4/0xb64
[68059.038183]  __alloc_pages+0x21c/0x39c
[68059.038186]  kmalloc_order+0x4c/0x13c
[68059.038189]  kmalloc_order_trace+0x34/0x154
[68059.038192]  __kmalloc+0x600/0x8a8
[68059.038196]  elf_core_dump+0x7c4/0x15d8
[68059.038201]  do_coredump+0x680/0xe54
[68059.038203]  get_signal+0x610/0x988
[68059.038209]  do_signal+0xd4/0x2bc
[68059.038213]  do_notify_resume+0xa0/0x1c8
[68059.038216]  el0_svc+0x68/0x90
[68059.038219]  el0t_64_sync_handler+0x88/0xec
[68059.038222]  el0t_64_sync+0x1b4/0x1b8

Reported-by: Guanglu Xu <guanglu.xu@unisoc.com>
Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 fs/coredump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index ebc43f9..52e9177 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -612,7 +612,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 			goto fail_dropcount;
 		}
 
-		helper_argv = kmalloc_array(argc + 1, sizeof(*helper_argv),
+		helper_argv = kvmalloc_array(argc + 1, sizeof(*helper_argv),
 					    GFP_KERNEL);
 		if (!helper_argv) {
 			printk(KERN_WARNING "%s failed to allocate memory\n",
@@ -631,7 +631,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 			retval = call_usermodehelper_exec(sub_info,
 							  UMH_WAIT_EXEC);
 
-		kfree(helper_argv);
+		kvfree(helper_argv);
 		if (retval) {
 			printk(KERN_INFO "Core dump to |%s pipe failed\n",
 			       cn.corename);
-- 
1.9.1

