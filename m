Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43A4570052
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiGKLYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiGKLYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:24:17 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72A83C168
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:52:22 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id y14-20020a17090a644e00b001ef775f7118so7910651pjm.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=X4BSofP/liFgaHy7KdUvtS1dtiJwFHgYiX4K2rZAcZY=;
        b=bkFtFBqskGK+NlCEO2LlXGIQbzqrbU5K0qbIgGrIczsLyvmd2Ydz/hwmv7U0bBKy7y
         949zcH6vz1+KKGYHWVfur5RHskaPO44U4PVwtHyJ9NrWArWMRIjdqZDcywxYwCGEA3ED
         OvqEFEyTXPas3oTnWvq+sGi9BTM8KfPBdN/9Wt+s29fsC9xrL/gAHcCJYtYgkU/sE/sN
         4N17TF9AmEGxcg5dxjBJqf59Vx7wEeV5QbGCr+gfqpN+bZCmEXoUp5QMakZcmnv2VXG/
         96zV8E/VMnGGbA9rVUyEDsJdEvHcHGq2afTbFP3ZwqGchP4cWwj3bKKJLnjuwQd+hbQK
         44Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=X4BSofP/liFgaHy7KdUvtS1dtiJwFHgYiX4K2rZAcZY=;
        b=5TSJbL0gOhdrNg00ma/gUDFhJJkXzb/6l9FfwXdWMgp/vUHMO2g+wXWBYydLo4CAoI
         9ERYg83c3yen+ipVhCb+Y6HAQ62Hr8AUi2K+9k1oVw+/Rzhs4pWYrDGs89m5HOTgHjrP
         ABC6Ohco1nc0+j8JeoLbdtCS+Cl+jmhztPFZRxX6qL70xKj7PRA7vde27e/e4G0KmXlS
         DsPvD/ujFY6KWF9f1RXJu8e9ycWKSCS+GFcupiSS0/6aEVbRhu/Zrr8qpUlCfuTxs3d5
         szXQrFY0HXOvBYO5CbYwpid7G8ND8VL4SKQn+bNTJzxgQOCJA63328gKt4pNSH48hZQc
         HuGw==
X-Gm-Message-State: AJIora/MOARr75tiuZLFzWm1siujCAPkKLU5/+SqUgWu2EpVRuI3+pIT
        uNkmA5YFG12BbwEVVOqmDWc=
X-Google-Smtp-Source: AGRyM1usHAtUqqvaIeKVnx/cbwzJ6hjdynxiRlCuWvtu9fuGuvq87cJwSQOplvvI8bJVvbcFteCMnw==
X-Received: by 2002:a17:90b:2788:b0:1ef:9fcc:4b18 with SMTP id pw8-20020a17090b278800b001ef9fcc4b18mr17220263pjb.127.1657536742077;
        Mon, 11 Jul 2022 03:52:22 -0700 (PDT)
Received: from archdragon (dragonet.kaist.ac.kr. [143.248.133.220])
        by smtp.gmail.com with ESMTPSA id s14-20020a17090a13ce00b001ef88c30fbbsm6678808pjf.49.2022.07.11.03.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 03:52:21 -0700 (PDT)
Date:   Mon, 11 Jul 2022 19:52:16 +0900
From:   "Dae R. Jeong" <threeearcat@gmail.com>
To:     bryantan@vmware.com, rjalisatgi@vmware.com, vdasa@vmware.com,
        pv-drivers@vmware.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: general protection fault in add_wait_queue_exclusive
Message-ID: <YswA4H+2l9qkIsrq@archdragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We observed a crash "general protection fault in
add_wait_queue_exclusive" during fuzzing.

Unfortunately, we have not found a reproducer for the crash yet. We
will inform you if we have any update on this crash.


Detailed crash information is attached at the end of this email.

Best regards,
Dae R. Jeong
------

- Kernel commit:
92f20ff72066d

- Crash report:
general protection fault, probably for non-canonical address 0xdffffc0000000019: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000000c8-0x00000000000000cf]
CPU: 2 PID: 14077 Comm: syz-executor.0 Not tainted 5.19.0-rc3-32288-g0f3b08299494 #15
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
RIP: 0010:__lock_acquire+0xf3/0x5e00 kernel/locking/lockdep.c:4926
Code: 89 bc 24 88 00 00 00 0f 85 02 27 00 00 83 3d 1b 16 66 10 00 0f 84 97 43 00 00 83 3d d6 ea f9 0e 00 74 31 48 89 f8 48 c1 e8 03 <42> 80 3c 00 00 74 17 e8 81 63 86 00 48 8b bc 24 88 00 00 00 49 b8
RSP: 0018:ffffc9000ea575e0 EFLAGS: 00010002
RAX: 0000000000000019 RBX: 0000000000000001 RCX: 1ffff92001d4aedc
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000000c8
RBP: ffffc9000ea57970 R08: dffffc0000000000 R09: 0000000000000001
R10: fffffbfff2394d5e R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
FS:  00007f44e25aa700(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056077effb180 CR3: 0000000028845000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x1a4/0x4a0 kernel/locking/lockdep.c:5672
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xb3/0x100 kernel/locking/spinlock.c:162
 add_wait_queue_exclusive+0x3c/0x130 kernel/sched/wait.c:33
 ep_ptable_queue_proc+0x1b1/0x370 fs/eventpoll.c:1259
 poll_wait include/linux/poll.h:49 [inline]
 vmci_host_poll+0xf8/0x2b0 drivers/misc/vmw_vmci/vmci_host.c:174
 vfs_poll include/linux/poll.h:88 [inline]
 ep_item_poll fs/eventpoll.c:853 [inline]
 ep_insert fs/eventpoll.c:1522 [inline]
 do_epoll_ctl+0x2f84/0x4a90 fs/eventpoll.c:2141
 __do_sys_epoll_ctl fs/eventpoll.c:2192 [inline]
 __se_sys_epoll_ctl fs/eventpoll.c:2183 [inline]
 __x64_sys_epoll_ctl+0x19d/0x230 fs/eventpoll.c:2183
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x4e/0xa0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x478dc9
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f44e25a9be8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e9
RAX: ffffffffffffffda RBX: 0000000000781408 RCX: 0000000000478dc9
RDX: 0000000000000004 RSI: 0000000000000001 RDI: 0000000000000003
RBP: 00000000f477909a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000020000240 R11: 0000000000000246 R12: 0000000000781500
R13: 0000000000781414 R14: 0000000000781408 R15: 00007ffc45fbf120
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0xf3/0x5e00 kernel/locking/lockdep.c:4926
Code: 89 bc 24 88 00 00 00 0f 85 02 27 00 00 83 3d 1b 16 66 10 00 0f 84 97 43 00 00 83 3d d6 ea f9 0e 00 74 31 48 89 f8 48 c1 e8 03 <42> 80 3c 00 00 74 17 e8 81 63 86 00 48 8b bc 24 88 00 00 00 49 b8
RSP: 0018:ffffc9000ea575e0 EFLAGS: 00010002
RAX: 0000000000000019 RBX: 0000000000000001 RCX: 1ffff92001d4aedc
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000000c8
RBP: ffffc9000ea57970 R08: dffffc0000000000 R09: 0000000000000001
R10: fffffbfff2394d5e R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
FS:  00007f44e25aa700(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056077effb180 CR3: 0000000028845000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
