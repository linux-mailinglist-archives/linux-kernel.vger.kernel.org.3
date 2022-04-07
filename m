Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EC94F86CC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 20:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346703AbiDGSDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 14:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbiDGSDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 14:03:32 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1EFBF96B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 11:01:30 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id s17so523879ljp.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 11:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nc2KMitqXXwMUX83HKghQR/LRLRxtBXah+9V4xkBICs=;
        b=hprdGD8oRcrP+d4uMRq8tj1WdE5uLs9uUyfo6bT6s4OBUPvwoSZgf+LKglIBUaAVsq
         EiLbrypIOSLKiKIYm1K7P8zI23ZeQJubgJBTdKL7UMv96Wr6Dq0XoC1Tn5lrZZIs9R9b
         wwUpN9IV7XAksdNicmeanV/JLFujJA6YqvRlHAGJEpIJ6qCRLoyuiqSvjWMevdLIlzIn
         GRpG4fVCfZv9N5jPKhtOUE4KjTYpSOKD/hFkrLvCiZN1VgzqY75o2QB8XK7HZVt98b3g
         2W97JbUgNeVqqAuRdQjK77H/3HZN1EZ2m8FNKZ19s/iL08Ph4631mVzBRse2KRaVb4bT
         HvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nc2KMitqXXwMUX83HKghQR/LRLRxtBXah+9V4xkBICs=;
        b=ZHI1vBspjLTx8OBFvS6CqvkZIfHvN/kC91SD8RU5mYsKLX8kEJv68PVFkOHBjKeLbo
         3hTWSxDHZbLfvQOac3ZRvQuyiY/9AdkHURJscC+UkNBnfjxyIav37Q30Fh7C0ibMLaLc
         7jCQHVJXcB7gy1Kn6xCT6BGHot9boEdTAL67hUAY5UVIH0XRMwNpRc5ygdxx2aLxCeLV
         OvXSU3lHVvXVvmIgzSKEv2Rb0mFEJA0hviq9mcyv0jSvPlY06Ed9GdhoA2sM3iGHfDBs
         EcFghMsiDj5Y1u0V3+Yi6c6/xT70lM5CDKpWPUrluCyVs031ugJTLQYL3GnZdY2ZAD9f
         hsFQ==
X-Gm-Message-State: AOAM532XgKjJWQKSFwlCw6m5lgEYC9wuc1P7VCkm+vem0JgVC4wKm+tH
        ps1jVoSSPg4U+3/O/5Mgk30+bB46P9g9KaWbdUFwTA==
X-Google-Smtp-Source: ABdhPJw+b9H5UOl+Iup4Aed7HFCmh/ChYIP6d74O9NiIa/kpPdqblNww5GkfmHyq7uM3ae0Db/bhBnqUdBm5XK8qJiw=
X-Received: by 2002:a2e:3a13:0:b0:24b:4025:344 with SMTP id
 h19-20020a2e3a13000000b0024b40250344mr3190537lja.468.1649354488708; Thu, 07
 Apr 2022 11:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220406153023.500847-1-masahiroy@kernel.org> <20220406153023.500847-8-masahiroy@kernel.org>
In-Reply-To: <20220406153023.500847-8-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 7 Apr 2022 11:01:17 -0700
Message-ID: <CAKwvOdkjPcLvv-AnG+JnP+k_eGd-sZoDwjZuVf6nkp5LyxWXtA@mail.gmail.com>
Subject: Re: [PATCH 7/7] kbuild: read *.mod to get objects passed to $(LD) or $(AR)
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 6, 2022 at 8:31 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> ld and ar support @file, which command-line options are read from.
>
> Now that *.mod lists the member objects in the correct order, without
> duplication, it is ready to be passed to ld and ar.
>
> By using the @file syntax, people will not be worried about the pitfall
> described in the NOTE.

Clever! Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/Makefile.build | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 3da731cf6978..f6a506318795 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -450,22 +450,18 @@ quiet_cmd_ar_lib = AR      $@
>  $(obj)/lib.a: $(lib-y) FORCE
>         $(call if_changed,ar_lib)
>
> -# NOTE:
> -# Do not replace $(filter %.o,^) with $(real-prereqs). When a single object
> -# module is turned into a multi object module, $^ will contain header file
> -# dependencies recorded in the .*.cmd file.
>  ifneq ($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT),)
>  quiet_cmd_link_multi-m = AR [M]  $@
>  cmd_link_multi-m =                                             \
>         $(cmd_update_lto_symversions);                          \
>         rm -f $@;                                               \
> -       $(AR) cDPrsT $@ $(filter %.o,$^)
> +       $(AR) cDPrsT $@ @$(patsubst %.o,%.mod,$@)
>  else
>  quiet_cmd_link_multi-m = LD [M]  $@
> -      cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ $(filter %.o,$^)
> +      cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ @$(patsubst %.o,%.mod,$@)
>  endif
>
> -$(multi-obj-m): FORCE
> +$(multi-obj-m): %.o: %.mod FORCE
>         $(call if_changed,link_multi-m)
>  $(call multi_depend, $(multi-obj-m), .o, -objs -y -m)
>
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
