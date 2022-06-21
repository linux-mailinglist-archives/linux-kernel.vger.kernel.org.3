Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181D25537B8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353916AbiFUQRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353848AbiFUQQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:16:59 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548FBCE29
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 09:16:58 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t25so23197273lfg.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 09:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ygOru1V+CqPdzVlc6g44G4+f/031CtJpK0ffalP9wKU=;
        b=ALJuFmJ2MgWHsuPdnOlWpIyCex1dQSuCHk/q8YBpxShXJT0+RwR/eiW/lM3EwY8BkE
         JxAx4j5NqMwY6W132S4o14HPBRTVQf1eO8Pt+Dr3GmnKV4muxrKAl1O8QGy68M51ipQl
         vk2SiezwIGLezoPwDEA2c5p4XsZm9LIO9eMaYy5uG5g4PJGsgmwIDeuiGNW/RBA6U3Xx
         vJh4/o+nmEivSp/gQCzsr7cUKJrIxBU/sG0soxK5OHfpJpNaaqL3IHqL+lyESjHuVyGk
         2+0JFYZVnJBkYz8Q0xIE3j2nsmoCGPbBaTAZzLSdsGZCP0UpZNOZ3xofoQ2IaZRKCnU9
         YNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ygOru1V+CqPdzVlc6g44G4+f/031CtJpK0ffalP9wKU=;
        b=Ic5h4enuihftm5ZWBKBG4Tu/Ee997t0YehRx04HDLBNNAH1zioZo0W7grEH6T6SmDQ
         EUGbZP55PeMVvzs2NkX83KtEbLDXfed8yNRDOxXSgE5Egn5tEVv6zEdvO7GRHoDDDdFu
         MIDYI8sd6UvpgWuUu6fIdv7Q3Z612Mi6ytA3ILBFAWdYb9S+209frw1ZyAei8+mBslYQ
         OHVks/nkfPqlkrxz43zMrLFhv1+qy/grRFqDmj4kgqqSxMY+UfyMe5cOuwTOqbULCbnr
         Nk69zPozGcVZoueXa8UP5vyUNMGcM4KEe7EQbPQxlW/BaJRovZIBOldsDjWseDFFiSQg
         0ggA==
X-Gm-Message-State: AJIora93d5PrUV5SVQmblAeJU77Ut0+Mxr2qd7gWLzG6JP5Z/G113IJk
        Na4IDHVeKvrr6b4JimRaAnTN8OYmb93sbHW/qKB8Sw==
X-Google-Smtp-Source: AGRyM1vl1kY/rfhG1ekDV3os5WgRq3Ow+TaCeNvDbKOJv/JFufeYfnJVlZvB6TAjyXdD2IgK0AXe8ylYTmXYo/BB1uQ=
X-Received: by 2002:ac2:4d22:0:b0:47f:65b5:35ec with SMTP id
 h2-20020ac24d22000000b0047f65b535ecmr8877385lfk.432.1655828216350; Tue, 21
 Jun 2022 09:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220621133526.29662-1-mikoxyzzz@gmail.com>
In-Reply-To: <20220621133526.29662-1-mikoxyzzz@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 21 Jun 2022 09:16:45 -0700
Message-ID: <CAKwvOd=Bmu40+_11GOBTeJBjToUf0LNG_RX0RiLcRLimUUkgcw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Kconfig: -O3 enablement
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Miko Larsson <mikoxyzzz@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sean Christopherson <seanjc@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Chris Down <chris@chrisdown.name>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Oleksandr Natalenko <oleksandr@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 6:35 AM Miko Larsson <mikoxyzzz@gmail.com> wrote:
>
> Hi,
>
> This very small series allows -O3 to be used for all architectures. The
> first patch marks -O3 as experimental, with the reasoning being that it
> might expose unwanted regressions to users, and the second patch
> actually allows -O3 by removing the "depend on ARC" string.

I think we should just remove -O3 support from KCONFIG.

If someone wants to mess around with "experimental features," there's
nothing stopping you from doing:

$ make KCFLAGS=-O3

>
> The reasoning behind this series is to open up -O3 so that bugs related
> to it (both compiler-related and kernel-related) can be discovered by
> eyeballs wanting to improve the "-O3 experience," as that might be
> beneficial to both compilers and the kernel. This has been attempted
> before [1], but unfortunately nothing ever came of it.
>
> [1] https://lore.kernel.org/lkml/20191211104619.114557-1-oleksandr@redhat.com/
>
> Cc: linux-kbuild@vger.kernel.org
> Cc: x86@kernel.org
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Chris Down <chris@chrisdown.name>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: Elliot Berman <quic_eberman@quicinc.com>
> Cc: Oleksandr Natalenko <oleksandr@redhat.com>
>
> Miko Larsson (2):
>   Kconfig: Mark -O3 as experimental
>   Kconfig: Allow -O3 for all architectures
>
>  init/Kconfig | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> --
> 2.36.1
>


-- 
Thanks,
~Nick Desaulniers
