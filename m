Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E65F530FEB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbiEWMe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbiEWMev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:34:51 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF2743EEF;
        Mon, 23 May 2022 05:34:47 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id p123so2486282qke.5;
        Mon, 23 May 2022 05:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zWW6thDJ98/KzWOHjOmZlsh4+inUgZI3sNPxS+N5zm4=;
        b=Fb+2IhZRT4kRSIPikn+2vrZ3ASxWPm9JevY9AyDxBmT0f96Tnjg97FewA8Z2eOHV9d
         3q6EtAFe80QFNOneuVVUOiPoyMHFCfKDdJfI99TA8S8/00y3BM0i+RAy/DTMamwLdVx3
         LivEDJxlb54BM4jD+44FiMjqRvcC1m4a0vQr/7D/dKXQFxovELDKdyRS3Yd28qPvyfs/
         z5fsbg4+TG+DgU+1p3W/Rl8KNKTucF/5+P5cMVxJSxoXxA28yYkJ5Eksnb4YX/3MFNb+
         78tTvvlsUHn7MoUdk/K6sw00DibL6xOgbTxAJMEETVsd3ExtbZ0ILhwN15M7LwQWyu4h
         iOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zWW6thDJ98/KzWOHjOmZlsh4+inUgZI3sNPxS+N5zm4=;
        b=kglG3W6T+/KJUZL2ee0Xs0viHQocBwigspQDWJJivBMy73TbfbIfCtOkPEuh36at4g
         eE/KHm4LZTJ4BCwqc84n5TrTudrdB9qHTpvYfTPoFd4//7WK399Wa8etjcaL98GCBZRQ
         1DByv294wlXCxzzoP0+ppT1gVcVD4ZhqcYjRsNveV7Kp9aj5PYW1O2NCNzjot4s426zf
         zhaZRklgD72MlEKovku6tu3opLV/xNy4b59adAIZ6wNb2g0L9CnueagY9YXfUlwTSmJD
         LW4PC0nhPKHY1cWB4eJL71ERH7bGlYWiclnGA4YnQZzl4ZfXqDyun5jyj9S2goT7qAy7
         QQfA==
X-Gm-Message-State: AOAM532Y8uZnWKXOF09L4dXhksT4xfF/Rna/tsBKc9NiyYVtPQg5GXxT
        04C64TC0cUVNlOghGb0rpeI=
X-Google-Smtp-Source: ABdhPJx6mxt2vccLVo+P6//wIKgsooq5eK5qasPIND7jHo2crxR3T9d9UlTX2rziojU63P7oPRzm9w==
X-Received: by 2002:a37:a74e:0:b0:6a3:95f5:48f8 with SMTP id q75-20020a37a74e000000b006a395f548f8mr2585829qke.126.1653309286500;
        Mon, 23 May 2022 05:34:46 -0700 (PDT)
Received: from mail.google.com ([207.246.89.135])
        by smtp.gmail.com with ESMTPSA id 9-20020a370809000000b006a346e0f653sm4374569qki.15.2022.05.23.05.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 05:34:46 -0700 (PDT)
Date:   Mon, 23 May 2022 20:34:36 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Changbin Du <changbin.du@gmail.com>
Subject: Re: [RFC PATCH] kbuild: Add an option to enable -O1 and speed-up
 compilation time
Message-ID: <20220523123436.b5gwj55xacc2hxcv@mail.google.com>
References: <23e0ba7863d51ab629498762a97d477645aeafea.1653123744.git.christophe.jaillet@wanadoo.fr>
 <CAK7LNASHGyzKS-d+S1GYz_L0pBxxSwk05YfvV+LK4ghZ5xx=cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASHGyzKS-d+S1GYz_L0pBxxSwk05YfvV+LK4ghZ5xx=cA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2022 at 12:38:17AM +0900, Masahiro Yamada wrote:
> (+CC: Arnd, Changbin Du)
> 
> 
> If -O1 support does not require additional effort,
> I have no objection to this patch.
> 
> (but I do not have enough insight about
> the compiler's inlining heuristic)
> 
> 
> 
> BTW, when we attempted to add the -Og support,
> we fixed various parts, and Linus rejected it.
> 
> https://lore.kernel.org/linux-kbuild/CAK7LNARQggM3aKEPRKJqa4tunFAfmfErMZuS-rrnRv6UB1VpPQ@mail.gmail.com/
> 
> 
> 
> 
> 
> 
> 
I am afraid that '-O1' has the same situation with '-Og'. As described in GCC
mannual:

Like -O0, -Og completely disables a number of optimization passes so that 
individual options controlling them have no effect. Otherwise -Og enables all
-O1 optimization flags except for those that may interfere with debugging:
 -fbranch-count-reg  -fdelayed-branch 
 -fdse  -fif-conversion  -fif-conversion2  
 -finline-functions-called-once 
 -fmove-loop-invariants  -fmove-loop-stores  -fssa-phiopt 
 -ftree-bit-ccp  -ftree-dse  -ftree-pta  -ftree-sra


> On Sat, May 21, 2022 at 6:04 PM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
> >
> > Add a new compilation option which speeds-up compilation time.
> > This can be useful when using static checker such as smatch or build-bots.
> > In such cases, the speed and quality of the generated code is not
> > important.
> >
> > Using -O0 would be even better, but unfortunately, building fails with
> > this option.
> >
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> >  Makefile     | 5 ++++-
> >  init/Kconfig | 8 ++++++++
> >  2 files changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 1f8bef92868f..14467386f947 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -817,7 +817,10 @@ KBUILD_CFLAGS      += $(call cc-disable-warning, format-truncation)
> >  KBUILD_CFLAGS  += $(call cc-disable-warning, format-overflow)
> >  KBUILD_CFLAGS  += $(call cc-disable-warning, address-of-packed-member)
> >
> > -ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
> > +ifdef CONFIG_CC_OPTIMIZE_FOR_COMPILATION_SPEED
> > +KBUILD_CFLAGS += -O1
> > +KBUILD_RUSTFLAGS_OPT_LEVEL_MAP := 1
> > +else ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
> >  KBUILD_CFLAGS += -O2
> >  KBUILD_RUSTFLAGS_OPT_LEVEL_MAP := 2
> >  else ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3
> > diff --git a/init/Kconfig b/init/Kconfig
> > index a96776a9b080..3177a1830c9a 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1384,6 +1384,14 @@ choice
> >         prompt "Compiler optimization level"
> >         default CC_OPTIMIZE_FOR_PERFORMANCE
> >
> > +config CC_OPTIMIZE_FOR_COMPILATION_SPEED
> > +       bool "Optimize for compilation speed (-O1)"
> > +       help
> > +         This option can be useful when running a static checker such as smatch
> > +         or a build-bot.
> > +         Compilation time is slighly faster than -O2 and it requires less
> > +         memory.
> > +
> >  config CC_OPTIMIZE_FOR_PERFORMANCE
> >         bool "Optimize for performance (-O2)"
> >         help
> > --
> > 2.34.1
> >
> 
> 
> -- 
> Best Regards
> Masahiro Yamada

-- 
Cheers,
Changbin Du
