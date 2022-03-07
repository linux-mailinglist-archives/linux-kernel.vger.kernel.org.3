Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F2C4D00B3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236783AbiCGOHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236976AbiCGOHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:07:13 -0500
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A188D695
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 06:06:18 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2dbd97f9bfcso164962497b3.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 06:06:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=st/f+0iO0UDzjkNWhcsOsygYrvFCRtgzkkkSRKcKsWc=;
        b=EGmGbR6QJchstZuNcWhdV6v0l9ElqdRUhuBVbso6eeBWcGLJYHwPCncrIYkpRxhme8
         CgCjYctVv1lA50pWihpweYJNR3JT5FzJwAg82x3xAQ7Iwy5WdxrPY6F94WeRX4MNxO+L
         dqPxYihg41OO0JNOMZE5C6Ce9QsNFVwMFI4IwHhFxeVWwSvKj6uSh3ni+Ys2axD/edPU
         q4kqgkOS0q6EMUYdz88l01kY0kqssT9ZmzkHQYmgVHHTJ4mSFc+uOo2hw9wWfJSZZJAc
         Bq6FEyqbRC8UaUeV1HzGyTK1ESX8QnR6wBOfzoCHvAnzp2YwTQ8zraN7kJlKGV4WvUqe
         DX8Q==
X-Gm-Message-State: AOAM532cOiXm0gxNX21+f/zOZODpdF69nko1F1RUehiF9o9QzykEjhUo
        s9nMbmFpMD5UPe7+GaIgvCWwLHc3faid/6kImbQ=
X-Google-Smtp-Source: ABdhPJyYfadWONCgpTahtOhc3za7pA4oZ0BDgV1sMzwEWBAzo4HcHDww/j8AJoYj+y74RlwFvKAKH1QpFd33er5+Row=
X-Received: by 2002:a81:6bc6:0:b0:2db:fe24:d5ee with SMTP id
 g189-20020a816bc6000000b002dbfe24d5eemr8306756ywc.392.1646661977922; Mon, 07
 Mar 2022 06:06:17 -0800 (PST)
MIME-Version: 1.0
References: <20220304124416.1181029-1-mailhol.vincent@wanadoo.fr>
 <CAHp75VeT3LbdbSaiwcC2YW40LnA2h8ADtGva-CKU_xh8Edi0nw@mail.gmail.com>
 <20220307105810.1747024-1-alexandr.lobakin@intel.com> <CAHp75Vcht_T5kUJu5zjmsUvn+mN+8D5vWBUvRXKTfo+2ocHOTg@mail.gmail.com>
In-Reply-To: <CAHp75Vcht_T5kUJu5zjmsUvn+mN+8D5vWBUvRXKTfo+2ocHOTg@mail.gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Mon, 7 Mar 2022 23:06:06 +0900
Message-ID: <CAMZ6RqK=yxLwVnotZuGRiao4Vu4eFEfVXfPaZV1r4rEOmQARig@mail.gmail.com>
Subject: Re: [PATCH] linux/bits.h: fix -Wtype-limits warnings in GENMASK_INPUT_CHECK()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>
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

On Mon. 7 Mar 2022 at 22:40, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> On Mon, Mar 7, 2022 at 1:00 PM Alexander Lobakin
> <alexandr.lobakin@intel.com> wrote:
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Date: Fri, 4 Mar 2022 20:46:08 +0200
> > > On Fri, Mar 4, 2022 at 7:36 PM Vincent Mailhol
> > > <mailhol.vincent@wanadoo.fr> wrote:
> > >
> > > > This pattern is harmless but because it occurs in header files
> > > > (example find_first_bit() from linux/find.h [1]) and because of the
> > > > include hell, the macro GENMASK_INPUT_CHECK() is accountable for 31%
> > > > (164714/532484) of all warnings when compiling all modules at W=2
> > > > level.
> >
> > Nice catch, thanks! I wanted to submit the very same fix, but
> > postponed it for some reason, and now here we are.
> >
> > > Have you fixed W=1 warnings?
> > > Without fixing W=1 (which makes much more sense, when used with
> > > WERROR=y && COMPILE_TEST=y) this has no value.
> >
> > How is this connected?
>
> By priorities.
> I don't see much value in fixing W=2 per se if the code doesn't compile for W=1.

*My code* compiles for W=1. For me, fixing this W=2 in the next in line
if speaking of priorities.

I do not understand why I should be forbidden to fix a W=2 in the
file which I am maintaining on the grounds that some code to which
I do not care still has some W=1.

> > When I do `make W=2 path/to/my/code`, I want to see the actual code
> > problems, not something that comes from the include files.
> > When I do `make W=2 path/to/new/code/from/lkml`, I want to see the
> > actual new warnings, not something coming from the includes.
> > It's much easier to overlook or miss some real warnings when the
> > stderr is being flooded by the warnings from the include files.
> > I'm aware there are some scripts to compare before/after, but I
> > don't want to use them just because "this has to value".
>
> I rephrased above.
>
> > I don't want to do `make W=2 KCFLAGS='-Wno-shadow -Wno-type-limits'`
> > because then I'm not able to spot the actual shadow or type limit
> > problems in my/new code.
> > I fixed several `-Wshadow` warnings previously in the include files
> > related to networking, and *nobody* said "this has no value" or
> > NAKed it. And `-Wshadow` has always been in W=2.
>
> Yes, because people rarely enable COMPILE_TEST + WERROR.
> To be clear, my comment is given in that scope.

And my comments are given in a different scope: a developer who
wants to solve the issue for his *own* file without being spammed.


Yours sincerely,
Vincent Mailhol
