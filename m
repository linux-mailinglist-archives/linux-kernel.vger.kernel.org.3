Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32C4589505
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 01:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240383AbiHCXvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 19:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240290AbiHCXvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 19:51:16 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB86F3D
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 16:51:13 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id u12so13865563qtk.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 16:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=PVlr/wP1iJpQXnjx/usv9VDWekQ3lTtnV5e8WZv8x48=;
        b=qKYroUFYwskMz0W56Qyd7/F3VZAWiS+ng+Y1u05aJSY3/NaYQrVAely1fG77ilrqzH
         KmRJUu6e/xHdAqDcl8wa2XLynBngE37Mb4feyPKJRsPVlPLjAtMXuEUVExJzkyedr9UU
         +/L2nKXGhHfZL+AsEyMNkevij8PrzcpqLFviJcFWI2jyEYyWHdc/DrYJv20PPQsfHjFu
         SLD+T6JhfiKtF9K8NZVGXNNH8sqAUB0M9MCUvdrtLJ+oF7gYfLA5tKyV/Xwe53RUtO9N
         oQXHqILMSpsoKlyvAbFgIiIk0TNc9w/M2WqTIgiZ+9FKPNHjdLdj9FiPU3SDMrmeQUAM
         SdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=PVlr/wP1iJpQXnjx/usv9VDWekQ3lTtnV5e8WZv8x48=;
        b=uaYE5aRL5Q61MdbWVeffbmp6ykmyYbpcz5fv347wbtsXMGhnp3YtfkE719ZLugm0+r
         +6sg8otkQHjckRqh+wi+FLDQe49BBuhNd4szRrJnMWWhouREyrmXg8IEo5s61V0FR5M8
         G6r0T5riEFsX8x4WdmjRPvFcfopmsCxKVv6owlxclJIKU4YE9G221BCivm/xf8xiuIog
         UHad5PXdnDfpVOjSqgelEstYo3wQPorf6TcRbdV3BCD1BUW+qv7CTdXeVoicYdoTQLTv
         EyYz+nTBsEoRHmUYo9NLidXXmMMj9COO2l82YmVkIXQKnagodsD1qdj97jA1pnRMFk8j
         O95A==
X-Gm-Message-State: AJIora8/ADYJwyNR1dOOq4OCLHe/la5IlpczP2I08Uvadja/1e0eqXyv
        a+msSB1xxxc68eVWWc8Sssq90CBWUtc=
X-Google-Smtp-Source: AGRyM1vEUq5JiLpjTas3X1ElFFHb04VQmNKmuIpB+l8MqPUxdYuJbJZQGHJmh8kUK2M8Zo0t8D2agw==
X-Received: by 2002:a05:622a:30a:b0:31e:fa39:2dd with SMTP id q10-20020a05622a030a00b0031efa3902ddmr24617308qtw.679.1659570672345;
        Wed, 03 Aug 2022 16:51:12 -0700 (PDT)
Received: from localhost ([2601:c4:c432:f9:ee0c:bfa:a55f:3217])
        by smtp.gmail.com with ESMTPSA id dm51-20020a05620a1d7300b006af147d4876sm3728132qkb.30.2022.08.03.16.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 16:51:11 -0700 (PDT)
Date:   Wed, 3 Aug 2022 16:51:07 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Neel Natu <neelnatu@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] sched, cpumask: don't leak impossible cpus via
 for_each_cpu_wrap().
Message-ID: <YusJ6/q/rXclCn8F@yury-laptop>
References: <20220802214041.2656586-1-neelnatu@google.com>
 <CAAH8bW_z3TjjafPRJPZmzDdOFjmU7xTLxOinw8D4nsZ2B6WN4w@mail.gmail.com>
 <CAJDe-O+8G=hyqWcaNk8_YP9S-R9-Xnn2_cLt8Loz9ru8V24K_Q@mail.gmail.com>
 <YurEAU5SlQaZ85vZ@yury-laptop>
 <CAJDe-O+7mqqrGvWimztYgEqDDqJGH=EA1NgJyiJjnurLASOQ8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJDe-O+7mqqrGvWimztYgEqDDqJGH=EA1NgJyiJjnurLASOQ8w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Andy Lutomirski <luto@kernel.org>
+ Thomas Gleixner <tglx@linutronix.de>

