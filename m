Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69B85510B8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 08:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238918AbiFTGw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 02:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbiFTGw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:52:27 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C0B6323
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 23:52:26 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id f16-20020a056602071000b00669bb12a6baso5646910iox.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 23:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=MCP61xtMRu0kQhKD2rnlQw35pt3dag8zKy5KedqHeAQ=;
        b=ehHBLB+ij+C+pGjo47DuxaTZmhTjzp0xb3qmR1dpF8PBN2kLHvSb67LNboZnNa19Tt
         +nT8b0gfPxjV9euNchaAaK5ZbQnYi+Oc1qqhTfZB3W6LRCltDPa6JjhyH3wEvRIbwMGY
         SKVQrQvaOj+SgyHniLovFPUBM9baxMzHtMOBz7GFme2NdGM54XgUbD2Jq4beAknbcsLE
         hSflGHlB+eaAjzlvHuW7suaNFBULil2DCu/C7sEy99yrT7MhhwEShIEN07vZXnF+FGBz
         VR0N1In4ZVc9i4jAbUZX32bs6R/g7hIa78qh0bl/4pMWcu0O7mbxuRuFtbEoabCEffYz
         gstA==
X-Gm-Message-State: AJIora+NJlp12OKSnyyTECl3bQNWj7FevfoLdYv4Y2ylDB34z4z5ZOKt
        ew9kb4ThrPkagvPzL5nJWuUV1Y17ZFsCuZefwCzOCR1t6k4D
X-Google-Smtp-Source: AGRyM1sDJXzTPwNOJcj25fuMdPk3x9JUwEpH09MaGr8PxXrL3OV6PfSkPmHyFwPCpGF1ztLjVvjER6T59fG1+WVRjFeOraLAQ6PS
MIME-Version: 1.0
X-Received: by 2002:a05:6638:f0d:b0:331:e337:f4e4 with SMTP id
 h13-20020a0566380f0d00b00331e337f4e4mr12653981jas.249.1655707945727; Sun, 19
 Jun 2022 23:52:25 -0700 (PDT)
Date:   Sun, 19 Jun 2022 23:52:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f5004705e1db8bad@google.com>
Subject: [syzbot] memory leak in setup_mq_sysctls
From:   syzbot <syzbot+b4b0d1b35442afbf6fd2@syzkaller.appspotmail.com>
To:     ebiederm@xmission.com, legion@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    979086f5e006 Merge tag 'fs.fixes.v5.19-rc3' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1284331bf00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c696a83383a77f81
dashboard link: https://syzkaller.appspot.com/bug?extid=b4b0d1b35442afbf6fd2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=163e740ff00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132b758bf00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b4b0d1b35442afbf6fd2@syzkaller.appspotmail.com

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



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
