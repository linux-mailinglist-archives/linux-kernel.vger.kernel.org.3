Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7FC49EF2A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 01:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344485AbiA1ARc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 19:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235341AbiA1ARb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 19:17:31 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FC9C06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 16:17:31 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id x23so8609062lfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 16:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IlSEJdjJrMjk0uBxQ1Hapn8YGZniC2X8+hlUSQJTZwM=;
        b=b0GAq2WgzrvcsiDSn/b3NReLAu13yP5fhdkdH7+7CT6UB+7fWmzEeAHsKA4dDNoeNo
         paizE2t2lPrMvJe9bILSyix2rdq0PRr2zY9MJG4pVC5F5WXz5wRRUk5hlzex7z7PLHob
         asTr+61XLgdhhPpPp0RKDRELmqf75iv7SoSyPKD9BNktRE6TCLbmzkjFgoJEVVA7g3zb
         6CjiFZP8sW76YJ+0pW8jd9eDQvnRKX1hdSL940vNICgmeRzitsOZ4qJcnM++xAhIrNJX
         KLerT7V508LixrbrvdMjcwYUJsJzwlwqhT/00ZQBa3tUYwEQaJOlcy1E3kH0EaMhdcMY
         AcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IlSEJdjJrMjk0uBxQ1Hapn8YGZniC2X8+hlUSQJTZwM=;
        b=o/QqYrFDUHLC3BRJBun3i8A1sgG90V7qLtFqvjJh/YxGaG7nNGzJcJuumDGsogJI8r
         dbS1PYOFoPsoOvXenj0s6n0tPxzl9sMFI1qMzACMjRHjgHGEMS8MGngJbfgWn0bWVEu6
         8aCo8UolruIXrLL888I94aafsp3uWt09gS5r8c2i2PzHAC8/ppZSpfrcrRmNDb/1DeXm
         vnh4brXF9Qa/QVdN/SP4gwOXL8WBQfzwNSsEnlu5zO6mPwLebJUpM1wFczw4IAvwQW2L
         FAcKhtgeNrerhjDdwwiEd7Wl8pedYFT3W0WAEesDTSC3eyO1ADOmMBPv3oclXFsDB/Gn
         nftA==
X-Gm-Message-State: AOAM531x2RyYE9movQz1HQrfas4OQ/WWXtF+ydmZimcZIv9MmhdSgzSs
        dFTSPHrnY+VOJ95kC0t+O2sB0tec+MVKXmgaUYy4Tw==
X-Google-Smtp-Source: ABdhPJwwq3RWKdq6zaQeBD4zp7BWV/yEz0bPSG5n3byJeJMyzqq7BkL9gHT/C/ZRY8175jaO1A1XGgvkI1yjZL5Hpfk=
X-Received: by 2002:ac2:4c4c:: with SMTP id o12mr4346659lfk.523.1643329049299;
 Thu, 27 Jan 2022 16:17:29 -0800 (PST)
MIME-Version: 1.0
References: <20220120155517.066795336@infradead.org> <20220120160822.852009966@infradead.org>
 <YfIAsHQv5Q84fOqO@google.com> <YfI9Y5l0fQAKuJav@google.com>
 <YfJsNcYNH8JTHrM/@hirez.programming.kicks-ass.net> <YfMruK8/1izZ2VHS@google.com>
In-Reply-To: <YfMruK8/1izZ2VHS@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 27 Jan 2022 16:17:17 -0800
Message-ID: <CAKwvOdmPkCuYuMRBSeK7DaK-wrdH5+C0gL63eqJ1buHsmueFsg@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 4/5] x86/uaccess: Implement unsafe_try_cmpxchg_user()
To:     Sean Christopherson <seanjc@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, posk@google.com, avagin@google.com,
        jannh@google.com, tdelisle@uwaterloo.ca, mark.rutland@arm.com,
        posk@posk.io, James Y Knight <jyknight@google.com>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 3:33 PM Sean Christopherson <seanjc@google.com> wro=
te:
>
> +Nick

(well, you asked the right person; you probably wont like the answer
much though)

>
> On Thu, Jan 27, 2022, Peter Zijlstra wrote:
> > On Thu, Jan 27, 2022 at 06:36:19AM +0000, Sean Christopherson wrote:
> > > On Thu, Jan 27, 2022, Sean Christopherson wrote:
> > > > Doh, I should have specified that KVM needs 8-byte CMPXCHG on 32-bi=
t kernels due
> > > > to using it to atomically update guest PAE PTEs and LTR descriptors=
 (yay).
> > > >
> > > > Also, KVM's use case isn't a tight loop, how gross would it be to a=
dd a slightly
> > > > less unsafe version that does __uaccess_begin_nospec()?  KVM pre-ch=
ecks the address
> > > > way ahead of time, so the access_ok() check can be omitted.  Altern=
atively, KVM
> > > > could add its own macro, but that seems a little silly.  E.g. somet=
hign like this,
> > > > though I don't think this is correct
> > >
> > > *sigh*
> > >
> > > Finally realized I forgot to add back the page offset after convertin=
g from guest
> > > page frame to host virtual address.  Anyways, this is what I ended up=
 with, will
> > > test more tomorrow.
> >
> > Looks about right :-) (famous last words etc..)
>
> And it was right, but clang-13 ruined the party :-/
>
> clang barfs on asm goto with a "+m" input/output.  Change the "+m" to "=
=3Dm" and
> clang is happy.  Remove usage of the label, clang is happy.