On Wed, Aug 03, 2022 at 02:21:46PM -0700, Neel Natu wrote:
> ject: Re: [PATCH] sched, cpumask: don't leak impossible cpus via for_each_cpu_wrap().
> To: Yury Norov <yury.norov@gmail.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
> 	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Peter Zijlstra <peterz@infradead.org>, 
> 	linux-kernel@vger.kernel.org
> Content-Type: text/plain; charset="UTF-8"
> Status: O
> Content-Length: 6037
> Lines: 152
> 
> On Wed, Aug 3, 2022 at 11:52 AM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > On Wed, Aug 03, 2022 at 10:49:57AM -0700, Neel Natu wrote:
> > > On Tue, Aug 2, 2022 at 6:22 PM Yury Norov <yury.norov@gmail.com> wrote:
> > > >
> > > > On Tue, Aug 2, 2022 at 2:41 PM Neel Natu <neelnatu@google.com> wrote:
> > > > >
> > > > > The value of 'nr_cpumask_bits' is dependent on CONFIG_CPUMASK_OFFSTACK.
> > > > > This in turn can change the set of cpus visited by for_each_cpu_wrap()
> > > > > with a mask that has bits set in the range [nr_cpu_ids, NR_CPUS).
> > > > >
> > > > > Specifically on !CONFIG_CPUMASK_OFFSTACK kernels the API can iterate
> > > > > over cpus outside the 'cpu_possible_mask'.
> > > > >
> > > > > Fix this to make its behavior match for_each_cpu() which always limits
> > > > > the iteration to the range [0, nr_cpu_ids).
> > > > >
> > > > > Signed-off-by: Neel Natu <neelnatu@google.com>
> > > >
> > > > The patch itself doesn't look correct because it randomly switches a piece
> > > > of cpumask API from nr_cpumask_bits to nr_cpu_ids, and doesn't touch
> > > > others.
> > > >
> > > > However...
> > > >
> > > > I don't know the story behind having 2 variables holding the max possible
> > > > number of cpus, and it looks like it dates back to prehistoric times.  In
> > > > modern kernel, there are 2 cases where nr_cpumask_bits == nr_cpu_ids
> > > > for sure: it's CONFIG_CPUMASK_OFFSTACK=y and
> > > > CONFIG_HOTPLUG_CPU=y. At least one of those is enabled in defconfig
> > > > of every popular architecture.
> > > >
> > >
> > > Hmm, in a kernel with CONFIG_HOTPLUG_CPU=y but not CONFIG_CPUMASK_OFFSTACK
> > > I see "nr_cpu_ids = 20, nr_cpumask_bits = 512". FYI since it doesn't
> > > match the observation
> > > above that nr_cpumask_bits == nr_cpu_ids when CONFIG_HOTPLUG_CPU=y.
> >
> > I said this because the comment in include/linux/cpumaks.h says:
> >  *  If HOTPLUG is enabled, then cpu_possible_mask is forced to have
> >  *  all NR_CPUS bits set, otherwise it is just the set of CPUs that
> >  *  ACPI reports present at boot.
> >
> > And because of the code that sets nr_cpu_ids:
> >
> > void __init setup_nr_cpu_ids(void)
> > {
> >         nr_cpu_ids = find_last_bit(cpumask_bits(cpu_possible_mask),NR_CPUS) + 1;
> > }
> >
> > Some arches override it, so it may be an issue. Are you running x86,
> > or maybe you have "nr_cpus" boot parameter?
> >
> > But anyways, I feel like this should be investigated for more... Can you
> > please share the config of your system and boot params?
> >
> 
> Yeah, this is a stock defconfig compiled on an x86_64 host and booted
> inside a 20 vcpu virtual machine (virtme). There are no command line
> params to modify the number of cpus.
> 
> I think everything is working as expected based on some debug prints I
> added during boot:
> [    0.641798] smp: setup_nr_cpu_ids: nr_cpu_ids 20, cpu_possible_mask 0-19
> [    0.648424] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64
> nr_cpu_ids:20 nr_node_ids:2
> 
> The first one is from setup_nr_cpu_ids() in kernel/smp.c. The second
> one is from setup_per_cpu_areas() from arch/x86/setup_percpu.c.

So it doesn't look correct. When HOTPLUG is ON, than cpu_possible_mask must
be 0-NR_CPUS, as it's mentioned in include/linux/cpumaks.h, because
user may add up to NR_CPUS...

Adding Thomas, Peter and Andy.

Guys, can you please clarify:
1. What for do we have both nr_cpu_ids and nr_cpumask_bits variables? In
   case of CPUMSAK_OFFSTACK, nr_cpumask_bits is aliased to nr_cpu_ids, and
   in case of HOTPLUG both should be equal to NR_CPUS. In HOTPLUG=off,
   everything is set up at boot time and never changes, so again - why do
   we need 2 variables?
