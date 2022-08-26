Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB715A3051
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 22:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344693AbiHZUHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 16:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiHZUHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 16:07:45 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA0396FF6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 13:07:44 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id fy31so4684965ejc.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 13:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5uVZvH0WBz/SiP6nDdXQ7fNSiMZNJF3T+BwdwEHBsbs=;
        b=Q/cENHnXRHQfPHNlmHyDlTvWdskTaGpvXdx0YnDNLNS/0RX8WPb1jR5KgVLVBJcIU7
         CSIyrv1NiJyoL5ax12gNIDW8tYBDTItBrtCw3Zl97Jwccpq1Ui0p68Ku4B3uDzrqFg8v
         uNufxLhtMvXsQPswhXy+3+QAszhCgZrLluj6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5uVZvH0WBz/SiP6nDdXQ7fNSiMZNJF3T+BwdwEHBsbs=;
        b=zXqLg5gUCixc46KYtaN1whGMiEpUbO+nEYZzxsPRWuQBdBpba3BiJ6Kio2T6kdLkA5
         g/aSTcBQYDOicA2J21gu3QXwDEwsXKT3Oz3KMgvhyvSjuMHnL8Zh9YBTxo5ywql0aQ9r
         TMKkIhfLA7YVyaj5DVJE75PGpzDadBmMq0mt1BEzOGLZpi40iayX8j29cWFEKqLiPBf8
         7d2ZyTWrNvWRw8m0ddcibC+oyu8dBnSaUD+lShVzVtNFPwsLRytGBVTmIfll+3Q8SSsl
         zrTWbFO2xPW6IEQKG07Sv+n40lJLGz/EjdQ4xKXJ0VuPGHiPKjZ51Jh/DP2kJmf0PfQa
         RLLg==
X-Gm-Message-State: ACgBeo2clG+LHMmZcql1FBNlYPVHfwUIq9aT7kAP49MNgfn/KRWUDHBW
        u04CiyLvVaV4dQEsuivKArm5ZSIpBAEqJn9QjbI=
X-Google-Smtp-Source: AA6agR5e9Iz2ETkneWHYuc3XDbJIUiAeIXo0Nc2IQK0S76sL7yFYoPzAs5TKcUdorLcEPFu+QAa5mw==
X-Received: by 2002:a17:907:7389:b0:73d:81a1:d562 with SMTP id er9-20020a170907738900b0073d81a1d562mr6680826ejc.27.1661544462690;
        Fri, 26 Aug 2022 13:07:42 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id 1-20020a170906328100b0073d70df6e56sm1255954ejw.138.2022.08.26.13.07.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 13:07:41 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id e13so2086573wrm.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 13:07:40 -0700 (PDT)
X-Received: by 2002:a5d:4052:0:b0:225:8b55:67fd with SMTP id
 w18-20020a5d4052000000b002258b5567fdmr637361wrp.281.1661544460541; Fri, 26
 Aug 2022 13:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2208220530050.32093@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh-6RJQWxdVaZSsntyXJWJhivVX8JFH4MqkXv12AHm_=Q@mail.gmail.com>
 <CAHk-=whfZSEc40wtq5H51JcsBdB50ctZPtM3rS3E+xUNvadLog@mail.gmail.com>
 <alpine.LRH.2.02.2208251501200.31977@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=wh7ystLBs7r=KrgFhuYpNULoTY1FFPgq=a=Kr2mxc3jdg@mail.gmail.com>
 <alpine.LRH.2.02.2208260508360.26588@file01.intranet.prod.int.rdu2.redhat.com>
 <CAMuHMdWQXqi__8q66R7cL4VVgr4r7WwqNmDExFFsi4aC=K3NPw@mail.gmail.com> <alpine.LRH.2.02.2208261550380.6969@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2208261550380.6969@file01.intranet.prod.int.rdu2.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Aug 2022 13:07:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgCN6moKefrRBECCon6675vh=6+yWGu0N5zu7G5eGh+wg@mail.gmail.com>
Message-ID: <CAHk-=wgCN6moKefrRBECCon6675vh=6+yWGu0N5zu7G5eGh+wg@mail.gmail.com>
Subject: Re: [PATCH] provide arch_test_bit_acquire for architectures that
 define test_bit
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
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

[ Crossed emails ]

On Fri, Aug 26, 2022 at 1:03 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> +static __always_inline bool
> +arch_test_bit_acquire(unsigned long nr, const volatile unsigned long *addr)
> +{
> +       unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
> +       return 1UL & (smp_load_acquire(p) >> (nr & (BITS_PER_LONG-1)));
> +}
> +

I'd suggest you just do

  #define arch_test_bit_acquire generic_test_bit_acquire

in each of these files, instead of duplicating that function over and
over again..

Because the generic version always exists, since it comes from
generic-non-atomic.h, which is included directly from
<linux/bitops.h>.

                  Linus
