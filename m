Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6C85AFBCD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 07:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiIGFgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 01:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiIGFf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 01:35:56 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9AC72FC1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 22:35:54 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 130so14391230ybz.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 22:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=vdL0JRw13DKnZIvgWCrjye4WeG1glTwaTkY0rU3yNtQ=;
        b=E7Amsg8JJMFe/At6cNPX5M3W6ULyiKUKC0LqZZbB6YPmWWHg9Zec0fPThMnkb+3llQ
         4eG1BpSIrBWdA7OqvPKI7N7xE5mGR9ssMbQJaBXvd3Wc/gYXwHhFq8YsV4gDjKHEPvHG
         PE6UpHNoii0zPILyxH42fawmVQzaxKxZ6QhXgLY1fYmRrA2c+/tUdlOBgcfRCPsskx4q
         9xveD9t2OCOv+03GTQHquQl9YjW74ulM6vdXO/Qkbm7npP6qn6/saDTpCC46nckXCfrm
         7m4CApkHcxl3ale/ZUHEPgHun/rJmkJM3vVQhabi+72Fae4oVLoS3IHXaioxxpY4c/X2
         5xfw==
X-Gm-Message-State: ACgBeo393QQgITnjPuZOdE4pRJJMvSLDVD01s9OCN67RU53cnCf+l2Zl
        i1ZijCNpqLNjvjbne5Q9j+7vPagiP0lpLpyDBKo=
X-Google-Smtp-Source: AA6agR4Mx3wcE7MiMBb1qrE0qoDdUpOdSsO3PayqlaD5SOV0ihZUNupGfrf4kxbOeVtJYKonXIoDGMsJXOg7K/Qp4r8=
X-Received: by 2002:a25:e6cf:0:b0:6a9:9c99:d8a3 with SMTP id
 d198-20020a25e6cf000000b006a99c99d8a3mr1492965ybh.500.1662528953184; Tue, 06
 Sep 2022 22:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220812114438.1574-1-mailhol.vincent@wanadoo.fr>
 <20220812114438.1574-3-mailhol.vincent@wanadoo.fr> <YwT+5GGCOKoTjfQZ@zn.tnic>
 <CAKwvOdnc-Js8x4sv0j23crtYP73sRkNexom5ydm=r=8rYgc_5Q@mail.gmail.com>
 <YwUR35I7+5JbLvMM@zn.tnic> <CAMZ6Rq+-Ld41cXt+Qy3a7nkQrDp3RK-BJYW0j=HCyKH-x9S3tw@mail.gmail.com>
 <YwXkuW3rSYY7ZJT+@zn.tnic> <CAMZ6RqLugOnskOpyUS6OjdcdnwoXz-E8Bsw2qNaabDPYJ=139A@mail.gmail.com>
 <YwYmpK40ju5WUlVZ@zn.tnic> <CAMZ6RqJSdbbpFw7iZBqmADY0cAhjzFkpqs+VWCfFM_P0P-wH6w@mail.gmail.com>
 <YxgY2MBmBIkBsdlu@nazgul.tnic>
In-Reply-To: <YxgY2MBmBIkBsdlu@nazgul.tnic>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 7 Sep 2022 14:35:41 +0900
Message-ID: <CAMZ6Rq+Uo4r9DXsOTgEhNEv7wWkHjBnU0498+1++qaD+4WCPKw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] x86/asm/bitops: __ffs,ffz: use __builtin_ctzl to
 evaluate constant expressions
To:     Borislav Petkov <bp@alien8.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, David Howells <dhowells@redhat.com>,
        Jan Beulich <JBeulich@suse.com>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        Joe Perches <joe@perches.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Yury Norov <yury.norov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed. 7 Sep 2022 at 13:06, Borislav Petkov <bp@alien8.de> wrote:
> On Sat, Aug 27, 2022 at 06:32:05AM +0900, Vincent MAILHOL wrote:
> > Agree that this is only the surface. But, my patch series is about
> > constant folding, not about the text of *ffs(). Here, I just *move*
> > the existing text, I did not modify anything.
> > Can we agree that this is a separate topic?
>
> Sure we can.
>
> But then you can't start your commit message with:
>
> "__ffs(x) is equivalent to (unsigned long)__builtin_ctzl(x) and ffz(x)
> is equivalent to (unsigned long)__builtin_ctzl(~x)."
>
> which will bring unenlightened readers like me into the very same mess.
>
> So at least mention that there's a difference between the kernel
> implementation using hw insns which are well defined on some machines
> and what the glibc API does. So that at least people are aware that
> there's something dangerous to be cautious about.
>
> Ok?

OK.

I rephrased the beginning of the commit message as below:


If x is not 0, __ffs(x) is equivalent to:
  (unsigned long)__builtin_ctzl(x)
And if x is not ~0UL, ffz(x) is equivalent to:
  (unsigned long)__builtin_ctzl(~x)
Because __builting_ctzl() returns an int, a cast to (unsigned long) is
necessary to avoid potential warnings on implicit casts.

Concerning the edge cases, __builtin_ctzl(0) is always undefined,
whereas __ffs(0) and ffz(~0UL) may or may not be defined, depending on
the processor. Regardless, for both functions, developers are asked to
check against 0 or ~0UL so replacing __ffs() or ffz() by
__builting_ctzl() is safe.



Does this solve the issue? If yes, I will prepare the v8 right away.

Yours sincerely,
Vincent Mailhol
