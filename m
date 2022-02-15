Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684B54B5F21
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 01:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbiBOAeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 19:34:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiBOAeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 19:34:11 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360B512E9E8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 16:34:02 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id p22so261550lfu.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 16:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OFruwUIxpJyCAJe6BUEe5KI8KczW9wuSS9rT9U6kwk8=;
        b=pNkfZ896aqQt7dxFAL3iK96SFQ7NoXtb2Ceidw3enkYzd0BLbOWPp60JGJUW+qHpzP
         vha9n63h1RLvgzCbw3+jQYFWQaCzLQ8wumhFW1a9hER8FUDMo215I+ch3kf3QAL6E5le
         wfg+eWhQzKrURlsaORbokfcPD25ZrXZngEdKY8/wbtkEmsPhlHRQGKCU8+37fX7AlUNN
         gPxty3ifxG7Ps7xfxpJu+jdhDgHNM8RFfh2TCd3LMjiZINYDyDkRhodU0PCMXA9Xdmx3
         k1WO3HjmEjFYIwtTRi+Xapadzjmqc1y4DsUChFQjxHNF/kUwVYPM8/WaKLi3lTASQLbd
         rFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OFruwUIxpJyCAJe6BUEe5KI8KczW9wuSS9rT9U6kwk8=;
        b=FNONy5ss5EdS1bwCneEMwW257IFaxfaOowP/tG81D1nk22v+2Wh4MIpBmPj5vDVR+N
         xsKxrxkZgUi94v63oZx8gJD4Aq8RPt+1p6pFU/LU6PEhAmPz/f9viw67DDWHOqe6hrPu
         TxtyUOX0vE0gOw6XXo/g5tQO7HMgYTP6gFNSV6IpfHtuZL/1R0mOI6f87NaQ2uPl5bKS
         j+VOpSr/bd+uLVXa0kJuXp3JhUAiX6nkN24Eo7fm8MWETVV5rSOs9oKc1LPAy3Ot4kpx
         JW77IjGhm+YAPJITWhV6IEvwyjK+/FcFjysnTk0wU3FBNoUiqJ/J5DH++FDhK/DJfVGM
         AkZA==
X-Gm-Message-State: AOAM531sS7NUgdxK9iKkgVTlclyCUGgR9eZiKkAH2gGOz+WTGhmeBae9
        KSM0QOeSMNZvGvTS0TKqXVW4fS17zEXXrhqbDv+Gc8bOMnKEdg==
X-Google-Smtp-Source: ABdhPJx7Rb7z1GPvI6D+qTr0nkylaeunlTRJq2MplQYHe5RLznwDlYot8RNG7SMgUqUeiXfZAdP4E+Zw5G60wNR8oyI=
X-Received: by 2002:ac2:4e10:: with SMTP id e16mr1229400lfr.444.1644885240322;
 Mon, 14 Feb 2022 16:34:00 -0800 (PST)
MIME-Version: 1.0
References: <20220204005742.1222997-1-morbo@google.com> <20220210223134.233757-1-morbo@google.com>
 <cb2ff5da9b704a9792549a9433dc0ac8@AcuMS.aculab.com> <CAGG=3QXvSt=d94iqSV-Y9JVNc+pt-WOZGpSeW--fp=w2ttMvUA@mail.gmail.com>
 <CAKwvOdmqQ4M1pcz1BW+MTtRdwP3itOLcV83X+1nJQkf9BNJ7Fw@mail.gmail.com> <CAGG=3QWmp_nXH0nkREMwRcqAcBOmGFuDifsE5t=wNjDGkLMcgg@mail.gmail.com>
In-Reply-To: <CAGG=3QWmp_nXH0nkREMwRcqAcBOmGFuDifsE5t=wNjDGkLMcgg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 14 Feb 2022 16:33:48 -0800
Message-ID: <CAKwvOdms4Zcfn1fUTjQ4cHbVa2vSUj+YvCgR24xYGNf1tz4rOQ@mail.gmail.com>
Subject: Re: [PATCH v4] x86: use builtins to read eflags
To:     Bill Wendling <morbo@google.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Sat, Feb 12, 2022 at 1:23 AM Bill Wendling <morbo@google.com> wrote:
>
> On Fri, Feb 11, 2022 at 4:24 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> > I would like to discuss this further off list with you Bill before you
> > resend this patch again.
>
> That won't be necessary.

Bill,
I'm sorry; I could have worded that better+differently.

In code review, I tend to use phrases like "consider doing X" for
suggestions that are merely suggestions; things I don't care about.

I should have been more explicit that my concern regarding released
versions of clang and CONFIG_UNWINDER_ORC=y was not one of those
cases.

I like the intent of the patch; with the following fixups, I would
gladly sign off on it and encourage the x86 maintainers to consider it
further.
1. handle the case of released versions of clang and
CONFIG_UNWINDER_ORC=y. Something with a grep'able comment for clang-14
so we can clean that up when the minimally supported version of clang
is bumped.
2. update the commit message to refer to previous commits that
modified these flags, as per Thomas in response to v1.
3. Note no change in generated code from GCC, as per Thomas in
response to v2. Perhaps test a few more configs, since I only checked
kmem_cache_free yet native_save_fl and local_irq_save have MANY more
call sites.
4. Add `Link: https://github.com/llvm/llvm-project/issues/46875` to
commit message.

Optionally:
5. Add notes to commit message about the intent of this patch
improving profiles for kmem_cache_free for CONFIG_SLAB=y. Feel free to
use numbers I cited from our internal bug and
https://lore.kernel.org/lkml/CAKwvOdmXxmYgqEOT4vSbN60smSkQRcc3B5duQAhaaYoaDo=Riw@mail.gmail.com/.
6. Add note to commit message about memory operands from Agner Fog's
instruction tables in the above lore link.
7. Add note to commit that compilers can schedule the generated
instructions from the builtins among instructions from surrounding C
statements, which they cannot do for inline asm, as demonstrated by
https://godbolt.org/z/EsP1KTjxa.

Actually 7 is probably more precise than 3. Since there's no change
generally in terms of operands chosen AFAICT, but GCC (and clang)
could now better schedule instructions.

It's still a good patch; please stick with it!  Let me know how I can help.
-- 
Thanks,
~Nick Desaulniers
