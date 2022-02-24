Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37244C36E2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 21:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbiBXU0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 15:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiBXU0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 15:26:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DECC422320B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 12:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645734368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iNWW1ty2Fdn3+li/1ME0ZXiLr4pAHZLm6MLTDBkwUBU=;
        b=bHhwIugojIOSKTODNH/wKwDUDtisf4nD/fvWAjm0GbxikiQDJ2r+uMxH1+GNrUZwFUruPz
        MpSUxOHSSGd+aWhoO0SpQhaxKdQ5cIsa608WD4+4waCA7Tqq6ZR0ICsg5Hy41ICcRAnDEp
        1pJ+6hM37zHSMseojkhZ8GC5x3EaNU0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-372-Ffd4f0KJNraUGT6RVMMNjQ-1; Thu, 24 Feb 2022 15:26:06 -0500
X-MC-Unique: Ffd4f0KJNraUGT6RVMMNjQ-1
Received: by mail-qt1-f199.google.com with SMTP id c2-20020ac81102000000b002de4af72dcbso495824qtj.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 12:26:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iNWW1ty2Fdn3+li/1ME0ZXiLr4pAHZLm6MLTDBkwUBU=;
        b=TfHH9TQstTJ92XdtDwuonuwOEZwVQLXB9EtqEW5atXLJM2mC+vfy/vdtQUtqmGwvCU
         OZwMkn3ibpu6w3ZrYOc9/uYnqpSVjaHH7U91DPk/CTe4XE9yzcd1RivrnQvtTBqV0kgD
         TahWoGaFFcSlokRnKV+Twq5pTzUxxGzt1SHPt215p5ZWgWMzupiYwA6rEjsXGsNU+WPW
         J0EWtRS7ENz598SmbNZCLPJLKKu7r9cdpntJemw+9ptYDhKYjNXCXWMbs1rmTPxiff/6
         aQ+46dA1nT8kevFArKAyn/HhDxVDWSfAZlexs34AQ1kyybM5SC2Q1UbsPyyCQ85Mme7n
         nEug==
X-Gm-Message-State: AOAM531lxFic/MQphui1G5b1zkbqxHUnJVcpwX5pPn/WXKj47YcY4gOI
        t5+Wl/ZrbctQiJFI1TexIFzDZO5a3eYtZqnItyDVVx8nXADOLt69Qze4S7fJEgaS8CwPULBOofh
        kumUlfz2LBhYdAldSI6+ukGCY
X-Received: by 2002:ae9:e016:0:b0:60d:fbbb:52d7 with SMTP id m22-20020ae9e016000000b0060dfbbb52d7mr2801500qkk.481.1645734366297;
        Thu, 24 Feb 2022 12:26:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz81s06nB8QQe5TnjxZnN+4CHONzVbuw+82rxiWsgqm41uEqiy+oZD/MPoPtE+vHFyKJ0aVnw==
X-Received: by 2002:ae9:e016:0:b0:60d:fbbb:52d7 with SMTP id m22-20020ae9e016000000b0060dfbbb52d7mr2801481qkk.481.1645734365989;
        Thu, 24 Feb 2022 12:26:05 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id k125-20020a37a183000000b005f170f7e497sm296658qke.47.2022.02.24.12.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 12:26:05 -0800 (PST)
Date:   Thu, 24 Feb 2022 12:26:02 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 00/39] x86: Kernel IBT
Message-ID: <20220224202602.3gvz5tnxvwb4maod@treble>
References: <20220224145138.952963315@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220224145138.952963315@infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 03:51:38PM +0100, Peter Zijlstra wrote:
> Hi,
> 
> This is an even more complete Kernel IBT implementation.
> 
> Since last time (in no specific order):
> 
>  - Reworked Xen and paravirt bits lots (andyhpp)
>  - Reworked entry annotation (jpoimboe)
>  - Renamed CONFIG symbol to CONFIG_X86_KERNEL_IBT (redgecomb)
>  - Pinned CR4_CET (kees)
>  - Added __noendbr to CET control functions (kees)
>  - kexec (redgecomb)
>  - made function-graph, kprobes and bpf not explode (rostedt)
>  - cleanups and split ups (jpoimboe, mbenes)
>  - reworked whole module objtool (nathanchance)
>  - attempted and failed at making Clang go
> 
> Specifically to clang; I made clang-13 explode by rediscovering:
> https://reviews.llvm.org/D111108, then I tried clang-14 but it looks like
> ld.lld is still generating .plt entries out of thin air.
> 
> Also, I know the very first patch is somewhat controversial amonst the clang
> people, but I really think the current state of affairs is abysmal and this
> lets me at least use clang.
> 
> Patches are also available here:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt

