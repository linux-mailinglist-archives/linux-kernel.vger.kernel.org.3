Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80236589404
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 23:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbiHCVWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 17:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbiHCVWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 17:22:00 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78DC2A43E
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 14:21:58 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id l7so7492625ual.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 14:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W31+WmZqDoTeRfHZKbgwNjG6H/G021VFwQTB4BGaHxs=;
        b=OURmV5cyPLxoH0AtByuPXsZsNGZZTChd2lpUNVTODewfq+G2biyliNUWMykdko/uK9
         3gQoCh/LzjtBfYzUKWV5rOdxSfDyhN1vYsE3L29Xb39pDaxFKh+tJiKvjxFeO36Jyynj
         tvPOntSEF0ADSfvX4R7L91jeQZcYHXm2OBmTTCsBEIazhSo+Ra/vckPyuydrnyYV5fcr
         ltjlfNx5zZqNB6k3d0KCUyOVFN4F3vFs0TLJZqQfJnJ1h7+piR4wJT7O0rDAAUYHfdOR
         J7qnxF7QZGAhPnzSzvjnG1s02qMGeezikmXNJEC4mytiDgs6otKmuKD/ei+C4yhWxi90
         nV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W31+WmZqDoTeRfHZKbgwNjG6H/G021VFwQTB4BGaHxs=;
        b=0zKFotAERuIeJjTQvGccwSx31ZJHiuVslIy+9lJWdWlC3Jn3YqLBGKOCqQ9heZQxoz
         ZEjKwq+ZI/H8kLhp/M4BFS7Fb+MwuG12JObPSeYTAER0SCMC/didud2HdwNh6TKJBa8S
         FKo6ut3RBs7VARs7m7gU1sP+JAfyLoKw3+4+GkoJa8SKq1ciSjKsvfcQhyMgjZohtQqM
         LEzc25sAZUtVeXC4eC78aZqaaSRwQSx7Q2sMye6gCaNILwN3zWutCZTXIVEGx+DElxz5
         x9wN7DBk0hqYO90BsGeb88WuUuEtT9YjmT189wMjkmH3QxYZUicHlEEFSUmNxl4wn0pw
         dvHA==
X-Gm-Message-State: ACgBeo1Sh5ispqS+/wxD4oggq5Absb1MtcBSZJ3AaPkTcP8ee9pd1kvY
        wGDz8cdQqOlYEv7dGOY0/lN3APkQGsg/4ILjnfpBBNSZ+t3ExRVX
X-Google-Smtp-Source: AA6agR6aHlyT7etx3/I6x5NJU8pqIbhuILalUFlWlg/GgkE+PtgWUlCXGRD/ZR9dG6ROT079KIqhgwhNJMT/UbA5w+c=
X-Received: by 2002:a9f:3869:0:b0:387:8a7f:4222 with SMTP id
 q38-20020a9f3869000000b003878a7f4222mr3135381uad.119.1659561717985; Wed, 03
 Aug 2022 14:21:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220802214041.2656586-1-neelnatu@google.com> <CAAH8bW_z3TjjafPRJPZmzDdOFjmU7xTLxOinw8D4nsZ2B6WN4w@mail.gmail.com>
 <CAJDe-O+8G=hyqWcaNk8_YP9S-R9-Xnn2_cLt8Loz9ru8V24K_Q@mail.gmail.com> <YurEAU5SlQaZ85vZ@yury-laptop>
In-Reply-To: <YurEAU5SlQaZ85vZ@yury-laptop>
From:   Neel Natu <neelnatu@google.com>
Date:   Wed, 3 Aug 2022 14:21:46 -0700
Message-ID: <CAJDe-O+7mqqrGvWimztYgEqDDqJGH=EA1NgJyiJjnurLASOQ8w@mail.gmail.com>
Subject: Re: [PATCH] sched, cpumask: don't leak impossible cpus via for_each_cpu_wrap().
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 3, 2022 at 11:52 AM Yury Norov <yury.norov@gmail.com> wrote:
>
> On Wed, Aug 03, 2022 at 10:49:57AM -0700, Neel Natu wrote:
> > On Tue, Aug 2, 2022 at 6:22 PM Yury Norov <yury.norov@gmail.com> wrote:
> > >
> > > On Tue, Aug 2, 2022 at 2:41 PM Neel Natu <neelnatu@google.com> wrote:
> > > >
> > > > The value of 'nr_cpumask_bits' is dependent on CONFIG_CPUMASK_OFFSTACK.
> > > > This in turn can change the set of cpus visited by for_each_cpu_wrap()
> > > > with a mask that has bits set in the range [nr_cpu_ids, NR_CPUS).
> > > >
> > > > Specifically on !CONFIG_CPUMASK_OFFSTACK kernels the API can iterate
> > > > over cpus outside the 'cpu_possible_mask'.
> > > >
> > > > Fix this to make its behavior match for_each_cpu() which always limits
> > > > the iteration to the range [0, nr_cpu_ids).
> > > >
> > > > Signed-off-by: Neel Natu <neelnatu@google.com>
> > >
> > > The patch itself doesn't look correct because it randomly switches a piece
> > > of cpumask API from nr_cpumask_bits to nr_cpu_ids, and doesn't touch
> > > others.
> > >
> > > However...
> > >
> > > I don't know the story behind having 2 variables holding the max possible
> > > number of cpus, and it looks like it dates back to prehistoric times.  In
> > > modern kernel, there are 2 cases where nr_cpumask_bits == nr_cpu_ids
> > > for sure: it's CONFIG_CPUMASK_OFFSTACK=y and
> > > CONFIG_HOTPLUG_CPU=y. At least one of those is enabled in defconfig
> > > of every popular architecture.
> > >
> >
> > Hmm, in a kernel with CONFIG_HOTPLUG_CPU=y but not CONFIG_CPUMASK_OFFSTACK
> > I see "nr_cpu_ids = 20, nr_cpumask_bits = 512". FYI since it doesn't
> > match the observation
> > above that nr_cpumask_bits == nr_cpu_ids when CONFIG_HOTPLUG_CPU=y.
>
> I said this because the comment in include/linux/cpumaks.h says:
>  *  If HOTPLUG is enabled, then cpu_possible_mask is forced to have
>  *  all NR_CPUS bits set, otherwise it is just the set of CPUs that
>  *  ACPI reports present at boot.
>
> And because of the code that sets nr_cpu_ids:
>
> void __init setup_nr_cpu_ids(void)
> {
>         nr_cpu_ids = find_last_bit(cpumask_bits(cpu_possible_mask),NR_CPUS) + 1;
> }
>
> Some arches override it, so it may be an issue. Are you running x86,
> or maybe you have "nr_cpus" boot parameter?
>
> But anyways, I feel like this should be investigated for more... Can you
> please share the config of your system and boot params?
>

