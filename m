Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC3E527E62
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240952AbiEPHP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240848AbiEPHPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:15:51 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34591180E;
        Mon, 16 May 2022 00:15:49 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id k8so11642023qki.8;
        Mon, 16 May 2022 00:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gKXNI3Zjy78U+ofmRrxvJNCYBgPtz8fzKvkASRSdlaE=;
        b=UKLX3FT3sCG/8qDrhem4Ev7QA9RRMEy05hY0L1GBCElVWJP+Rj2hZdh/OQb+LiJhh4
         b5A30TIAmzCp6Whxrx2S9iU+Lg8hdJoOMVsyUu+0liicRrLSFqaAtHpI7gEj6JGrZI62
         6Bnk1QDdAH1wY7a77y8Z0pdWoX1sNCfP5UXbWOq6gSnkR70OAkrvs5UiBL6evAClm4vd
         qImk1MAU0XrLUUDq7GUDgk8jVtC/3004lc+9wb6bemGFRLT7HK8ep7RV66r+qOPnVoRZ
         NK+vohG/2iPUoFeK4UXEcgjQ6KEx2ogsybfXvYIO22pmTcVzRhKE+cwijd/VJ+RNeSjS
         6YSQ==
X-Gm-Message-State: AOAM53038CPdBanyz9dEY80xfTYLGOh1TtorMlqDy1LYhyGIZFzQGB4T
        QRvOTqkA6SadzXUpWYjczbWJ+D3g4CDxKg==
X-Google-Smtp-Source: ABdhPJzxTDQACrWXU5Pt/gAt+77vQxpG0pvauTm4JCosfAAl4bgTNuNB8NFot82GXYk5E4UPRTdurg==
X-Received: by 2002:a05:620a:458b:b0:6a0:3399:c9dd with SMTP id bp11-20020a05620a458b00b006a03399c9ddmr11162882qkb.630.1652685348737;
        Mon, 16 May 2022 00:15:48 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id x2-20020a05620a14a200b0069fc13ce20fsm5452409qkj.64.2022.05.16.00.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 00:15:48 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2fee9fe48c2so21003927b3.3;
        Mon, 16 May 2022 00:15:48 -0700 (PDT)
X-Received: by 2002:a0d:f002:0:b0:2fe:cfba:d597 with SMTP id
 z2-20020a0df002000000b002fecfbad597mr9720916ywe.502.1652685347986; Mon, 16
 May 2022 00:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220513064952.3610672-1-gerg@linux-m68k.org> <CAMuHMdVWRM7U9_SxbtDUE0a-sB5_PDiO2009Cu3QKMP3wNc=yw@mail.gmail.com>
 <2532419a-812b-c2de-ef56-849ec7dc16bc@linux-m68k.org> <CAK8P3a3RuOTidFpW7diHekJ6POV20SBb5PhSF943Ju1xAtOxNw@mail.gmail.com>
 <5d546c21-169c-cacc-6ca3-becf54876f7f@linux-m68k.org>
In-Reply-To: <5d546c21-169c-cacc-6ca3-becf54876f7f@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 16 May 2022 09:15:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVdWhKJ4Lwr1RaDXsc1b6_J0Hnjv4d+r1q=Fd3qhQ_WLQ@mail.gmail.com>
Message-ID: <CAMuHMdVdWhKJ4Lwr1RaDXsc1b6_J0Hnjv4d+r1q=Fd3qhQ_WLQ@mail.gmail.com>
Subject: Re: [PATCH] m68knommu: fix undefined reference to `mach_get_rtc_pll'
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
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

On Mon, May 16, 2022 at 8:08 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
> On 13/5/22 22:59, Arnd Bergmann wrote:
> > On Fri, May 13, 2022 at 2:25 PM Greg Ungerer <gerg@linux-m68k.org> wrote:
> >> On 13/5/22 17:12, Geert Uytterhoeven wrote:
> >>> read_persistent_clock64() uses mach_hwclk(), which is provided by
> >>> both setup_mm.c and setup_no.c, so it's always available?> Albeit not populated by coldfire or nommu platform code, so I see
> >>> the point in depending on MMU (no nommu Amiga support yet ;-).
> >>
> >> Yes, exactly. And even worse is that on ColdFire platforms it
> >> is never set, so will be the startup value of NULL. It is called
> >> without checking for NULL in both of rtc_generic_get_time() and
> >> rtc_generic_set_time().
> >
> > I think that's ok because rtc_generic_{get,set}_time is only called
> > from the rtc_generic driver, but that is not registered when mach_hwclk()
> > is NULL.
> >
> > With your patch to add the CONFIG_MMU check, you can actually
> > remove the mach_hwclk() symbol from setup_no.c, and move the
> > remaining RTC related symbols from setup_mm.c into the #ifdef.
>
> Yes, I think that would be a good idea.
> Tidies thins up a little.

Let's fix the build error first.

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
