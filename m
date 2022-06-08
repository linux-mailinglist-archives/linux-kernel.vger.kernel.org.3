Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9254543D56
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 22:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiFHUHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 16:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiFHUH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 16:07:28 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062161D0CF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 13:07:24 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id q1so43572282ejz.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 13:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZuMrWXkULkBDGlmsnHz4J4K87p642Pa6n5p0SpJC58U=;
        b=VJXIyE1t2dbJB1WiNhgxAyflpNWBLomOQZcjjbgmoF9Pa/ntwr9nvi0Ji1dDmIo/7c
         kG3KBj6C915FwIlBPvXCgkHtBH6M/yzD3upAlSVc7ORjrC1UQcHxoVi6Od1rnwbNCra9
         +4pe76XUh2jNNqYMPudEZ/TEPYG5fiVtPwSQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZuMrWXkULkBDGlmsnHz4J4K87p642Pa6n5p0SpJC58U=;
        b=wj4CV8gGR1k0WmB+PrL3OYKoMwSYxnHWCn3tYQ8A+tWUSZ94LUv6cxYrylUjTAAXDe
         Djry5kyI8ewqCwI1luxiOpCfe2xBfH+Q3xFgRyiSwuIkyDKkDxAj1B7QzYsT8tn/YHiG
         42pKGZt6sZLcSawDS4Kl+/SePpVqCOGj2xPxWZKASzmZRhTEPlJkCmknL3mX9FIVxBsH
         sllSq0j9jxoilKdQvYypF1HOUKFacy/y2XuK9HDI1VEQzG5ggdMwHf0gcXtM4ZMj10hD
         DZVsGTqUCskr5kRmvGKE3knTxSFRh1SYhNnjlDjrWJCWRYfFidCioeAv4wnAkHwGIjlZ
         oi4w==
X-Gm-Message-State: AOAM533tfCfU2w52U2RjrKpIa3D4n62vLaXPJ5kzvWQpBZ2TkbDJ5V1m
        ZywLye5WobdZQ0fPL5xAVYxCpeWFlVKUrFja
X-Google-Smtp-Source: ABdhPJzhLMUbwn14yZdv6suLEPxwIqp/7dVtCaEeKOYIlYZ3arHxOLHRyTd1wngzKN7NyS1SLGlIHw==
X-Received: by 2002:a17:906:c834:b0:6ff:4275:1e4e with SMTP id dd20-20020a170906c83400b006ff42751e4emr17375721ejb.121.1654718842916;
        Wed, 08 Jun 2022 13:07:22 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id jt2-20020a170906dfc200b006f4cb79d9a8sm9601490ejc.75.2022.06.08.13.07.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 13:07:22 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id a15so21208702wrh.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 13:07:21 -0700 (PDT)
X-Received: by 2002:a5d:414d:0:b0:213:be00:a35 with SMTP id
 c13-20020a5d414d000000b00213be000a35mr28253388wrq.97.1654718841642; Wed, 08
 Jun 2022 13:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220422134308.1613610-1-svens@linux.ibm.com> <202204221052.85D0C427@keescook>
In-Reply-To: <202204221052.85D0C427@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Jun 2022 13:07:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjahn2fZtMxmc4D9UOUGWVws1wZ=X46jrTV=_tEpzXeoA@mail.gmail.com>
Message-ID: <CAHk-=wjahn2fZtMxmc4D9UOUGWVws1wZ=X46jrTV=_tEpzXeoA@mail.gmail.com>
Subject: Re: [PATCH] s390: disable -Warray-bounds
To:     Kees Cook <keescook@chromium.org>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coming back to this, because my rc2 week tends to be quiet as people
take a breather, and as such a good time for me to do system upgrades.

And gcc-12 dropped in Fedora 36, and shows problems on x86 too.

So I suspect we'll have to disable -Warray-bounds globally on gcc-12,
not just on s390.

Unless Kees has patches ready to go already.

Some of the warnings look potentially simple, ie

   struct mbus_dram_target_info;

in <linux/mbus.h> has the comment

         *   [..]  Peripherals are
         * required to support at least 4 decode windows.

and then as a result has

        int             num_cs;
        struct mbus_dram_window {
           [..]
        } cs[4];

and that "cs[4]" looks just bogus - it can be a much larger array, the
'4' is just a minimum. The real limit is that 'num_cs' one.

But there's a *lot* of warnings, and many of them are due to this, and
while some are obvious, others aren't.

There are other things too in gcc-12 that seem half-baked. I was
interested to see the new '-Wdangling-pointer' thing, but then when I
looked at it, the two cases I looked at were just bogus, so ..

                     Linus

On Fri, Apr 22, 2022 at 10:54 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Apr 22, 2022 at 03:43:08PM +0200, Sven Schnelle wrote:
> > gcc-12 shows a lot of array bound warnings on s390. This is caused
> > by our S390_lowcore macro:
> >
> > which uses an hardcoded address of 0. Wrapping that with
> > absolute_pointer() works, but gcc no longer knows that a 12 bit
> > instruction is sufficient to access lowcore. So it emits instructions
> > like 'lghi %r1,0; l %rx,xxx(%r1)' instead of a single load/store
> > instruction. As s390 stores variables often read/written in lowcore,
> > this is considered problematic. Therefore disable -Warray-bounds on
> > s390 for now until there is a better real solution.
> >
> > Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
>
> It looks like the source of this problem (the literal-values-treated-as-NULL)
> is gcc-12 specific. From the discussions, it sounded like Jacob was
> going to fix this "correctly" in gcc-13. It might be a good idea to make
> this version-checked? (i.e. only disable on gcc-12)
