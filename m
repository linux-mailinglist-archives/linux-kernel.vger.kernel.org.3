Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A064E3393
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 23:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiCUWy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 18:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiCUWyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:54:36 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13A13CE87B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:33:13 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id q14so8509954ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BH/ZvdHwavygsraND3jZ9umdlqtC3J2xs3HpZjL2mwo=;
        b=c9f3Pm5IXTpo39kOd0g++gJvtwaFhoqGjkoHxlqOe7Xi1L7cCP3CuQXXRVkJjdLjuo
         IE79P2+w5wFiYpdJmX0ofyWAZYycl34hnsS8D4ynzd82H5n4Ly8vXdsyUlivtGQuBnmL
         b9SF9v0advLxASxQduWy0nkNPxJMmDIwkXSzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BH/ZvdHwavygsraND3jZ9umdlqtC3J2xs3HpZjL2mwo=;
        b=IwIAJOGIV70rZTKxpLsooUJ+Hks/A+wEcJhTguXFE4VMcQy51e+XYocWiCctZ7x6nA
         Gs4wfS1ze5eRuiLB1TSIlb3q7tbSe3bqzo2x9qB3rmk4oZiBw/od3vSeTR6OPFm41uEU
         YgywSGkZRk6AYi0onyLou6Qj1sggY13cmN10nEQxv1JSUM5QqwHbRbzu7u0wGTBGcN1c
         36Ql7m3HYBKektoDWSRIUJYjXOVCCxjDZFOSq+MOnFYFz5fBINjrB9TlPKsHeBIwIC5a
         gfHZjFpR2h/fcUnN2TGU2UjywASsCQAiR16BQe3hFxccy97JdIqbpMAJFmlQbyGe1bua
         cRMA==
X-Gm-Message-State: AOAM530VW7f9ngiAsGNEQWKI+sf5tq/lNYXJWjSe+RzkBXj8xxymKcPv
        3wS3iR/OgvHVr/jYbDHt8N9r0S//2l60jGwBFC0=
X-Google-Smtp-Source: ABdhPJwBc6EONckhenm5IaiH/Z4Mv128h+5O6h1QUc8m/y9R/nrrSdEhUdQRLLmZHauk5Ll4VPNIYg==
X-Received: by 2002:ac2:5fa8:0:b0:448:7e92:3be0 with SMTP id s8-20020ac25fa8000000b004487e923be0mr16036386lfe.148.1647900217819;
        Mon, 21 Mar 2022 15:03:37 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id l24-20020a2e99d8000000b002497e14723esm720642ljj.86.2022.03.21.15.03.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 15:03:36 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id e16so12638110lfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:03:35 -0700 (PDT)
X-Received: by 2002:a05:6512:2294:b0:448:6c86:3c78 with SMTP id
 f20-20020a056512229400b004486c863c78mr15507615lfu.531.1647900215381; Mon, 21
 Mar 2022 15:03:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220319142759.1026237-1-chenhuacai@loongson.cn>
 <CAK8P3a12dY57+ZPEREAUrsNf45S0_4-yYHen6p0-PjJEivjczg@mail.gmail.com>
 <CAHk-=wj81Cgjb5xj=ghB0oEA4ronnc=WKZLTPGpJYPUn=QcQ5g@mail.gmail.com> <CAK8P3a33TZm2NZg28KbCCeLzLvf759_5r8hr-rcWftci9qinog@mail.gmail.com>
In-Reply-To: <CAK8P3a33TZm2NZg28KbCCeLzLvf759_5r8hr-rcWftci9qinog@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Mar 2022 15:03:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHLUK8oew17oD=4v-7DXUEDAbrup+7oZ8Stq0m9S2EGQ@mail.gmail.com>
Message-ID: <CAHk-=wiHLUK8oew17oD=4v-7DXUEDAbrup+7oZ8Stq0m9S2EGQ@mail.gmail.com>
Subject: Re: [PATCH V8 00/22] arch: Add basic LoongArch support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
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

On Mon, Mar 21, 2022 at 2:55 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> I can prepare a pull request when it gets to that, but I think the boot protocol
> should be fixed first, and that makes it 5.19 material.

Thanks. No problem on 5.19, it's not like I don't have enough pending
for this merge window already..

                 Linus
