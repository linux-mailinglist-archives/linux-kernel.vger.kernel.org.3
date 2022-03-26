Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E844E8364
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 19:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbiCZSlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 14:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbiCZSk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 14:40:58 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820172FFD2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 11:39:21 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id m67so19420268ybm.4
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 11:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k/ssPz4GjZfeEN38KWETRXLltMA9E5UJ9EeqUr0mW+E=;
        b=eU4nTQZtKr8tHEmUIXFQeybG037KmX2E/b8xIuZDvlAj2YJrGqdLkEQ2py/rY3TJLN
         OcAvYWuJX3WhXjaFlWFzJXA59mE/8/x2c1SXRpWBe9RIL1joAUFFC4vFL17R8lpLlqo6
         MZ37zjeuySDtgQMNnM+kQILWAH2CTGnb+b/vvVCo5z4TsocVZ5cdGCjr+Zunakmdjv8O
         GYfNZV8wwhbB8s0k7dPAyz0BWAikIHIW5npY3tjbBbzT/8m0Qd3zvXQ9pwReWCa8G3i1
         u7RmbN3tr4DMcKGNOMkYCAPRMH4v3aIBIoJrnIGod9Ywz11trDYEu/G2Azmw1Jt/Xqcn
         HmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k/ssPz4GjZfeEN38KWETRXLltMA9E5UJ9EeqUr0mW+E=;
        b=tuj+qSkEBzbWTKAuEb5B/Gmj5QQ6R8NysekvUcQc0+Rag1MkRLtz8K/6gj4EdLeKUY
         0b092U6rRRWXhLLT1QWuy7pXgOO6HOmktzuVhmbJvSoLXzf0f/CjrwpkfwD9/UcP7ISw
         0RfCHbH/HMz+cxQW5izo4Ib8n7fCmGaYd33ux2eWflK6x8S17PD3bcUfxmorRCWTlc1F
         Y1kFWpjl4+LiKNhq55GuAi4CMYsQ/uGe2W+wEw/dY0zP34Q35ushbxwR/bu63+7PzwQ4
         6humZMDSRLkwZggzkRefWrNbBDt19SesZawAoaejIEcJ8ezR912jeuhYCWXcBdyEiCl3
         dw0A==
X-Gm-Message-State: AOAM533DrUxKoh3+Lsuv5k7oThz7hITGE4EitXK9wp9eSwrVENsbJJTd
        iMT60D8jNiaPlP/5y9bZ8oJf5SVo7wZIxpzFSH0awA==
X-Google-Smtp-Source: ABdhPJzwmw6Z8LdcfSmjv9GvfYSLTsZMXaWLSBNT2IbcRER7i/wVtT89y8wvZg2ZFXaL7T0ipXC+3JOrJ0qnI1spITY=
X-Received: by 2002:a25:f45:0:b0:628:b4c9:7a9f with SMTP id
 66-20020a250f45000000b00628b4c97a9fmr15340626ybp.55.1648319960447; Sat, 26
 Mar 2022 11:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220322004654.618274-1-eric.dumazet@gmail.com>
In-Reply-To: <20220322004654.618274-1-eric.dumazet@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sat, 26 Mar 2022 11:39:09 -0700
Message-ID: <CANn89iLOCN8888SQFh6i1+yBZ=RWwDGE3BbPRbjpdKxApC1MxQ@mail.gmail.com>
Subject: Re: [PATCH] watch_queue: Free the page array when watch_queue is dismantled
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot <syzkaller@googlegroups.com>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping ?

On Mon, Mar 21, 2022 at 5:47 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
>
> Commit 7ea1a0124b6d ("watch_queue: Free the alloc bitmap
> when the watch_queue is torn down") took care of the bitmap,
> but not the page array.
>
> BUG: memory leak
> unreferenced object 0xffff88810d9bc140 (size 32):
>   comm "syz-executor335", pid 3603, jiffies 4294946994 (age 12.840s)
>   hex dump (first 32 bytes):
>     40 a7 40 04 00 ea ff ff 00 00 00 00 00 00 00 00  @.@.............
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff81459bff>] kmalloc_array include/linux/slab.h:621 [inline]
>     [<ffffffff81459bff>] kcalloc include/linux/slab.h:652 [inline]
>     [<ffffffff81459bff>] watch_queue_set_size+0x12f/0x2e0 kernel/watch_queue.c:251
>     [<ffffffff8159fcf2>] pipe_ioctl+0x82/0x140 fs/pipe.c:632
>     [<ffffffff815b601c>] vfs_ioctl fs/ioctl.c:51 [inline]
>     [<ffffffff815b601c>] __do_sys_ioctl fs/ioctl.c:874 [inline]
>     [<ffffffff815b601c>] __se_sys_ioctl fs/ioctl.c:860 [inline]
>     [<ffffffff815b601c>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:860
>     [<ffffffff84493a05>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84493a05>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Fixes: c73be61cede5 ("pipe: Add general notification queue support")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Jann Horn <jannh@google.com>
> ---
>  kernel/watch_queue.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
> index 00703444a21948deaa8b7ac8b57b73528badff0d..58fe68664eb1b0001cb00c8d046e108462df4836 100644
> --- a/kernel/watch_queue.c
> +++ b/kernel/watch_queue.c
> @@ -370,6 +370,7 @@ static void __put_watch_queue(struct kref *kref)
>
>         for (i = 0; i < wqueue->nr_pages; i++)
>                 __free_page(wqueue->notes[i]);
> +       kfree(wqueue->notes);
>         bitmap_free(wqueue->notes_bitmap);
>
>         wfilter = rcu_access_pointer(wqueue->filter);
> --
> 2.35.1.894.gb6a874cedc-goog
>