2. Neel observes that with HOTPLUG_CPU=y, nr_cpu_ids differs from
   nr_cpumask_bits because cpu_possible_mask is not set completely, despite
   the comment in cpumask.h:
     *  If HOTPLUG is enabled, then cpu_possible_mask is forced to have
     *  all NR_CPUS bits set, otherwise it is just the set of CPUs that
     *  ACPI reports present at boot.
   Is that a bug, or just incorrect comment? If not a bug, what code
   increases nr_cpu_ids when a cpu goes up? From what I see, nr_cpu_ids
   is set only once in start_kernel(), and then never changes.
 
> > > > In case of HOTPLUG is off, I don't understand why we should have nr_cpu_ids
> > > > and nr_cpumask_bits different - what case should it cover?... Interestingly, in
> > > > comments to cpumask functions and in the code those two are referred
> > > > interchangeably.
> > > >
> > > > Even more interestingly, we have a function bitmap_setall() that sets all bits
> > > > up to nr_cpumask_bits, and it could trigger the problem that you described,
> > >
> > > I think you mean cpumask_setall() that in turn calls
> > > bitmap_fill(nr_cpumask_bits)?
> >
> > Yes, sorry.
> >
> > > > so that someone would complain. (Are there any other valid reasons to set
> > > > bits behind nr_cpu_ids intentionally?)
> > > >
> > >
> > > I don't know of any although this wasn't the case that trigger in my case.
> > >
> > > > Can you share more details about how you triggered that? If you observe
> > > > those bits set, something else is probably already wrong...
> > >
> > > The non-intuitive behavior of for_each_cpu_wrap() was triggered when iterating
> > > over a cpumask passed by userspace that set a bit in the [nr_cpu_ids,
> > > nr_cpumask_bits)
> > > range.
> >
> > If you receive bitmap from userspace, you need to copy it with
> > bitmap_copy_clear_tail(), or bitmap_from_arr{32,64}, as appropriate.
> > That will clear unneeded bits.
> >
> > For user-to-kernel communications, I'd recommend passing bitmaps in a
> > human-readable formats - hex string or bitmap list. Check the functions
> > cpumask_parse_user() and cpumask_parselist_user(). This would help to
> > avoid all possible issues related to endianness and 32/64 word length
> > mismatch.
> >
> > > The kernel code is out of tree but open source so happy to provide a
> > > pointer if needed.
> >
> > Yes please
> >
> 
> Here is where we copy the user supplied cpumask using the
> get_user_cpu_mask() helper:
> https://github.com/google/ghost-kernel/blob/c21b36f87663efa2189876b2caa701fe74e72adf/kernel/sched/ghost.c#L5729
> 
> For performance reasons we cannot use human readable cpu masks in this
> code path.

If nr_cpu_ids == 20, I can't imagine a case where copying 4 bytes
string to bitmap_parse() instead of 3 bytes of plain bitmap would
affect your performance.

Even if you're going to scale, it's hard to believe that code that
calls alloc() functions 3 times without GFP_ATOMIC is so critical...
I didn't look at the code deeply, but it looks like it sends many
IPIs, which also doesn't look deterministic in terms of high-perf
loads.
 
> Note that the helper copies up to 'nr_cpumask_bits' which in some
> kernels (!CONFIG_CPUMASK_OFFSTACK) can copy bits beyond 'nr_cpu_ids'.
> A possible option could be to fix this helper but I do feel that
> for_each_cpu() and for_each_cpu_wrap() should visit the same set of
> cpus given the same cpumask (ordering can be different but the set of
> cpus should remain the same).
> 
> What do you think?

I think that for_each_cpu{,_wrap} is correct here because you have
HOTPLUG=y, and any cpu may be present.

Let's see what Peter, Andy and Tomas will say. I have a feeling that
we need to drop nr_cpumask_bits, and always rely on nr_cpu_ids.

For your problem, because you are passed with the mask from userspace,
you shouldn't rely on it anyways and need some sanity checks. Maybe
like this:
        if (!cpumask_subset(user_mask, cpu_possible_mask))
                return -EINVAL;

Thanks,
Yury

> best
> Neel
> 
> > > I considered ANDing the user supplied mask with 'cpu_possible_mask'
> > > but that felt
> > > like working around an inconsistency in the kernel API (hence the proposed fix).
> > >
> > > > So, if there is no real case in modern kernel to have nr_cpumask_bits and
> > > > nr_cpu_ids different, the 