Bricked my SPR:

[   21.602888] jump_label: Fatal kernel bug, unexpected op at sched_clock_stable+0x4/0x20 [0000000074a0db20] (eb 06 b8 01 00 != eb 0a 00 00 00)) size:2 type:0
[   21.618489] ------------[ cut here ]------------
[   21.623706] kernel BUG at arch/x86/kernel/jump_label.c:73!
[   21.629903] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[   21.630897] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G          I       5.17.0-rc5+ #3
[   21.630897] Hardware name: Intel Corporation ArcherCity/ArcherCity, BIOS EGSDCRB1.86B.0064.D15.2109031959 09/03/2021
[   21.630897] RIP: 0010:__jump_label_patch.cold.0+0x24/0x26
[   21.630897] Code: 9f e9 9d b1 5f ff 48 c7 c3 a8 44 65 a0 41 55 45 89 f1 49 89 d8 4c 89 e1 4c 89 e2 4c 89 e6 48 c7 c7 78 00 77 9f e8 e8 a8 00 00 <0f> 0b 48 89 fb 48 c7 c6 f0 03 77 9f 48 8d bf d0 00 00 00 e8 41 16
[   21.630897] RSP: 0000:ff7af25cc01cfd68 EFLAGS: 00010246
[   21.630897] RAX: 000000000000008f RBX: ffffffffa06544a8 RCX: 0000000000000001
[   21.630897] RDX: 0000000000000000 RSI: 00000000fffeffff RDI: 00000000ffffffff
[   21.630897] RBP: ff7af25cc01cfd98 R08: 0000000000000000 R09: c0000000fffeffff
[   21.630897] R10: 0000000000000001 R11: ff7af25cc01cfb88 R12: ffffffff9e520a74
[   21.630897] R13: 0000000000000000 R14: 0000000000000002 R15: ffffffff9f7293b7
[   21.630897] FS:  0000000000000000(0000) GS:ff422b3e2cc40000(0000) knlGS:0000000000000000
[   21.630897] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   21.630897] CR2: 0000000000000000 CR3: 0000001994810001 CR4: 0000000000f71ee0
[   21.630897] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   21.630897] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[   21.630897] PKRU: 55555554
[   21.630897] Call Trace:
[   21.630897]  <TASK>
[   21.630897]  arch_jump_label_transform_queue+0x37/0x80
[   21.630897]  __jump_label_update+0x74/0x130
[   21.630897]  ? sched_init+0x556/0x556
[   21.630897]  ? rdinit_setup+0x30/0x30
[   21.630897]  static_key_enable_cpuslocked+0x5b/0x90
[   21.630897]  static_key_enable+0x1a/0x20
[   21.630897]  sched_clock_init_late+0x7a/0x95
[   21.630897]  do_one_initcall+0x45/0x200
[   21.630897]  kernel_init_freeable+0x211/0x27a
[   21.630897]  ? rest_init+0xd0/0xd0
[   21.630897]  kernel_init+0x1a/0x130
[   21.630897]  ret_from_fork+0x1f/0x30
[   21.630897]  </TASK>
[   21.630897] Modules linked in:
[   21.838238] ---[ end trace 0000000000000000 ]---


ffffffff81120a70 <sched_clock_stable>:
ffffffff81120a70:       f3 0f 1e fa             endbr64
ffffffff81120a74:       eb 06                   jmp    ffffffff81120a7c <sched_clock_stable+0xc>
ffffffff81120a76:       b8 01 00 00 00          mov    $0x1,%eax
ffffffff81120a7b:       c3                      retq
ffffffff81120a7c:       f3 0f 1e fa             endbr64
ffffffff81120a80:       31 c0                   xor    %eax,%eax
ffffffff81120a82:       c3                      retq
ffffffff81120a83:       66 66 2e 0f 1f 84 00    data16 nopw %cs:0x0(%rax,%rax,1)
ffffffff81120a8a:       00 00 00 00
ffffffff81120a8e:       66 90                   xchg   %ax,%ax

