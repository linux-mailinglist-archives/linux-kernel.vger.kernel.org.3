Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B3D4C9187
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236493AbiCARbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbiCARbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:31:47 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C518F2A253
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 09:31:03 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id y15-20020a4a650f000000b0031c19e9fe9dso23120482ooc.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 09:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=o/78n2aarY86rKcvOA8UmQUR3xchXhCUCyiacOlJ4v0=;
        b=JuTl3MYhm7IzUIIdKDt0fj8jIwUW8/3tKoJpI22zC0St2Mgw2+mL8B61kdnxJHPT1F
         PN7IZDodvzossRZw+x/yYAdP0e8K04J4yMOR8kEuvbvJjTA3w19NTBQts//yuG9FtgY0
         FacCIbPwqCRZrkgJWT1fuwh7bB+Q0TtQOO6TERvpPcu3jUGO2boLV9BFwofE2ue495u4
         XNHfX6w8Vp5Og2lR6Um4WEvBadHHTvpSdstTqeRu1f81VFKkW/t9vEC2WW6hZI0r2ZaG
         MsGPJAuZ4x2ime+TEASCJ/LRPHWKf7+RX/hUHU3D4ikhXhopyQdikEZamZBut6h94AxF
         sl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=o/78n2aarY86rKcvOA8UmQUR3xchXhCUCyiacOlJ4v0=;
        b=5su6AJ526Il/0ZuYlA2DCdDDEh3xio9N7UfGP8Rs7fgwXsSG+65XS4hV2v3NzmQ1/X
         4rw8v3MjEzLYVQm/XvRPy5BzfwyttbDYeGEee7ov2IeB1zYoeCIMviarshyCzjETqwV+
         jx8GkPw/1GAc2r043gVuLF+HFbet8WKDcdiy95Y/GgD67ac2I696FtPE3+BXMJB7sTVT
         ruscJLgXDV/WwkcuGg7axxAAA8DhmCRz+8EjSEWD1XLsCpuFOlthGaVjmYylpupWRI27
         8uXzT1TJgREmGHXrCE6WE8Au260pZsU57A2JOZ/EV/va7pkRE7cc0+85Pbu30tfTc+Is
         5sEg==
X-Gm-Message-State: AOAM5315PoFsN/yjf85tFNZGePs5rZjcHPNk17Rbbnk7k6JKR7lkOzG0
        oBYzj+U8KiEQgoKhlybSVj8HpQ==
X-Google-Smtp-Source: ABdhPJzCQfdYR6oGqfZIQy2ESibsO/SewDOX7QYisxM3flIJtrv/0xUGGhx4jSMUOpmcak+uQ+X0qg==
X-Received: by 2002:a05:6870:e997:b0:ce:c0c9:61d with SMTP id r23-20020a056870e99700b000cec0c9061dmr12290739oao.111.1646155862632;
        Tue, 01 Mar 2022 09:31:02 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 35-20020a9d0026000000b005ad363440a2sm6583209ota.64.2022.03.01.09.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 09:31:01 -0800 (PST)
Date:   Tue, 1 Mar 2022 09:30:48 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     syzbot <syzbot+d7ed29a6231d3747fb31@syzkaller.appspotmail.com>
cc:     akpm@linux-foundation.org, willy@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] kernel BUG in hugepage_add_anon_rmap
In-Reply-To: <0000000000009ee0ca05d9288b83@google.com>
Message-ID: <5fb25913-c4be-123-b013-b76fc37994@google.com>
References: <0000000000009ee0ca05d9288b83@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Mar 2022, syzbot wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    196d330d7fb1 Add linux-next specific files for 20220222
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=15b0618a700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=45b71d0aea81d553
> dashboard link: https://syzkaller.appspot.com/bug?extid=d7ed29a6231d3747fb31
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d7ed29a6231d3747fb31@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> kernel BUG at mm/rmap.c:2330!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 4289 Comm: syz-executor.0 Not tainted 5.17.0-rc5-next-20220222-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:hugepage_add_anon_rmap+0x1f5/0x240 mm/rmap.c:2330

Already fixed in next-20220301 by latest version (16f06327291e)
of "mm/migrate: Convert remove_migration_ptes() to folios".

> Code: 89 ef e8 6e ad f8 ff 0f 0b e8 77 b2 c4 ff 48 83 eb 01 e9 a6 fe ff ff e8 69 b2 c4 ff 48 83 eb 01 e9 ff fe ff ff e8 5b b2 c4 ff <0f> 0b e8 54 b2 c4 ff 0f 0b e8 4d b2 c4 ff 49 8d 6c 24 ff eb b4 48
> RSP: 0018:ffffc9000fa8f9b8 EFLAGS: 00010216
> RAX: 0000000000002b78 RBX: 0000000000000000 RCX: ffffc90003bd1000
> RDX: 0000000000040000 RSI: ffffffff81b47f75 RDI: 0000000000000003
> RBP: ffffea0001008040 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffffff81b47eab R11: 0000000000000000 R12: ffff88801e231210
> R13: 0000000020400000 R14: ffff8880738f8700 R15: 0000000000000000
> FS:  00007f1a19594700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f33cc0df300 CR3: 000000001ca70000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  remove_migration_pte+0x5fd/0xc50 mm/migrate.c:234
>  rmap_walk_anon+0x44b/0x9e0 mm/rmap.c:2236
>  rmap_walk+0x92/0xd0 mm/rmap.c:2302
>  remove_migration_ptes mm/migrate.c:271 [inline]
>  unmap_and_move_huge_page mm/migrate.c:1259 [inline]
>  migrate_pages+0x1709/0x4030 mm/migrate.c:1379
>  do_mbind mm/mempolicy.c:1334 [inline]
>  kernel_mbind+0x4d7/0x7d0 mm/mempolicy.c:1481
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f1a18489059
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f1a19594168 EFLAGS: 00000246 ORIG_RAX: 00000000000000ed
> RAX: ffffffffffffffda RBX: 00007f1a1859c030 RCX: 00007f1a18489059
> RDX: 0000000000000000 RSI: 0000000000800000 RDI: 0000000020001000
> RBP: 00007f1a184e308d R08: 0000000000000000 R09: 0000000000000002
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffe5da8cc9f R14: 00007f1a19594300 R15: 0000000000022000
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:hugepage_add_anon_rmap+0x1f5/0x240 mm/rmap.c:2330
> Code: 89 ef e8 6e ad f8 ff 0f 0b e8 77 b2 c4 ff 48 83 eb 01 e9 a6 fe ff ff e8 69 b2 c4 ff 48 83 eb 01 e9 ff fe ff ff e8 5b b2 c4 ff <0f> 0b e8 54 b2 c4 ff 0f 0b e8 4d b2 c4 ff 49 8d 6c 24 ff eb b4 48
> RSP: 0018:ffffc9000fa8f9b8 EFLAGS: 00010216
> RAX: 0000000000002b78 RBX: 0000000000000000 RCX: ffffc90003bd1000
> RDX: 0000000000040000 RSI: ffffffff81b47f75 RDI: 0000000000000003
> RBP: ffffea0001008040 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffffff81b47eab R11: 0000000000000000 R12: ffff88801e231210
> R13: 0000000020400000 R14: ffff8880738f8700 R15: 0000000000000000
> FS:  00007f1a19594700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f33cc0df300 CR3: 000000001ca70000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
