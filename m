Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C335758815B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 19:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbiHBRwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 13:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiHBRwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 13:52:22 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388C04AD6F
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 10:52:21 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id z4so1767339ljn.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 10:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uq/Rx8c6eBVDptz85wyGlZI0bE76rVfRd4ysyVALge8=;
        b=b2jEgDNxQhurFIkvbRB/cc8K1euIi9k2FYZ2QjjLBqqAju9eZFe3WeAB05IFuGKQ/I
         mbTPDnDGpqaGdSNV6gwE919JvALQMKYvmR2KUfDRHSchgmeuSw2IXSC/yGL2TJdx1iHX
         n7IwlqxAO5U58RuSSHqg2Ic3OIXarmVSbRYQ4Ux1fj+TnDd2U852/0KChmGH6jRA/CRS
         aCEaTEv4zfqC0UrSZWweYNwJsdqDQM2ay9ZbjARWl2qGYM3Z7lw+4FNMXV0O0qlob6Zu
         3OR2hhw/dzGFVOe/208aZzGb8RcukrnNMrwoIgtSyNNopOC1iOi8f/hoxcJmK5FZ/Rhw
         ULXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uq/Rx8c6eBVDptz85wyGlZI0bE76rVfRd4ysyVALge8=;
        b=3K0f2Jdd6MzPv2i2PfuJZAIozqoxOg6+ASmiq8M4zMMuxviUft345B//bamsSNUXi6
         Uxw7Hrg0WlXzDw3+Ce8Lz37dCWnPCWwDUVCpZsU62UqAaboLppgus3ucd9jUauigsI3e
         v/c+GwDs6KGGBB2RIUGn2d190pzzinK2xIAKKGWF2rhIort0L6prTvtMkb+NYFG37zB+
         m4aNkmOKHfDXufrAsAqq45scYRLKhoLYJbPmL1IuHetoMV51/bk8PcM3rZ9IZiY3d+US
         L0DTQL3Qlg8srPZOrx3yE4gZOgq9F4Mz9ix+U+2GrBW9uX/rj2ZbfVF/Hbzl2Sdrjtxo
         0wDA==
X-Gm-Message-State: AJIora9E96kekGNu2dffY67uLGIEvFdW9Vx7JOUVh2RPU+4oHlB1ZTw+
        md/lS0W4wopfoDhSUpFPBunT600HwjKpFWLykvzwxw==
X-Google-Smtp-Source: AGRyM1tJrCoFHyyr4qY674dMt6LxVswiFuk9pC1geTEyd4bL4pwORFdgPIdNaGzn6g2yxtgv6gIhw5zGGGYAXfZJQRg=
X-Received: by 2002:a2e:3109:0:b0:25a:8a0c:40e2 with SMTP id
 x9-20020a2e3109000000b0025a8a0c40e2mr6633298ljx.26.1659462739415; Tue, 02 Aug
 2022 10:52:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220728031433.1077354-1-masahiroy@kernel.org>
In-Reply-To: <20220728031433.1077354-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 2 Aug 2022 10:52:08 -0700
Message-ID: <CAKwvOdmy4rPHqfMwnfOUMiZ-5kpV4EAugU1vnJrqkGPGnsTVcQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: set EXIT trap before creating temporary directory
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        David Laight <David.Laight@aculab.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 8:17 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Swap the order of 'mkdir' and 'trap' just in case the subshell is
> interrupted between 'mkdir' and 'trap' although the effect might be
> subtle.
>
> Please not this is not a perfect solution to avoid the left-over tmp
> directory. There are more cases that miss to remove the tmp directory,
> for example:
>
>  - When interrupted, dash does not invoke the EXIT trap (bash does)
>
>  - 'rm' command might be interrupted before removing the directory
>
> I am not addressing all the cases since the tmp directory is harmless
> after all.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  scripts/Kconfig.include   | 2 +-
>  scripts/Makefile.compiler | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
> index c1f4222d223d..a0ccceb22cf8 100644
> --- a/scripts/Kconfig.include
> +++ b/scripts/Kconfig.include
> @@ -25,7 +25,7 @@ failure = $(if-success,$(1),n,y)
>
>  # $(cc-option,<flag>)
>  # Return y if the compiler supports <flag>, n otherwise
> -cc-option = $(success,mkdir .tmp_$$; trap "rm -rf .tmp_$$" EXIT; $(CC) -Werror $(CLANG_FLAGS) $(1) -c -x c /dev/null -o .tmp_$$/tmp.o)
> +cc-option = $(success,trap "rm -rf .tmp_$$" EXIT; mkdir .tmp_$$; $(CC) -Werror $(CLANG_FLAGS) $(1) -c -x c /dev/null -o .tmp_$$/tmp.o)
>
>  # $(ld-option,<flag>)
>  # Return y if the linker supports <flag>, n otherwise
> diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
> index 86ecd2ac874c..94d0d40cddb3 100644
> --- a/scripts/Makefile.compiler
> +++ b/scripts/Makefile.compiler
> @@ -21,8 +21,8 @@ TMPOUT = $(if $(KBUILD_EXTMOD),$(firstword $(KBUILD_EXTMOD))/).tmp_$$$$
>  # automatically cleaned up.
>  try-run = $(shell set -e;              \
>         TMP=$(TMPOUT)/tmp;              \
> -       mkdir -p $(TMPOUT);             \
>         trap "rm -rf $(TMPOUT)" EXIT;   \
> +       mkdir -p $(TMPOUT);             \
>         if ($(1)) >/dev/null 2>&1;      \
>         then echo "$(2)";               \
>         else echo "$(3)";               \
> --
> 2.34.1
>


-- 
Thanks,
~Nick Desaulniers
