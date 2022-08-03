Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BC65891C3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238033AbiHCRuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236382AbiHCRuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:50:12 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DC8C8
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 10:50:10 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id s7so7292172uao.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 10:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jNo0t7J4xSJTYPyNgZeujz/xHeQ1nHMX04e7zkXpbvk=;
        b=HYQl97J7/hTTZXHe4Ih+SR++ScVh81kgNnqV2pxjeO2pt4yXF8GuYUxcW+HI0ndTnT
         IZ4LgdbN18NGmg9eI8/4npxAzBeFrlybrgLgSDvOqrrIFtJBDzApGGbTwccHtfbYjG+A
         ylR3huYZG7exzLtQV8ZZFG+30kdp+Sx5sBtO0cr6oAOGMZ0gFMdDHYNYbNpP43EVlOKK
         +JeRwF5CuobLO4IDZvQ9JuY+hUMj8Qg3+1hJ281UNKdZDgtcdAxO2ao2cJd3i2QbLAxr
         oYVQsVTPa4I1co96nb4e6HAt4g5Esh578U6xV42EvVcCoR+jjuyLWtsWbudp0b9k2vCE
         x/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jNo0t7J4xSJTYPyNgZeujz/xHeQ1nHMX04e7zkXpbvk=;
        b=PYHLFr8EyVbaWGNNoPAjA/pJ5X/1PZ2+wHFhk/O/EANlLiRc76DiBRbDFCqOKMouth
         cSYPSjbFcYxwCvrQ7B9PtA5+h3NdV3uIQvxOodi/oqpHblk6lKFBfpYbrym2KX2T5Qz0
         TujvNm0b8eSQkbfMMcDE7q0KxI2toN0eGr6o2bkgRqOooloFraVfJZMIRfRLR+PPmPvJ
         FayC6ubyE1HjCW6KBY+pcYXDiopbBj8/B3xsz5157/aYaKBcGw4egsmooQGQ5J88PAvx
         H7I5rGHqXRutK6Q7VjGIVc/mJ8GNVMz4XXB44eiCpiEK7HFUY46icuadC1uF5h9PgN9e
         LePA==
X-Gm-Message-State: ACgBeo1k0VpiyGOoTHs2CdfiWS8dyFLWviwb7FKpa8zMajDjpo6v41nl
        QuilBXLonijYufkpOn+WoRX3adqIzNtthl0M7qlSUA==
X-Google-Smtp-Source: AA6agR7R5SXWDx1T+w6QvsZb3AX4jjCgaMf68XMoY0cUe7PhTplcKdIn51OWAXURg6jTa3ZsE/THotdxqANN/PSZOGI=
X-Received: by 2002:ab0:785a:0:b0:386:d33c:d636 with SMTP id
 y26-20020ab0785a000000b00386d33cd636mr10812524uaq.87.1659549009110; Wed, 03
 Aug 2022 10:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220802214041.2656586-1-neelnatu@google.com> <CAAH8bW_z3TjjafPRJPZmzDdOFjmU7xTLxOinw8D4nsZ2B6WN4w@mail.gmail.com>
In-Reply-To: <CAAH8bW_z3TjjafPRJPZmzDdOFjmU7xTLxOinw8D4nsZ2B6WN4w@mail.gmail.com>
From:   Neel Natu <neelnatu@google.com>
Date:   Wed, 3 Aug 2022 10:49:57 -0700
Message-ID: <CAJDe-O+8G=hyqWcaNk8_YP9S-R9-Xnn2_cLt8Loz9ru8V24K_Q@mail.gmail.com>
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

On Tue, Aug 2, 2022 at 6:22 PM Yury Norov <yury.norov@gmail.com> wrote:
>
> On Tue, Aug 2, 2022 at 2:41 PM Neel Natu <neelnatu@google.com> wrote:
> >
> > The value of 'nr_cpumask_bits' is dependent on CONFIG_CPUMASK_OFFSTACK.
> > This in turn can change the set of cpus visited by for_each_cpu_wrap()
> > with a mask that has bits set in the range [nr_cpu_ids, NR_CPUS).
> >
> > Specifically on !CONFIG_CPUMASK_OFFSTACK kernels the API can iterate
> > over cpus outside the 'cpu_possible_mask'.
> >
> > Fix this to make its behavior match for_each_cpu() which always limits
> > the iteration to the range [0, nr_cpu_ids).
> >
> > Signed-off-by: Neel Natu <neelnatu@google.com>
>
> The patch itself doesn't look correct because it randomly switches a piece
> of cpumask API from nr_cpumask_bits to nr_cpu_ids, and doesn't touch
> others.
>
> However...
>
> I don't know the story behind having 2 variables holding the max possible
> number of cpus, and it looks like it dates back to prehistoric times.  In
> modern kernel, there are 2 cases where nr_cpumask_bits == nr_cpu_ids
> for sure: it's CONFIG_CPUMASK_OFFSTACK=y and
> CONFIG_HOTPLUG_CPU=y. At least one of those is enabled in defconfig
> of every popular architecture.
>

Hmm, in a kernel with CONFIG_HOTPLUG_CPU=y but not CONFIG_CPUMASK_OFFSTACK
I see "nr_cpu_ids = 20, nr_cpumask_bits = 512". FYI since it doesn't
match the observation
above that nr_cpumask_bits == nr_cpu_ids when CONFIG_HOTPLUG_CPU=y.

> In case of HOTPLUG is off, I don't understand why we should have nr_cpu_ids
> and nr_cpumask_bits different - what case should it cover?... Interestingly, in
> comments to cpumask functions and in the code those two are referred
> interchangeably.
>
> Even more interestingly, we have a function bitmap_setall() that sets all bits
> up to nr_cpumask_bits, and it could trigger the problem that you described,

I think you mean cpumask_setall() that in turn calls
bitmap_fill(nr_cpumask_bits)?

> so that someone would complain. (Are there any other valid reasons to set
> bits behind nr_cpu_ids intentionally?)
>

I don't know of any although this wasn't the case that trigger in my case.

> Can you share more details about how you triggered that? If you observe
> those bits set, something else is probably already wrong...

The non-intuitive behavior of for_each_cpu_wrap() was triggered when iterating
over a cpumask passed by userspace that set a bit in the [nr_cpu_ids,
nr_cpumask_bits)
range.

The kernel code is out of tree but open source so happy to provide a
pointer if needed.

I considered ANDing the user supplied mask with 'cpu_possible_mask'
but that felt
like working around an inconsistency in the kernel API (hence the proposed fix).

> So, if there is no real case in modern kernel to have nr_cpumask_bits and
> nr_cpu_ids different, the proper fix would be to just drop the first.
>

I'll let other people more knowledgable than me in this area chime in.
I'll be happy either
way if that fixes the problem at hand.

best
Neel

> If there is such a case, this is probably your case, and we'd know more
> details to understand how to deal with that.
>
> Thanks,
> Yury
