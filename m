Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16622573B0A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236650AbiGMQUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbiGMQUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:20:43 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDC0183B6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:20:42 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y4so14758870edc.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 09:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=Y5NSihFez2XvScqkpb+CatCLJeMlzbRshfYp6qFIWEg=;
        b=V42I4AWxhP/5u6RJWY6rIv4SzWcfBjIUqxRPakHX6Yb+w3tyOt0fOvtHLq3/sogGFp
         FLjZeSiOSuZPDv9EB/oEG7GRojgR8EmPUrLsBloo8xLL2dxMvUuqp3FmdaseK4IAESvk
         tKwZQPlnP4cF/dfidXHkinL3RBa3fOAIEgEPSWLz4Trwo40o0rgwllfvv1bta525QBlj
         uvzCiWk+ibkOBFZl2Dpw/UMVgzqxLECNxLooRrHGzlgJGep/UKivJpmAfW19EX5Nu4iX
         egolLTDkilPAXxtjdXxCEpOaRMSL+EmPQdffhwchFIidUL0ZCC4CDXNAOjxXuos9oVlQ
         f2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Y5NSihFez2XvScqkpb+CatCLJeMlzbRshfYp6qFIWEg=;
        b=T7YZwpPLR0eLxBH1JhKDECmNHskLcpsZwLLvXJClY0VS8PKahdvwCiI+mKLvpIBr52
         jWPEFmmESTUX8N0evAjFDZdBPJ5Vituwmzp8fYkg6gLJ8cXptIDZgEUgYWLLjkeGF5gm
         PQEu2HIm24Xm860lnnHua2ZhXu2b/gmiFtZkeOOOOqK6wFUCTGEcMEbJnSE8PFViGnDS
         0ddlCkXMjsa91VEL51pAWdpdBRK6Tzy700VlzyYVm3+cEzwkbgtqAy6LxO2vEVuWip3i
         fyDiYHsGfh2VaI9Y2d5vL1FpYYpEmBCKvAqGqaFxXp0FC6p59wizzcZskKss+ARRJV/r
         4NfQ==
X-Gm-Message-State: AJIora+0zIyUrS/EFKxoVCOKWxi6zQXO//o0Oafw1AJP3BHJ0kqTuYLJ
        SGDCoIjXmy86FeGi2PLvQ1/rHk+pO8ry2o7krqiUmC89CNs=
X-Google-Smtp-Source: AGRyM1sW1QTgI5c4TuGK/LXKqTEpM+koCDujf6eIGiEGfCQNWWxiZiaEyRT7kH8SwCaXXBjteVx1zH+ds2Cr7SKNYxQ=
X-Received: by 2002:a05:6402:239f:b0:43a:92a7:84e with SMTP id
 j31-20020a056402239f00b0043a92a7084emr6036924eda.293.1657729240178; Wed, 13
 Jul 2022 09:20:40 -0700 (PDT)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Thu, 14 Jul 2022 00:20:04 +0800
Message-ID: <CAO4mrfcHQRSgR923e==6Y4nXU-BfdJ_UE8bhjZxoqxWo_=L-MQ@mail.gmail.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in sctp_sched_dequeue_common
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux Developer,

Recently when using our tool to fuzz kernel, the following crash was triggered:

