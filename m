Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1AA59F57D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 10:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbiHXInv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 04:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbiHXInt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 04:43:49 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5F57DF4B
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 01:43:46 -0700 (PDT)
Received: from zn.tnic (p200300ea971b9893329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:9893:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0D93D1EC0409;
        Wed, 24 Aug 2022 10:43:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1661330621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qcWk8Yx08d0RoRr1+RIQ+X/8WT+atfVDHthN60oeDWM=;
        b=oLSjZPneA3ztrhjjn34BmCI/4WgMyeV6rnJ9x2Kc2yVvaSTkFWCLnZcuxXoGQzRZO4986w
        4kVoULl9n3KBDDUcMLL4LFElP1DqjUzm+7UevY2kLafsZP5FbbtuxC5OcoUeV6HOlsWkzF
        Jc9TQGEr9q/o6lvGuv+umAhXxxzMTdw=
Date:   Wed, 24 Aug 2022 10:43:37 +0200
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
Message-ID: <YwXkuW3rSYY7ZJT+@zn.tnic>
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
 <20220812114438.1574-1-mailhol.vincent@wanadoo.fr>
 <20220812114438.1574-3-mailhol.vincent@wanadoo.fr>
 <YwT+5GGCOKoTjfQZ@zn.tnic>
 <CAKwvOdnc-Js8x4sv0j23crtYP73sRkNexom5ydm=r=8rYgc_5Q@mail.gmail.com>
 <YwUR35I7+5JbLvMM@zn.tnic>
 <CAMZ6Rq+-Ld41cXt+Qy3a7nkQrDp3RK-BJYW0j=HCyKH-x9S3tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMZ6Rq+-Ld41cXt+Qy3a7nkQrDp3RK-BJYW0j=HCyKH-x9S3tw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 05:31:20AM +0900, Vincent MAILHOL wrote:
> If the fact that __ffs(0) is undefined is a concern,

So what is of concern is I'm looking at those *ffs things and they look
like a real mess:

 * Undefined if no bit exists, so code should check against 0 first.
 */
static __always_inline unsigned long __ffs(unsigned long word)
{
        asm("rep; bsf %1,%0"

and that's TZCNT.

And nowhere in TZCNT's description does it talk about undefined behavior
- it is all defined.

So I have no clue what that comment is supposed to mean?

Then:

 * ffs - find first set bit in word
 * @x: the word to search
 *
 * This is defined the same way as the libc and compiler builtin ffs
 * routines, therefore differs in spirit from the other bitops.
 *
 * ffs(value) returns 0 if value is 0 or the position of the first
 * set bit if value is nonzero. The first (least significant) bit
 * is at position 1.

while

"Built-in Function: int __builtin_ctz (unsigned int x)

    Returns the number of trailing 0-bits in x, starting at the least significant bit position. If x is 0, the result is undefined."

as previously pasted.

So ffs() doesn't have undefined behavior either.

I guess it wants to say, it is undefined in the *respective* libc or
compiler helper implementation. And that should be explained.

> I can add a safety net:

Nah, no need. It seems this "behavior" has been the case a long time so
callers should know better (or have burned themselves properly :)).

> There is an index issue. __ffs() starts at 0 but ffs() starts at one.
> i.e.: __ffs(0x01) is 0 but ffs(0x01) is 1.
> Aside from the zero edge case, ffs(x) equals __ffs(x) + 1. This
> explains why __fss(0) is undefined.

I'd love to drop the undefined thing and start counting at 1 while
keeping the 0 case the special one.

But that ship has sailed a long time ago - look at all the __ffs() and
ffs() callers.

Back to your patch: I think the text should be fixed to say that both
ffs() and __ffs()'s kernel implementation doesn't have undefined results
but since it needs to adhere to the libc variants' API, it treats 0
differently. They surely can handle 0 as input.

I.e., I'd like to see a comment there explaining the whole difference
between ffs() and __ffs() so that people are aware.

Btw, pls do

s/variable___ffs/variable__ffs/g

Two underscores are just fine.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
