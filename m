Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236CE522B9D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 07:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238371AbiEKFZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 01:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiEKFZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 01:25:50 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99A56267
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 22:25:48 -0700 (PDT)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 24B5POum021481
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 14:25:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 24B5POum021481
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652246725;
        bh=fRrVkhc4C69GR5bjBNf1IL1bPSkMZTmDY7FnTVwEOfk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bDmhjqVQkNuZl9hB6eOHMxjDMqv9/k7Ryyb/MsyeVua8KVEVkGObOKEmrKHgkmRoW
         BTamJTRZD4IlzXYBRQdGojlr1ZV9q1s02SJ/1rKlpALhW5DN6bzQQGXEwpR+nh/MXJ
         d2YEUdMNrWVmVeBa0nGw+0C9F1BxVuleIALEoA3QJfYIUzW32bdONsz6qNISrkBwuq
         e40glc0Dp6zlpEhBZjM9apLsvrKoU3wRYlXuKq1E8QcomBJDKtJhRahPiLVS9DaJwr
         6bmLMiHNf5w/2Y/5wSymyVYnEwckPRduJnUS4Q/x/aHKHljLP25YnN87cLbsSQf+BM
         by0RFpNq60QRA==
X-Nifty-SrcIP: [209.85.214.175]
Received: by mail-pl1-f175.google.com with SMTP id i1so815798plg.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 22:25:24 -0700 (PDT)
X-Gm-Message-State: AOAM5325bSVWlKdcaex2JzNvF4fs2LWamquE+ZOFQNPxOnomMHFkm+ak
        6N6Uzrkr4g6aWNNiSXB3C+pXK+tvMMnTPNoFNmk=
X-Google-Smtp-Source: ABdhPJy6zdKt8+ced+xpKRH0+cNbA/iuWs7wjkoZ+DGXYmCBsEeJ8fxq19TFozcExsuvWxuWp0yKBBjWcefPoF/lmdM=
X-Received: by 2002:a17:902:7891:b0:15e:cae9:7620 with SMTP id
 q17-20020a170902789100b0015ecae97620mr23934575pll.136.1652246723945; Tue, 10
 May 2022 22:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220429053329.2278740-1-aik@ozlabs.ru> <d4ebca66-2899-7cd1-3cb1-4b1a587eb2bf@ozlabs.ru>
In-Reply-To: <d4ebca66-2899-7cd1-3cb1-4b1a587eb2bf@ozlabs.ru>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 11 May 2022 14:24:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNATMY4J-WMTwjcbdteq+Sb3o_onLyC4PGw2GLLR8L4xvPg@mail.gmail.com>
Message-ID: <CAK7LNATMY4J-WMTwjcbdteq+Sb3o_onLyC4PGw2GLLR8L4xvPg@mail.gmail.com>
Subject: Re: [PATCH kernel v2] zstd: Fixing mixed module-builtin objects
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 11:03 AM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>
>
>
> On 4/29/22 15:33, Alexey Kardashevskiy wrote:
> > With CONFIG_ZSTD_COMPRESS=m and CONFIG_ZSTD_DECOMPRESS=y we end up in
> > a situation when files from lib/zstd/common/ are compiled once to be
> > linked later for ZSTD_DECOMPRESS (build-in) and ZSTD_COMPRESS (module)
> > even though CFLAGS are different for builtins and modules.
> > So far somehow this was not a problem but enabling LLVM LTO exposes
> > the problem as:
> >
> > ld.lld: error: linking module flags 'Code Model': IDs have conflicting values in 'lib/built-in.a(zstd_common.o at 5868)' and 'ld-temp.o'
> >
> > This particular conflict is caused by KBUILD_CFLAGS=-mcmodel=medium vs.
> > KBUILD_CFLAGS_MODULE=-mcmodel=large , modules use the large model on
> > POWERPC as explained at
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/Makefile?h=v5.18-rc4#n127
> > but the current use of common files is wrong anyway.
> >
> > This works around the issue by introducing a zstd_common module with
> > shared code.
> >
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>
>
> Ping? Thanks,


Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>







-- 
Best Regards
Masahiro Yamada
