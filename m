Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EBB582123
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiG0Hdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiG0Hdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:33:49 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78DE41989
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:33:46 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id v10so6154052uap.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K9terHDd9pBkdhpb5Lv3MDxyCeJPbC9WTivXosPfkwc=;
        b=G8MHYFcRGoVn8IWTYMUJRGERsrgiwCYpqbzuMvOUhSpbr8AkUsGiaRKtCgfKzFtbJM
         rBwDsqY1KnTEEsNLBbI2oNTCfOC2Zqyc/M9Htmv/yBJrybNE5GeEe7Z+iN/5t3o5VyE7
         ao3WHhq84IJNGIDYAdlWRAg610Q65td9W9zxCttaxtweHhlqYzkM4hm6iCPVPpaYsE2b
         IJ9YLUM2Oog8Y36nU9bMJM3ajmKtkgcMRldNZfy0dpzZqERRz2uK0yjqcYTyu9TpuEBz
         mFxYw6GF2nBj/nxyrja8KguYqUnrqdbueBV8f0wl1FipHtOPMwyUNJNXGREr2s1xiUvA
         cNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K9terHDd9pBkdhpb5Lv3MDxyCeJPbC9WTivXosPfkwc=;
        b=lzwwM6xi8hF0y6lEyWc3lIAEZe4g6t13X5/qeFx968NYc6jqOa/uUC3ZuduDuhVlqy
         CQ4Dh0vkgVxoTbe7B1MnlOs/3T8ApZotvghK0ZEvT1PNLWY6C3hA9fkVzioOjCwCqTbr
         5Srne1q0poiFFFfy1kZIYhXFBqLjBxs0kSu1ti+FCfCQTaYjEod03AxhEqdGBbyt87s/
         2x66j5Hb2DpZggvCFaaKSA7dPIbyFD16LfV02+ecNrCisTQlp9xlyAR2PQ4wcFgzpY3M
         A0P6FXY6XlTqkcJFWLSHl0KjxBDXouYw55rEfuepJyXEJe6kk/LvMi7I5r1WLxNWWa55
         WyWQ==
X-Gm-Message-State: AJIora9yiO5nhqB/Wef3YvJPy7diUI3Z7TTblK3hbXIHw68JgYRNiA1v
        9+ehJzuDfIrRBY6RnHm7ajW/JLAzVO4NjSe92TieFA==
X-Google-Smtp-Source: AGRyM1tyrcIEL5rRtfSf0gB+xBL0hOYD1HPltgyDD9tfK7isrIJRcuW4HZ6+26nBiYdGrw+yaTY4EG8VtL5MM98TZdc=
X-Received: by 2002:ab0:32d8:0:b0:384:cced:87fb with SMTP id
 f24-20020ab032d8000000b00384cced87fbmr1982709uao.52.1658907225945; Wed, 27
 Jul 2022 00:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220711162713.2467476-1-dlatypov@google.com> <20220711204859.3DDD5C34115@smtp.kernel.org>
 <CAGS_qxqxGfQ5tA063XoRbL1ktimyfmt+CuucJ_rsYVnoi4i7gw@mail.gmail.com>
 <CABVgOS=bm5TmEBd8jxuTPJy426OgC14ryqn4FLQR1pHNf5uhsw@mail.gmail.com> <20220726200741.2DDA2C433C1@smtp.kernel.org>
In-Reply-To: <20220726200741.2DDA2C433C1@smtp.kernel.org>
From:   David Gow <davidgow@google.com>
Date:   Wed, 27 Jul 2022 15:33:34 +0800
Message-ID: <CABVgOS=rvmh1n_-iW9UvYQ95oOvOoOu6m6+FN+2RTUKDEinb0A@mail.gmail.com>
Subject: Re: [PATCH] clk: explicitly disable CONFIG_UML_PCI_OVER_VIRTIO in .kunitconfig
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-clk@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 4:07 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting David Gow (2022-07-11 23:44:08)
> >
> > So, as I understand it, casting a regular pointer to an __iomem
> > pointer (as the clk test does) isn't technically correct, though it
> > does work on almost every architecture out there. If we want some way
> > of intercepting I/O access, then then that'll need to be handled by
> > the various read()/write() functions.
>
> Yep. It's test code though so it seemed ok at the time.
>
> >
> > UML doesn't support iomem at all out of the box, and logic_iomem is a
> > way of implementing it which allow us to attach handler functions to
> > blocks of memory, albeit with more constraints about what addresses
> > get used. Brendan started implementing a "fake hardware" interface on
> > top of this here, though it's still in-progress:
> > https://kunit-review.googlesource.com/c/linux/+/5272/4
>
> Cool.
>
> >
> > Ultimately, I think the 'correct' solution here will be
> > logic_iomem-based, but doing that nicely will probably require one of
> > two things:
> > - logic_iomem to support non-UML architectures as well (becoming a
> > generic "insert a 'fake' device here" system)
> > - logic_iomem to have some way of "passing through" access to an io
> > memory region through to the normal underlying memory.
> >
> > Ideally, we'll have both, and maybe even defaults which will allow
> > hacks like this to continue working (perhaps with a warning?). That'll
> > require some significant (and probably not uncontroversial) work on
> > how iomem accesses work in general, though, possibly with performance
> > impact.
>
> Does it matter to pass through to real iomem? I'd think we wouldn't want
> to actually affect real hardware in test code. Instead we'd like to fake
> it and then look at the result, like how the clk test works.
>

The only case I'm worried about is where real iomem is necessary to
boot to the point where tests run. It won't affect UML, but if you
were (e.g.) running tests as modules on real hardware (or under qemu),
and iomem was required to access the disk containing these modules,
that would be a case for having both real and fake iomem supported on
the same system.

Given the sheer number of things which depend on iomem in some regard,
I suspect this'd affect pretty much every architecture except UML.

> >
> > The other option of using function redirection on the io read()
> > write() functions exists, and would be a bit simpler in the
> > short-term, but would probably result in a lot of tests reimplementing
> > this, and also would have some performance impacts, as the I/O
> > accesses wouldn't be able to be inlined if KUNIT is enabled.
> >
>
> That sounds OK to me because nobody is enabling KUNIT in production,
> right?

As Daniel noted, Android is looking at enabling KUNIT in production
(but tainting the system if any actual tests run). That's a pretty
unusual use-case, though, so it definitely doesn't preclude people
from redirecting functions, particularly if ftrace-based stubbing is
used to avoid the overhead when disabled (though I can't recall if
that works on ARM, so Android might be out of luck for those tests
anyway...)

But yeah, I'm definitely not considering the potential performance
impact a blocker here, just something to be aware of.

Either way, neither the stubbing support or the logic_iomem stuff is
quite ready yet, so disabling CONFIG_UML_PCI_OVER_VIRTIO is the right
solution in the meantime.

Cheers,
-- David
