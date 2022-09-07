Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69B55AFF92
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiIGIux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiIGIup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:50:45 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB99D40561
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 01:50:43 -0700 (PDT)
Received: from nazgul.tnic (unknown [84.201.196.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 163A41EC04F0;
        Wed,  7 Sep 2022 10:50:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1662540638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Xp7hEi4p44/YaMgw6I5ghs8SKRBZzu64Qfp4lEGDVUE=;
        b=rdnbgqVqTpHwwG1pYwF2zHuScR2Z1tHcze6vuIuRCEbTr5UMuW4JmyssZgyMjlWc/uT4lw
        rBKsLyw3Xhj3Y5hKJqKhjqyj7eRxbGSH3pmSaHEDNGosWXgdYG5zf8cYf1EO45r5pNTO7T
        ylGrelCoW526O3cMffELufeIKytaqIs=
Date:   Wed, 7 Sep 2022 10:50:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
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
Subject: Re: [PATCH v5 2/2] x86/asm/bitops: __ffs,ffz: use __builtin_ctzl to
 evaluate constant expressions
Message-ID: <YxhbXE0lWtyNtRHh@nazgul.tnic>
References: <YwT+5GGCOKoTjfQZ@zn.tnic>
 <CAKwvOdnc-Js8x4sv0j23crtYP73sRkNexom5ydm=r=8rYgc_5Q@mail.gmail.com>
 <YwUR35I7+5JbLvMM@zn.tnic>
 <CAMZ6Rq+-Ld41cXt+Qy3a7nkQrDp3RK-BJYW0j=HCyKH-x9S3tw@mail.gmail.com>
 <YwXkuW3rSYY7ZJT+@zn.tnic>
 <CAMZ6RqLugOnskOpyUS6OjdcdnwoXz-E8Bsw2qNaabDPYJ=139A@mail.gmail.com>
 <YwYmpK40ju5WUlVZ@zn.tnic>
 <CAMZ6RqJSdbbpFw7iZBqmADY0cAhjzFkpqs+VWCfFM_P0P-wH6w@mail.gmail.com>
 <YxgY2MBmBIkBsdlu@nazgul.tnic>
 <CAMZ6Rq+Uo4r9DXsOTgEhNEv7wWkHjBnU0498+1++qaD+4WCPKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMZ6Rq+Uo4r9DXsOTgEhNEv7wWkHjBnU0498+1++qaD+4WCPKw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 02:35:41PM +0900, Vincent MAILHOL wrote:
> I rephrased the beginning of the commit message as below:
> 
> 
> If x is not 0, __ffs(x) is equivalent to:
>   (unsigned long)__builtin_ctzl(x)
> And if x is not ~0UL, ffz(x) is equivalent to:
>   (unsigned long)__builtin_ctzl(~x)
> Because __builting_ctzl() returns an int, a cast to (unsigned long) is
> necessary to avoid potential warnings on implicit casts.
> 
> Concerning the edge cases, __builtin_ctzl(0) is always undefined,
> whereas __ffs(0) and ffz(~0UL) may or may not be defined, depending on
> the processor. Regardless, for both functions, developers are asked to
> check against 0 or ~0UL so replacing __ffs() or ffz() by
> __builting_ctzl() is safe.
> 
> 
> 
> Does this solve the issue?

Yes, that sounds better.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
