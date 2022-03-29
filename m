Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211C44EB33C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 20:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240466AbiC2ST6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 14:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240446AbiC2STz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 14:19:55 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6472D21278
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 11:18:11 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bq24so15784766lfb.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 11:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=badPnvYLoc8XodG+san6C71FDRyrQhQ3//Al/NWGAOI=;
        b=mjBURzk+zh1n20pTJaIBFYAiC21cHwGZvyBQABEoSFKCujzsf4KJRzrudaIeq/lbE0
         uX4Fy1HwfnDDfJG+vyBTJS7Tliuy7Kka+VKVtYSYcO6OZltmdpQ1LuuePSEZc4D66GZk
         BMpa0B/+8WxfvNq2vzNPZ4jDD80VpIB/4BigxHrXeZGWYK0tBblQlLSXhzx1DTeYAoIw
         Acbh6e+ohmbf+XDN4SY2Y3CbElAH73HNyW6bYRqFsb0ANW/4YuIWyWvOfw49cejN1dml
         ua5PsZ3NEADLPM9E7pUowcUY8vnkO9gzCiBCxgAnDw5yHg+aX6eN/vDQcLJLq6+IguYf
         DvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=badPnvYLoc8XodG+san6C71FDRyrQhQ3//Al/NWGAOI=;
        b=JabHWL+yAeWcFoF3E7LYFXlLHZ4gHyNsFZL6oH5P9idk6owSYXlew0s0SCB7WzZiZe
         X29atwc9zPDJ41HTJuSdgb7L7FKwtILDkyorfdxSOwu74P+ecuzyJtxakma1kWIbSqKS
         g9rcXHwA2nFODcLWFXg5PNAE+UYGm1vfHROiGPycTQVm3mEjingT+REsw+FYYefZU1lr
         f0PgL5XSBGzaDY6zcobZAttCMgSQzxwMFNGCI8urgn3jNS1b7wJPLKeRNFwjV/dbD22Y
         uD8OBx5YXl7RexJjWJLbSm7B8L5EVnXdPX1RHiJ4iu+nLeXJptWkETcMJXicywhnUP8l
         m64A==
X-Gm-Message-State: AOAM5305Jqf8O6LNlg1fGHxbFMH4R3EpYtx23UxbRGt4qbcLs4IaTyTF
        /CBPhZiu1Fo+rhLm3a/VVbVLtCcLyyFiegs8pO92YA==
X-Google-Smtp-Source: ABdhPJyxLBxM9eerhgsyMbYzz8f3HvEow0dSW81FW2BIZoApC9jeij0DvBZyTxbnwgGn63wb2EVs13JDH91DpugBjYo=
X-Received: by 2002:a05:6512:33d4:b0:44a:9971:de48 with SMTP id
 d20-20020a05651233d400b0044a9971de48mr3878250lfg.392.1648577889154; Tue, 29
 Mar 2022 11:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220329021520.308997-1-masahiroy@kernel.org>
In-Reply-To: <20220329021520.308997-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 29 Mar 2022 11:17:57 -0700
Message-ID: <CAKwvOdkP12zrGu4iJStSJ5-pAKFBar=Cxf=CYO5gE9L636q8-w@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: factor out genksyms command from cmd_gensymtypes_{c,S}
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
> The genksyms command part in cmd_gensymtypes_{c,S} is duplicated.
> Factor it out into the 'genksyms' macro.
>
> For the readability, I slightly refactor the arguments to genksyms.

Looks nicer, thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/Makefile.build | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 9717e6f6fb31..3f2985df4d60 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -125,13 +125,14 @@ cmd_cpp_i_c       = $(CPP) $(c_flags) -o $@ $<
>  $(obj)/%.i: $(src)/%.c FORCE
>         $(call if_changed_dep,cpp_i_c)
>
> +genksyms = scripts/genksyms/genksyms           \
> +       $(if $(1), -T $(2))                     \
> +       $(if $(CONFIG_MODULE_REL_CRCS), -R)     \
> +       $(if $(KBUILD_PRESERVE), -p)            \
> +       -r $(or $(wildcard $(2:.symtypes=.symref), /dev/null))
> +
>  # These mirror gensymtypes_S and co below, keep them in synch.
> -cmd_gensymtypes_c =                                                         \
> -    $(CPP) -D__GENKSYMS__ $(c_flags) $< |                                   \
> -    scripts/genksyms/genksyms $(if $(1), -T $(2))                           \
> -     $(patsubst y,-R,$(CONFIG_MODULE_REL_CRCS))                             \
> -     $(if $(KBUILD_PRESERVE),-p)                                            \
> -     -r $(firstword $(wildcard $(2:.symtypes=.symref) /dev/null))
> +cmd_gensymtypes_c = $(CPP) -D__GENKSYMS__ $(c_flags) $< | $(genksyms)
>
>  quiet_cmd_cc_symtypes_c = SYM $(quiet_modtag) $@
>  cmd_cc_symtypes_c =                                                         \
> @@ -344,11 +345,7 @@ cmd_gensymtypes_S =                                                         \
>      $(CPP) $(a_flags) $< |                                                  \
>       grep "\<___EXPORT_SYMBOL\>" |                                          \
>       sed 's/.*___EXPORT_SYMBOL[[:space:]]*\([a-zA-Z0-9_]*\)[[:space:]]*,.*/EXPORT_SYMBOL(\1);/' ; } | \
> -    $(CPP) -D__GENKSYMS__ $(c_flags) -xc - |                                \
> -    scripts/genksyms/genksyms $(if $(1), -T $(2))                           \
> -     $(patsubst y,-R,$(CONFIG_MODULE_REL_CRCS))                             \
> -     $(if $(KBUILD_PRESERVE),-p)                                            \
> -     -r $(firstword $(wildcard $(2:.symtypes=.symref) /dev/null))
> +    $(CPP) -D__GENKSYMS__ $(c_flags) -xc - | $(genksyms)
>
>  quiet_cmd_cc_symtypes_S = SYM $(quiet_modtag) $@
>  cmd_cc_symtypes_S =                                                         \
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
