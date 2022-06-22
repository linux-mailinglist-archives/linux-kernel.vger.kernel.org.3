Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F706555538
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 22:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358691AbiFVUHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 16:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358758AbiFVUHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 16:07:41 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D212F31DD5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 13:07:39 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-510-tiqLrDOmP0egyC1vcjU4OA-1; Wed, 22 Jun 2022 16:07:35 -0400
X-MC-Unique: tiqLrDOmP0egyC1vcjU4OA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E6AF89C7DB;
        Wed, 22 Jun 2022 20:07:34 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.40.208.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B4B4492CA5;
        Wed, 22 Jun 2022 20:07:32 +0000 (UTC)
From:   Alexey Gladkov <legion@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        syzkaller-bugs@googlegroups.com,
        syzbot+b4b0d1b35442afbf6fd2@syzkaller.appspotmail.com
Subject: [PATCH] ipc: Free mq_sysctls if ipc namespace creation failed
Date:   Wed, 22 Jun 2022 22:07:29 +0200
Message-Id: <20220622200729.2639663-1-legion@kernel.org>
In-Reply-To: <8735fyhyvy.fsf@email.froward.int.ebiederm.org>
References: <8735fyhyvy.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problem that Dmitry Vyukov pointed out is that if setup_ipc_sysctls fails,
mq_sysctls must be freed before return.

