Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0046553F165
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 23:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbiFFVHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 17:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbiFFVHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 17:07:09 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB434A0D25
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 14:01:08 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id m25so13759606lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 14:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5BDsc5bbYKzIu4e5AjWI5oj5WFwg9FG5ypm0RT2X37o=;
        b=iZ+eq6f0qWBcVlCYNFejMvOVknXgaya6vQsrOfRv5E2iTBJfRWfE2oEMvkk72BGN8P
         1uqk9LzX03yVvoLlEeom83DCV6cfeUbJiQK1Gsofqd4BK9To/8J+5Q+stX4sblXN1CEF
         hCbKErQxjth6X9engoQDKEKYwjovbroU/MpiDibY1aFHADvohuMUOwiXLfBgR3ztta9l
         IR2yy8BI+g2d+ehHKBi5pCIov8mwDyXMQZhqH4UBVLFIsHG1caIajjkyyn8apDvovzVW
         mKBxl6mcfwEpth0JFcmRFWspTYPF9c3nZlKuRks7kIQ6a9RHWxoLVw89p2BqbJH2ULj7
         WgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5BDsc5bbYKzIu4e5AjWI5oj5WFwg9FG5ypm0RT2X37o=;
        b=6BBUuxDOTqMEaRn73WBsFfqn1xcmHON0vmLN7fbPA1l2MTc0w2vMZ3rx+mKpyFd+7C
         JW65D4Rve/ihw7RrO2pgrwOG2KNLkd1DZxx3qK2f+tgcIcihP7GYvuMkk0KLNEa63DJc
         nDmkXaIsW1ojWVAaZzwJHTUw4QddxerjXoGwL5MZz1fWGigU5Sy2X/M3tEPhhZqsczSM
         1xHsXsdQ57ZWDG21sTwign73YkduM9o5A2E7yTKV6ERMd+cR+GdpTVoKdvsTzXUnjtN8
         RvvqpBMmz1lBGYz5nBOoN3DN9syUdbXpnAP3Do3Q26CLFDe39rvexCsGybLj4SrLYEF6
         Xd1g==
X-Gm-Message-State: AOAM533U3VDgttiZHXnO2OTCU+5jWVa8/xwmAVc/uuRXl/0KTafCL0kR
        Qg15DVyJa1CgF0cmIievl4vwbBTKqNpmSJnKYxE+rQ==
X-Google-Smtp-Source: ABdhPJxpi0S5lZEwAT5AwoqHhB442DYgtjabdMM2nJyKEXQHEOrBjds0gFhnJZhTC94SPT+6iZSJASpqKItPKJ1DaKk=
X-Received: by 2002:a2e:8715:0:b0:255:a7e5:d50d with SMTP id
 m21-20020a2e8715000000b00255a7e5d50dmr1182148lji.26.1654549266943; Mon, 06
 Jun 2022 14:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220530125258.3149370-1-masahiroy@kernel.org>
In-Reply-To: <20220530125258.3149370-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 6 Jun 2022 14:00:55 -0700
Message-ID: <CAKwvOdmYGmF-xVt0krTGpmJdhCVGTHbf797GyhH41CNHO+wZEQ@mail.gmail.com>
Subject: Re: [PATCH] modpost: fix section mismatch check for exported
 init/exit sections
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alessio Igor Bogani <abogani@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Rusty Russell <rusty@rustcorp.com.au>
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

On Mon, May 30, 2022 at 5:55 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Since commit f02e8a6596b7 ("module: Sort exported symbols"),
> EXPORT_SYMBOL is placed in the individual section ___ksymtab(_gpl)+<sym>
> (3 leading underscores, not 2).
>
> Since then, modpost cannot detect the bad combination of EXPORT_SYMBOL
> and __init/__exit.
>
> Fix the .fromsec to ___ksymtab*.
>
> Fixes: f02e8a6596b7 ("module: Sort exported symbols")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  scripts/mod/modpost.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 29d5a841e215..620dc8c4c814 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -980,7 +980,7 @@ static const struct sectioncheck sectioncheck[] = {
>  },
>  /* Do not export init/exit functions or data */
>  {
> -       .fromsec = { "__ksymtab*", NULL },
> +       .fromsec = { "___ksymtab*", NULL },
>         .bad_tosec = { INIT_SECTIONS, EXIT_SECTIONS, NULL },
>         .mismatch = EXPORT_TO_INIT_EXIT,
>         .symbol_white_list = { DEFAULT_SYMBOL_WHITE_LIST, NULL },
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
