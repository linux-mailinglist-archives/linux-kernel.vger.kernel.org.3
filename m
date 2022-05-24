Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479F75332A7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 22:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241604AbiEXUx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 16:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235839AbiEXUx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 16:53:26 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27ECD77F27
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 13:53:25 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id g7so2935041lja.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 13:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bW5/8lI4JjFQ6Xag2meN8L4VITbIpxKq0yUGICqVrIc=;
        b=WpvrEVmuTl2Kx5iqizXnztaJbRV6fnt43A0sf4YpzEgTzyvZ1jmLsw+fd6x4j/a5jl
         ef9kOPZKrEXxbXKlOmkFFkqVl7qePJXkW7sSjczqRVU9eaK23gdLP0JzNRYvjPBeCGKX
         50WAFccP6NrcY5s62BPW6EYi2JkzEq+oR9WH8GtAEN+UR6hNMHnarAv14tJGOAamIjU/
         PPYIVS0QGSEcwQCslNS5imW4VKB/fVCyYLQFfNtMGuqhk9Rgu7dw2kuCJqw0tMwuqmbG
         c9NemwHFdhnEzrKcWgeVh28uM39rBtJb2f+QyxtTKr/hEETDVVbwwEcJZugMGnPgPqR8
         LKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bW5/8lI4JjFQ6Xag2meN8L4VITbIpxKq0yUGICqVrIc=;
        b=OgoPK74ZrYt4HHWEWEDR0CsWnAa816ayGt+WZEwugPLAz8MGPOaD6DkeHRk5okL3NA
         6ub1ABGTNjlb+q+WerNJxzJzVqb7wnSwJVPqXVRno35PVI23ZMSo0z0JPicHPOW9XbyU
         b/ZlUoRFkwPcPJwFq8aCgt7QJ5AikASaDFWZmc0ZLwSJ9jtpEjUgSAQK7z2EN+qcN/fS
         0M+2UMaVvUJ+upezlNnkiWyw8VJFOYcyacSY8iWUu7n48Wu7ry2IpRJF5bXlLd9Oky9V
         KrN6vhdSW5R3Ei1lT/BqS9Aaws9zLWx+n5e9jBoS0Rxw/RlK3fET+dMv41bpPcFwKe1N
         DFCg==
X-Gm-Message-State: AOAM530lR88Cjg/j/Hhk2bmi9bBcm7oVjgBFcJ6SIorArsGBthAlciS+
        FFqwsX2QLKLyXossvRB/oURV9r4hJBf8pET7vOU9aA==
X-Google-Smtp-Source: ABdhPJxk2brImsvQXheQLXj2NVwibLAuU32WQRqqGWEA2q1mzgCJ9lYctHlJTOcDFEPuy9bwxBxyAT2QBckrxuuAKwg=
X-Received: by 2002:a2e:98c3:0:b0:253:e0e1:20 with SMTP id s3-20020a2e98c3000000b00253e0e10020mr11709312ljj.26.1653425603309;
 Tue, 24 May 2022 13:53:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220523181503.1007987-1-masahiroy@kernel.org>
In-Reply-To: <20220523181503.1007987-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 24 May 2022 13:53:12 -0700
Message-ID: <CAKwvOdmrcmaR7vUP73UXCLaibqJ0-tiJUTL=tZQTY8buL3NwqQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: replace $(if A,A,B) with $(or A,B) in scripts/Makefile.modpost
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Schier <nicolas@fjasle.eu>
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

On Mon, May 23, 2022 at 11:16 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Similar cleanup to commit 5c8166419acf ("kbuild: replace $(if A,A,B)
> with $(or A,B)").
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  scripts/Makefile.modpost | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> index 7c3899182a4a..911606496341 100644
> --- a/scripts/Makefile.modpost
> +++ b/scripts/Makefile.modpost
> @@ -84,7 +84,7 @@ obj := $(KBUILD_EXTMOD)
>  src := $(obj)
>
>  # Include the module's Makefile to find KBUILD_EXTRA_SYMBOLS
> -include $(if $(wildcard $(src)/Kbuild), $(src)/Kbuild, $(src)/Makefile)
> +include $(or $(wildcard $(src)/Kbuild), $(src)/Makefile)
>
>  # modpost option for external modules
>  MODPOST += -e
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
