Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CB059106A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 13:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238357AbiHLLz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 07:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbiHLLz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 07:55:26 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E039913D25
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 04:55:24 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-31f41584236so7610997b3.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 04:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=PNBikb0xhnt9Fd0jSSfSSfR2sxz3CzKFgt8jDKr0/dw=;
        b=lcUo442ghrp/dS1Q0h7zM135PL6rH+C4IpSqejJVhX0NsF2xPlMMf7Q1JMh0eR+b3I
         wCOBDIW86dnxUVzhS+u/IX2LcN5RMovhf6S9y6PC0tIgGbroVCS8pQlOMVkfOwHKa7TT
         VtLqvzYBP5wR33sgCk/ckYp4UwAb6axmKBjR26viS++M1wgKWmjXGVBVIRCk5GDinReT
         SrFISwDEIUfs5yX/fHaF3DWWLA65Nkm4uQ0AFhM9SQBFtg/W6klR5hjxsDI/XYWjVuXu
         rppgFtBUIvEv3sWU3dS4LHS5HzcPwxLc9d0Oio2RIxtcLC86r0YE0gwaNaeRU1GTzcJr
         1Aow==
X-Gm-Message-State: ACgBeo0JfshLWVxerXMoTHZGdQma0+/SKxD3px6RSClVGlVT2JK6tBon
        dP9AsJ2w/2LbW4WS/l/ULxphZQe61FQjWjTayB6rsJ6Sf5cjhQFy
X-Google-Smtp-Source: AA6agR5mr6Qg2/yIsE9vf+WvDD+w6wxmNJ+ViiqI3LaJ4g0funJYgF5sa8xR3gFlg+YxXSNd2uwbYac6mnjauNeJJQk=
X-Received: by 2002:a81:11c2:0:b0:31f:5a44:c0b7 with SMTP id
 185-20020a8111c2000000b0031f5a44c0b7mr3537115ywr.518.1660305324059; Fri, 12
 Aug 2022 04:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
 <20220723151521.51451-1-mailhol.vincent@wanadoo.fr> <20220723151521.51451-2-mailhol.vincent@wanadoo.fr>
 <YvUZVYxbOMcZtR5G@zn.tnic>
In-Reply-To: <YvUZVYxbOMcZtR5G@zn.tnic>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Fri, 12 Aug 2022 20:55:11 +0900
Message-ID: <CAMZ6Rq+k-5PKesdW7z9DdDMUNSKQR-c1qmQADvJ6VKZA2CM8nw@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 1/2] x86/asm/bitops: ffs: use __builtin_ffs to
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
        Josh Poimboeuf <jpoimboe@kernel.org>
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

Hi Borislav,

On Thu. 11 Aug 2022 at 23:59, Borislav Petkov <bp@alien8.de> wrote:
> On Sun, Jul 24, 2022 at 12:15:20AM +0900, Vincent Mailhol wrote:
> > For x86_64, the current ffs() implementation does not produce
> > optimized code when called with a constant expression. On the
> > contrary, the __builtin_ffs() function of both GCC and clang is able
> > to simplify the expression into a single instruction.
> >
> > * Example *
> >
> > Let's consider two dummy functions foo() and bar() as below:
> >
> > | #include <linux/bitops.h>
> > | #define CONST 0x01000000
>
> Those code examples you can simply indent with two spaces.
>
> > In both examples, we clearly see the benefit of using __builtin_ffs()
>
> Who's "we"?
>
> Please use passive voice in your commit message: no "we" or "I", etc,
> and describe your changes in imperative mood.
>
> > instead of the kernel's asm implementation for constant expressions.
> >
> > However, for non constant expressions, the ffs() asm version of the
> > kernel remains better for x86_64 because, contrary to GCC, it doesn't
> > emit the CMOV assembly instruction, c.f. [1] (noticeably, clang is
> > able optimize out the CMOV call).
> >
> > This patch uses the __builtin_constant_p() to select between the
>
> Avoid having "This patch" or "This commit" in the commit message. It is
> tautologically useless.
>
> Also, do
>
> $ git grep 'This patch' Documentation/process
>
> for more details.
>
> > kernel's ffs() and the __builtin_ffs() depending on whether the
> > argument is constant or not.
>
> In general, you don't have to say what the patch does - that should be
> visible from the diff. The more important part is the *why*. And that
> you do.
>
> Rest looks ok.

Thank you for the review!
I addressed all your comments and sent a v5:
https://lore.kernel.org/all/20220812114438.1574-1-mailhol.vincent@wanadoo.fr/


Yours sincerely,
Vincent Mailhol
