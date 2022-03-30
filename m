Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7B64EC84D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348239AbiC3PeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345743AbiC3PeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:34:07 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85D72A2641;
        Wed, 30 Mar 2022 08:32:21 -0700 (PDT)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 22UFW6uD021486;
        Thu, 31 Mar 2022 00:32:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 22UFW6uD021486
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1648654327;
        bh=+jgSjINaX2RyRLCECfYZOraAeDuLJJPFZ1fqF8WE6SA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yrKVFynM/yzZFguVFnebkl2p2IgvWtQPIhAvJIn6ppkeC1zSF2XS9oBgCXbVOg95p
         NfGagyWbRJmp/BdgPqdakxIri7F8OrJEr0q5Afnkpo7S83YQWEvygUJwUXdwXnYWsQ
         yv7+vtnT/3NBx68T7i7rweOYDmfjAxq5dziwlX55GZqlL/Ag1ITkG/Cd3fPySefHSz
         MGr6KN60/WqCGsE1cHOYZxfAYKLfiYV9dIxy18vdZffgp5Gp50V6qXEhdKU4RTVhWr
         XbRePTwedIqckRoOYQUbxrdncYyo3aVJHbYUL60g8fFzUWi+TwHDH/26P8Yydu5HtZ
         oyXJroZRrgrWw==
X-Nifty-SrcIP: [209.85.215.175]
Received: by mail-pg1-f175.google.com with SMTP id k14so17913073pga.0;
        Wed, 30 Mar 2022 08:32:06 -0700 (PDT)
X-Gm-Message-State: AOAM531h5dmRcWD3CZZ0ITUKNvc+HREywLWTLk8/Lqim0rOFQCD7wVNZ
        czwg4kMgdpZaah19qWVJjzyspL7tiGT9IShkMeY=
X-Google-Smtp-Source: ABdhPJzoDPjI9fV8HDohlqidunbnB1OZUNjx4hFoH/PcPh0JwyhOLFCU7Q9szZaAm2wppP1wXFUgDaeaMHTMnuvOkqo=
X-Received: by 2002:a05:6a00:24d2:b0:4fb:1b6d:ee7d with SMTP id
 d18-20020a056a0024d200b004fb1b6dee7dmr84413pfv.36.1648654325909; Wed, 30 Mar
 2022 08:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <479c5c98-0e0d-072d-dae1-f91629989e46@gmail.com>
In-Reply-To: <479c5c98-0e0d-072d-dae1-f91629989e46@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 31 Mar 2022 00:31:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNASxaJMUAS6vgcDX3jwM9LQj7Lz8RX941FQhrDrtJSt6GA@mail.gmail.com>
Message-ID: <CAK7LNASxaJMUAS6vgcDX3jwM9LQj7Lz8RX941FQhrDrtJSt6GA@mail.gmail.com>
Subject: Re: [PATCH] riscv: Set SRCARCH to riscv if ARCH is riscv64 or riscv32
To:     Ben Westover <kwestover.kw@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 11:34 PM Ben Westover <kwestover.kw@gmail.com> wrote:
>
> When riscv64 or riscv32 are used as the value for ARCH during compilation, like
> in tools that get the ARCH value from uname, set SRCARCH to riscv instead of
> failing because the riscv64 and riscv32 targets don't exist.

Can you refer to the code that really needs this?




>
> Signed-off-by: Ben Westover <kwestover.kw@gmail.com>
> ---
>  Makefile | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index c28c5d91e5c8..315c364bf2ba 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -408,6 +408,14 @@ ifeq ($(ARCH),parisc64)
>         SRCARCH := parisc
>  endif
>
> +# Additional ARCH settings for riscv
> +ifeq ($(ARCH),riscv32)
> +       SRCARCH := riscv
> +endif
> +ifeq ($(ARCH),riscv64)
> +       SRCARCH := riscv
> +endif
> +
>  export cross_compiling :=
>  ifneq ($(SRCARCH),$(SUBARCH))
>  cross_compiling := 1
> --
> 2.35.1
>


-- 
Best Regards
Masahiro Yamada
