Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D4B4A79AC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242082AbiBBUnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347202AbiBBUnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:43:19 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D932BC061714;
        Wed,  2 Feb 2022 12:43:19 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id s18so566954ioa.12;
        Wed, 02 Feb 2022 12:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qyB3mZFViRKtoK+ZaB1dzKFHtCmielRBwsqk/DQ2WJQ=;
        b=mUVp+yHnfU+Ky+xnhzeuAas2HJgzIGVaqSkvPow3NXucLX1B/su2vti0ba/qw8x581
         2/jI+nwO+Oe2ECIk6ak3NofPP0IzJVvCUwEwqZSitjN+154j8mH2c+XKO/xTXM0T/SuJ
         li6I5HcI/xFwePbFHt8CDVUQOQ5UPkyp1pMrC7Q7sldI3q/WxSxPBg176xjV1IlNmFuG
         Fg5CNrKqWDIFfoVeV9sQTq76VKtLRaRzXQwjy7U+o1jfKpx5qjp2iT9dLSL9FOXdgRtR
         nYVYCqRapRJjZBDC5/6VCuymW1Z93T0uiWSgCnvFLeDHwJtYIvqdORtLt/9WnE7tEv55
         D3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qyB3mZFViRKtoK+ZaB1dzKFHtCmielRBwsqk/DQ2WJQ=;
        b=BwqH1klse1OxjqgS7wO1MElFwa57K76DnSdBG47W8BqlfCZ6EFYWvFCSrd/fYwM04j
         qnH2YMNNIO2kJ1kB1Ex4EcwvmcZCu8V8L6F0EVPMfvP/2rwAnI9tDTOGg1TRbZzqWIx2
         Arzw5FDJKOm3Hw9RoyMVcYbYmd/R0Z08g+f4xrlzDd3CBi2RqODjMBCdry5AIBoq/4as
         RsN2pxzs/x8jf+Qak7PcKnIfMudcJ5U45wn0xLpjqDmz8Wwdh3KemKyOE7cOvZJLNiF2
         OnY8HAaAS4RlwIuCucyneVh9pFkNt5BIMnj+k+8I9vLLFkBU5xhYgMaU0qs37HQytjLI
         2Leg==
X-Gm-Message-State: AOAM531B4WBdcWJiHB82G8pyUrfxzmUUvXRs6jdB6ryZcTI2sokEABQo
        U5OVPZX3xgkCQsRGuurJxg0NLs222P61C/YInGo=
X-Google-Smtp-Source: ABdhPJxbh04iyraHpojKt0cv3EVon4gjDwj/u225RgUEcwWEObau8d+RmMB1Zz2hYQM4ttUVK06007shVtOG+Jithqs=
X-Received: by 2002:a05:6638:382a:: with SMTP id i42mr15171407jav.256.1643834599082;
 Wed, 02 Feb 2022 12:43:19 -0800 (PST)
MIME-Version: 1.0
References: <20220131204357.1133674-1-keescook@chromium.org>
In-Reply-To: <20220131204357.1133674-1-keescook@chromium.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 2 Feb 2022 21:43:08 +0100
Message-ID: <CANiq72m+3UKC+PskuGYu_c_u1Ua-=bvkHi9Gess-59+pqXdSwA@mail.gmail.com>
Subject: Re: [PATCH] linux/const.h: Explain how __is_constexpr() works
To:     Kees Cook <keescook@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Martin Uecker <Martin.Uecker@med.uni-goettingen.de>,
        Ingo Molnar <mingo@kernel.org>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 9:43 PM Kees Cook <keescook@chromium.org> wrote:
>
> + * - The conditional operator ("... ? ... : ...") returns the type of the
> + *   operand that isn't a null pointer constant. This behavior is the

Perhaps clarify that this happens only if it fits that case? ...

> + * - If (x) is an integer constant expression, then the "* 0l" resolves it
> + *   into a null pointer constant, which forces the conditional operator
> + *   to return the type of the last operand: "(int *)".
> + * - If (x) is not an integer constant expression, then the type of the
> + *   conditional operator is from the first operand: "(void *)".

... i.e. this one happens because it is specified as returning a
pointer to void (one could read it as returning the type of the first
operand).

What about something like:

  - The behavior (including its return type) of the conditional
operator ("... ? ... : ...") depends on the kind of expressions given
for the second and third operands. This is the central mechanism of
the macro.
  - If (x) is an integer constant expression, then the "* 0l" resolves
it into a null pointer constant. When one operand is a null pointer
constant and the other is a pointer, the conditional operator returns
the type of the pointer operand; that is, "int *".
  - If (x) is not an integer constant expression, then that operand is
a pointer to void (but not a null pointer constant). When one operand
is a pointer to void and the other a pointer to an object type, the
conditional operator returns a "void *" type.

Cheers,
Miguel
