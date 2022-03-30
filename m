Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D23F4EBB74
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 09:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243627AbiC3HJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 03:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243633AbiC3HIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 03:08:52 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413AA103B9C;
        Wed, 30 Mar 2022 00:07:08 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id r11so13963943ila.1;
        Wed, 30 Mar 2022 00:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=MuSE8ky/YceVzy94b3kF16ekfJW+aB742cvLMQSQXSc=;
        b=aiLiPnzSFaRsLmcV+nHV728jY8NpNqOFPlm6EriArKzB9bht+1+FVZuhgnF+ZEzBnn
         +DcmewQq00yCh9OqbMDJbQW2LU/9w8DkophPSSOXfO20P1gSJAQAx1k6aPBMGxaZmdXg
         KtXRLy02yD/3QXxiA5i6+hVaJ9NU8TWnFtXYFQNG1yzyJ87cK61qx341oIou7oYt7M/2
         xKOeMjRKdGAqGUYYfCcffF5qauE5jeTnoieNAP4GM92i7rDpsPHpiDU4snG3MsnSphpF
         uwm9lyg9s/J8kHLLvvG5fijWjnKr0cN7xxzyhOTDfj8vynLPGUYylQgJS5CeYKOTOR1x
         ZLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=MuSE8ky/YceVzy94b3kF16ekfJW+aB742cvLMQSQXSc=;
        b=yeIYZt8vRyISkkSFrecPjg+3EjZh9eG0+zYRUsxBYB1Tc3hArrWR3pgXa/mgLFkZFL
         twQOaimdJ7tySrq0Yt8ScyRfQkifysFiDrZCf3B+hRAOr4aNZx47teyHpdW4Iw+IDYZ5
         Ye6j/OT/mhyWY/dGfoUGLkysKjR8c6pDNu5AGU7mcVzEekAkLydWnxQmITumf9HuXiJS
         7N5ob4eTsewenVocruFDvOsJ23OnMLNF28ufxl5fVEtw/9sHiVeiroJrKPbHWB06zSX+
         ot8xGox9SRl3OMG9+fpVVYMa7vbJbcp5EvU6QtT5xCQHd1LuDLuj3Iq/I+dO9JNBodv/
         ttHA==
X-Gm-Message-State: AOAM530ebVq78bOPd2KvdbNMafSVyj1I6MxYlMOip52KUaOSFQ8kwv82
        D2AuPx9EKEGg3/iursE75z/cp3caNAiakm8UCFo9Igr5Xy/fO9Yr
X-Google-Smtp-Source: ABdhPJzu1O69f+bLYnC4Zpv50cvaTavd6euepP3ejQNOZAnD+mbkEDOqJiDElsztL7SRsMXc7ei+NPYIECbs1SgSwAw=
X-Received: by 2002:a92:cda6:0:b0:2c8:8289:c31 with SMTP id
 g6-20020a92cda6000000b002c882890c31mr9715967ild.245.1648624027317; Wed, 30
 Mar 2022 00:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220329021437.308790-1-masahiroy@kernel.org> <CAKwvOd=z5BQcQnhkgMOpZXPLkggmdPo=jvZxXkfVG7D8GuEYRw@mail.gmail.com>
In-Reply-To: <CAKwvOd=z5BQcQnhkgMOpZXPLkggmdPo=jvZxXkfVG7D8GuEYRw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 30 Mar 2022 09:06:31 +0200
Message-ID: <CA+icZUUWCAfyznemv6cUYKQSTtPO+9ww7v8oLxK=Hd2o6gMNbg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: fix empty ${PYTHON} in scripts/link-vmlinux.sh
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
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

On Wed, Mar 30, 2022 at 5:17 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Mar 28, 2022 at 7:15 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > The two commits
> >
> >   d8d2d38275c1 ("kbuild: remove PYTHON variable")
> >   a8cccdd95473 ("init: lto: ensure initcall ordering")
> >
> > were applied in the same development cycle, in two different trees.
> >
> > After they were merged together, this ${PYTHON} expands to an empty
> > string.
> >
> > Therefore, ${srctree}/scripts/jobserver-exec is executed directly.
> > (it has the executable bit set)
> >
> > This is working but let's fix the code into the intended form.
>
> Thanks for the patch!
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>

Good catch.
I was not aware that scripts/jobserver-exec was executable.
Debian/unstable now switched to python v3.10.x as default "python3"
and I will have this patch in my next series for testing.
Thanks.

Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>

- Sedat -


> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/link-vmlinux.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> > index f704034ebbe6..20f44504a644 100755
> > --- a/scripts/link-vmlinux.sh
> > +++ b/scripts/link-vmlinux.sh
> > @@ -50,7 +50,7 @@ gen_initcalls()
> >  {
> >         info GEN .tmp_initcalls.lds
> >
> > -       ${PYTHON} ${srctree}/scripts/jobserver-exec             \
> > +       ${PYTHON3} ${srctree}/scripts/jobserver-exec            \
> >         ${PERL} ${srctree}/scripts/generate_initcall_order.pl   \
> >                 ${KBUILD_VMLINUX_OBJS} ${KBUILD_VMLINUX_LIBS}   \
> >                 > .tmp_initcalls.lds
> > --
> > 2.32.0
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
