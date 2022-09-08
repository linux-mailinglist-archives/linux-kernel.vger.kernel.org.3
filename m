Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F0B5B283C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 23:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiIHVQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 17:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiIHVQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:16:18 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D1BBF34F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 14:16:17 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id b35so8288699edf.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 14:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Lr8oiy+JZ5JB+d+QkGV7FDirBPOdIiFwxT3YvDwpj8w=;
        b=LEaHRiXOMVqfETuRtrKDKenARH14qGRl7NuB14aBEgeGMGDbtWkzQVh7KylKuhB81s
         TxAgAz88H1/wFtBfBFXaJMjn9BqJ3YVRnK2wBWrnAUzzcO+Jcxz/bAKaZfjSBtkDEYaN
         JrtGiPbJ0nlKQXtYte0RSwd2BUastFp1538FMZRnLjouyAQw7TyOiH939vzUi4PgnPlU
         1ywc9DWipvNeZaDaO1iTX6M6UH88ZAe8GEoN/8DOuPX30m3kHZpUCsKR0iu87CXHLS2P
         oM0cYVleAG1luTB1ykljvduO8DDMzt8jbpchT1b/rzsJR9qe2XXu8HxXOVCuG6l1mGBC
         Y4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Lr8oiy+JZ5JB+d+QkGV7FDirBPOdIiFwxT3YvDwpj8w=;
        b=t/aDjFxYQlBR53avrnDJj7a55tNvJFoqYoloYyd98HBq7rGL5wXMIBU0+CwS75nuPk
         G5DLcMtAIfAqJ3RQFAj+9MNZUpIfLGoxdl/0nQD3M/caYf2L1liz2NvmGjF00mMHfA6F
         wnvpBtDT/OcpR0wQGLr1A05djCJuNLrU0jOHA1ZFiKWqzRqD9z24M8X0SszVkxv0gJB9
         P3FZfMNr7sMpKJRnqe4KHCmv42wAntn88wTFXJ2dUXcj8smZzNvdMrdPfVCR9ZbNUcFX
         IAMjfJkCuP9hPtyWeq5iVWv03dbbcS92nR/+BTQoTwGJ/xGeort3M6UG9wiugQ3eiYhX
         +JKA==
X-Gm-Message-State: ACgBeo2y95uT7a28+93wwlAHGcN5ahIHnBoihrxYI3JRlaPEi7HPjC4+
        gsgJE2sS9OsRPjWmtmzcjoslYIAHaJNmVO/hrxeV
X-Google-Smtp-Source: AA6agR5lsRmAOE/0+TTz415bYxQiXfuxn/OW7pA3his5JST/uY+2zxr8lfmlZJuVp7ZpH5p8b5vEhIAXAzK3XUN1mds=
X-Received: by 2002:a05:6402:274c:b0:44f:334e:1e11 with SMTP id
 z12-20020a056402274c00b0044f334e1e11mr5788349edd.304.1662671775594; Thu, 08
 Sep 2022 14:16:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220902213750.1124421-1-morbo@google.com> <20220902213750.1124421-3-morbo@google.com>
 <202209022251.B14BD50B29@keescook> <CAGG=3QXpK+bFOSYZkdNNFGzNfgJSSADGTRWYRv6z0vfBAgQvWQ@mail.gmail.com>
 <CAKwvOdm+kVTrqMrSPHwTa0NrG9qwTcFkGnikjYjk0ctFGBfeRA@mail.gmail.com>
 <YxhbO1YZPMHutw48@hirez.programming.kicks-ass.net> <202209071609.BE5BF18D6@keescook>
In-Reply-To: <202209071609.BE5BF18D6@keescook>
From:   Bill Wendling <morbo@google.com>
Date:   Thu, 8 Sep 2022 22:16:04 +0100
Message-ID: <CAGG=3QUcQCQXff9Hk+eHrvbAhPT16BmFGNuAGcd-N0d-G8yBKg@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/paravirt: add extra clobbers with
 ZERO_CALL_USED_REGS enabled
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Juergen Gross <jgross@suse.com>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        virtualization@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        linux-hardening@vger.kernel.org
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

On Thu, Sep 8, 2022 at 12:10 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Sep 07, 2022 at 10:50:03AM +0200, Peter Zijlstra wrote:
> > On Tue, Sep 06, 2022 at 11:00:07PM -0700, Nick Desaulniers wrote:
> > > On Sun, Sep 4, 2022 at 11:02 PM Bill Wendling <morbo@google.com> wrote:
> > > >
> > > > On Sat, Sep 3, 2022 at 12:18 AM Kees Cook <keescook@chromium.org> wrote:
> > > > >
> > > > > On Fri, Sep 02, 2022 at 09:37:50PM +0000, Bill Wendling wrote:
> > > > > > [...]
> > > > > >         callq   *pv_ops+536(%rip)
> > > > >
> > > > > Do you know which pv_ops function is this? I can't figure out where
> > > > > pte_offset_kernel() gets converted into a pv_ops call....
> > > > >
> > > > This one is _paravirt_ident_64, I believe. I think that the original
> > > > issue Nathan was seeing was with another seemingly innocuous function.
> > >
> > > _paravirt_ident_64 is marked noinstr, which makes me suspect that it
> > > really needs to not be touched at all by the compiler for
> > > these...special features.
> >
> > My source tree sayeth:
> >
> >   u64 notrace _paravirt_ident_64(u64 x)
>
> I don't see noinstr either. But it seems a reasonable thing to do?
>
> Bill, does fixing up the noinstr macro and adding it here fix the
> problem?
>
[sorry for late response]

Let me give it a shot. I'll also test out Peter's suggestion, which
might be a better option in the long run. I suspect that we'll need to
devise similar patches for other places, but it shouldn't be hard to
find them all.

-bw

-bw