executing program
BUG: memory leak
unreferenced object 0xffff888112fc9200 (size 512):
  comm "syz-executor237", pid 3648, jiffies 4294970469 (age 12.270s)
  hex dump (first 32 bytes):
    ef d3 60 85 ff ff ff ff 0c 9b d2 12 81 88 ff ff  ..`.............
    04 00 00 00 a4 01 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814b6eb3>] kmemdup+0x23/0x50 mm/util.c:129
    [<ffffffff82219a9b>] kmemdup include/linux/fortify-string.h:456 [inline]
    [<ffffffff82219a9b>] setup_mq_sysctls+0x4b/0x1c0 ipc/mq_sysctl.c:89
    [<ffffffff822197f2>] create_ipc_ns ipc/namespace.c:63 [inline]
    [<ffffffff822197f2>] copy_ipcs+0x292/0x390 ipc/namespace.c:91
    [<ffffffff8127de7c>] create_new_namespaces+0xdc/0x4f0 kernel/nsproxy.c:90
    [<ffffffff8127e89b>] unshare_nsproxy_namespaces+0x9b/0x120 kernel/nsproxy.c:226
    [<ffffffff8123f92e>] ksys_unshare+0x2fe/0x600 kernel/fork.c:3165
    [<ffffffff8123fc42>] __do_sys_unshare kernel/fork.c:3236 [inline]
    [<ffffffff8123fc42>] __se_sys_unshare kernel/fork.c:3234 [inline]
    [<ffffffff8123fc42>] __x64_sys_unshare+0x12/0x20 kernel/fork.c:3234
    [<ffffffff845aab45>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845aab45>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff8460006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

BUG: memory leak
unreferenced object 0xffff888112fd5f00 (size 256):
  comm "syz-executor237", pid 3648, jiffies 4294970469 (age 12.270s)
  hex dump (first 32 bytes):
    00 92 fc 12 81 88 ff ff 00 00 00 00 01 00 00 00  ................
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff816fea1b>] kmalloc include/linux/slab.h:605 [inline]
    [<ffffffff816fea1b>] kzalloc include/linux/slab.h:733 [inline]
    [<ffffffff816fea1b>] __register_sysctl_table+0x7b/0x7f0 fs/proc/proc_sysctl.c:1344
    [<ffffffff82219b7a>] setup_mq_sysctls+0x12a/0x1c0 ipc/mq_sysctl.c:112
    [<ffffffff822197f2>] create_ipc_ns ipc/namespace.c:63 [inline]
    [<ffffffff822197f2>] copy_ipcs+0x292/0x390 ipc/namespace.c:91
    [<ffffffff8127de7c>] create_new_namespaces+0xdc/0x4f0 kernel/nsproxy.c:90
    [<ffffffff8127e89b>] unshare_nsproxy_namespaces+0x9b/0x120 kernel/nsproxy.c:226
    [<ffffffff8123f92e>] ksys_unshare+0x2fe/0x600 kernel/fork.c:3165
    [<ffffffff8123fc42>] __do_sys_unshare kernel/fork.c:3236 [inline]
    [<ffffffff8123fc42>] __se_sys_unshare kernel/fork.c:3234 [inline]
    [<ffffffff8123fc42>] __x64_sys_unshare+0x12/0x20 kernel/fork.c:3234
    [<ffffffff845aab45>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845aab45>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff8460006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

BUG: memory leak
unreferenced object 0xffff888112fbba00 (size 256):
  comm "syz-executor237", pid 3648, jiffies 4294970469 (age 12.270s)
  hex dump (first 32 bytes):
    78 ba fb 12 81 88 ff ff 00 00 00 00 01 00 00 00  x...............
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff816fef49>] kmalloc include/linux/slab.h:605 [inline]
    [<ffffffff816fef49>] kzalloc include/linux/slab.h:733 [inline]
    [<ffffffff816fef49>] new_dir fs/proc/proc_sysctl.c:978 [inline]
    [<ffffffff816fef49>] get_subdir fs/proc/proc_sysctl.c:1022 [inline]
    [<ffffffff816fef49>] __register_sysctl_table+0x5a9/0x7f0 fs/proc/proc_sysctl.c:1373
    [<ffffffff82219b7a>] setup_mq_sysctls+0x12a/0x1c0 ipc/mq_sysctl.c:112
    [<ffffffff822197f2>] create_ipc_ns ipc/namespace.c:63 [inline]
    [<ffffffff822197f2>] copy_ipcs+0x292/0x390 ipc/namespace.c:91
    [<ffffffff8127de7c>] create_new_namespaces+0xdc/0x4f0 kernel/nsproxy.c:90
    [<ffffffff8127e89b>] unshare_nsproxy_namespaces+0x9b/0x120 kernel/nsproxy.c:226
    [<ffffffff8123f92e>] ksys_unshare+0x2fe/0x600 kernel/fork.c:3165
    [<ffffffff8123fc42>] __do_sys_unshare kernel/fork.c:3236 [inline]
    [<ffffffff8123fc42>] __se_sys_unshare kernel/fork.c:3234 [inline]
    [<ffffffff8123fc42>] __x64_sys_unshare+0x12/0x20 kernel/fork.c:3234
    [<ffffffff845aab45>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845aab45>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff8460006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

BUG: memory leak
unreferenced object 0xffff888112fbb900 (size 256):
  comm "syz-executor237", pid 3648, jiffies 4294970469 (age 12.270s)
  hex dump (first 32 bytes):
    78 b9 fb 12 81 88 ff ff 00 00 00 00 01 00 00 00  x...............
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff816fef49>] kmalloc include/linux/slab.h:605 [inline]
    [<ffffffff816fef49>] kzalloc include/linux/slab.h:733 [inline]
    [<ffffffff816fef49>] new_dir fs/proc/proc_sysctl.c:978 [inline]
    [<ffffffff816fef49>] get_subdir fs/proc/proc_sysctl.c:1022 [inline]
    [<ffffffff816fef49>] __register_sysctl_table+0x5a9/0x7f0 fs/proc/proc_sysctl.c:1373
    [<ffffffff82219b7a>] setup_mq_sysctls+0x12a/0x1c0 ipc/mq_sysctl.c:112
    [<ffffffff822197f2>] create_ipc_ns ipc/namespace.c:63 [inline]
    [<ffffffff822197f2>] copy_ipcs+0x292/0x390 ipc/namespace.c:91
    [<ffffffff8127de7c>] create_new_namespaces+0xdc/0x4f0 kernel/nsproxy.c:90
    [<ffffffff8127e89b>] unshare_nsproxy_namespaces+0x9b/0x120 kernel/nsproxy.c:226
    [<ffffffff8123f92e>] ksys_unshare+0x2fe/0x600 kernel/fork.c:3165
    [<ffffffff8123fc42>] __do_sys_unshare kernel/fork.c:3236 [inline]
    [<ffffffff8123fc42>] __se_sys_unshare kernel/fork.c:3234 [inline]
    [<ffffffff8123fc42>] __x64_sys_unshare+0x12/0x20 kernel/fork.c:3234
    [<ffffffff845aab45>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845aab45>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff8460006a>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

Reported-by: syzbot+b4b0d1b35442afbf6fd2@syzkaller.appspotmail.com
Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 ipc/namespace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/ipc/namespace.c b/ipc/namespace.c
index 754f3237194a..e1fcaedba4fa 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -64,7 +64,7 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
 		goto fail_put;
 
 	if (!setup_ipc_sysctls(ns))
-		goto fail_put;
+		goto fail_mq;
 
 	sem_init_ns(ns);
 	msg_init_ns(ns);
@@ -72,6 +72,9 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
 
 	return ns;
 
+fail_mq:
+	retire_mq_sysctls(ns);
+
 fail_put:
 	put_user_ns(ns->user_ns);
 	ns_free_inum(&ns->ns);
-- 
2.33.3

