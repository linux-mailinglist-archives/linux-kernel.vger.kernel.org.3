Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDEA57005A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbiGKL0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbiGKLZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:25:45 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3632AB854
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:58:40 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id a15so4426521pfv.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=Ilo+G+TPtm4MhEKcZK9WJSstSpgrmWQA3rANoOXuyBQ=;
        b=jrIvCx3kVCR0eUYcluIFiKvwMq6fuwqixY7FUH7LMqljM9n0bK5botV2+ZtFkl3b8j
         0TgIiNqnZKbD4TsEWtnl0+oGTtZQ/rhR/ui3aJtFb8Y0bpgqtO0pZVdoyASeya812fLc
         RM7XmL49Dq7K5KPT8C7PV8Atpi7GI0OkE3ZpK7vOucUYdtbazyFOfuoaCpIY9ymWnD4/
         KQe6PWskhLPMuXIm229GRxpGRdBiT0gP8IKRAc562Vh0OurIhMVuL0+VTKIk/tgPZ67j
         NeUcv+DKYQDVqLn9KmL9ezCnlqa0Fbaby4xZdY1AnlDq9gdTMPHnMTcsVIDWr8cnCN6k
         uwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=Ilo+G+TPtm4MhEKcZK9WJSstSpgrmWQA3rANoOXuyBQ=;
        b=Q6xq89V8t1LL7M7gFM8fp2ZiCwVnQ+sIh4PrEEtXJU+NloiFFch6aIC17m3uVN2jM7
         E1R7tZPOiFw4+42OIzHOfgBwaOJ8dYgc4xOMXd2F3Pzh56m0HSCW3MbBX+HGfw4BMA/6
         LJiUuTCHcE92H9IvDq4U4WFPb8Dt0NCy2sAaIjBf9PaBFrqZHAqhvb5STg7KbdLyPCjd
         z9QtEeDhmSV7vYCxS1mU7WpXPPM/Rf/+8eTth0ecMy96V4CQjt44sfhHhjTm4cKY95kI
         cmDn/03vNrohz5R3tnRzsbhWqBXwIkUCD+AeLxs0xvZw9iWgkjlM4GQaoX82T2NXFzCB
         9Qgw==
X-Gm-Message-State: AJIora/QsekcZ6yn7eW1qidweHtFEFCqL0POnxlrNcWmxLUEwF7iCArW
        rRqq39l/cUGfRs7vYCd4S39IGuJQq1eI3g==
X-Google-Smtp-Source: AGRyM1uzbpXOPKfMmhPQrAoOV1jCIqwFh1BkMVEo8IYzBOcsHwdtxLFVwZ68ovFhCXfJdKkBBAitEw==
X-Received: by 2002:a05:6a00:238c:b0:52a:c865:6e9a with SMTP id f12-20020a056a00238c00b0052ac8656e9amr7330278pfc.84.1657537119568;
        Mon, 11 Jul 2022 03:58:39 -0700 (PDT)
Received: from archdragon (dragonet.kaist.ac.kr. [143.248.133.220])
        by smtp.gmail.com with ESMTPSA id 6-20020a631446000000b00415fcde23a4sm1854984pgu.27.2022.07.11.03.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 03:58:39 -0700 (PDT)
Date:   Mon, 11 Jul 2022 19:58:35 +0900
From:   "Dae R. Jeong" <threeearcat@gmail.com>
To:     bryantan@vmware.com, rjalisatgi@vmware.com, vdasa@vmware.com,
        pv-drivers@vmware.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: general protection fault in vmci_host_poll
Message-ID: <YswCW3yBdaI7CkOn@archdragon>
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

We observed a crash "general protection fault in vmci_host_poll"
during fuzzing.

Unfortunately, we have not found a reproducer for the crash yet. We
will inform you if we have any update on this crash.

Detailed crash information is attached at the end of this email.


Best regards,
Dae R. Jeong
------

- Kernel commit:
92f20ff72066d

- Crash report: 
general protection fault, probably for non-canonical address 0xdffffc000000000b: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000058-0x000000000000005f]
CPU: 2 PID: 10337 Comm: syz-executor.0 Not tainted 5.19.0-rc3-32288-g0f3b08299494 #15
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
RIP: 0010:__lock_acquire+0xf3/0x5e00 kernel/locking/lockdep.c:4926
Code: 89 bc 24 88 00 00 00 0f 85 02 27 00 00 83 3d 1b 16 66 10 00 0f 84 97 43 00 00 83 3d d6 ea f9 0e 00 74 31 48 89 f8 48 c1 e8 03 <42> 80 3c 00 00 74 17 e8 81 63 86 00 48 8b bc 24 88 00 00 00 49 b8
RSP: 0018:ffffc90003727320 EFLAGS: 00010002
RAX: 000000000000000b RBX: 0000000000000001 RCX: 1ffff920006e4e84
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000058
RBP: ffffc900037276b0 R08: dffffc0000000000 R09: 0000000000000000
R10: fffffbfff2394d5e R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007fc21b11a700(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b8cfafd7d0 CR3: 000000001c4aa000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x1a4/0x4a0 kernel/locking/lockdep.c:5672
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:349 [inline]
 vmci_host_poll+0x16b/0x2b0 drivers/misc/vmw_vmci/vmci_host.c:177
 vfs_poll include/linux/poll.h:88 [inline]
 do_pollfd fs/select.c:873 [inline]
 do_poll fs/select.c:921 [inline]
 do_sys_poll+0xc7c/0x1aa0 fs/select.c:1015
 __do_sys_ppoll fs/select.c:1121 [inline]
 __se_sys_ppoll+0x2cc/0x330 fs/select.c:1101
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x4e/0xa0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x478dc9
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc21b119be8 EFLAGS: 00000246 ORIG_RAX: 000000000000010f
RAX: ffffffffffffffda RBX: 0000000000781408 RCX: 0000000000478dc9
RDX: 0000000020001b40 RSI: 0000000000000001 RDI: 0000000020001ac0
RBP: 00000000f477909a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000781500
R13: 0000000000781414 R14: 0000000000781408 R15: 00007ffcf3912790
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0xf3/0x5e00 kernel/locking/lockdep.c:4926
Code: 89 bc 24 88 00 00 00 0f 85 02 27 00 00 83 3d 1b 16 66 10 00 0f 84 97 43 00 00 83 3d d6 ea f9 0e 00 74 31 48 89 f8 48 c1 e8 03 <42> 80 3c 00 00 74 17 e8 81 63 86 00 48 8b bc 24 88 00 00 00 49 b8
RSP: 0018:ffffc90003727320 EFLAGS: 00010002
RAX: 000000000000000b RBX: 0000000000000001 RCX: 1ffff920006e4e84
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000058
RBP: ffffc900037276b0 R08: dffffc0000000000 R09: 0000000000000000
R10: fffffbfff2394d5e R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007fc21b11a700(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b8cfafd7d0 CR3: 000000001c4aa000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
