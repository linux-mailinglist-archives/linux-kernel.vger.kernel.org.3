Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAAC64D0DF9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 03:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344333AbiCHCZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 21:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbiCHCZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 21:25:36 -0500
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5278133E13;
        Mon,  7 Mar 2022 18:24:41 -0800 (PST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 2282OEl5007809;
        Tue, 8 Mar 2022 11:24:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 2282OEl5007809
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1646706254;
        bh=jaudEKd5AZONQq2c9DRIU6gE9ZvBpcFYgzLXJrL6Sw0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vdo1T6brTBldjxNLOGuqABUSsQFHzTkJ9iy2vMvvtO8UrE5EY6+KIogQkMhzIV5Xv
         RJPFvbEPgbspGqCza4NL3oooBd/5+hO+qPzdzgJaCIhTnETX0q+5g0Xrs84HoPKqT7
         ExddZnv8JSzx9yPnmZaqWidekORciqOwzvvWNGdtg2LqUDubPMGDNY5iPPidV+/bgM
         Tjx78XLwewg5D9MkiOwjXVRy+WERevZB37Bd/P2ybczPHifPKUCmpBLrSDsIKaxc4u
         1L2QnOII3ZE/oFczVoTgwceV0LGSUx1DiFzRA//gHQ4sDKOOZB/TzV1LkNwiL0HLNC
         1A6CiCQQNHnJA==
X-Nifty-SrcIP: [209.85.216.41]
Received: by mail-pj1-f41.google.com with SMTP id v1-20020a17090a088100b001bf25f97c6eso1127712pjc.0;
        Mon, 07 Mar 2022 18:24:14 -0800 (PST)
X-Gm-Message-State: AOAM5314Z6li1UmQ3f43b2+atMNV2OnZNYSr3fdwdC+s8NX01E0ZHGBz
        Ocr8ICcc+L1+wg+VX8BNPeFW34/I2xNJmH6dRZk=
X-Google-Smtp-Source: ABdhPJylfrVRKaZ5ZKNaHfBLP2L3/qRhilS0b8BTHyCxMfHdkfkwWWRu608EqycDfzkX3iMRlPIf0QClBAxYTQGO4dQ=
X-Received: by 2002:a17:902:b183:b0:14f:c266:20d5 with SMTP id
 s3-20020a170902b18300b0014fc26620d5mr15362296plr.136.1646706253754; Mon, 07
 Mar 2022 18:24:13 -0800 (PST)
MIME-Version: 1.0
References: <20220307223231.608498-1-mst@redhat.com>
In-Reply-To: <20220307223231.608498-1-mst@redhat.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 8 Mar 2022 11:23:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR=fs+VJUZJj7YyprdA6xjx=4bttPRL6e4bvNkEeX9eng@mail.gmail.com>
Message-ID: <CAK7LNAR=fs+VJUZJj7YyprdA6xjx=4bttPRL6e4bvNkEeX9eng@mail.gmail.com>
Subject: Re: [PATCH] Makefile: fix config cc version check
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 8, 2022 at 7:32 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> .config is of the form:
> CONFIG_CC_VERSION_TEXT="gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-9)"


No. This was changed.

See this:

$ git show 129ab0d2d9f -- Makefile



> while CC_VERSION_TEXT is of the form: gcc (GCC) 11.2.1 20220127 (Red Hat 11.2.1-7)
>
> thus when comparing these, CONFIG_CC_VERSION_TEXT should not
> be put in "", otherwise we get () outside "" which shell then
> tries to evaluate.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index daeb5c88b50b..d5c03c827825 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1714,9 +1714,9 @@ PHONY += prepare
>  # now expand this into a simple variable to reduce the cost of shell evaluations
>  prepare: CC_VERSION_TEXT := $(CC_VERSION_TEXT)
>  prepare:
> -       @if [ "$(CC_VERSION_TEXT)" != "$(CONFIG_CC_VERSION_TEXT)" ]; then \
> +       @if [ "$(CC_VERSION_TEXT)" != $(CONFIG_CC_VERSION_TEXT) ]; then \
>                 echo >&2 "warning: the compiler differs from the one used to build the kernel"; \
> -               echo >&2 "  The kernel was built by: $(CONFIG_CC_VERSION_TEXT)"; \
> +               echo >&2 "  The kernel was built by: "$(CONFIG_CC_VERSION_TEXT)";" \
>                 echo >&2 "  You are using:           $(CC_VERSION_TEXT)"; \
>         fi
>
> --
> MST
>


-- 
Best Regards
Masahiro Yamada
