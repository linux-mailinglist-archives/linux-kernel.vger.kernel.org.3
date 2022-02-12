Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE544B3549
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 14:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235729AbiBLN2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 08:28:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbiBLN2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 08:28:01 -0500
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57034245AF
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 05:27:56 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0V4DccNi_1644672462;
Received: from VM20190228-102.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0V4DccNi_1644672462)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 12 Feb 2022 21:27:52 +0800
From:   Guanghui Feng <guanghuifeng@linux.alibaba.com>
To:     pmladek@suse.com, senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org
Cc:     baolin.wang@linux.alibaba.com, yaohongbo@linux.alibaba.com,
        zhangliguang@linux.alibaba.com, zhuo.song@linux.alibaba.com
Subject: [PATCH] printk: fix softlockup/rcu stall warning without setting CONFIG_PREEMPTION
Date:   Sat, 12 Feb 2022 21:27:42 +0800
Message-Id: <1644672462-20793-1-git-send-email-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If without setting CONFIG_PREEMPTION, and there are too many messages
only in one cpu which will set console_may_schedule to 0 without cond_resched,
we will find softlockup/rcu stall warning. Although the timer interrupt
can be raised in the routine of console_unlock, the irq interrupt return
to user/kernel will't schedule other tasks(without setting CONFIG_PREEMPTION).
So I add need_resched() for cond_schedule to avoid it.

Call trace:
    console_unlock+0x220/0x420
    vprintk_emit+0x17c/0x1ac
    vprintk_default+0x3c/0x44
    vprintk+0x38/0x70
    printk+0x64/0x88
    dump_task.part.0+0xc4/0xe0
    dump_task+0x70/0x74
    dump_tasks+0x78/0x90
    dump_global_header+0xcc/0xe8
    oom_kill_process+0x258/0x274
    out_of_memory.part.0+0xb0/0x33c
    out_of_memory+0x4c/0xa0
    __alloc_pages_may_oom+0x11c/0x1a0
    __alloc_pages_slowpath.constprop.0+0x4c0/0x75c
    __alloc_pages_nodemask+0x2b4/0x310
    alloc_pages_current+0x8c/0x140
    get_zeroed_page+0x20/0x50
    __pud_alloc+0x40/0x190
    copy_pud_range+0x264/0x280
    copy_page_range+0xe8/0x204
    dup_mmap+0x334/0x434
    dup_mm+0x64/0x11c
    copy_process+0x5e0/0x11a0
    kernel_clone+0x94/0x364
    __do_sys_clone+0x54/0x80
    __arm64_sys_clone+0x24/0x30
    el0_svc_common.constprop.0+0x7c/0x210
    do_el0_svc+0x74/0x90
    el0_svc+0x24/0x60
    el0_sync_handler+0xa8/0xb0
    el0_sync+0x140/0x180

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 kernel/printk/printk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 82abfaf..54b6cf2 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2716,7 +2716,11 @@ void console_unlock(void)
 		if (handover)
 			return;
 
+#ifndef CONFIG_PREEMPTION
+		if (do_cond_resched || need_resched())
+#else
 		if (do_cond_resched)
+#endif
 			cond_resched();
 	}
 
-- 
1.8.3.1

