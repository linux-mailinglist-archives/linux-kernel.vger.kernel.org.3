Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53A454B657
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 18:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbiFNQk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 12:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbiFNQkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 12:40:21 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52599167E0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:40:20 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id z17so4277111vkb.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 09:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H+CLgNnvG4ejMcDaCC6CBSZfQpDp7ynC+U7+7Ur1OXA=;
        b=ShGFnS6qjkhb3C+9rWluX3kBN1e3f0bBdM/co+arNUTANvlydk9n5NXypsAxPlEC27
         IOZRjEny9+YhMUoVouZDLjfVklZeuo0AWnOiiNyhmUgBv4oSYYGqVkZKMP2lTDB1ZiQ8
         E1HUZXNwiGO9SP415KZh4eCR0PFoWleU/HPDbOaYf5NLPJbXylcDIEMW2punvUZ/28q9
         aTaDsGxb52XIcN2wJSj5bvAedlqfsWDksxzH8f4BDHDU8Yfh9tU3n6ym7kVSds3ckvmj
         7ALAroQH7tmDsELWQH0rCFswsgWOqZQISg00OznNru4eaCHKNErhNSX3hNgghWQU5T0T
         JmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H+CLgNnvG4ejMcDaCC6CBSZfQpDp7ynC+U7+7Ur1OXA=;
        b=R3NCrHo+CgaboA91997OtW2WpNkhcKvpwPvXG9jjojQto7ef4kK0jfstl3soX6kBPE
         2jFCHjCTcW6LI1e4VmkzZYyVnAbRcxvxwZRoWBEM3jDNUN1CgG5G8I1q0hNyHHhCmHCy
         BdPHcUWAXCsRFxZvvBMIMeHxwoWA1Jebl5ISp7QjUteAFMnlUJPxxNgUA6fKAJZeryAW
         kwqLd860U7aaFM7c6NtvhjuQcya/cFahILkEP7zoP0YDKg7e6Yy6pIhV5X65WK3hkUuL
         yz9U3tDqdA06Xs0IZruVrdAZXcNpkRdBiT0SV21Gpq1JcWquUtjD/DaHnDvfdyMwECNv
         CDvg==
X-Gm-Message-State: AJIora8QQuIwDmDm3rG8RNIyV+LIPHsU43Bd47MPlsWyqz0xgNkMPKBq
        40gbIMkP091gVtTqjSbyIf+W0prPT3RAGfBi6Bc=
X-Google-Smtp-Source: AGRyM1uNwzfWHrr7+8bKRxefAncB5rUaV2CjMVG3ah+isvWQbfeyKTpgV08VCjoT3Mp0YlhixWHAVDTUBPP39Vre1Bw=
X-Received: by 2002:a1f:3482:0:b0:368:4e6a:8ea5 with SMTP id
 b124-20020a1f3482000000b003684e6a8ea5mr2613686vka.2.1655224819297; Tue, 14
 Jun 2022 09:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAAH8bW8wD_hsOqtWa-g_1SNWNi7GHzsu9RvL8feY069JPKFWBA@mail.gmail.com>
 <202206141145339651323@zte.com.cn>
In-Reply-To: <202206141145339651323@zte.com.cn>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Tue, 14 Jun 2022 09:40:08 -0700
Message-ID: <CAAH8bW_GCviYSadmf5CUxgJixkXbq+SfL63ZJt7Lsm9OAmPjVQ@mail.gmail.com>
Subject: Re: [PATCH] bitmap: fix a unproper remap when mpol_rebind_nodemask()
To:     wang.yi59@zte.com.cn, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Cc:     andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.liang82@zte.com.cn, Liu.Jianjun3@zte.com.cn,
        Yury Norov <yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Andrew Morton <akpm@linux-foundation.org>
+ linux-mm@kvack.org

