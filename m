Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C32D4EB350
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 20:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240518AbiC2S3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 14:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240507AbiC2S3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 14:29:44 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA4E98F48
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 11:28:01 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id a30so17111771ljq.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 11:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LEsaIpfGuGJOhUIm0H9UVSLgz5NQlKj2WuLYDNMMKww=;
        b=nXRNZr4s55P5NZofW2TBn4pudVrihSs1n8yDaT8QdSILssP1d1ZD1Y15RfKpi4KPTr
         Uu8E1wM9N3iviXIefra9RiwoL8WoXOC+Np8t8QlmnjAH7/i+FAyeTBDWGRyrj379EP0V
         1I6s9MFc7oCor5UNrveAGVT+vfsRG8QorrL5UbBmOz1RS5Pr/s+ns8vjbyop6NuSp19/
         fU36wpnxz+JT1p8eCZuem6nNjErOSpOQ5tTLBmcCbZG6kFGwMqY33THXBhwn0OPBkKV4
         S7E1ztBRBWxx009d0vOMIvZ2y779O+rnyAC0Vv2dA/hfoH7J9qqn6UzJ65nQ6uYu2ivo
         89Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LEsaIpfGuGJOhUIm0H9UVSLgz5NQlKj2WuLYDNMMKww=;
        b=0kagjDlH1kfZuYjFpWqJO8+omAFYbdPRlSPaJx3zcu3Y7mGc1PCJtLCkR6vPVSv1lS
         wCpBMwCxBPupdz7pX5modOM7z3DCfCeNvMNiulFmocG23kuVHFTRhLL690pm8LGS7mRf
         gfHRZv37Sarw7FReOjn6rLXADaBVaWufoffRTztbPvdO4lYuyV5vWUpuh6ULm7224/Mh
         0o+ovdA0qrfE8tP1rHYwzm0WyM7aMVzd3QsyHlkUyDgZLjN2qUw8c4OCPq9BP2YQKEeB
         x8kcQubVNsjnTdIonBqgRpzH63yK84TH38Fe/L2a530yyyiaYz829fb8jSsYw+AEcFxp
         n50w==
X-Gm-Message-State: AOAM531NBPyFDT5IGxPdixsu8CqslKPsTu6S+MgEHwkp/wjRGYktjIDn
        VvaoT807fmThsmM7UBA946F8Xy57ODuWqudyuyCBVg==
X-Google-Smtp-Source: ABdhPJxyDCbUs3P0iDO3sS8Lwqjr56z3pLlnPDMkaLKE9m1ms3Ks72/ED5j+irAip/mhuPzNFDYxQ7ecavxgAFYsRPE=
X-Received: by 2002:a2e:611a:0:b0:249:83e5:9f9b with SMTP id
 v26-20020a2e611a000000b0024983e59f9bmr3897329ljb.165.1648578479300; Tue, 29
 Mar 2022 11:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220329021520.308997-1-masahiroy@kernel.org> <20220329021520.308997-2-masahiroy@kernel.org>
In-Reply-To: <20220329021520.308997-2-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 29 Mar 2022 11:27:47 -0700
Message-ID: <CAKwvOdnbEVj=Y-AVSWnOT1g3jUEJdAESHjhny=5d8iXcKWgb9A@mail.gmail.com>
Subject: Re: [PATCH 2/2] kbuild: do not remove empty *.symtypes explicitly
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
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

On Mon, Mar 28, 2022 at 7:15 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Presumably, 'test -s $@ || rm -f $@' intends to remove the output when
> the genksyms command fails.
>
> It is unneeded because .DELETE_ON_ERROR automatically removes the output
> on failure.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/Makefile.build | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 3f2985df4d60..974bb6435826 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -135,9 +135,7 @@ genksyms = scripts/genksyms/genksyms                \
>  cmd_gensymtypes_c = $(CPP) -D__GENKSYMS__ $(c_flags) $< | $(genksyms)
>
>  quiet_cmd_cc_symtypes_c = SYM $(quiet_modtag) $@
> -cmd_cc_symtypes_c =                                                         \
> -    $(call cmd_gensymtypes_c,true,$@) >/dev/null;                           \
> -    test -s $@ || rm -f $@
> +      cmd_cc_symtypes_c = $(call cmd_gensymtypes_c,true,$@)

Was it an accident that you removed the redirection of stdout to
/dev/null here, but not also below?
If quiet_modtag silences the output, perhaps the redirection should be
dropped below as well?

>
>  $(obj)/%.symtypes : $(src)/%.c FORCE
>         $(call cmd,cc_symtypes_c)
> @@ -348,9 +346,7 @@ cmd_gensymtypes_S =                                                         \
>      $(CPP) -D__GENKSYMS__ $(c_flags) -xc - | $(genksyms)
>
>  quiet_cmd_cc_symtypes_S = SYM $(quiet_modtag) $@
> -cmd_cc_symtypes_S =                                                         \
> -    $(call cmd_gensymtypes_S,true,$@) >/dev/null;                           \
> -    test -s $@ || rm -f $@
> +      cmd_cc_symtypes_S = $(call cmd_gensymtypes_S,true,$@) >/dev/null
>
>  $(obj)/%.symtypes : $(src)/%.S FORCE
>         $(call cmd,cc_symtypes_S)
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
