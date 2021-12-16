Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C57477CE2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 20:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241119AbhLPTz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 14:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbhLPTzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:55:25 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BA9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 11:55:25 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id y12so90057443eda.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 11:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IOXiuI6LubyIojQSSPOrAuT1Pzx6Dib99dr/KQXnlVQ=;
        b=PsjjFessyuD8M6gyj4nhtoquh95EtpKtar+McrP49/5ybr6ITdQ3iemUosEzuHtE+b
         5acpCcsORf7x9jNtdUdYHkKsz9IKiNH6gHEVv6wMJ7DCfdWHVhgrxA/zi/GpERur6nR8
         rDk59WuqCF2jo5LeLWlQHDW743R2cTmjNfFka6TA3vIIQCk1ViCGDVeU+fHynfBr4tYl
         asNL94bDdFgxqza3yAAc9FBl8veKC0Cs2s1KSaKXVbT7yWIyM0pwlREY7EZW0BhXuVjd
         lNZkNHlVj+6EYsl6C297hbP8ckNBpv5dPhz1GRKmCnL60BDR7E250bJZ9phoMKhuLkzI
         7KtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IOXiuI6LubyIojQSSPOrAuT1Pzx6Dib99dr/KQXnlVQ=;
        b=RDT0eYr9eGRyB6qSfbLsuzez1gBHWQyozlNXGkypvC3E6d1luUEEwH2mSTxMxA8Zwr
         pPmrtzx2uRC7G2cOzHrN58U/6AKUVjQNVhhXsNYdpKHUOYkGKwe5N3PFa+Z1Hv7axa6S
         otbdbMdjGSCOjOgBa39/C+hP2AumlprPMdFiIJK1b9gZRZOL5oYHB8JgZ/hNDsbsyP9u
         mZECbQEgvFceA20F6I45YulrpKiKj5fga791VgYETcEbHy03aCeLj9aT6zNtpIwhQz9K
         r4qZoY0nDtPxJuvZ4yVZFw9/16iJnkWQtKJgwAuTJ+eyeRDaiC5+o2rCP+npnmQ7pqqY
         46UA==
X-Gm-Message-State: AOAM531d0uCp0qbDjDm4iHjPc9rVvqC/0TdUxQxPmb4mcEUV+QSRZLqL
        mQVPMigNmYbnnG1c5YXTTqlo7xbZ1+eDUMtLnE7V
X-Google-Smtp-Source: ABdhPJyH++bVUV/h5tufDRSPBxUBp0JrVSC9Sq0G74EZnaboOzWr9e7a+HeWkcP70X9osrIcutc+ZjjmxMmALFbZt7M=
X-Received: by 2002:a50:cd52:: with SMTP id d18mr4746385edj.386.1639684523275;
 Thu, 16 Dec 2021 11:55:23 -0800 (PST)
MIME-Version: 1.0
References: <20211215211847.206208-1-morbo@google.com> <87mtl1l63m.ffs@tglx>
In-Reply-To: <87mtl1l63m.ffs@tglx>
From:   Bill Wendling <morbo@google.com>
Date:   Thu, 16 Dec 2021 11:55:12 -0800
Message-ID: <CAGG=3QV2sw1w+j2NDqPVAbobGj04QXfOF0VcSCebRbs6y-L5WA@mail.gmail.com>
Subject: Re: [PATCH] x86: use builtins to read eflags
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, llvm@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 4:57 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Bill,
>
> On Wed, Dec 15 2021 at 13:18, Bill Wendling wrote:
>
> please always CC the relevant mailing lists, i.e. this lacks a cc:
> linux-kernel@vger.kernel.org
>
I thought that was automatically added. But as Peter pointed out in
another email thread, no one has time to read the LKML, so it seems a
bit pointless? Nonetheless it's added now.

> > GCC and Clang both have builtins to read from and write to the
> > EFLAGS register. This allows the compiler to determine the best way
> > to generate the code, which can improve code generation.
>
> Emphasis on *can*. Just claiming that this might improve things does not
> cut it. Where is the prove?
>
There are a few proofs. First, clang generates better code with the
builtin. Yes, that's because clang doesn't handle the "=rm" constraint
in the same way that GCC does, but that's not really relevant (sure,
clang should correct this, but that shouldn't prevent this patch from
going, because builtins are generally better than inline assembly).
Builtins exist for a reason. The compiler's able to understand what's
going on and generate the appropriate code for it. It also gives the
compiler more freedom for optimizations.

Secondly, this one small function has had multiple changes since its
creation, basically pinging back and forth trying to determine the
best constraints to use:

  6abcd98f x86: irqflags consolidation
  f1f029c7 x86: fix assembly constraints in native_save_fl()
  ab94fcf5 x86: allow "=rm" in native_save_fl()

The information on which form to use already exists in the compiler.
Using the builtin will save future churning and thus developers' time.

> IIRC, this was proposed before and the real reason was not better code
> generation but to address the confusion of clang vs. the '=rm'
> constraint which is still correct despite some clang folks having
> different opinions.
>
> So what has changed since then?

The minimal version of GCC is now 5.1, which supports these builtins.
That wasn't the case before.

> AFAICT, nothing. So I consider this as
> another attempt of "let's see whether it sticks".
>
The first patch was dismissed primarily because it was deemed too
convoluted, because I was trying to get past the then GCC minimal
version not supporting the builtins.

-bw
