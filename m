Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBEBB5AFAF6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 06:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiIGEG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 00:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiIGEGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 00:06:55 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21397D792
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 21:06:54 -0700 (PDT)
Received: from nazgul.tnic (unknown [84.201.196.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6786E1EC068F;
        Wed,  7 Sep 2022 06:06:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1662523609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oF8uyun+ouCeH4rU0Sgny6nXLM0tjw0TQ71zarK9tig=;
        b=I66wrZ08yscrWobgTr7tjuBmYVub0sMgs1pmnJ2jRbXAi7RAAscCJHcTwJKc5ZcMnGu1VR
        8+rc3rFQ9+g2ra5WsruBdluAyQ/YcsIGwA9+G89xQZiLoWl3bEZ8vR6O4QFMht8Z1yScjM
        clZ7EIynTYl84Kq+6QPYN9ZbsnKgW+A=
Date:   Wed, 7 Sep 2022 06:06:58 +0200
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
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH v5 2/2] x86/asm/bitops: __ffs,ffz: use __builtin_ctzl to
 evaluate constant expressions
Message-ID: <YxgY2MBmBIkBsdlu@nazgul.tnic>
References: <20220812114438.1574-1-mailhol.vincent@wanadoo.fr>
 <20220812114438.1574-3-mailhol.vincent@wanadoo.fr>
 <YwT+5GGCOKoTjfQZ@zn.tnic>
 <CAKwvOdnc-Js8x4sv0j23crtYP73sRkNexom5ydm=r=8rYgc_5Q@mail.gmail.com>
 <YwUR35I7+5JbLvMM@zn.tnic>
 <CAMZ6Rq+-Ld41cXt+Qy3a7nkQrDp3RK-BJYW0j=HCyKH-x9S3tw@mail.gmail.com>
 <YwXkuW3rSYY7ZJT+@zn.tnic>
 <CAMZ6RqLugOnskOpyUS6OjdcdnwoXz-E8Bsw2qNaabDPYJ=139A@mail.gmail.com>
 <YwYmpK40ju5WUlVZ@zn.tnic>
 <CAMZ6RqJSdbbpFw7iZBqmADY0cAhjzFkpqs+VWCfFM_P0P-wH6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMZ6RqJSdbbpFw7iZBqmADY0cAhjzFkpqs+VWCfFM_P0P-wH6w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2022 at 06:32:05AM +0900, Vincent MAILHOL wrote:
> Agree that this is only the surface. But, my patch series is about
> constant folding, not about the text of *ffs(). Here, I just *move*
> the existing text, I did not modify anything.
> Can we agree that this is a separate topic?

Sure we can.

But then you can't start your commit message with:

"__ffs(x) is equivalent to (unsigned long)__builtin_ctzl(x) and ffz(x)
is equivalent to (unsigned long)__builtin_ctzl(~x)."

which will bring unenlightened readers like me into the very same mess.

So at least mention that there's a difference between the kernel
implementation using hw insns which are well defined on some machines
and what the glibc API does. So that at least people are aware that
there's something dangerous to be cautious about.

Ok?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