Yeah, this is a stock defconfig compiled on an x86_64 host and booted
inside a 20 vcpu virtual machine (virtme). There are no command line
params to modify the number of cpus.

I think everything is working as expected based on some debug prints I
added during boot:
[    0.641798] smp: setup_nr_cpu_ids: nr_cpu_ids 20, cpu_possible_mask 0-19
[    0.648424] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64
nr_cpu_ids:20 nr_node_ids:2

The first one is from setup_nr_cpu_ids() in kernel/smp.c. The second
one is from setup_per_cpu_areas() from arch/x86/setup_percpu.c.

> > > In case of HOTPLUG is off, I don't understand why we should have nr_cpu_ids
> > > and nr_cpumask_bits different - what case should it cover?... Interestingly, in
> > > comments to cpumask functions and in the code those two are referred
> > > interchangeably.
> > >
> > > Even more interestingly, we have a function bitmap_setall() that sets all bits
> > > up to nr_cpumask_bits, and it could trigger the problem that you described,
> >
> > I think you mean cpumask_setall() that in turn calls
> > bitmap_fill(nr_cpumask_bits)?
>
> Yes, sorry.
>
> > > so that someone would complain. (Are there any other valid reasons to set
> > > bits behind nr_cpu_ids intentionally?)
> > >
> >
> > I don't know of any although this wasn't the case that trigger in my case.
> >
> > > Can you share more details about how you triggered that? If you observe
> > > those bits set, something else is probably already wrong...
> >
> > The non-intuitive behavior of for_each_cpu_wrap() was triggered when iterating
> > over a cpumask passed by userspace that set a bit in the [nr_cpu_ids,
> > nr_cpumask_bits)
> > range.
>
> If you receive bitmap from userspace, you need to copy it with
> bitmap_copy_clear_tail(), or bitmap_from_arr{32,64}, as appropriate.
> That will clear unneeded bits.
>
> For user-to-kernel communications, I'd recommend passing bitmaps in a
> human-readable formats - hex string or bitmap list. Check the functions
> cpumask_parse_user() and cpumask_parselist_user(). This would help to
> avoid all possible issues related to endianness and 32/64 word length
> mismatch.
>
> > The kernel code is out of tree but open source so happy to provide a
> > pointer if needed.
>
> Yes please
>

Here is where we copy the user supplied cpumask using the
get_user_cpu_mask() helper:
https://github.com/google/ghost-kernel/blob/c21b36f87663efa2189876b2caa701fe74e72adf/kernel/sched/ghost.c#L5729

For performance reasons we cannot use human readable cpu masks in this
code path.

Note that the helper copies up to 'nr_cpumask_bits' which in some
kernels (!CONFIG_CPUMASK_OFFSTACK) can copy bits beyond 'nr_cpu_ids'.
A possible option could be to fix this helper but I do feel that
for_each_cpu() and for_each_cpu_wrap() should visit the same set of
cpus given the same cpumask (ordering can be different but the set of
cpus should remain the same).

What do you think?

best
Neel

> > I considered ANDing the user supplied mask with 'cpu_possible_mask'
> > but that felt
> > like working around an inconsistency in the kernel API (hence the proposed fix).
> >
> > > So, if there is no real case in modern kernel to have nr_cpumask_bits and
> > > nr_cpu_ids different, the proper fix would be to just drop the first.
> > >
> >
> > I'll let other people more knowledgable than me in this area chime in.
> > I'll be happy either
> > way if that fixes the problem at hand.
> >
> > best
> > Neel
> >
> > > If there is such a case, this is probably your case, and we'd know more
> > > details to understand how to deal with that.
> > >
> > > Thanks,
> > > Yury
