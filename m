Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C272859FB3E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238185AbiHXNZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238130AbiHXNZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:25:18 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B5F2D1C8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 06:25:01 -0700 (PDT)
Received: from zn.tnic (p200300ea971b9859329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:9859:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4DB421EC056A;
        Wed, 24 Aug 2022 15:24:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1661347496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hvtVxhWrztDsZXHALGXRisb9QLUwGNxxI+ykol7ovVo=;
        b=Igt6T7VsheNVHQUMoO69O/uFLPp7VAdAhsrFKKwTrxalqZq+17xhfRkrVg23xurex9KpDu
        /MThpzGjF+UqrqaAsUToD9N6w3NsaVraXMOWKHY6egMnU98E7XsjxlbK2E9vcG1kZumei0
        wsg5NuIgX4mHx+ipvBNi9wX/4rN9DQ8=
Date:   Wed, 24 Aug 2022 15:24:52 +0200
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
Message-ID: <YwYmpK40ju5WUlVZ@zn.tnic>
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
 <20220812114438.1574-1-mailhol.vincent@wanadoo.fr>
 <20220812114438.1574-3-mailhol.vincent@wanadoo.fr>
 <YwT+5GGCOKoTjfQZ@zn.tnic>
 <CAKwvOdnc-Js8x4sv0j23crtYP73sRkNexom5ydm=r=8rYgc_5Q@mail.gmail.com>
 <YwUR35I7+5JbLvMM@zn.tnic>
 <CAMZ6Rq+-Ld41cXt+Qy3a7nkQrDp3RK-BJYW0j=HCyKH-x9S3tw@mail.gmail.com>
 <YwXkuW3rSYY7ZJT+@zn.tnic>
 <CAMZ6RqLugOnskOpyUS6OjdcdnwoXz-E8Bsw2qNaabDPYJ=139A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMZ6RqLugOnskOpyUS6OjdcdnwoXz-E8Bsw2qNaabDPYJ=139A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 09:10:59PM +0900, Vincent MAILHOL wrote:
> Not exactly, this is TZCNT for x86_64 but for x86, it will be BSF…

Not x86 - some old models which do not understand TZCNT, I'm being told.
And I'm being also told, "Intel and AMD disagree on what BSF does when
passed 0". So this is more mess.

> It means that __ffs() is not a x86_64 specific function. Each

No, not that. The comment "Undefined if no bit exists".

On my machine, __ffs(0) - the way it is implemented:

	rep; bsf %1,%0

is well-defined:

"If the input operand is zero, CF is set to 1 and the size (in bits) of
the input operand is written to the destination register. Otherwise, CF
is cleared."

Leading to

__ffs(0): 0x40

i.e., input operand of 64 bits.

So on this particular x86 implementation, TZCNT(0) is well defined.

So I'd like for that "undefined" thing to be expanded upon and
explained. Something along the lines of "the libc/compiler primitives'
*ffs(0) is undefined. Our inline asm helpers adhere to that behavior
even if the result they return for input operand of 0 is very well
defined."

Now, if there are some machines which do not adhere to the current hw
behavior, then they should be ALTERNATIVEd.

Better?

> > Back to your patch: I think the text should be fixed to say that both
> > ffs() and __ffs()'s kernel implementation doesn't have undefined results
> 
> NACK. __ffs(0) is an undefined behaviour (c.f. TZCNT instruction for

NACK, SCHMACK. Read my mail again: "I think the text should be fixed".
The *text* - not __ffs(0) itself. The *text* should be fixed to explain
what undefined means. See above too.

IOW, to start explaining this humongous mess I've scratched the surface
of.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
