Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320F74C454C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbiBYNGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiBYNGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:06:52 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AFA1E5A63
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:06:20 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id j2so5839563ybu.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=91lfqerMyrhcvkt/Xxml96fIqw1rCGTngu2Yekjv2ZI=;
        b=E+tFHAQ5pyr27wKtgDUnzIAZDktAJK1JxSFWfkF+uK5aNwQybxvr9cfZBFwUHlYZZ0
         MK6E+8qKnHRMT2xPb+Y3izP3sho0aJIaHAWWU6WGuMItBEnSLrYkcV2CPRjJzz6ddAD8
         J+br2bR3zJSJbZ1lAl0Zvhjwde64U/c0dbzLVJokqOYSaVRdGySmQbY+mcgRVV91wJ/S
         S0gSuJmSMUVTB3rcIJiMxIy2B8ateNHDJ54h/N+KaemldpyDH7ioajAiIRB41VhZYbzZ
         2wUnoYDRvJ3UgTuByfaLZj+2wiy2OjRN7WW0Gev0AeiFZk/NzaBfeAurcujexBgjgpq9
         dmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=91lfqerMyrhcvkt/Xxml96fIqw1rCGTngu2Yekjv2ZI=;
        b=Ya1RIpM0EZC5YJlnz8U5z4/rkZbhr1mYrTJZps1GI/veaYRb/wrvxafCOHD/tAC3E8
         DMvDYb1FvkeWsRjmFLY0BafKZc1Ah1OktGLLD+493wrEqotzIm6hBjkl12Oq0YpkmM2J
         fN4PqR15xnDGb3Aax85sUznrsLyC762AVK6A7GspZuC/dF9lTjFSHDuNFu/3syW/9Af6
         2JHoeJzZtk+3Tsx1muFdmHlziQVMuS3wFWz+EanXbIe1gLjYWw2eSRLtg19VeQr8fgl5
         /NHERN2VQUVLVGmJ6+JaKFGtsL2p7KMYiU7643Orp3Alcw3nQ1HD/fp00vgxDIo22I12
         sJAg==
X-Gm-Message-State: AOAM531I/gIyNchzdE/B9+IWD2QwmuHrxre/scvm5iTqdbs2JUPT4+l3
        qqlkdsiZvFg4hyjcIy53H5jZrXGm6j5ALni10Y8Gxw==
X-Google-Smtp-Source: ABdhPJxnv0D/Higle+O11O1DFAqioIx1d2WO7mloPNrhUPfrQPNRwDoAfE17Xn9OXd9PJjOxozfDe+0uLf3STxtqJ9A=
X-Received: by 2002:a05:6902:2:b0:624:4cb5:fd3b with SMTP id
 l2-20020a056902000200b006244cb5fd3bmr7286257ybh.1.1645794379723; Fri, 25 Feb
 2022 05:06:19 -0800 (PST)
MIME-Version: 1.0
References: <20220225123953.3251327-1-alexandre.ghiti@canonical.com>
In-Reply-To: <20220225123953.3251327-1-alexandre.ghiti@canonical.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 25 Feb 2022 14:05:42 +0100
Message-ID: <CANpmjNN304EZfFN2zobxKGXbXWXAfr92nP1KvtR7j-YqSFShvQ@mail.gmail.com>
Subject: Re: [PATCH -fixes v3 0/6] Fixes KASAN and other along the way
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Nick Hu <nickhu@andestech.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
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

On Fri, 25 Feb 2022 at 13:40, Alexandre Ghiti
<alexandre.ghiti@canonical.com> wrote:
>
> As reported by Aleksandr, syzbot riscv is broken since commit
> 54c5639d8f50 ("riscv: Fix asan-stack clang build"). This commit actually
> breaks KASAN_INLINE which is not fixed in this series, that will come later
> when found.
>
> Nevertheless, this series fixes small things that made the syzbot
> configuration + KASAN_OUTLINE fail to boot.
>
> Note that even though the config at [1] boots fine with this series, I
> was not able to boot the small config at [2] which fails because
> kasan_poison receives a really weird address 0x4075706301000000 (maybe a
> kasan person could provide some hint about what happens below in
> do_ctors -> __asan_register_globals):

asan_register_globals is responsible for poisoning redzones around
globals. As hinted by 'do_ctors', it calls constructors, and in this
case a compiler-generated constructor that calls
__asan_register_globals with metadata generated by the compiler. That
metadata contains information about global variables. Note, these
constructors are called on initial boot, but also every time a kernel
module (that has globals) is loaded.

It may also be a toolchain issue, but it's hard to say. If you're
using GCC to test, try Clang (11 or later), and vice-versa.
