Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A2B4F47B8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240949AbiDEVSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457630AbiDEQUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:20:42 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A004955AB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:18:41 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y32so8864781lfa.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 09:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wIU2TEaS8WXbUqpi1fM6EfmEmwnBi19lD4NhlLBz3ig=;
        b=H8/4Lx4V0XygDs2dccjNd7TS7BtZ2fMSdr3xp4cjLVJj1pIAG8E/lefcRKdKOVEcDq
         0K+DG1Xns7N/k3s/nBe/9wCZfncNH69qMkDM9XvpXMRkvH+bCU2KCXleFNDWKjkqewpk
         IPy2hfj/pbDYC90dDuVUsKY0KS75145Wb2v/078FGCGX71uwEW/JGKMcMqr+9Cj2bPOp
         HKSXu5vKjskeXytHF25DvAkVsnlFk15eVE4zcractjvW8tvGzunroHoHyGFtu1iB8E40
         C7FXx+WgMFYFECMibHGBn5OK/9VMXK53nQXr/V6k+ni5i/+X5vRXaQu+vE2tXjFzGv2x
         SYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wIU2TEaS8WXbUqpi1fM6EfmEmwnBi19lD4NhlLBz3ig=;
        b=TKGyc4BPJTXm7xJvn3DKYupngiaWUsUtiWfSX0JSrb70yyZAv5OtFach5QiRyn4VKW
         Q0HPP346lZO44xKptj4lzUA0s3Gm36uZRvYtAWjOb0Ka947n1UqD612lsRkHumPD7tJ+
         OEgOXQQAfV8JRWA7LNGtXgDDxrsPWFb8CHpTa61axCDGQMAR592MyM87yapgAY3pfyZY
         YQwlRtt1mFzNk5Uhtmko3a61XnVKkxrCk1WA/XgHpORKvp80BFjSY9ZuB6FlIcetXWy7
         AmV8ZWcNsEV+4pHiqgWS+N8nxdw6FfqDNlEac2pre2sfSeN7qrpmeamdAWv/zp82g/5a
         OQUQ==
X-Gm-Message-State: AOAM532Qb1Uok0ZYrLCZXYBLQzH6JnRcBj8ELdy9Dg+3TtgAkrMshtap
        FxErSUyWmtp6Azp22+yvs/QlpL2Jym969m3cHDjrgqbhCwN/Nw==
X-Google-Smtp-Source: ABdhPJzyIXHKLyRxKNDc0gfAZnnCNVmFVcYvD3pwWFNRifi2q7UjxoNx7BuehqH/sa8M5LtAyeh2d+vmVolrtFy4p0A=
X-Received: by 2002:a05:6512:3da1:b0:44a:2aeb:28e4 with SMTP id
 k33-20020a0565123da100b0044a2aeb28e4mr3016271lfv.579.1649175515578; Tue, 05
 Apr 2022 09:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220405113359.2880241-1-masahiroy@kernel.org> <20220405113359.2880241-3-masahiroy@kernel.org>
In-Reply-To: <20220405113359.2880241-3-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 5 Apr 2022 09:18:23 -0700
Message-ID: <CAKwvOd=13RwpvTQ5O86aQkyrGVSbqJkCWwsvU+DbRsGiKNS71A@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] kbuild: do not remove empty *.symtypes explicitly
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
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

On Tue, Apr 5, 2022 at 4:34 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Presumably, 'test -s $@ || rm -f $@' intends to remove the output when
> the genksyms command fails.
>
> It is unneeded because .DELETE_ON_ERROR automatically removes the output
> on failure.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> Changes in v2:
>   - Fix accidental drop of '> /dev/null'
>
>  scripts/Makefile.build | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 31e0e33dfe5d..3ef2373f0a57 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -135,9 +135,7 @@ genksyms = scripts/genksyms/genksyms                \
>  cmd_gensymtypes_c = $(CPP) -D__GENKSYMS__ $(c_flags) $< | $(genksyms)
>
>  quiet_cmd_cc_symtypes_c = SYM $(quiet_modtag) $@
> -cmd_cc_symtypes_c =                                                         \
> -    $(call cmd_gensymtypes_c,true,$@) >/dev/null;                           \
> -    test -s $@ || rm -f $@
> +      cmd_cc_symtypes_c = $(call cmd_gensymtypes_c,true,$@) >/dev/null
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
