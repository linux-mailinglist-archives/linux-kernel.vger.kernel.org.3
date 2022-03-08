Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D0C4D1727
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 13:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346631AbiCHMVm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 8 Mar 2022 07:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbiCHMVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 07:21:40 -0500
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D403D45508
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 04:20:43 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id u10so17542314ybd.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 04:20:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8JVjoa74iunmuwBgS5aLlTqz0b8LZXNDf+BjGGWzCus=;
        b=pMje7NmLIME+STwntbPQ4DzVjBZ1upS/ggOZoZMlc/Jzjb8K0+1iYxrLFxP3zRe2LJ
         0rSk07dLYQ3TH6hqfkrjNTYUPF2fXCDLsH1i/yJLUjW8rCG2y+C+60Sz03dTcDYcRL3w
         axJC7kK7aATDt4NhpP487KLRBW8JU2KA3+94vty1hfzip+VT2mL3L3whrQC6miRgIUou
         UK9iTc6FrsGXNf+67z70N93i10Kw/SmHjS/IWtP15MU6vwjyS66XIFPWUWZAb/wuM7p/
         +fwf/E7oaJY6FLnTp2kwAPMxgJ1p5HODAUA2DkSSRO6XWZThS6VdbRX0znslxE/9rdUU
         neug==
X-Gm-Message-State: AOAM531BcF7bGOgjb5T7gHU+Fe7QUyfJyF5TZr14f0bqHzYpan538nDj
        ys+9LxO+oxDr8/2SpmRV+/hugFRdtXajKRA0UQl2aDFL6v0u9Q==
X-Google-Smtp-Source: ABdhPJzr9rb7gyoBmLyI7npg9emZ4/qU600ZA9EwdWEKYWBu+zv0/s48iVh8IG1ZssW7B5kBeayXqfuDiP6d/csCbXU=
X-Received: by 2002:a25:d2d0:0:b0:628:7d69:b598 with SMTP id
 j199-20020a25d2d0000000b006287d69b598mr12208517ybg.381.1646742042945; Tue, 08
 Mar 2022 04:20:42 -0800 (PST)
MIME-Version: 1.0
References: <20220304124416.1181029-1-mailhol.vincent@wanadoo.fr>
 <CAHp75VeT3LbdbSaiwcC2YW40LnA2h8ADtGva-CKU_xh8Edi0nw@mail.gmail.com>
 <20220307105810.1747024-1-alexandr.lobakin@intel.com> <CAK8P3a07uXLTpNz3t1oMwz_imZOTs+1Fw5hhELjUrJ8Zs=8bpQ@mail.gmail.com>
 <CAMZ6RqKaq8GiPYMyL4D1ksUtgketAF905oBgwKuGLtk7BmobZw@mail.gmail.com>
 <20220307150750.1762040-1-alexandr.lobakin@intel.com> <CAHp75VfXeo0rrKB74t7gJOcv4CEnkByucE+Sa1hT2GTap=oQNA@mail.gmail.com>
In-Reply-To: <CAHp75VfXeo0rrKB74t7gJOcv4CEnkByucE+Sa1hT2GTap=oQNA@mail.gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 8 Mar 2022 21:20:32 +0900
Message-ID: <CAMZ6RqKPicgiU15g3xkFD15-TVsSYTyxNqkCEYVn2EpzrmJcNw@mail.gmail.com>
Subject: Re: [PATCH] linux/bits.h: fix -Wtype-limits warnings in GENMASK_INPUT_CHECK()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue. 8 Mar 2022 à 01:30, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> On Mon, Mar 7, 2022 at 5:10 PM Alexander Lobakin
> <alexandr.lobakin@intel.com> wrote:
> > From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
> > Date: Mon, 7 Mar 2022 22:50:56 +0900
>
> ...
>
> > For example, people tend to make the following mistake:
> >
> >         unsigned int i;
> >
> >         for (i = 0; i ...) {
> >                 ret = setup_something(array[i]);
> >                 if (ret)
> >                         goto unroll;
> >         }
> >
> > unroll:
> >         while (--i)
> >                 unroll_something(array[i]);
> >
> > The loop will never end as `i` was declared as unsigned.
> > -Wtype-limits catches this.
>
> This looks like a wrapping value issue, not sure if the type limits
> makes logical sense. What I'm saying is that the waning is
> controversial. It may help or it may make noise.
>
> > Not speaking of checking unsigned variables on < 0:
> >
> >         unsigned int num;
> >
> >         /* calculate_something() returns the number of something
> >          * or -ERRNO in case of an error
> >          */
> >         num = calculate_something();
> >         if (num < 0)
> >                 ...
>
> Depends on the context. Here is a mistake, but there are plenty of
> cases when it's okay to do so.

I am curious to see which case you are thinking of.

Personally, I see two cases, both with macro:

  1/ Cases similar to GENMASK_INPUT_CHECK() in which the macro is
  made for generic purpose and in which there was no way to know
  in advance that one parameter would be unsigned and the other
  zero.

  2/ Comparaison again a macro which might or might not be
  zero. e.g.:

#ifdef FOO
#define BAR 42
#else
#define BAR 0
#endif

void baz(void)
{
        unsigned int i;

        if (i > BAR) /* yields -Wtype-limits if FOO is not defined. */
}

And because of those two false positives, moving it to W=2 was a
wise choice.

But I am not aware of any use cases outside of macro where doing
an:

unsigned int num;
/* ... */
if (num < 0)

would be okay. At best it is dead code, at worse, it is a bug as
pointed out by Alexander.

I am not sure what I am missing here.

> And in the above the variable name is
> misleading with its semantics, The proper code should be
>
>   unsigned int num;
>   int ret;
>
>   ret = ...
>   if (ret < 0)
>     ...
>   num = ret;
>
> Again, the warning is controversial in my opinion.
>
> --
> With Best Regards,
> Andy Shevchenko
