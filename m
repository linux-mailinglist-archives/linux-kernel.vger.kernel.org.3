Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0005776DE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 17:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbiGQPD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 11:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiGQPD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 11:03:27 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC5C13DCC;
        Sun, 17 Jul 2022 08:03:26 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id os14so17168875ejb.4;
        Sun, 17 Jul 2022 08:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Dv/p7nIIHn8hT8UchBSA1/4q6QSRvBvNjEZvxKQbyo8=;
        b=mI3kAqolKJgIMErLRLmU220y2pf1R3sVUCBZ48ZmrtB9/qm4CWeIBjsaUqo6TrqNng
         yl7MTD2nmTkTbkA1Cz64bJnNezfsstOddleBs2IRYZXxR2JHYtQHBx5xI0xEWP/w1lqH
         GHS674QDl1KZ/c69QdmmiA6fyj9RRVXH+P+WPHUOHENXxKstvGWeou3Uv54thCkm1YWP
         Z1PGTT+QcuppkLjB6RRhVdrDJqH+RGtWkBJWUmUutcWbIkS5Z5N2aXTQ4v7c+JknP4u0
         qfN0OXt6cUmY3wcEur23i5aFHVxOZ8K9T0Z2Oq0KklazzFei0gIV87SozXvwSCz20C6m
         Y9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Dv/p7nIIHn8hT8UchBSA1/4q6QSRvBvNjEZvxKQbyo8=;
        b=vQNGbQs3109hCqiTIbI7B4dy9egk7XKoApN0C3BCIzU71quYlJ8cj5l7S8908NkWn6
         WubZM9wo6Q2wTW6Yxv7vd7o8kJreTLpYNpmlVhyTLUTP0wvV9bBC4gOWNlg3jAdrKr/N
         bSLmr3NNusn+8bRYb2sHhor9laP96ZkHQmOWsdVJkDiAPJ1SvvrIXfesnxdQ5HqD8Mbt
         5ZlTlhDgoNjEDTKKRRJ8V7oVA4s1YE2P/5Vk+ld6b/qvkylehKfxWbyebQKNYnMeNkpU
         0O3FPzhwG1DXECocjC8+r1NzCXtq4+xP8G23szdQwXXpPanUKbb23mZhLZ4V5rkoAd09
         01ZQ==
X-Gm-Message-State: AJIora9ARzC667pYT4jxnY+e4zBr2Q+VzNUz1MUGgY/NpnEY2rntcQJF
        WSJ9lmPif5us+508JC4UNOkyRfUdldkzIzQhNpLOV1KR9/8YzA+a
X-Google-Smtp-Source: AGRyM1uOuPqlK5ptYLbZNVxzFCT39fPMVgLt6uh8ewQOJiucginsvXn8XqJj3WtSh7l0p/ZWCB2s1ggEe/mcOj0OuP4=
X-Received: by 2002:a17:907:c27:b0:72b:8118:b899 with SMTP id
 ga39-20020a1709070c2700b0072b8118b899mr22465859ejc.739.1658070204720; Sun, 17
 Jul 2022 08:03:24 -0700 (PDT)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Sun, 17 Jul 2022 23:02:49 +0800
Message-ID: <CAO4mrfdjv2TZf7dc=ei61NBmLePLUGCJ9WbmvWGWa8Q4o=bRkw@mail.gmail.com>
Subject: WARNING in floppy_interrupt
To:     efremov@linux.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux Developer,

Recently when using our tool to fuzz kernel, the following crash was triggered:

HEAD commit: fc74e0a40e4f Linux 5.16-rc7
git tree: upstream
compiler: clang 12.0.0
console output:
https://drive.google.com/file/d/1bTS1Khxq5ZVwEPK-QIzGMJ24DcBhlZNW/view?usp=sharing
Syzlang reproducer:
https://drive.google.com/file/d/11TW-_hd6xARpzEv05ZzN5njdyKjPV4ku/view?usp=sharing
C reproducer: https://drive.google.com/file/d/1vLLyr50AtjVUYr3ZFyypwB0WcNa0dloj/view?usp=sharing
kernel config: https://drive.google.com/file/d/1L16y3aFu5mPQbKNsc7eQc6RH55YRd1zd/view?usp=sharing

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

