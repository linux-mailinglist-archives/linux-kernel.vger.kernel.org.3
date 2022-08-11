Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A04858FEAA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 16:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbiHKO7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 10:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbiHKO7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:59:44 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5922A6F549
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 07:59:43 -0700 (PDT)
Received: from zn.tnic (p200300ea971b9854329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:9854:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E43F51EC064A;
        Thu, 11 Aug 2022 16:59:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660229978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GeFK2lgYVqxhWRQuhMQEmc/VC301WwhF62rP4d0xu88=;
        b=dLaL7GWuRmMHmcxfVxRhTvwSphjJdZG7TKtQK58CjRFYOl36RMjQHxj4vpia0fve4YMh4P
        PTrMVIuBgYHgyrZWD9Xsw/TzDkaijJ+9x9JuW4tQbTWfvU/RjHRmWvZZKdTSdOrjBJY+Yz
        MPcDNn0Iwh6W7fNwr04lh6xokt5FTcI=
Date:   Thu, 11 Aug 2022 16:59:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
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
Subject: Re: [RESEND PATCH v4 1/2] x86/asm/bitops: ffs: use __builtin_ffs to
 evaluate constant expressions
Message-ID: <YvUZVYxbOMcZtR5G@zn.tnic>
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
 <20220723151521.51451-1-mailhol.vincent@wanadoo.fr>
 <20220723151521.51451-2-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220723151521.51451-2-mailhol.vincent@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 12:15:20AM +0900, Vincent Mailhol wrote:
> For x86_64, the current ffs() implementation does not produce
> optimized code when called with a constant expression. On the
> contrary, the __builtin_ffs() function of both GCC and clang is able
> to simplify the expression into a single instruction.
> 
> * Example *
> 
> Let's consider two dummy functions foo() and bar() as below:
> 
> | #include <linux/bitops.h>
> | #define CONST 0x01000000

Those code examples you can simply indent with two spaces.

> In both examples, we clearly see the benefit of using __builtin_ffs()

Who's "we"?

Please use passive voice in your commit message: no "we" or "I", etc,
and describe your changes in imperative mood.

> instead of the kernel's asm implementation for constant expressions.
> 
> However, for non constant expressions, the ffs() asm version of the
> kernel remains better for x86_64 because, contrary to GCC, it doesn't
> emit the CMOV assembly instruction, c.f. [1] (noticeably, clang is
> able optimize out the CMOV call).
> 
> This patch uses the __builtin_constant_p() to select between the

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

> kernel's ffs() and the __builtin_ffs() depending on whether the
> argument is constant or not.

In general, you don't have to say what the patch does - that should be
visible from the diff. The more important part is the *why*. And that
you do.

Rest looks ok.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
