Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C5B50E7E2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244270AbiDYSSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234471AbiDYSSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:18:52 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB63A3B03C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:15:47 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id v4so6742146ljd.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SrA3q5vKgnexwjJdLQyRp9dPvv3gEmYky32fImzfWNM=;
        b=tnNzFQymgy81reA0SdtSKkRmjtKzwlkfCUQvGH7B7FxvRgOP5O0G6gWrASkUUAJU78
         Wrv6OHeQPTAlnp6uNUezR6QrCWigfM7Qr4RmaBg3sRQSfcwIrb2HBcHvu/yBqE8SKllL
         2OQxjHqisYomqKtQHlUL8ut+3aPahVsRSbXBFlf3l9hGtetpIBN4LaCSRdudnhHMe2Sh
         6b17AD3BIy7+qtvPATr8W9zwnaWK7/NvEwhSDicpgkY8BspqxcJn6DXfn5gMCkW4aQ/6
         ShX40NDIuY11/907JjNsLCnq8av8gmc/2vW/C/pQy1VeINHEb6+y4wju9Wv7lASvLyDm
         3J4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SrA3q5vKgnexwjJdLQyRp9dPvv3gEmYky32fImzfWNM=;
        b=63MXBr4E0IDZYJHco8GWYaWhLCey/unGUw9NGT5691LgLXaM0bO4uNLUPMIhZGHrFz
         qdOVdpa7KaSmxdZzUFwBnY5wn4kq7WubYyBewCC4Cjm6NALBlHln+myXHdofAswlx7a1
         Umhd4SoGJ15KxGmclPNgBPZn4k+Dyk/ObL9mtBnanqorSivDcziVqgfk3qwDU8xvUkrL
         qlsUfwLMvFKWS/uX0Tk03hcXhwZyEQ6QjAcEaqBUHkwwL3W05OzNuwQRFCOYfWInDtz5
         wg6ZhAtD0YuHOjNSybxauE/mm3Sx/idB/ztV0sizP/vYupJKgi5eAoP1o4wuXMSPIO86
         121g==
X-Gm-Message-State: AOAM532zCphH4iRcNx/r5APHqEIduOSOb6UJ+wpVDZmxOgkYZn+JKIiT
        z6T9gS1t/Br7YWgGLDE5MhGxTRIaeE1doTfzieBqYw==
X-Google-Smtp-Source: ABdhPJxEwBsQ97Hw9qzkEutYtpAQSiAjp3/B7GwVMw1cNq5pD2OtsI7/Yv6zprYNpd1nT+AQEBddlzn5NaXA2ilTuWU=
X-Received: by 2002:a05:651c:553:b0:24f:18c1:d2a1 with SMTP id
 q19-20020a05651c055300b0024f18c1d2a1mr391342ljp.239.1650910545571; Mon, 25
 Apr 2022 11:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220424190811.1678416-1-masahiroy@kernel.org> <20220424190811.1678416-3-masahiroy@kernel.org>
In-Reply-To: <20220424190811.1678416-3-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 25 Apr 2022 11:15:28 -0700
Message-ID: <CAKwvOdnTh+qVRHsQ3YRrZ8b22wmfVUQ3eLd7R8VHJgNw7WA=MQ@mail.gmail.com>
Subject: Re: [PATCH 02/27] modpost: do not write out any file when error occurred
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 12:09 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> If an error occurs, modpost will fail anyway. Do not write out
> any content (, which might be invalid).
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

The callers could probably do less work before calling write_buf, too,
but this is ok.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  scripts/mod/modpost.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 141370ebbfd3..f0d48f65fb33 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -2333,6 +2333,9 @@ static void write_buf(struct buffer *b, const char *fname)
>  {
>         FILE *file;
>
> +       if (error_occurred)
> +               return;
> +
>         file = fopen(fname, "w");
>         if (!file) {
>                 perror(fname);
> --
> 2.32.0
>


-- 
Thanks,
~Nick Desaulniers
