Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106C84D0073
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241029AbiCGNwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237571AbiCGNwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:52:04 -0500
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C588BF55
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 05:51:08 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id g1so31052897ybe.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 05:51:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JapVBA42ANAFaik/R5R8oQrdBborYpBMhsREvW8QUhg=;
        b=T0xH5JDXg32O0/V+GFnmg9vPSXCp++Plln+RZx3Vh98q8Ig+rxJ/Kr0Qe53mnc26nJ
         YyFwUKaP8Rmm551Uq0IefU9k1gWYy+XrKYlBV89aKSkOgoPan6LmwBEMuezbi12anvH7
         TRAZ6LBvWOdOZj1K9Zi7oUFSWuAE6dee8MkaX2jkPd4ccZyEcnniZ9Pt61XE5tDVkaQ4
         yzC/nut9w4e57N6iyIU+icWZHi5rGn1DSxPWTLCdZkXWStg8yNSQlYz0xmKZNob+ukYq
         TrUDmvztDq+cPeUvhM+DtU91F5PjL6GDQVeZC9TjxtauvdMHB/YhwxhQIdHdY52XicCS
         ktuQ==
X-Gm-Message-State: AOAM530A1AyCvSMKgIoL7is3oMfXz46ss4N3nF4vcIm0tK257Gwb2eiZ
        f8oGhENtbAz4Ebexg/9j0Qv9QOrUKitp5jewq+A=
X-Google-Smtp-Source: ABdhPJzyJ/pxlRpHBhsQ4c7WUrBG0fwIJEahQfvXBm7VT/LXl4cWBLhkw2ufpCsBJZyKtWna67j3SNIds4KyuCFWoLg=
X-Received: by 2002:a25:2685:0:b0:629:1eee:81e1 with SMTP id
 m127-20020a252685000000b006291eee81e1mr6274535ybm.20.1646661067635; Mon, 07
 Mar 2022 05:51:07 -0800 (PST)
MIME-Version: 1.0
References: <20220304124416.1181029-1-mailhol.vincent@wanadoo.fr>
 <CAHp75VeT3LbdbSaiwcC2YW40LnA2h8ADtGva-CKU_xh8Edi0nw@mail.gmail.com>
 <20220307105810.1747024-1-alexandr.lobakin@intel.com> <CAK8P3a07uXLTpNz3t1oMwz_imZOTs+1Fw5hhELjUrJ8Zs=8bpQ@mail.gmail.com>
In-Reply-To: <CAK8P3a07uXLTpNz3t1oMwz_imZOTs+1Fw5hhELjUrJ8Zs=8bpQ@mail.gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Mon, 7 Mar 2022 22:50:56 +0900
Message-ID: <CAMZ6RqKaq8GiPYMyL4D1ksUtgketAF905oBgwKuGLtk7BmobZw@mail.gmail.com>
Subject: Re: [PATCH] linux/bits.h: fix -Wtype-limits warnings in GENMASK_INPUT_CHECK()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

Hi Arnd and Alexander,

Thanks for the support!

On Mon. 7 Mar 2022 at 21:15, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Mar 7, 2022 at 11:58 AM Alexander Lobakin
> <alexandr.lobakin@intel.com> wrote:
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Have you fixed W=1 warnings?
> > > Without fixing W=1 (which makes much more sense, when used with
> > > WERROR=y && COMPILE_TEST=y) this has no value.
> >
> > How is this connected?
> > When I do `make W=2 path/to/my/code`, I want to see the actual code
> > problems, not something that comes from the include files.
> > When I do `make W=2 path/to/new/code/from/lkml`, I want to see the
> > actual new warnings, not something coming from the includes.
> > It's much easier to overlook or miss some real warnings when the
> > stderr is being flooded by the warnings from the include files.
> > I'm aware there are some scripts to compare before/after, but I
> > don't want to use them just because "this has to value".
> > I don't want to do `make W=2 KCFLAGS='-Wno-shadow -Wno-type-limits'`
> > because then I'm not able to spot the actual shadow or type limit
> > problems in my/new code.
> > I fixed several `-Wshadow` warnings previously in the include files
> > related to networking, and *nobody* said "this has no value" or
> > NAKed it. And `-Wshadow` has always been in W=2.
>
> I agree: if we decide that W=2 warnings are completely useless, we should
> either remove the option to build a W=2 kernel or remove some of the warning
> flags that go into it. My feeling is that both W=2 in general, and the
> Wtype-limits have some value, and that reducing the number of W=2 by
> 30% as this patch does is a useful goal by itself.
>
> A different question is whether this particular patch is the best
> workaround for the warnings, or if a nicer alternative can be found,
> such as moving -Wtype-limits to W=3,

I disagree with moving it to W=3 for two reasons:

  1/ This would just move the issue elsewhere. If I had to
  compile with W=3 (which I admittedly *almost* never do), the
  -Wtype-limits spam would still be there.

  2/ After this patch, the number of remaining -Wtype-limits
  drops to only 431 for an allyesconfig (and I guess that there
  are a fair amount of true positives here). This warning is not
  *as broken* as people think. W=2 is a good place I think.

That said, moving it to W=3 would still solve the core issue: W=2
being spammed. Definitely not my favorite solution, but still an
acceptable consensus for me.

> or using an open-coded variant
> of __is_constexpr() that includes the comparison in a way that avoids the
> warning.

This is easier said than done. This is the __is_constexpr()
macro:

| #define __is_constexpr(x) \
|     (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))

Good luck doing an open-coded variant of it!

What I mean here is that there definitely might be a smarter
way than my solution to tackle the issue, but I could not see
it. If you have any concrete ideas, please do not hesitate to
share :)


Yours sincerely,
Vincent Mailhol
