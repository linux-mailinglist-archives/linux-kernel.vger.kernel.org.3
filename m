Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EEA4A93B0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 06:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243497AbiBDFgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 00:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242516AbiBDFgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 00:36:00 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8C4C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 21:36:00 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id i34so10600490lfv.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 21:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=14M8Z2g4rIcd4MzM7IK/f5yDui7+jhXmK0fHQ0UO9gg=;
        b=iy8PQqnumvl1erIic+I0eZn9SlBWRx6M5CVxb89pXk/qzT+lbmKJyRd3CFDnpfqxHc
         2l4Ckbss4XRYs9T6e8Siz20gEC2Fg+t3BZv6dz9x/7h6ve+vZeoxOhRAquDkYL4yhseg
         ygh5JmtCMeF/WDGMIkU8XB3e8miD5IhN2wid347G8w2zPwvZrAxiI+fPhgBS2+iVQ9fI
         DtmG31vNmXxlsmqzJXxmR+Hu9o87ulAZHP4gC4RGh1YOV6psJNJOaPLqiXThqzsljpoC
         swfoaYfKbfHdLamVt+n8sbaiMk7XEAayix8WJfGG6CcKUX5RNTwQx6ULzx0tkzDlUaqw
         yvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=14M8Z2g4rIcd4MzM7IK/f5yDui7+jhXmK0fHQ0UO9gg=;
        b=MKHvq+llXTbUP1mVwwuN1+3UPo3OIUVJfBOGr8uwVN9Z46SMEEZfoDZ0hR/P0fayPL
         XsX1Kvs01KBuu9NWZSKf/VAIwQVYFv74XSP9EgW4I98WNRnjGGS1FfGwtA+lZ8ZhpL4h
         drn65Ucy/s7vP0rtduPY8dNCy2xvv4qmk6LJkXXcADTNTbxLFvLzGaFlM7byUDacPg8e
         TVFj6HDLN8xPFGbiW1eT0zP8//gXcUeV0B2uyNcuo1fUdqKSM1AsBZijtJ3jd5zAUrLA
         oiaZAv5VrDv8Z3C1D70HsZmHuIgm47/4zQudNMzQhioUQHgBE3ZT0tsTKjVC2CYFdfII
         UFNg==
X-Gm-Message-State: AOAM530+ILeSluo9ipBQjK+7uXiriyJr6iuftAMgzVEY4S1kGtuX+/lC
        dpjqRm5HiIGqiyRv673GtoKTbNrZkKk5cp2E4A4=
X-Google-Smtp-Source: ABdhPJzWdFi4IcAzkHjRqu5yWpmydedG6tke/n69JSi0I2Sq4d1SsM/tZ0hk1XD4rEK8eXlFpOAUYcn+QswhDEUKyRs=
X-Received: by 2002:a05:6512:3d0f:: with SMTP id d15mr1187647lfv.77.1643952958413;
 Thu, 03 Feb 2022 21:35:58 -0800 (PST)
MIME-Version: 1.0
References: <CA+cA0PB92khCo7dNAyw-zUmhKJHg-D2aQyT=HmLHhyVvd_Cd5g@mail.gmail.com>
 <feffc13d-5ee5-7326-1f5d-d803d0ab44b2@intel.com>
In-Reply-To: <feffc13d-5ee5-7326-1f5d-d803d0ab44b2@intel.com>
From:   Nikita Popov <npv1310@gmail.com>
Date:   Fri, 4 Feb 2022 10:35:47 +0500
Message-ID: <CA+cA0PCbY2qSsgTLsK8=N3WNEWN_JSgOoefn2wNhKFPrJbJCSA@mail.gmail.com>
Subject: Re: A logical error in arch/x86/mm/init.c
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Juergen Gross <jgross@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your attention.
> If you really feel that this is something that needs to be fixed, I'd
> appreciate if you could find some way to reproduce it and then send a
> proper patch.
I believe this would be hard to reproduce.
I just noticed this discrepancy during manual code review.
I'm considering the following facts:
1) The area 'pgt_buf' is part of the 'brk' area defined in the linker
script. It is allocated in the function 'early_alloc_pgt_buf' using
the very same 'extend_brk'. The latter is essentially a stack-based
allocator picking its memory slices from the linker defined area.
2) The allocations from 'pgt_buf' are in the stack manner too.
One can expect that these two areas (one of which is completely
contained in the other) have the same properties in view of the direct
memory mapping.

Then there is the flag 'can_use_brk_pgt' which allows usage of the
pgt_buf area if a mapped range doesn't overlap with the free space of
the pgt_buf area. In the 'init_range_memory_mapping' function we can
observe that this flag doesn't reflect the relative position between a
mapped range and the free space of the brk area as a whole:
                /*
                 * if it is overlapping with brk pgt, we need to
                 * alloc pgt buf from memblock instead.
                 */
                can_use_brk_pgt = max(start, (u64)pgt_buf_end<<PAGE_SHIFT) >=
                                    min(end, (u64)pgt_buf_top<<PAGE_SHIFT);
This check is simply too narrow.

So for whatever reason this flag prohibits usage of the pgt_buf area,
I believe for the exact same reason we have to avoid using brk area if
the similar condition on the free space of the brk area holds.
> This _might_ be right.  But, my confidence that it won't break anything
> else is pretty low.  It's also obviously not been tested.
Yes, I agree here. I saw it as my duty to report the possible issue.
> What are these "MMU issues"?
I tried to deduce the underlying reason beyond the code fragments in
question. I presumed that checking for overlap is protecting against
some MMU issues that could affect stability of the kernel.

Kind regards,
Nikita Popov
Senior C Developer

On Thu, Feb 3, 2022 at 10:27 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 2/3/22 02:30, Nikita Popov wrote:
> > It appears that there is a logical error in arch/x86/mm/init.c in the
> > master branch. Although it is unlikely to occur in practice. I
> > discovered it while studying source code in that file.
>
> I looked at this a bit.  It seems to have originated in:
>
> > https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=c9b3234a6aba
>
> which isn't the best changelog in the history of the world.  It's also
> fixing a boot problem in a configuration that I can't readily reproduce
> (Xen PV guest).
>
> There's one thing from the old changelog that's confusing me:
>
> >     But after we get back that page for pgt, it tiggers one bug in pgt allocation
> >     with xen: We need to avoid to use page as pgt to map range that is
> >     overlapping with that pgt page.
>
> and presumably alluding to the same issue from your mail:
>
> > ... which can incur MMU issues if that page is allocated as a page
> > directory)
>
> What are these "MMU issues"?
>
> > In my opinion one of the simplest fixes here is to completely remove
> > the following lines:
> >     if (!ret && can_use_brk_pgt)
> >             ret = __pa(extend_brk(PAGE_SIZE * num, PAGE_SIZE));
>
> This _might_ be right.  But, my confidence that it won't break anything
> else is pretty low.  It's also obviously not been tested.
>
> I'd be much more confident if this issue was reproduced, even if the
> reproduction was contrived by doing something like purposefully
> exhausting the pgt_buf_* area.
>
> If you really feel that this is something that needs to be fixed, I'd
> appreciate if you could find some way to reproduce it and then send a
> proper patch.
