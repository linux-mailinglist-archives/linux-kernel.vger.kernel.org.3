Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99215520376
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 19:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239623AbiEIRX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 13:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239614AbiEIRX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 13:23:57 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C54024DC63
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 10:20:01 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bq30so24997584lfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 10:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xq5ml2d/MeiCgCuvTz1iX/vBFJV/Zf5wkHsF94chv1Q=;
        b=FoDLMQ1CUcXkPH5YH2WUvQkrh4wyHkUUHZHcdPJapmG1T0eHAY1wc8brR60ppGMa5J
         MvFXF3tuoDWJ6lkuzwDg+uXRKK1dpjzfA/uB5GQC4TIBsPxsrPlb2FDEA+M+F9oDz5r4
         vtrjLZL3T3cOwM7JK/DHccrk8RMKefToEtmE3ezQ84jzYnAtOuLgLmSS8SPIbwmYpL8e
         +569UZLjUuKlLJxuLia9HvqCZWJPaqW6wxZ2wKVmnB6sIpUzIEuoLVasYEAtGywHS+dy
         NOLgCVKyfJ/Tlp9jDY6Jr3DzFF11gOShM2S20Pm+kw6ankpEDU3X7veoarlOtuIzCHqv
         rMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xq5ml2d/MeiCgCuvTz1iX/vBFJV/Zf5wkHsF94chv1Q=;
        b=MKnVDPNCtv3LczYvjdhQY30AT9gHHbyBJlXk+aCFQObgd4mfoC0JUSRIWm3GFcMjt3
         ++ut8E0rUjZCKD4aSNiedAr/QN7JaPNyPHS7xhm/2T84LGhnC6iuAjg9Yh1kH+M4CXIV
         M2rrwyn4kwc6lFLPr5SiBT6v+QwEPHwiuUw6f0sPtqujtGguEKuIA6/XH6iFFT4owj2o
         Jnn16Ouha8TQVM9XQG+fk2fPcVAV0tXmJycESh3Dbt4jhI/a1vCH4mpUAUuFU0vBkmlC
         lQm0vmjPsqPJ6FB9/eFNZnQaLVGU9J1iYvItMhDMpeNxdss+hnkDhNJmfgm5cf8uyAyO
         PEpw==
X-Gm-Message-State: AOAM530E7Puk7ljnNKmo9Uzt6KLfL65WivFXIevyK3P/uzJik86GnwwK
        DsjpekAmrZxQjNOyTbvpxBERGbupXY1pVWrVveSGOA==
X-Google-Smtp-Source: ABdhPJz9taxhLV4YRudjP7JD9rlg95k5LEcou1gLMLiVH/oLNlkumRLOmW/IlL/tmn/lb4A3bbzyo1/l2F7YyG1FIcQ=
X-Received: by 2002:a19:4303:0:b0:473:f5fb:27b2 with SMTP id
 q3-20020a194303000000b00473f5fb27b2mr12343182lfa.626.1652116799064; Mon, 09
 May 2022 10:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220508190631.2386038-1-masahiroy@kernel.org> <20220508190631.2386038-4-masahiroy@kernel.org>
In-Reply-To: <20220508190631.2386038-4-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 9 May 2022 10:19:47 -0700
Message-ID: <CAKwvOd=LR=UNOeWJDmM-McJ=FrCWTo8w1ox+KGMQCwCVpiUyFg@mail.gmail.com>
Subject: Re: [PATCH v4 03/14] modpost: split the section mismatch checks into section-check.c
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules@vger.kernel.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 8, 2022 at 12:10 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> modpost.c is too big, and the half of the code is for section checks.
> Split it.
>
> I fixed some style issues in the moved code.

It would be helpful for review if the split and restyle were distinct
patches.  Otherwise I can't tell what has changed.

This does lose the ability to use git blame to get more context on
some of the oddities in modpost (which I have found useful in the
past).  I don't feel strongly though.

>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> Changes in v4:
>   - New patch
>
>  scripts/mod/Makefile        |    2 +-
>  scripts/mod/modpost.c       | 1202 +---------------------------------
>  scripts/mod/modpost.h       |   34 +-
>  scripts/mod/section-check.c | 1222 +++++++++++++++++++++++++++++++++++
>  4 files changed, 1240 insertions(+), 1220 deletions(-)
>  create mode 100644 scripts/mod/section-check.c
>
> diff --git a/scripts/mod/Makefile b/scripts/mod/Makefile
> index c9e38ad937fd..ca739c6c68a1 100644
> --- a/scripts/mod/Makefile
> +++ b/scripts/mod/Makefile
> @@ -5,7 +5,7 @@ CFLAGS_REMOVE_empty.o += $(CC_FLAGS_LTO)
>  hostprogs-always-y     += modpost mk_elfconfig
>  always-y               += empty.o
>
> -modpost-objs   := modpost.o file2alias.o sumversion.o
> +modpost-objs   := modpost.o section-check.o file2alias.o sumversion.o
>
>  devicetable-offsets-file := devicetable-offsets.h
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index a78b75f0eeb0..e7e2c70a98f5 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -31,7 +31,7 @@ static bool external_module;
>  /* Only warn about unresolved symbols */
>  static bool warn_unresolved;
>
> -static int sec_mismatch_count;
> +int sec_mismatch_count;

^ this should go in modpost.h if it is to be used in two translation
units, rather than forward declaring it in section-check.c.  You did
this for the functions.
-- 
Thanks,
~Nick Desaulniers
