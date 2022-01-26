Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0D749D124
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243823AbiAZRty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237190AbiAZRtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:49:53 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E40C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:49:52 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b9so423159lfq.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WmqGKC4xQawqKboaNiLBn0or4cSkyVr5JGe27OnIXqE=;
        b=f1lwMnsFln7jwIlKeNRMgWZPMKNtP0Jo/oZ3+o0dmsT4mbbG58Z3vrUxOVRIfpRKZb
         IUlDgx0olo1pwkNhQ0LYYGvdES8EkuWgoQekAL+ZTIGywebhQ6lMi995unOcQOQOrHbu
         TAKhciwaZT/Kvn+SwoXK4IsxnMvo/tuA+LGUPimURVZPI47xkMq/FYYue2FiddLWcOG8
         8l4nDfpuPdg8IP+16WNdnWOr1iBN5+r7D11yWI5UQvLGY0hdYmSfRe4qAyxMWYMO1bEc
         OjJ1yd25qS46TxqqbKmkIwaLBni4gRvodCECLApDTY3gKfHSyIr+fm1X4z3WtHhh405l
         WRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WmqGKC4xQawqKboaNiLBn0or4cSkyVr5JGe27OnIXqE=;
        b=KxJnYFxcG9e0g8A3HOq6Z9MvIxJ4KBYcQS9wOonS8CFtPENxpPKqg3wbLCN2q8dSU+
         oQYsPZ3dzD7NAmbczuDry2lDUWK7zd4UFiou0z89GIwOeuuiXSFDdr/0Xq6592hD/EV9
         VrodSh6iUhwmgUuNUoWWEob38f5Q3g5A069CRjTcx+bsuILBLdLHMBX8/NkldVvP2TVD
         ztDQnmpoabaKJwRsy5BMeLMWHPjn5qi2PBT3dfGwFntl7SC6OORAv209H4vAKA5E9HGa
         iLWL1HoeUthpgntPqxSEck+wFUDbdWeVOtVCUNnoWEolEwKxEFnYZA766TdZGdxo8H8g
         WQvQ==
X-Gm-Message-State: AOAM5337Lo6aVJKwNJuuzTGb0Zu6ZVong8vJEEWbnEtHWPVRXUH1RGUF
        NB00y5CxCTPdCZCWpnKg74ub4SGRlAaKHcaKIgNCyg==
X-Google-Smtp-Source: ABdhPJyh1s08ERde5TjNYji88g4oR4j7/LzUI/PAKpMTs6IpknOwPL6wW6hnoMCoRCvwncLnEC0ti0uu3ea8HNxoMt8=
X-Received: by 2002:ac2:5510:: with SMTP id j16mr44355lfk.240.1643219390726;
 Wed, 26 Jan 2022 09:49:50 -0800 (PST)
MIME-Version: 1.0
References: <20220126141917.75399-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220126141917.75399-1-andriy.shevchenko@linux.intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 26 Jan 2022 09:49:38 -0800
Message-ID: <CAKwvOdkBAe4qMdFgDFWNLHMsJrW+PBwa7-hAL5T9fReQqNiF7g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] string: Make stpcpy() possible to use
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Francis Laniel <laniel_francis@privacyrequired.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        kernel test robot <lkp@intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 6:19 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> It is a good rule to avoid submitting code without users.
> Currently the stpcpy() is unusable due to missed declaration.
> Any attempts to use it will bring something like:
>
>   error: implicit declaration of function =E2=80=98stpcpy=E2=80=99 [-Werr=
or=3Dimplicit-function-declaration]
>
> Move declaration to the header and guard it as other string functions.
>
> Fixes: 1e1b6d63d634 ("lib/string.c: implement stpcpy")
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Recall the discussion from Kees:
https://lore.kernel.org/lkml/CAK7LNAQXo5-5W6hvNMEVPBPf3tRWaf-pQdSR-0OHyi4RC=
GhjsQ@mail.gmail.com/
and
https://lore.kernel.org/lkml/202008150921.B70721A359@keescook/

I'm guessing that the 0day bot report was on the third patch in this
series, which looks to use stpcpy:
https://lore.kernel.org/lkml/20220126141917.75399-3-andriy.shevchenko@linux=
.intel.com/

for patch 3, I'd s/"compress"/de-duplicate/ or s/"compress"/merge/.

Kees, I'm curious if we can do something like require the string
length to be known at compile time otherwise BUILD_BUG_ON?

> ---
> v3: new patch to fix reported issue
>  include/linux/string.h | 3 +++
>  lib/string.c           | 3 ++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/string.h b/include/linux/string.h
> index b6572aeca2f5..b1aeb3475396 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -31,6 +31,9 @@ size_t strlcpy(char *, const char *, size_t);
>  #ifndef __HAVE_ARCH_STRSCPY
>  ssize_t strscpy(char *, const char *, size_t);
>  #endif
> +#ifndef __HAVE_ARCH_STPCPY
> +char *stpcpy(char *__restrict__ dest, const char *__restrict__ src);
> +#endif
>
>  /* Wraps calls to strscpy()/memset(), no arch specific code required */
>  ssize_t strscpy_pad(char *dest, const char *src, size_t count);
> diff --git a/lib/string.c b/lib/string.c
> index 485777c9da83..4ecb8ec1fdd1 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -233,6 +233,7 @@ ssize_t strscpy(char *dest, const char *src, size_t c=
ount)
>  EXPORT_SYMBOL(strscpy);
>  #endif
>
> +#ifndef __HAVE_ARCH_STPCPY
>  /**
>   * stpcpy - copy a string from src to dest returning a pointer to the ne=
w end
>   *          of dest, including src's %NUL-terminator. May overrun dest.
> @@ -248,7 +249,6 @@ EXPORT_SYMBOL(strscpy);
>   * not recommended for usage. Instead, its definition is provided in cas=
e
>   * the compiler lowers other libcalls to stpcpy.
>   */
> -char *stpcpy(char *__restrict__ dest, const char *__restrict__ src);
>  char *stpcpy(char *__restrict__ dest, const char *__restrict__ src)
>  {
>         while ((*dest++ =3D *src++) !=3D '\0')
> @@ -256,6 +256,7 @@ char *stpcpy(char *__restrict__ dest, const char *__r=
estrict__ src)
>         return --dest;
>  }
>  EXPORT_SYMBOL(stpcpy);
> +#endif
>
>  #ifndef __HAVE_ARCH_STRCAT
>  /**
> --
> 2.34.1
>


--=20
Thanks,
~Nick Desaulniers
