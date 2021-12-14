Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2660D473AF8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 03:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbhLNCvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 21:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhLNCve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 21:51:34 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6615C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 18:51:34 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id l5so16621434ilv.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 18:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3jsCu17UcfNVcbc00SJeDBruH8+M4d/e9QG8WaxESCQ=;
        b=fzXsd0CgZZ72srj/m//lLXbIvPLOupij7fwNQ75VD3XgvZjWiNYZidyseu+uAhx41r
         NGsv0l6les/fYmdjestNvt+gse2Ff9dqPDm64TuZ/QhyvMwvGI8OZNVUOaCIw+qcwbd5
         2WQorZW7zRzdoio/7GwfAtZIcsuIM/pzgmkfnfDuuVKraZX6zhMi7VszGnNmHqvgr/1s
         OG5/pjWmRGfVfFD7F2UyLJ3j5Lqi3p6Z20m2j65vtsiPkTwoi1gAvajdetz4UZzB7pQ+
         XuoNqu08JCVGzFFGbTzYL88etzp2xsphRpOkZdxPy1UzGhTB/3NjkdMiYMk2mQ79onPl
         YgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3jsCu17UcfNVcbc00SJeDBruH8+M4d/e9QG8WaxESCQ=;
        b=sSeFcAiLV3rW2HAKrjxakEEzEwbLY8AdLkTiT+ifGx//oNuRvzPiw4U3c0Rj/d6gPY
         +sJIQu/wt2sTBcVJftHz8jsT4VZPggGgrGMMYjnF9KI0y2yUCxBz7QC5Atudcdfd60ZP
         U4X9aiPXhl9AqwXHxWr+6Qrss62dO1Cjpvc8z17ZwUgcxdYvXoIobSsJc7LkPUcgVu1K
         kFF8sOtOu0LS3ea80l7fuokQQ8sLAx2vlGJacS8ZSq6gpAMv4Aa835BOZVtzOcLvR9RA
         qmDBfbAevskuJiiiWWZ77SXSO2XvosT5AS2iDPf520RoaSs7tYINrIMHnV+2RQ6zFE/p
         vsvA==
X-Gm-Message-State: AOAM532uQ6sLJ6zM5ub/UmLlZVEGT2RkFg8OeWscnS3ujVcGMTfkmGev
        ory67RzUQ5Z9R/ZMU7PvGNDduWx5KKVLKXMc9sc=
X-Google-Smtp-Source: ABdhPJy8WxFEeG2pN8CG05UVDaJE5hZSo4sZRqAyhs0pjLEbXEs+QPJPSwztg75vG5hi4lEGXiM9x+AIQnOCjHf0fs8=
X-Received: by 2002:a92:cb4b:: with SMTP id f11mr1690559ilq.286.1639450294290;
 Mon, 13 Dec 2021 18:51:34 -0800 (PST)
MIME-Version: 1.0
References: <20211213042215.3096-1-jiangshanlai@gmail.com> <20211213042215.3096-2-jiangshanlai@gmail.com>
 <YbeaXT1Y80baey3t@zn.tnic>
In-Reply-To: <YbeaXT1Y80baey3t@zn.tnic>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Tue, 14 Dec 2021 10:51:23 +0800
Message-ID: <CAJhGHyB=VY-m7fJ+bapWgPsczhH0q9oeMmCTP5cOYJAP0VW5ZA@mail.gmail.com>
Subject: Re: [PATCH 1/3] X86/db: Change __this_cpu_read() to this_cpu_read()
 in hw_breakpoint_active()
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Tue, Dec 14, 2021 at 3:09 AM Borislav Petkov <bp@alien8.de> wrote:

> So please try to restrain yourself and write proper English. Run your
> commit message through a spellchecker at least so that there are no
> funky words.

The commit message was checked via VIM spellchecker.  It did highlight
denylist, noinstr, noinstrument, complexify, and a lot more.

There are too many false-negative results from VIM spellchecker, and
I searched denylist, complexify via google and they are used by some
other places so I kept them.

I'm sorry for not searching in the kernel tree to find a proper
word for noinstrument, not searching the web for better words for
denylist, complexify.

I will change a spellchecker and improve my English.


>
> > to any extra data except the percpu cpu_dr7, and cpu_dr7 is disallowed
> > to be watched in arch_build_bp_info().  So this_cpu_read() is safe to
> > be used when hw_breakpoints is still active, and __this_cpu_read() here
> > should be changed to this_cpu_read().
> >
> > This problem can only happen when the system owner uses a kernel with
> > CONFIG_DEBUG_PREEMPT enabled and deliberately use hw_breakpoints on
> > the data that __this_cpu_preempt_check() accesses.  Sot it is just a
> > problem with no significance.
> >
> > One might suggest that, all the data accessed by noinstr functions
> > should be marked in denylist for hw_breakpoints.  That would complexify
>
> should be marked in denylist for hw_breakpoints.  That would complexify
> Unknown word [denylist] in commit message, suggestions:
>         ['deny list', 'deny-list', 'dentistry']
>
> should be marked in denylist for hw_breakpoints.  That would complexify
> Unknown word [complexify] in commit message, suggestions:
>         ['complexity', 'complexion']
>
> > the noinstrment framework and add hurdles to anyone that who want to
>
> the noinstrment framework and add hurdles to anyone that who want to
> Unknown word [noinstrment] in commit message, suggestions:
>         ['instrument']
>
> So you need to restrain yourself and stop inventing new English words.
>
> > add a new noinstr function.  All we need is to suppress #DB in the IST
>
> Who is "we"?
>
> > interrupt entry path until safe place where #DB is disabled in hardware
> > or #DB handler can handle well even it hits data accessed by noinstr
> > function.  Changing __this_cpu_read() to this_cpu_read() is fit for it.
>
> You don't need to write *what* your patch is doing - that is clear from
> the diff.

What I wanted to say in this paragraph is that why I chose this way to fix
it since there are several ways/policies to fix it.

"Changing __this_cpu_read() to this_cpu_read() is fit for" this policy.

I don't think it can be seen in the diff.

> I don't really follow the argument for why this_cpu_read(); why not
> raw_cpu_read() instead, which is what __this_cpu_read() is based on.
> Also, this really needs a comment.

Yes, raw_cpu_read() is better.

Some other places in noinstr function use this_cpu_read(), so I did
not search if there is a better alternative.  I just reviewed the
definition of this_cpu_read() and concluded that it can be used.

>        /*
>         * Must not hit a breakpoint in check_preempt_disabled()
>         */
>        return raw_cpu_read(cpu_dr7) & DR_GLOBAL_ENABLE_MASK;

Although, this comment is describing raw_cpu_read() obviously, I often
can't get which code is a comment in other places referring to due
to later changes with new code added and removed.

Can I duplicate the code in the comments?
  Use raw_cpu_read() instead of __this_cpu_read() to avoid hitting
  a breakpoint in check_preempt_disabled().

Thanks
Lai
