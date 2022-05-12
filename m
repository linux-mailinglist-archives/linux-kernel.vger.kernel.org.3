Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C20524376
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 05:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344087AbiELDeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 23:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343921AbiELDeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 23:34:03 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B164D6FA18;
        Wed, 11 May 2022 20:34:02 -0700 (PDT)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 24C3XRUS015264;
        Thu, 12 May 2022 12:33:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 24C3XRUS015264
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652326408;
        bh=dbNwEvZYw1fjRFSQZy5q9B2R8hJHj2WYVFlICWwM6Oc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=23082fZBoIgWOojx7XxPpv03C3EJGPNBRuMzZAGL3AOXpRozDEr9PQpuxUCERQYrP
         0+0gSR3MjCbTfbTk6GsZcVbiGrPa7rMlSfERLAIJ9Y4LbWg3AXEL6MPs1DdhdKyswB
         A2ZKISCJ3B3op0jPuphxOrtjAJOhDmkfl9sMwHKMRmcBRAkJ9eeU76+cNVN13duZ5s
         Y4isHZit2d7hK+eqpiOX0WR5ktLWnMCInuq3FoCYhQMpQR/JyFUy7VIYRhO+yCO2cn
         3YFNsTjC39Ht4c/k8+5d6OdqLYkwUy4zOxRcmAt8khm7oTOG6LLUgArhWn91cnk2ke
         FDtOEKmTru2qw==
X-Nifty-SrcIP: [209.85.215.173]
Received: by mail-pg1-f173.google.com with SMTP id h186so815384pgc.3;
        Wed, 11 May 2022 20:33:27 -0700 (PDT)
X-Gm-Message-State: AOAM533LILPcG388CIa23fFx7q/vNsLxDHbqyacb60lKYBNinZAVH2n9
        4mmf5S4T8xgwXrvhMj7+t5oD0oly+sbxuMx6vkM=
X-Google-Smtp-Source: ABdhPJwG0xbZVE9S3odmeddiK5smlXhc5MfRFuwXPi0gSLw2Nm0SAMreZzrCHdbMunbY06F+fLSoK5TjQygOQdUrI6I=
X-Received: by 2002:a63:6989:0:b0:3c2:3c19:d661 with SMTP id
 e131-20020a636989000000b003c23c19d661mr23412597pgc.352.1652326406909; Wed, 11
 May 2022 20:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220511164514.2741934-1-masahiroy@kernel.org>
 <20220511164514.2741934-2-masahiroy@kernel.org> <CAKwvOd=SZYO0344rrJWP+JvmuZmQ9N6VM9UgMwrb9fH3MaNLMQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=SZYO0344rrJWP+JvmuZmQ9N6VM9UgMwrb9fH3MaNLMQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 12 May 2022 12:32:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNASsnrxu1BvtR9aq6oeOvmTX8jr4Wum=+7qemKzcLpSRWQ@mail.gmail.com>
Message-ID: <CAK7LNASsnrxu1BvtR9aq6oeOvmTX8jr4Wum=+7qemKzcLpSRWQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/12] modpost: split the section mismatch checks into section-check.c
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 7:28 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, May 11, 2022 at 9:49 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > modpost.c is too big, and the half of the code is for section checks.
> > Split it.
> >
> > Also, move some related typedefs and macros from modpost.h to
> > section-check.c
> >
> > Copy Sam's Copyright there. Commit b39927cf4cc5 ("kbuild: check for
> > section mismatch during modpost stage") is the initial work for the
> > section checks.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Sorry again for my "brain fart" in reviewing the global var in v4. :(
> I think my blood sugar was getting low or something...

Never mind.
Thanks for the close review all the time!

>
> > ---
> >
> > Changes in v5:
> >    - Fix the build error  (spotted by Nathan)
> >    - Do not do codying style changes  (Suggested by Nick)
>
> I'm surprised the style changes didn't show up in v5 as a later patch
> in the series. I wasn't against them in general, just thought it would
> be easier to review if they were distinct commits.


I just postponed the coding style fixes
because they are not essential for my main goal
in this patch set.

A lot of old code exists in modpost.
We can improve it later.


-- 
Best Regards
Masahiro Yamada