On Mon, Jun 13, 2022 at 8:45 PM <wang.yi59@zte.com.cn> wrote:
>
> Hi Yury,
>
> Thanks for your quick and clear response!
>
> > On Mon, Jun 13, 2022 at 4:31 AM Yi Wang <wang.yi59@zte.com.cn> wrote:
> > >
> > > Consider one situation:
> > >
> > > The app have two vmas which mbind() to node 1 and node3 respectively,
> > > and its cpuset.mems is 0-3, now set its cpuset.mems to 1,3, according
> > > to current bitmap_remap(), we got:
> >
> > Regarding the original problem - can you please confirm that
> > it's reproduced on current kernels, show the execution path etc.
> > From what I see on modern kernel, the only user of nodes_remap()
> > is mpol_rebind_nodemask(). Is that the correct path?
>
> Yes, it's mpol_rebind_nodemask() calls nodes_remap() from
> mpol_rebind_policy(). The stacks are as follow:
> [  290.836747]  bitmap_remap+0x84/0xe0
> [  290.836753]  mpol_rebind_nodemask+0x64/0x2a0
> [  290.836764]  mpol_rebind_mm+0x3a/0x90
> [  290.836768]  update_tasks_nodemask+0x8a/0x1e0
> [  290.836774]  cpuset_write_resmask+0x563/0xa00
> [  290.836780]  cgroup_file_write+0x81/0x150
> [  290.836784]  kernfs_fop_write_iter+0x12d/0x1c0
> [  290.836791]  new_sync_write+0x109/0x190
> [  290.836800]  vfs_write+0x218/0x2a0
> [  290.836809]  ksys_write+0x59/0xd0
> [  290.836812]  do_syscall_64+0x37/0x80
> [  290.836818]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
>
> To reproduce this situation, I write a program which seems like this:
>     unsigned int flags = MAP_PRIVATE | MAP_ANONYMOUS;
>     unsigned long size = 262144 << 12;
>     unsigned long node1 = 2;   // node 1
>     unsigned long node2 = 8;   // node 3
>
>     p1 = vma1 = mmap(NULL, size, PROT_READ | PROT_WRITE, flags, -1, 0);
>     p2 = vma2 = mmap(NULL, size, PROT_READ | PROT_WRITE, flags, -1, 0);
>
>     assert(!mbind(vma1, size, MPOL_BIND, &node1, MAX_NODES, MPOL_MF_STRICT | MPOL_MF_MOVE));
>     assert(!mbind(vma2, size, MPOL_BIND, &node2, MAX_NODES, MPOL_MF_STRICT | MPOL_MF_MOVE));
>
> Start the program whos name is mbind_tester, and do follow steps:
>
>         mkdir && cd /sys/fs/cgroup/cpuset/mbind
>         echo 0-31 > cpuset.cpus
>         echo 0-3 > cpuset.mems
>
>         cat /proc/`pidof mbind_tester`/numa_maps |grep bind -w
>         7ff73e200000 bind:3 anon=262144 dirty=262144 active=0 N3=262144 kernelpagesize_kB=4
>         7ff77e200000 bind:1 anon=262144 dirty=262144 active=0 N1=262144 kernelpagesize_kB=4
>
>         echo 1,3 > cpuset.mems
>         cat /proc/`pidof mbind_tester`/numa_maps |grep bind -w
>         7ff73e200000 bind:3 anon=262144 dirty=262144 active=0 N3=262144 kernelpagesize_kB=4
>         7ff77e200000 bind:3 anon=262144 dirty=262144 active=0 N1=262144 kernelpagesize_kB=4
>
> As you see, after set cpuset.mems to 1,3, the nodes which one of vma
> binded to changed from 1 to 3.
>
> This maybe confused, the original nodes binded is 1, after modify
> cpuset.mems to 1,3 which include the node 3, it changed to 3...

Ok, thanks for the reproducer. I'll take a look at it closer to the weekend.

> > Anyways, as per name, bitmap_remap() is intended to change bit
> > positions, and it doesn't look wrong if it does so.
> >
> > This is not how the function is supposed to work. For example,
> >         old: 00111000
> >         new: 00011100
> >
> > means:
> >         old: 00111 000
> >              || \\\|||
> >         new: 000 11100
> >
> > And after this patch it would be:
> >         old: 001 11000
> >              || \|||||
> >         new: 000 11100
> >
> > Which is not the same, right?
>
> Right.

So, we both agree that bitmap_remap() works as advertised. This is
good. Let's try figuring out a solution without touching it.

> Actually this is what makes me embarrassed. If we want to fix this
> situtation, we can:
>
> - change the bitmap_remap() as this patch did, but this changed the
> behavior of this routine which looks does the right thing. One good
> news is this function is only called by mpol_rebind_nodemask().

There are users of bitmap_remap() in drivers/gpio/gpio-xilinx.c

> - don't change the bitmap_remap(), to be honest, I didn't figure out
> a way. Any suggestions?

I haven't had a chance to play with it (because of my dayjob), but I
have a strong feeling that the proper solution should come from
existing functionality.

Did you experiment with MPOL_F_{STATIC,RELATIVE}_NODES?
Those flags enable nodes_and() and mpol_relative_nodemask()
paths correspondingly.

> > If mpol_rebind() wants to keep previous relations, then according to
> > the comment:
> >  * The positions of unset bits in @old are mapped to themselves
> >  * (the identify map).
> >
> > , you can just clear @old bits that already have good relations
> > you'd like to preserve.
>
> Actually this does not work for me :)

What I suggested is:

 328                 node_clear(1, pol->w.cpuset_mems_allowed);
 329                 node_clear(3, pol->w.cpuset_mems_allowed);
 330                 nodes_remap(tmp, pol->nodes, pol->w.cpuset_mems_allowed,
 331                                                                 *nodes);
 332                 pol->w.cpuset_mems_allowed = *nodes;

> In the example above, if set cpuset.mems to 0,2 firstly, the nodes
> binds will change from 1 to 2. And then set cpuset.mems to 1,3, it will
> change from 2 to 3 again.

I bet you can find a sequence that will finally give you the desired binding.
And probably somebody does this black magic in production. For me it
looks just scary. Can you try those static/relative flags, and if it doesn't
work, we'll have to invent another policy for nodes binding.

Adding Andrew and linux-mm, as it's definitely beyond bitmaps scope.

Thanks,
Yury

> ---
> Best wishes
> Yi Wang
