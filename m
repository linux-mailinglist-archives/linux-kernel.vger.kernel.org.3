Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBAF4EB2AD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 19:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiC2R2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 13:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239139AbiC2R2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 13:28:13 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BAF25B903
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 10:26:30 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id g24so24340473lja.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 10:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lvT/B5UyGGfXB9H/0ToFtVxAgxElFg49xc7wYGAcXVk=;
        b=im10hmyQ5qCy+ZyjDuG3axiiK0atBzb6fC/VLF6Rer8NEmi/WqQsBpPa27g123Pjxx
         c17H1FzBE/heoVIlaMMnBHQYQcJN0st9uHhPT4pZO36m/kVF+wSmZ8IyPv9k7aqBgJBs
         rjviRIhlX99slvazNJ0/ilL2hgkq0vO1LQTD/lO1fYs0yTza3IlmJfucWhiy5MU+UZiL
         hSw1YLOkf/ENK9JfjryhtDUunGqyQtxZS8tO+lFTWG7C/wmkYF1Zjht3fpgmiQuZ5+JA
         GKneT7H2jtkQGPLjiO2WC7p31pi3KdriviLlYl/dg7OIW46sEG0JlcQVB7DYpoib6LWl
         MH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lvT/B5UyGGfXB9H/0ToFtVxAgxElFg49xc7wYGAcXVk=;
        b=HT948Z+x2xFUqHEO1QdXrtWH7et1zDF8GNEZ+EkJIOJZOZvComB0mTwbgYxzoGCmeo
         nh2MKzzCaWqXSsOGkwg+N8leXu9/hS2Wc34q3Rir5n0gIWYsZGE9UqfxJgfVGs5kZ0/6
         Jyey/IW/fwoEY8XNONnBjGfcKfIDeThY0hwP+Steb+T7RFmm6ELDLvy/TMKfm3BK0fMz
         8elTA66YLwVcCkLRQGwlbgnB4LwzZvuodABVX7PYfcqWq42XzxjLoLQphdNtTh4rLZpZ
         cfZR3x08DX4ynxJ57ebovyeHnDzd6L+2i1BSW+Usk+jwJ02/8UTteqLOaIsr3bsg1qcp
         eXhw==
X-Gm-Message-State: AOAM532lSXWcS5JY6J6qRhOtkoOy6SvtjBqCc+PVSMrHrvEbIeqhL13P
        BtGy3U6rtbKwnqjVxFzwlRp8TEwdGCby+QcOjF1HMEP+CW9RnA==
X-Google-Smtp-Source: ABdhPJxwSBWNiTH2PffW5bH1OLZ2NnJhXodXOyfGKs5tkoYM2T6fdCD0I0cwrpUiTaPInh2XEVaXFnL4ZPvANmU8VHE=
X-Received: by 2002:a2e:611a:0:b0:249:83e5:9f9b with SMTP id
 v26-20020a2e611a000000b0024983e59f9bmr3659783ljb.165.1648574787837; Tue, 29
 Mar 2022 10:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220329021437.308790-1-masahiroy@kernel.org>
In-Reply-To: <20220329021437.308790-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 29 Mar 2022 10:26:16 -0700
Message-ID: <CAKwvOd=z5BQcQnhkgMOpZXPLkggmdPo=jvZxXkfVG7D8GuEYRw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: fix empty ${PYTHON} in scripts/link-vmlinux.sh
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

On Mon, Mar 28, 2022 at 7:15 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> The two commits
>
>   d8d2d38275c1 ("kbuild: remove PYTHON variable")
>   a8cccdd95473 ("init: lto: ensure initcall ordering")
>
> were applied in the same development cycle, in two different trees.
>
> After they were merged together, this ${PYTHON} expands to an empty
> string.
>
> Therefore, ${srctree}/scripts/jobserver-exec is executed directly.
> (it has the executable bit set)
>
> This is working but let's fix the code into the intended form.

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/link-vmlinux.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index f704034ebbe6..20f44504a644 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -50,7 +50,7 @@ gen_initcalls()
>  {
>         info GEN .tmp_initcalls.lds
>
> -       ${PYTHON} ${srctree}/scripts/jobserver-exec             \
> +       ${PYTHON3} ${srctree}/scripts/jobserver-exec            \
>         ${PERL} ${srctree}/scripts/generate_initcall_order.pl   \
>                 ${KBUILD_VMLINUX_OBJS} ${KBUILD_VMLINUX_LIBS}   \
>                 > .tmp_initcalls.lds
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
