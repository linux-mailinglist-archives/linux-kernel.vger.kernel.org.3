Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4985720CE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbiGLQ1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbiGLQ0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:26:34 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF708CC019
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:26:22 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id i186so8306088vsc.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yc6YXnNVL61q+QUGaIhVOre8jSccirUVb8sqMkVrX9c=;
        b=LsNq0warVVX+8zijyaGLKwZxd85OPS4s3YIqFk6/bKfHtq2L8GpADGvZXQbEzXVLFa
         8GQrzzldl95+RP0pUe3GMAovzJDZJ1JzMbO1Hm0y0xg5fA8pLddlxuCSG8V7p0oLBdmo
         xXydF2rMyI86OJOOE18GDMBH/EksdlSu81br8Kz7TmsseXRnbyHcwADSKxpQHD6Ag8GM
         I3M4AWtZwHPxOQLRzVK4Lj7Te+Ay62avCHlyU1BQqGqVEzTxUB1cQLWVffjzrMIptqc3
         chmh/AkHlD95aE893qAKY13CpXWGVCkL9tQrI0nmVX88nfC9vMPCb6mIEqsKMs9BnCBo
         AgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yc6YXnNVL61q+QUGaIhVOre8jSccirUVb8sqMkVrX9c=;
        b=X+1TXWILo4rmL5uDIyQFTSv2oEQenFF3yaSER0d0516lBFzIxRdO0RudnEDMBFL72M
         e+BHwzW20CnenX9LNOqJWEkPC8eSvcDn8QE2N1ikmo1Co/dVXgKDDjjDB+Ro1HcgfdFw
         uqXbZU2E/3mUgImS/3ItvL/UDUug5yYx3tD3Qaw2C9xyR7KsB32rSYNZ77SJy7p4HJXS
         z11JJvb7sQxNG2j/JwCMuu6fe8YD02EofMhpScIg2CsQJm48l9itQnYHq4iO4ZiDRfQD
         1oie2DeFfv7+R+kgiYJlaT1Z/fv0DECOR/CnH5fxbcltxieeXynEQLendbtV3zxJODaV
         9R1w==
X-Gm-Message-State: AJIora/0FDFkCdpy9F+DX2y51ZTQ1oXjP1zdT2C18RR+eg95zv/vlBYQ
        9xk0D89G3ZdFCM+sAmdHOHbFmhmqK8sMS5KSv6M=
X-Google-Smtp-Source: AGRyM1sn55QtslIMX6fUep3gArNIJ8Ftpa4qLDEde2Q9HFgL1X88NxObWCITye/Xgr3rtG6yRvbKqXfvoSY46bxHceY=
X-Received: by 2002:a67:df04:0:b0:356:f32d:148d with SMTP id
 s4-20020a67df04000000b00356f32d148dmr9226267vsk.60.1657643181852; Tue, 12 Jul
 2022 09:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220711044711.466822-1-yury.norov@gmail.com> <CAHp75Vf8EhRYWdQN6Oc79GzWCvo-sRJDvy7_Aek_Z63GCu2dMQ@mail.gmail.com>
In-Reply-To: <CAHp75Vf8EhRYWdQN6Oc79GzWCvo-sRJDvy7_Aek_Z63GCu2dMQ@mail.gmail.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Tue, 12 Jul 2022 09:26:10 -0700
Message-ID: <CAAH8bW_RYG_Tbpip=BkSFAymDm2y3jJBqTi0PJWA=H-a-L_3tg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] lib/find: add find_nth_bit()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Kees Cook <keescook@chromium.org>,
        Keith Busch <kbusch@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
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

On Mon, Jul 11, 2022 at 1:55 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Jul 11, 2022 at 6:51 AM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > Kernel lacks for a function that searches for Nth bit in a bitmap.
> > Usually people do it like this:
> >         for_each_set_bit(bit, mask, size)
> >                 if (--n == 0)
> >                         return bit;
> >
> > Which is not so elegant, and very slow.
> >
> > This series adds fast routines for this task, and applies them where
> > appropriate.
> >
> > While here, move thin wrappers around find_bit() in nodemask.c to a
> > corresponding header, and because nodemask.c is empty after that,
> > remove it.
> >
> > v1: https://lore.kernel.org/lkml/20220706182300.70862-4-yury.norov@gmail.com/T/
> > v2: - count Nth bit from 0 (was 1);
> >     - use 'invert' trick in _find_nth_bit(), as in _find_next_bit();
> >     - cleanup comments;
> >     - fns() is kept inline - looking at __ffs() generic implementation,
> >       I decided to keep it untouched.
>
> Two observations:
> 1) your patches are not versioned (hint: use `git format-patch
> --thread -vX --cover-letter ...`, where X is a version you want to
> give);

OK

> 2) fns() is not good abbreviation, because among ffs (First) and fls
> (Last), fns would be read as Next, which is misleading, I'm not sure
> fnths(), which is correct, is good for readers.

I agree that fns() may be confusing, but fnths() is even worse to me.
I expect that it will be mostly used indirectly via find_nth_bit(), and
will not create a lot of confusion for users.

Thanks,
Yury
