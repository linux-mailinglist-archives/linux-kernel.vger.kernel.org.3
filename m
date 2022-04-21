Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA882509BA4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387120AbiDUJCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387099AbiDUJBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:01:12 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B06D21273
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:58:24 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id x16-20020a6bfe10000000b006409f03e39eso2876407ioh.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=hEgnTex8BYwpSBORN3EBim5ECJvWbtZDB9zT3ak4tmY=;
        b=73vN9jhn7Xg3CDkg+DlwUfeIHUcCJuOzdyEsXkV4e/cbboi4C3yWIOLn+zo8mH1CuP
         dzhLJtBk00lWBBv95JF2UcJB5xb6ynO0LfV5S9wcaXn3wwgrRlb5fM69GMUnKzMYkFiY
         CFw75CvV8qXB2uYMrGP47mQqfbNzuC2BMZ9cHUqLdQ87Ro2UL08KzFMjuz7rgSDFNTZP
         1j1S5fGdprhyHxMD3WADlXjQd5GgvNc3ClC2uXDPaUvXhF2+5weCqCsozjXIMgf+fNsj
         hA3dpquLz7YHVFqGuvBh1tWyOrgy68p11tnRxd7rtP+aetMkdir9bPdMTqJTcPV8q4T3
         SbZA==
X-Gm-Message-State: AOAM531W2n/+4KywXKr+Cl6jsGbvGyIXGQskiaFH++meFEhL02jVATiM
        G56fV5SUmQFN2wqz/6sOz7fLinw038Mp3ZMr/XV4lSB5R6zs
X-Google-Smtp-Source: ABdhPJyG5iLq37s+N8SpmzvgequCMu6ImAX2ZQulPyJoky5vOtW7ENqmAIGRWKzAJkKWOaGrCREkN9xjcvb8Gw41AlMSrenQ4X9M
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2dcf:b0:656:d2f8:9dee with SMTP id
 l15-20020a0566022dcf00b00656d2f89deemr3420087iow.29.1650531503466; Thu, 21
 Apr 2022 01:58:23 -0700 (PDT)
Date:   Thu, 21 Apr 2022 01:58:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f46c6305dd264f30@google.com>
Subject: [syzbot] WARNING in __kfence_free
From:   syzbot <syzbot+ffe71f1ff7f8061bcc98@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, dvyukov@google.com, elver@google.com,
        glider@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    559089e0a93d vmalloc: replace VM_NO_HUGE_VMAP with VM_ALLO..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10853220f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2e1f9b9947966f42
dashboard link: https://syzkaller.appspot.com/bug?extid=ffe71f1ff7f8061bcc98
compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ffe71f1ff7f8061bcc98@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 2216 at mm/kfence/core.c:1022 __kfence_free+0x84/0xc0 mm/kfence/core.c:1022
Modules linked in:
CPU: 0 PID: 2216 Comm: syz-executor.0 Not tainted 5.18.0-rc3-syzkaller-00007-g559089e0a93d #0
Hardware name: linux,dummy-virt (DT)
pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __kfence_free+0x84/0xc0 mm/kfence/core.c:1022
lr : kfence_free include/linux/kfence.h:186 [inline]
lr : __slab_free+0x2e4/0x4d4 mm/slub.c:3315
sp : ffff80000a9fb980
x29: ffff80000a9fb980 x28: ffff80000a280040 x27: f2ff000002c01c00
x26: ffff00007b694040 x25: ffff00007b694000 x24: 0000000000000001
x23: ffff00007b694000 x22: ffff00007b694000 x21: f2ff000002c01c00
x20: ffff80000821accc x19: fffffc0001eda500 x18: 0000000000000002
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000001 x13: 000000000005eb7f x12: f7ff000007a08024
x11: f7ff000007a08000 x10: 0000000000000000 x9 : 0000000000000014
x8 : 0000000000000001 x7 : 0000000000094000 x6 : ffff80000a280000
x5 : ffff80000821accc x4 : ffff80000a50e078 x3 : ffff80000a280348
x2 : f0ff00001e325c00 x1 : ffff80000a522b40 x0 : ffff00007b694000
Call trace:
 __kfence_free+0x84/0xc0 mm/kfence/core.c:1022
 kfence_free include/linux/kfence.h:186 [inline]
 __slab_free+0x2e4/0x4d4 mm/slub.c:3315
 do_slab_free mm/slub.c:3498 [inline]
 slab_free mm/slub.c:3511 [inline]
 kfree+0x320/0x37c mm/slub.c:4552
 kvfree+0x3c/0x50 mm/util.c:615
 xt_free_table_info+0x78/0x90 net/netfilter/x_tables.c:1212
 __do_replace+0x240/0x330 net/ipv6/netfilter/ip6_tables.c:1104
 do_replace net/ipv6/netfilter/ip6_tables.c:1157 [inline]
 do_ip6t_set_ctl+0x374/0x4e0 net/ipv6/netfilter/ip6_tables.c:1639
 nf_setsockopt+0x68/0x94 net/netfilter/nf_sockopt.c:101
 ipv6_setsockopt+0xa8/0x220 net/ipv6/ipv6_sockglue.c:1026
 tcp_setsockopt+0x38/0xdb4 net/ipv4/tcp.c:3696
 sock_common_setsockopt+0x1c/0x30 net/core/sock.c:3505
 __sys_setsockopt+0xa0/0x1c0 net/socket.c:2180
 __do_sys_setsockopt net/socket.c:2191 [inline]
 __se_sys_setsockopt net/socket.c:2188 [inline]
 __arm64_sys_setsockopt+0x2c/0x40 net/socket.c:2188
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xec arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x6c/0x84 arch/arm64/kernel/syscall.c:181
 el0_svc+0x44/0xb0 arch/arm64/kernel/entry-common.c:616
 el0t_64_sync_handler+0x1a4/0x1b0 arch/arm64/kernel/entry-common.c:634
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:581
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
