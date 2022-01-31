Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0081D4A4F33
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 20:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359165AbiAaTJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 14:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235245AbiAaTJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 14:09:41 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15298C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 11:09:41 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id q22so20798426ljh.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 11:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Ok0BFBVUs/aGLvZ8hIj39mJA1z2SbFZGpjd3f3p7Vg=;
        b=hX0xetF3Nl2xlWjDIF6C04FvfYjWAUNtF9/XaoMWge4H3R+tddXnppQBiNsE0QcTf2
         H1VLpE42C+1XDt+SPkmPcrXc+e5QUUVrzLLDhqapMhQ0cidbmLUZZ/2vX3Wacu7dyBxV
         Lh8kF3a4RuCGstgCCYTqIB+JyzvN46ciBhUsVNy/FS8vcwjWfECmOJNm+wgYUCFefL1M
         XUAeYfLXSWd6OTzBH/X9ZmXihVo+k4wq0R9j+D7BO9kOyjrCttYyR+72q4YPJbkP9z5o
         fWAhJ2aD/U2rBALByHUFY/TdI3p24zf2WUC2OpgmsXuJaqrlVpDqUy/pQvlF7nYYsZWG
         vbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Ok0BFBVUs/aGLvZ8hIj39mJA1z2SbFZGpjd3f3p7Vg=;
        b=qdfjoumSPocfG/zDi5O+yQDSO4/qDR2xoLhVVA5dSu6P3IyMJhUJVEFLph6HJz+oZS
         zLFpGCYbiRS1l70yorON5PzXjwribIWnuNeW24pppq8Qx/g2RlKx8kkwzZ34oVPZ4QZN
         1g1iZMbq7CQHqI5A2jpPnCl+0eKdZtPpvqOj7inrJdMrG0soFhlglb1AdKb9AVBRN0Xb
         LQVmhLQcoPGVDajDGjRGhELitxPEbnOJ4icYoDUEfn7eSwJVmwhRwchqiBwDQ7mSkDc4
         BfPNTnrs5F8RJVSELE9G+RlxbGSdhgsLS3w5P0GVLFzKrNWGtnyhCA7URkNBoupBMi5g
         eJ6Q==
X-Gm-Message-State: AOAM533zbVZ/KwAu964ijDumXedfJH8JorZnTqYJDLKm/k8wlkxOZk5/
        No2poLN+6pLCVDYpZhiMrWL7LAtUz8A++OrRh3sKDA==
X-Google-Smtp-Source: ABdhPJyfrhQq8UNHudmznONYOwVRAN5a2rNhHhfUuvRoigSmkENJcxC7SBSpqD9IcWpP8HXdLEAMEzjLZqVgJINMisE=
X-Received: by 2002:a05:651c:1253:: with SMTP id h19mr5956839ljh.338.1643656179244;
 Mon, 31 Jan 2022 11:09:39 -0800 (PST)
MIME-Version: 1.0
References: <20220130181616.420092-1-keescook@chromium.org>
In-Reply-To: <20220130181616.420092-1-keescook@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 31 Jan 2022 11:09:27 -0800
Message-ID: <CAKwvOdmETY-j9B9vms4d31kAc0xb1yE902KijiH2baY5-M=fLQ@mail.gmail.com>
Subject: Re: [PATCH] fortify: Update compile-time tests for Clang 14
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 10:16 AM Kees Cook <keescook@chromium.org> wrote:
>
> Clang 14 introduces support for compiletime_assert(). Update the
> compile-time warning regex to catch Clang's variant of the warning text
> in preparation for Clang supporting CONFIG_FORTIFY_SOURCE.

https://twitter.com/ifosteve/status/1190348262500421634?lang=en
error messages can change over time. More thoughts below.

>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: linux-hardening@vger.kernel.org
> Cc: llvm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> I'm splitting this patch out of the main Clang FORTIFY enabling patch.
> ---
>  scripts/test_fortify.sh | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/test_fortify.sh b/scripts/test_fortify.sh
> index a4da365508f0..c2688ab8281d 100644
> --- a/scripts/test_fortify.sh
> +++ b/scripts/test_fortify.sh
> @@ -46,8 +46,12 @@ if "$@" -Werror -c "$IN" -o "$OUT".o 2> "$TMP" ; then
>                 status="warning: unsafe ${FUNC}() usage lacked '$WANT' symbol in $IN"
>         fi
>  else
> -       # If the build failed, check for the warning in the stderr (gcc).
> -       if ! grep -q -m1 "error: call to .\b${WANT}\b." "$TMP" ; then
> +       # If the build failed, check for the warning in the stderr.
> +       # GCC:
> +       # ./include/linux/fortify-string.h:316:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
> +       # Clang 14:
> +       # ./include/linux/fortify-string.h:316:4: error: call to __write_overflow_field declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror,-Wattribute-warning]
> +       if ! grep -Eq -m1 "error: call to .?\b${WANT}\b.?" "$TMP" ; then

Doesn't this depend on -Werror being set? I guess it did so before
hand, too, but couldn't I unset CONFIG_WERROR then this check would
still fail (since instead of `error:` we'd have `warning:`)? If we
used __attribute__((error(""))) then this would always be an error.
Right now, it is only because -Werror is set promoting the warning
diagnostic to an error.

>                 status="warning: unsafe ${FUNC}() usage lacked '$WANT' warning in $IN"
>         fi
>  fi
> --
> 2.30.2
>


-- 
Thanks,
~Nick Desaulniers
