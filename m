Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3610E5A00B6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 19:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239430AbiHXRuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 13:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238320AbiHXRun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 13:50:43 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97722BC84
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:50:41 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id f4so13267346qkl.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=sDYCJ3jg9yuLE/OMVMOyabundH0O0Kkzt1VVF9Ipbj4=;
        b=ebK9tYay7XA+KAvD/bOK4BDp4VZTZQcqRrb04F9PHRUd8v+bfJF6j05/fRvQje4XH5
         BA8P8gO5L8YwW31/Z+m8HaDNeoQHCAqCreI5/MBAtUVFl2m8WkJ/DaI8HBWF5NCOHqMc
         WPxDIk6U6eLQTCKyqwVqrpkHCN6ky7kS0Jpu4pnmS+f9+OHaOig7ULVpP1onLzIYjwLW
         XcPiK/NVpN3QqQ4Voc6Lt94wR0eiCvKJ8lH+7/+zGVoGIQkaPJ8+uU4p9brNVV5309Zf
         m6el0TSdSAjIyP/vODh+eSf9kTzk2Zs1PZSVBNCymQKYt9xnkhC9CZn0IzBtSzgH8x3h
         cGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=sDYCJ3jg9yuLE/OMVMOyabundH0O0Kkzt1VVF9Ipbj4=;
        b=b9eRMfexifxsRMBniJNrERizGkrKIlJBp/oO+KmEScpjhEb2F3pujpyXum87T1tRjN
         XS4QPFnhgbrVzpLITdHFnbuHw/GjAwovMaCObyFASiBkaiHJ0CNw4nd/KIGYbBumz41A
         fmBvVnUoq/a/VSR9EqlssGKNsTQtJbYJp96Lr6oWGXws8nH577CaJPfW+mDjC9xowG7u
         /UaBP/AXiqOsXYhm1d1kr2c5iwvreXhArrPsFMa8KZFD0iIP/kDXeMtP34E2SvFEn6tG
         E3BTSOcrSehRsR/jOig+iFshWZVOF8A2v5/ZhkyWykU1K+BXRoDv7wqne7BSQkM7yESx
         pi/w==
X-Gm-Message-State: ACgBeo0cM050Q1SvHH/f1Ywj1CZAjv6CBfjPeG35ytfu1SNJjWPRBLIu
        vIYU/t/svds2udGeUIuADB/2ZY+0CL11nzS4Rzk=
X-Google-Smtp-Source: AA6agR682IddhhKuXMr9KdEsKiZTMTpJgMITlfiYL1c2SvhhI67WytoRie+lEiUVZmuGIRgHh5F0nW6pLUu4Ow3jFyM=
X-Received: by 2002:a05:620a:288a:b0:6b8:fcfe:db02 with SMTP id
 j10-20020a05620a288a00b006b8fcfedb02mr325985qkp.504.1661363440720; Wed, 24
 Aug 2022 10:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220824012624.2826445-1-yury.norov@gmail.com>
 <20220824012624.2826445-3-yury.norov@gmail.com> <CAHp75VdgXBFH_vxUNYZLc2ahOrC8oBj0x=2GWXZr+CLGX1qyTg@mail.gmail.com>
 <YwYpqRZxCe9NLZyk@yury-laptop>
In-Reply-To: <YwYpqRZxCe9NLZyk@yury-laptop>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 24 Aug 2022 20:50:04 +0300
Message-ID: <CAHp75VccfouBXXNNdehB-G_N6P-Ah8VyogcY4c7kSyW2f3VAKg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] lib/find_bit: create find_first_zero_bit_le()
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dennis Zhou <dennis@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexey Klimov <aklimov@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Whitcroft <apw@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 4:37 PM Yury Norov <yury.norov@gmail.com> wrote:
> On Wed, Aug 24, 2022 at 12:22:33PM +0300, Andy Shevchenko wrote:
> > On Wed, Aug 24, 2022 at 5:17 AM Yury Norov <yury.norov@gmail.com> wrote:

...

> > > Like other find_*_le() functions, the new one takes void *addr, instead
> > > of unsigned long *. This should be fixed for all in a separate series.
> >
> > From this comment it is unclear to me why we can't fix them first and
> > then apply this with the correct type?
>
> Because there is a codebase that relies on existing types, mostly in
> filesystem code. And those fs fixes would require 5 or 6 patches.
>
> This would triple the length of this series, and is completely
> unrelated. That's why I think that:
>         > > This should be fixed for all in a separate series.

So comment update then, if a new version is required?

...

> > > +#define word_op swab
> > > +#include "find_bit.h"
> >
> > Looking at this, I would rather always require to define __ffs_word_op
> > (or whatever name) in the user and replace #ifndef in the find_bit.h
> > with
> > #error "The __ffs_word_op must be defined before including find_bit.h!"
>
> This is a local header which is not intended to be included anywhere
> except lib/find_bit{,_be}.c. I don't expect someone else would want to
> include it, even in lib. So what you suggest is a bit overthinking to
> me. But if you insist, I can do that.

Basically by the above you assured me that #error is the right
approach, please do it that way and we will definitely catch the
incorrect users (even by `git grep -lw __ffs_word_op` if they slip
into the kernel somehow).

-- 
With Best Regards,
Andy Shevchenko
