Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6100051D0A4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 07:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378069AbiEFFaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 01:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389208AbiEFFaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 01:30:22 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4BB66ACB;
        Thu,  5 May 2022 22:26:24 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id i22so4188923ila.1;
        Thu, 05 May 2022 22:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=btRfdC3/ebasVHvh6uBMVKIVD47Na90nsM4/u+AC2ZM=;
        b=csQ7RZUtRH6jQJGzwUTsP8YRSCyTNZYFEEs5nHcuj27V2/BbiCk22oZe28NzwdR5Y6
         /+icHCwD+cPSuiC5HXHZdW2ufqsDeIvtMO9bgJ8mdYI45dusdxQimS3BV7wHCzUO1RL8
         40aIWruIi6OuClhmuetnsCyV1nKDBV0Jt0r/7BzpOrZp1JR6zzGa4oMJ8eUy3HvTxIea
         d2KEntj7H2lcf/5fCxonDp5ZlPphExdTd/vLOvA0WX5infw2wPeOYxn0t86Jzdj37b1y
         Tdr9HQrrz4domCTJaqWB+k0JHbRJDhtfkEa+Ma+Qn5JtOtIPBVxv/whExZHUXAE60GAI
         GLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=btRfdC3/ebasVHvh6uBMVKIVD47Na90nsM4/u+AC2ZM=;
        b=g8fRmnHwUBYmuOcyUGe7+AisMiea1Hmt1nIhu7TvZCCtfhtaaZBsxRP4A9rqzK+U1h
         HnuX9vslN1W46bs0DHm1LVQ5NAXHYN6B8KTVx01vNBnarEZWY7jByzoB0P/enFLLc044
         F2L39Jhj0kKEctYGqAC0DUIbp6S6l/5HoQIGdxlqvuifdxfRxBiYRC3RxfARTFzUHqRw
         /1lHvek52+QfxE1IXan6PWEoKJZE0ws+FdSRfiFrueta0cOervaJKcQZaVE8AETXwt5S
         UCiNJwz1h7H+MxiAvjVr4Bj9H94UzLBtZJ2bUYSYuRMsVqYRSYuJ0KuZjF9IQ9x9rAvy
         0oHg==
X-Gm-Message-State: AOAM5326TYhmLlsZAv5cZ7FGEXXUkhYl5rOa2YOTgdhNeaIaHFPgZHSa
        ozypv8IVwZiohmPdd3Z6R8YGOneNYxA4AmymhpU=
X-Google-Smtp-Source: ABdhPJyeIUrhz3EpREFg1AsHHMUf4LhxfAFGKKfYPJemYWqV0jWB1mOS4wrsMq7C8VUTYVLdfmaDY3VDmVi0y+nojG0=
X-Received: by 2002:a05:6e02:152e:b0:2cf:548d:a400 with SMTP id
 i14-20020a056e02152e00b002cf548da400mr715860ilu.72.1651814783766; Thu, 05 May
 2022 22:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220505191704.22812-1-ojeda@kernel.org> <20220505191704.22812-2-ojeda@kernel.org>
 <202205051643.1A8E38C7F2@keescook>
In-Reply-To: <202205051643.1A8E38C7F2@keescook>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 6 May 2022 07:26:12 +0200
Message-ID: <CANiq72n+g_=QQcSuE13+58j+PCuqLEyCusEUqMKFywR8UKHK6g@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] kallsyms: avoid hardcoding the buffer size
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 6, 2022 at 1:46 AM Kees Cook <keescook@chromium.org> wrote:
>
> No need to repeat the sizing:
>
>         fgets(name, sizeof(name), in)

Definitely.

> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks for the three reviews!

Cheers,
Miguel