Yep, sorry, we only recently noticed that this was broken.  I fixed
this very recently (over the holidays) in clang-14, and is too risky
and late to backport to clang-13 IMO.
https://reviews.llvm.org/rG4edb9983cb8c8b850083ee5941468f5d0ef6fe2c

>
> I tried a bunch of different variants to see if anything would squeak by,=
 but
> clang found a way to die on everything I threw at it.
>
> $ clang --version
>
>   Debian clang version 13.0.0-9+build1
>   Target: x86_64-pc-linux-gnu
>   Thread model: posix
>   InstalledDir: /usr/bin
>
> As written, with a named label param, clang yields:
>
>   $ echo 'int foo(int *x) { asm goto (".long (%l[bar]) - .\n": "+m"(*x) :=
:: bar); return *x; bar: return 0; }' | clang -x c - -c -o /dev/null
>   <stdin>:1:29: error: invalid operand in inline asm: '.long (${1:l}) - .=
'
>   int foo(int *x) { asm goto (".long (%l[bar]) - .\n": "+m"(*x) ::: bar);=
 return *x; bar: return 0; }
>                             ^
>   <stdin>:1:29: error: unknown token in expression
>   <inline asm>:1:9: note: instantiated into assembly here
>           .long () - .
>                ^
>   2 errors generated.
>
> While clang is perfectly happy switching "+m" to "=3Dm":
>
>   $ echo 'int foo(int *x) { asm goto (".long (%l[bar]) - .\n": "=3Dm"(*x)=
 ::: bar); return *x; bar: return 0; }' | clang -x c - -c -o /dev/null

=3D constraints should work with older clang releases; + constraints are
what was broken (Not generally, only when using asm goto with
outputs), fixed in clang-14.

>
> Referencing the label with a numbered param yields either the original er=
ror:
>
>   $ echo 'int foo(int *x) { asm goto (".long (%l1) - .\n": "+m"(*x) ::: b=
ar); return *x; bar: return 0; }' | clang -x c - -c -o /dev/null
>   <stdin>:1:29: error: invalid operand in inline asm: '.long (${1:l}) - .=
'
>   int foo(int *x) { asm goto (".long (%l1) - .\n": "+m"(*x) ::: bar); ret=
urn *x; bar: return 0; }
>                             ^
>   <stdin>:1:29: error: unknown token in expression
>   <inline asm>:1:9: note: instantiated into assembly here
>           .long () - .
>                  ^
>    2 errors generated.

^ That case should not work in either compilers, more info below...

>
> Bumping the param number (more below) yields a different error (I tried d=
efining
> tmp1, that didn't work :-) ).
>
>   $ echo 'int foo(int *x) { asm goto (".long (%l2) - .\n": "+m"(*x) ::: b=
ar); return *x; bar: return 0; }' | clang -x c - -c -o /dev/null
>   error: Undefined temporary symbol .Ltmp1
>   1 error generated.

"Bumping the param number" will be required when using numbered
references, more info below...

>
> Regarding the param number, gcc also appears to have a goof with asm goto=
 and "+m",
> but bumping the param number in that case remedies its woes.
>
>   $echo 'int foo(int *x) { asm goto (".long (%l1) - .\n": "+m"(*x) ::: ba=
r); return *x; bar: return 0; }' | gcc -x c - -c -o /dev/null
>   <stdin>: In function =E2=80=98foo=E2=80=99:
>   <stdin>:1:19: error: invalid 'asm': '%l' operand isn't a label
>
>   $ echo 'int foo(int *x) { asm goto (".long (%l2) - .\n": "+m"(*x) ::: b=
ar); return *x; bar: return 0; }' | gcc -x c - -c -o /dev/null

Right, so in fixing the above issue with tied outputs, I noticed that
the GCC implementation of asm goto with outputs had different
behavior. I changed clang's implementation in clang-14 (same patch
series) to match:
https://reviews.llvm.org/rG5c562f62a4ee15592f5d764d0710553a4b07a6f2
This comment summarizes most of my thoughts on the issue:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D98096#c7
Specifically the quote "It appears to me that the GCC decision here
was accidental, and that when pointed out, the bug was simply
documented rather than fixed."
Though I think compatibility between compilers is ultimately more
important.  There's no standards bodies involved in these extension,
which is simultaneously more flexible, yet can also lead to
differences in implementations like this. Thanks for attending my TED
talk.

>
>
> So my immediate question: how do we want to we deal with this in the kern=
el?  Keeping
> in mind that I'd really like to send this to stable@ to fix the KVM mess.
>
> I can think of few options that are varying degrees of gross.
>
>   1) Use a more complex sequence for probing CC_HAS_ASM_GOTO_OUTPUT.
>
>   2) Use an output-only "=3Dm" operand.
>
>   3) Use an input register param.
>
> Option #1 has the obvious downside of the fancier asm goto for  __get_use=
r_asm()
> and friends being collateral damage.  The biggest benefit is it'd reduce =
the
> likelihood of someone else having to debug similar errors, which was quit=
e painful.

Right; I assumed we'd hit this at some point, as soon as people wanted
to used tied outputs with asm goto.  I'd rather have a different
Kconfig test for working tied outputs, and that all uses in the
kernels used the symbolic references which are much more readable and
less confusing than the rules for numbered references (which are bug
prone IMO).

>
> Options #2 and #3 are quite gross, but I _think_ would be ok since the se=
quence
> is tagged as clobbering memory anyways?

--=20
Thanks,
~Nick Desaulniers