HEAD commit: c5eb0a61238d Linux 5.18-rc6
git tree: upstream
compiler: clang 12.0.0
console output:
https://drive.google.com/file/d/1zbd9t-NNorzTXESdQ3bxE-q9uLu-Bm9d/view?usp=sharing
Syzlang reproducer:
https://drive.google.com/file/d/18wnwTf53Ln4K8e4G9d8hS4-e0URQKHet/view?usp=sharing
C reproducer: https://drive.google.com/file/d/1ttiMq0WYi46zFP1II8O9eee_dvDweIb6/view?usp=sharing
kernel config: https://drive.google.com/file/d/1fITkvcuglspvuhI0mhXUndx112fJmcOZ/view?usp=sharing

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 12f83067 P4D 12f83067 PUD 0
Oops: 0000 [#1] PREEMPT SMP
CPU: 0 PID: 13 Comm: ksoftirqd/0 Not tainted 5.18.0-rc6 #12
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:__list_del_entry_valid+0x26/0x80
Code: 00 00 00 00 55 48 89 e5 48 89 fe 48 ba 00 01 00 00 00 00 ad de
48 8b 0f 48 39 d1 74 22 48 8b 46 08 48 83 c2 22 48 39 d0 74 25 <48> 8b
10 48 39 f2 75 2d 48 8b 51 08 48 39 f2 75 37 b0 01 5d c3 48
RSP: 0018:ffff888007313720 EFLAGS: 00010217
RAX: 0000000000000000 RBX: ffff88800c6283e8 RCX: 0000000000000000
RDX: dead000000000122 RSI: ffff88800c6283e8 RDI: ffff88800c6283e8
RBP: ffff888007313720 R08: ffffffff84399732 R09: ffffffff84392a74
R10: 0000000000000042 R11: ffff8880072a2f80 R12: ffff8880138be238
R13: ffff888016cdb000 R14: ffff888016cdb5a0 R15: ffff888016cdb000
FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000012f82000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 sctp_sched_dequeue_common+0x1c/0x90
 sctp_sched_prio_dequeue+0x67/0x80
 __sctp_outq_teardown+0x299/0x380
 sctp_outq_free+0x15/0x20
 sctp_association_free+0xc3/0x440
 sctp_do_sm+0x1ca7/0x2210
 sctp_assoc_bh_rcv+0x1f6/0x340
 sctp_inq_push+0x98/0xb0
 sctp_rcv+0x134e/0x16b0
 sctp6_rcv+0x1b/0x30
 ip6_protocol_deliver_rcu+0x5b7/0x930
 ip6_input+0x80/0x140
 ip6_rcv_finish+0x16e/0x1d0
 ipv6_rcv+0x72/0x110
 __netif_receive_skb+0x66/0x140
 process_backlog+0x13d/0x230
 __napi_poll+0x4b/0x310
 net_rx_action+0x1ae/0x410
 __do_softirq+0x16e/0x30f
 run_ksoftirqd+0x23/0x30
 smpboot_thread_fn+0x210/0x370
 kthread+0x124/0x160
 ret_from_fork+0x1f/0x30
 </TASK>
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
CR2: 0000000000000000
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid+0x26/0x80
Code: 00 00 00 00 55 48 89 e5 48 89 fe 48 ba 00 01 00 00 00 00 ad de
48 8b 0f 48 39 d1 74 22 48 8b 46 08 48 83 c2 22 48 39 d0 74 25 <48> 8b
10 48 39 f2 75 2d 48 8b 51 08 48 39 f2 75 37 b0 01 5d c3 48
RSP: 0018:ffff888007313720 EFLAGS: 00010217
RAX: 0000000000000000 RBX: ffff88800c6283e8 RCX: 0000000000000000
RDX: dead000000000122 RSI: ffff88800c6283e8 RDI: ffff88800c6283e8
RBP: ffff888007313720 R08: ffffffff84399732 R09: ffffffff84392a74
R10: 0000000000000042 R11: ffff8880072a2f80 R12: ffff8880138be238
R13: ffff888016cdb000 R14: ffff888016cdb5a0 R15: ffff888016cdb000
FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000012f82000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
----------------
Code disassembly (best guess):
   0: 00 00                add    %al,(%rax)
   2: 00 00                add    %al,(%rax)
   4: 55                    push   %rbp
   5: 48 89 e5              mov    %rsp,%rbp
   8: 48 89 fe              mov    %rdi,%rsi
   b: 48 ba 00 01 00 00 00 movabs $0xdead000000000100,%rdx
  12: 00 ad de
  15: 48 8b 0f              mov    (%rdi),%rcx
  18: 48 39 d1              cmp    %rdx,%rcx
  1b: 74 22                je     0x3f
  1d: 48 8b 46 08          mov    0x8(%rsi),%rax
  21: 48 83 c2 22          add    $0x22,%rdx
  25: 48 39 d0              cmp    %rdx,%rax
  28: 74 25                je     0x4f
* 2a: 48 8b 10              mov    (%rax),%rdx <-- trapping instruction
  2d: 48 39 f2              cmp    %rsi,%rdx
  30: 75 2d                jne    0x5f
  32: 48 8b 51 08          mov    0x8(%rcx),%rdx
  36: 48 39 f2              cmp    %rsi,%rdx
  39: 75 37                jne    0x72
  3b: b0 01                mov    $0x1,%al
  3d: 5d                    pop    %rbp
  3e: c3                    retq
  3f: 48                    rex.W

Best,
Wei
