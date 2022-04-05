Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8734F4E8B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835462AbiDFAbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457763AbiDEQot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:44:49 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857DAE0981
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:42:50 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id b21so13706708lfb.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 09:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aVM16YtaCx1dYir94c9sxYwusYmuTqkX1MFty8IIFQk=;
        b=YtUkRUgQkrt4P9V69iJ32ka9iOIb/+ccGqqjKVsR0c1fQHRSqVXLh76rhQPtxYrQCD
         5DaXMJOw2MWRhGn1MeMzYEpTNeRWYll4CT4rEwHMH0TxvHSr8B/3jPBrSjhoSQsirJmi
         5aurdwzxud7rt4lGs2usfaHCr6txQI9A5WPlLs4NQ76cD/Fr9W23PUOTZhnP2omqEYCD
         XRjiG4ekyp3R1/pKvDVhTm60f8jrwkqmXZkc22HTTUcUCURHBcw5vuNRMd1IWJF8Efn6
         sUCQOWPkg0lN6dhJ8q06t3ztFR/uwcovxLZMbX5d3v/1PewPUohAn9mFXYCWyoQvXpds
         YRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aVM16YtaCx1dYir94c9sxYwusYmuTqkX1MFty8IIFQk=;
        b=7SWvZgORcx7sV84Z+802hg2Saa++Mav2eGb+BSlZ5gCK3OTf4iQXAvWXeR3VIO5sLu
         2CsQvczS8QYtwgZ1t5lntZhF8kCpc3gpp1H/DNWSc8YrUtHrm/TJlZ+Ag5Hfex113ANw
         B38uRptDEan0fcDXUPz0WR8tOQWqGKWDLCxN3l2jLiXDPnQxQem+zFtXOUibq/7TVm9n
         R8cKNTUFtJHv28f7JrqxuK/RYhxo1cQ40VDCoP7D0MEcWteB8G6PMsSF/UqY7XxYPdI8
         3imSKTYLh7NxvHJo03n7X4wjBMcamg0sZym1I6dlbF2Kbc0FGLx3N+RtmMdQ+HWDgz0O
         EUkA==
X-Gm-Message-State: AOAM5335WsAZEjSngZB3Dn3e6wA1IUScM8OHMoxhw9Gz4uDRA89eM6Pn
        ZYA5gme+BorXxK91vhEiNNXYf7OPs3uHKwFfTTD0bg==
X-Google-Smtp-Source: ABdhPJz3jBIQ7EkEmj+tI9A+lIIYlFEORto6nxVAIbaEAMf4GKZe+IPBCCzl9LE/xhd2lQpRB76SurWFw5kPGx38Ono=
X-Received: by 2002:a19:651d:0:b0:44a:b88a:b0b1 with SMTP id
 z29-20020a19651d000000b0044ab88ab0b1mr3373569lfb.380.1649176968442; Tue, 05
 Apr 2022 09:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220405113359.2880241-1-masahiroy@kernel.org> <20220405113359.2880241-10-masahiroy@kernel.org>
In-Reply-To: <20220405113359.2880241-10-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 5 Apr 2022 09:42:36 -0700
Message-ID: <CAKwvOd=oCivWGHLFLCuPeH1R-gKGRmsvg=NV5ZbSVhd13cqgSw@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] kbuild: refactor cmd_modversions_c
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>
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

On Tue, Apr 5, 2022 at 4:34 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> cmd_modversions_c implements two parts; run genksyms to calculate CRCs
> of exported symbols, run $(LD) to update the object with the CRCs. The
> latter is not executed for CONFIG_LTO_CLANG=y since the object is not
> ELF but LLVM bit code at this point.
>
> The first part can be unified because we can always use $(NM) instead
> of "$(OBJDUMP) -h" to dump the symbols.
>
> Split the code into the two macros, cmd_gen_symversions_c and
> cmd_modversions.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> Changes in v2:
>  - new
>
>  scripts/Makefile.build | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index d934bdf84de4..ba2be555f942 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -169,29 +169,25 @@ ifdef CONFIG_MODVERSIONS
>  #   the actual value of the checksum generated by genksyms
>  # o remove .tmp_<file>.o to <file>.o
>
> -ifdef CONFIG_LTO_CLANG
>  # Generate .o.symversions files for each .o with exported symbols, and link these
>  # to the kernel and/or modules at the end.
> -cmd_modversions_c =                                                            \
> +gen_symversions =                                                              \
>         if $(NM) $@ 2>/dev/null | grep -q __ksymtab; then                       \
> -               $(call cmd_gensymtypes_c,$(KBUILD_SYMTYPES),$(@:.o=.symtypes))  \
> +               $(call cmd_gensymtypes_$(1),$(KBUILD_SYMTYPES),$(@:.o=.symtypes)) \
>                     > $@.symversions;                                           \
>         else                                                                    \
>                 rm -f $@.symversions;                                           \
> -       fi;
> -else
> -cmd_modversions_c =                                                            \
> -       if $(OBJDUMP) -h $@ | grep -q __ksymtab; then                           \
> -               $(call cmd_gensymtypes_c,$(KBUILD_SYMTYPES),$(@:.o=.symtypes))  \
> -                   > $(@D)/.tmp_$(@F:.o=.ver);                                 \
> -                                                                               \
> +       fi
> +
> +cmd_gen_symversions_c =        $(call gen_symversions,c)
> +
> +cmd_modversions =                                                              \
> +       if [ -r $@.symversions ]; then                                          \
>                 $(LD) $(KBUILD_LDFLAGS) -r -o $(@D)/.tmp_$(@F) $@               \
> -                       -T $(@D)/.tmp_$(@F:.o=.ver);                            \
> +                       -T $@.symversions;                                      \
>                 mv -f $(@D)/.tmp_$(@F) $@;                                      \
> -               rm -f $(@D)/.tmp_$(@F:.o=.ver);                                 \
>         fi
>  endif
> -endif
>
>  ifdef CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT
>  # compiler will not generate __mcount_loc use recordmcount or recordmcount.pl
> @@ -269,7 +265,8 @@ define rule_cc_o_c
>         $(call cmd,checksrc)
>         $(call cmd,checkdoc)
>         $(call cmd,gen_objtooldep)
> -       $(call cmd,modversions_c)
> +       $(call cmd,gen_symversions_c)
> +       $(if $(CONFIG_LTO_CLANG),,$(call cmd,modversions))
>         $(call cmd,record_mcount)
>  endef
>
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
