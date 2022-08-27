Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96B75A3823
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 16:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbiH0Odu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 10:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiH0Ods (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 10:33:48 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677166CD2B;
        Sat, 27 Aug 2022 07:33:47 -0700 (PDT)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 27REXN6q011142;
        Sat, 27 Aug 2022 23:33:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 27REXN6q011142
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1661610804;
        bh=r3RuiVhz02YDOYCKUD6tQkz2KkGo9JNyPIOr+gWiuFw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BfS4oCWg4bw0zw6AY6qJ26K069UIZ59LWTklITdRbn89nN6nnYjLZlt59NtYzV3FO
         8PzuSFzNCmHxew9BMxzbEO91Lb8P8rnLsMmKYg73G4U5GnOWb25MWpCVtTE7Veox5J
         5yuGAQmrBcMgf3sNKdZJBArLlFqSXO0Lt2ULp3ndKlFifz8NFQROZ5zJObtQc7dH4M
         3Vistdjm9IuT2nCa5ubtbabBw0pudT8/gl4cN4xsbSrTLGXQZNVItagrkyMO5EULq5
         0V+UJ/zCAYsIJqxj+6wJQt6C1Pn5CQj+wm7ergQK/W44xIW0BmnWEizn0WqQkT/vIp
         DgJz4iXblDHpg==
X-Nifty-SrcIP: [209.85.167.175]
Received: by mail-oi1-f175.google.com with SMTP id a133so5452164oif.4;
        Sat, 27 Aug 2022 07:33:23 -0700 (PDT)
X-Gm-Message-State: ACgBeo3sy6nlsKuZbJYxrwsdmzN+vK9vVxFExUZ5s1uCUKkcJokx1Dyn
        xY11A4f13mm3nnCus4evTSysZFxOZfvnmkCky3I=
X-Google-Smtp-Source: AA6agR7rXve0v0yJlspa5QxdePWwu0GRH6Fgsj/LGMckPZ7PTktOTsd9toOIdunYrHD1TLI+2JlKxmb175dYEwzL3bc=
X-Received: by 2002:a05:6808:1189:b0:33a:34b3:6788 with SMTP id
 j9-20020a056808118900b0033a34b36788mr3602323oil.194.1661610802833; Sat, 27
 Aug 2022 07:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220824200340.45673-1-thitat@flux.ci> <YwcjFCXF7lKpU3r5@buildd.core.avm.de>
In-Reply-To: <YwcjFCXF7lKpU3r5@buildd.core.avm.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 27 Aug 2022 23:32:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQxM4HswuOAyV_CgG7sxLnkco6ioR5vVC3c3dKfu2aj=w@mail.gmail.com>
Message-ID: <CAK7LNAQxM4HswuOAyV_CgG7sxLnkco6ioR5vVC3c3dKfu2aj=w@mail.gmail.com>
Subject: Re: [PATCH] scripts/extract-ikconfig: add zstd compression support
To:     Nicolas Schier <n.schier@avm.de>
Cc:     Thitat Auareesuksakul <thitat@flux.ci>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 4:22 PM Nicolas Schier <n.schier@avm.de> wrote:
>
> On Thu, Aug 25, 2022 at 03:03:40AM +0700, Thitat Auareesuksakul wrote:
> > Add extract-ikconfig support for kernel images compressed with zstd.
> >
> > Signed-off-by: Thitat Auareesuksakul <thitat@flux.ci>
> > ---
>
> Tested-by: Nicolas Schier <n.schier@avm.de>
>
> >  scripts/extract-ikconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/scripts/extract-ikconfig b/scripts/extract-ikconfig
> > index 3b42f255e2ba..8df33e7d6daa 100755
> > --- a/scripts/extract-ikconfig
> > +++ b/scripts/extract-ikconfig
> > @@ -62,6 +62,7 @@ try_decompress 'BZh'          xy    bunzip2
> >  try_decompress '\135\0\0\0'   xxx   unlzma
> >  try_decompress '\211\114\132' xy    'lzop -d'
> >  try_decompress '\002\041\114\030' xyy 'lz4 -d -l'
> > +try_decompress '\050\265\057\375' xxx unzstd
> >
> >  # Bail out:
> >  echo "$me: Cannot find kernel config." >&2
> > --
> > 2.37.2
> >


Applied to linux-kbuild. Thanks.



-- 
Best Regards
Masahiro Yamada
