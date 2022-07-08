Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095F056C56E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 02:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiGHXjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 19:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiGHXjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 19:39:21 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3661450197
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 16:39:20 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id c15so221254ljr.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 16:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MzgkqlEXtLd/v+wVSBGVjho9DoRS4811IAns7bCcuhE=;
        b=cP1Cp1ng5PycYG+Ay4ewCeYqKCQLnFr0Ax0omkY9g/v9/xFbeCgUC3B+Bjw/7RSzTu
         iR9425lhMiNeZAULZDX2OqTSIDll6BS+47pr9ZBXulmr8hfzC2wvx+Jzz0zDVVpgdNPJ
         q08dGZqQvP6ikvSY+ipe/pXzNVtCuklIa26uUel7sQMGvMKmltW4XSLugYJky/iIXzA9
         rilIIQ9EpULp6cueTU23ElAXsAPuqXfDBT4Ib/U8qYo1va7mwMXSuJFBZ1a9rrnRJtFy
         fiJqL304zhaq24Hh2dY1MW+msi9OovmdFyr2eQKvDrJsUjADIgpChs3RlvemL8RcsN7p
         KY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MzgkqlEXtLd/v+wVSBGVjho9DoRS4811IAns7bCcuhE=;
        b=X95h343lTgduvbJYPQjnrYCa1Mn4NxwiZFHzswBC+oTmcSolbdis5Xg1cU+k0pOvGZ
         W5P1m9hskExM/lkEsjWQiIgZlQh8htVvMZRGcyPmJC4CC5ZzMR0KcFhj4tRR/V6kJEEB
         h61O8dMKXolAF5zGccr9VBgt4zP/Mio4HfKkrpBhbnQwaibyoJAGKvsGHMKgCSgXmNaf
         M5UtWPkcvudKS+0kv/N0dV14MUjVd7vt5ASYKx52Tq5mWFBqhNQsjjrMe3peMYzjRxLe
         IUZfwLEDLS6ECjNssP49HCNiHsPqxmQlz7xxD0kXrNGealKrx8wBKSFvtOC/7HX9rZuL
         2gtw==
X-Gm-Message-State: AJIora+bO9FQX7mQXFy7zp8pYdmxbrI9VuoG1vIHocEw0uJ6JXQEP+L7
        cv3Xqd7Jl0oFD+v38lwLaDkAmQZvU6Rdh13qEldIlyZIaAk=
X-Google-Smtp-Source: AGRyM1vZjSv1TI8OphLcBFVwegK3L92Y52UqOTbVd4m0fDNyOGGUp8j3B+ooCd4byiBQQ9L8vZhwWjKTnrdA+cH/3Mg=
X-Received: by 2002:a05:651c:2104:b0:25b:f4ed:db93 with SMTP id
 a4-20020a05651c210400b0025bf4eddb93mr3339834ljq.295.1657323558277; Fri, 08
 Jul 2022 16:39:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220708203549.3834790-1-justinstitt@google.com>
In-Reply-To: <20220708203549.3834790-1-justinstitt@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 8 Jul 2022 16:39:06 -0700
Message-ID: <CAKwvOdm9-pJ3AUzpkJwsssk9JCq1zWQt3DugQXF9rsi7YBQC2w@mail.gmail.com>
Subject: Re: [PATCH] mei: me: fix clang -Wformat warning
To:     Justin Stitt <justinstitt@google.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
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

On Fri, Jul 8, 2022 at 1:36 PM Justin Stitt <justinstitt@google.com> wrote:
>
> When building with Clang we encounter the following warning:
> | drivers/misc/mei/hw-me.c:564:44: error: format specifies type 'unsigned
> | short' but the argument has type 'int' [-Werror,-Wformat]
> | dev_dbg(dev->dev, "empty slots = %hu.\n", empty_slots);
>
> The format specifier used is `%hu` which specifies an unsigned short,
> however, empty_slots is an int -- hence the warning.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks for the patch! This fixes the warning I observe when building
x86_64 allmodconfig with -Wno-format removed.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/misc/mei/hw-me.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
> index befa491e3344..3a95fe7d4e33 100644
> --- a/drivers/misc/mei/hw-me.c
> +++ b/drivers/misc/mei/hw-me.c
> @@ -561,7 +561,7 @@ static int mei_me_hbuf_write(struct mei_device *dev,
>         dev_dbg(dev->dev, MEI_HDR_FMT, MEI_HDR_PRM((struct mei_msg_hdr *)hdr));
>
>         empty_slots = mei_hbuf_empty_slots(dev);
> -       dev_dbg(dev->dev, "empty slots = %hu.\n", empty_slots);
> +       dev_dbg(dev->dev, "empty slots = %d.\n", empty_slots);
>
>         if (empty_slots < 0)
>                 return -EOVERFLOW;
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>


-- 
Thanks,
~Nick Desaulniers