WARNING: CPU: 0 PID: 38 at drivers/block/floppy.c:1000
floppy_interrupt+0x694/0x6d0
Modules linked in:
CPU: 0 PID: 38 Comm: kworker/u2:2 Not tainted 5.16.0-rc7 #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Workqueue: floppy floppy_work_workfn
RIP: 0010:floppy_interrupt+0x694/0x6d0
Code: 21 0c 31 ed 48 c7 c7 00 a6 f4 8a 48 c7 c2 6d c1 52 8c 48 c7 c1
e0 a4 f4 8a 31 c0 e8 9d 68 26 05 e9 e7 fd ff ff e8 1c 38 ac fc <0f> 0b
e9 63 fb ff ff 89 d9 80 e1 07 38 c1 0f 8c a6 fa ff ff 48 89
RSP: 0018:ffffc90000007d28 EFLAGS: 00010046
RAX: ffffffff84d5d9d4 RBX: 0000000000000001 RCX: ffff8880149523c0
RDX: 0000000080010000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff84d5d530 R09: fffffbfff1a56ead
R10: fffffbfff1a56ead R11: 0000000000000000 R12: dffffc0000000000
R13: 0000000000000000 R14: ffffffff84d65f30 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888063c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007efe73921000 CR3: 000000000c88e000 CR4: 0000000000752ef0
DR0: 00000000200000c0 DR1: 0000000020000080 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
PKRU: 55555554
Call Trace:
 <IRQ>
 __handle_irq_event_percpu+0x20a/0x6d0
 handle_irq_event+0x10a/0x300
 handle_edge_irq+0x245/0xbe0
 __common_interrupt+0xce/0x1e0
 common_interrupt+0x9f/0xc0
 </IRQ>
 <TASK>
 asm_common_interrupt+0x1e/0x40
RIP: 0010:reset_fdc+0x36b/0x520
Code: 80 cb 80 48 8d 2c ed 70 a9 f7 90 48 89 e8 48 c1 e8 03 42 80 3c
30 00 74 08 48 89 ef e8 1e d9 f6 fc 8b 55 00 83 c2 04 89 d8 ee <e9> aa
00 00 00 e8 6b b4 ab fc 48 8d 1c ed 6d a9 f7 90 48 89 d8 48
RSP: 0018:ffffc90000cbfc28 EFLAGS: 00000202
RAX: 0000000090f7a981 RBX: ffffffff90f7a981 RCX: ffff8880149523c0
RDX: 00000000000003f4 RSI: 0000000000000062 RDI: 0000000000000044
RBP: ffffffff90f7a970 R08: ffffffff84d65d27 R09: fffffbfff1ff5bd0
R10: fffffbfff1ff5bd0 R11: 0000000000000000 R12: 0000000000000000
R13: 1ffffffff21ef52f R14: dffffc0000000000 R15: ffffffff90f7a978
 process_one_work+0x853/0x1140
 worker_thread+0xac1/0x1320
 kthread+0x410/0x500
 ret_from_fork+0x1f/0x30
 </TASK>
----------------
Code disassembly (best guess):
   0: 80 cb 80              or     $0x80,%bl
   3: 48 8d 2c ed 70 a9 f7 lea    -0x6f085690(,%rbp,8),%rbp
   a: 90
   b: 48 89 e8              mov    %rbp,%rax
   e: 48 c1 e8 03          shr    $0x3,%rax
  12: 42 80 3c 30 00        cmpb   $0x0,(%rax,%r14,1)
  17: 74 08                je     0x21
  19: 48 89 ef              mov    %rbp,%rdi
  1c: e8 1e d9 f6 fc        callq  0xfcf6d93f
  21: 8b 55 00              mov    0x0(%rbp),%edx
  24: 83 c2 04              add    $0x4,%edx
  27: 89 d8                mov    %ebx,%eax
  29: ee                    out    %al,(%dx)
* 2a: e9 aa 00 00 00        jmpq   0xd9 <-- trapping instruction
  2f: e8 6b b4 ab fc        callq  0xfcabb49f
  34: 48 8d 1c ed 6d a9 f7 lea    -0x6f085693(,%rbp,8),%rbx
  3b: 90
  3c: 48 89 d8              mov    %rbx,%rax
  3f: 48                    rex.W

Best,
Wei
