Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB3A4A5CC6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 14:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238325AbiBANF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 08:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237005AbiBANF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 08:05:57 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36662C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 05:05:57 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id s13so54186167ejy.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 05:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pnoo7aJhLt3YDqvvu10ioozSGr7iFA5VpsVCHoexJmU=;
        b=hfjfGzE4fj2e6NFgYx9uOoqRuxQ2PRIvBkLuNm8EypMiyBwPIaitM1ZyCVCm0jYS1t
         6V3O+NL80f3wnhUpw5e+Ei7Z21xjKvj7vf0fzAghhlbXSTK+zAirWBku415yuBhpM0ZD
         bohEsWDP28NcL9hblm0Maswp4MsUO9jK7S5/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pnoo7aJhLt3YDqvvu10ioozSGr7iFA5VpsVCHoexJmU=;
        b=WSyN+0ho/Wl48rK0o3IYrl58hEfvhxCmRn9a8/Jdlc+OboWLDIOSfZ0QIFZkIHspCV
         56wMwQ9R7deVF/GGPtYvShoju8lV7GwNVyF8b/HqDevFOJqWaqACHJaSsHnlJDnZvTk0
         3NNZ6CUkLCvokC9edMfsxSOJC1SKIVIAyzkQ97MimQYMn0m0y8TyOA+87kpM5HHFE7yw
         L5JroSxqYTq2b5O9c0hnhRVmPSQsng+VeHHlM1XvZsChDLZoswvUp++vJ5dIrrelq960
         VeuUpLwoo94eASAiq3aAZpq/33vq/dMraxh4oeeOMKAb66O5KXBomwuYGbq/uxq3YJnm
         wkEg==
X-Gm-Message-State: AOAM530yFAUir7G5V0Tg2pke1346zLxm6VzyO98KImwWE5j1te/1kpEL
        stvBFaFktlw215lckX6MyUBiXQ==
X-Google-Smtp-Source: ABdhPJwzCZMvsuY5E8PIB2VKBud6R0MMtKxxkgmArxECA2N5Qe7EvBfhEiq/lXx9Xs92PrjvMZgZmQ==
X-Received: by 2002:a17:907:82a3:: with SMTP id mr35mr21304067ejc.455.1643720755701;
        Tue, 01 Feb 2022 05:05:55 -0800 (PST)
Received: from [192.168.1.149] ([80.208.64.233])
        by smtp.gmail.com with ESMTPSA id c2sm19380943edj.24.2022.02.01.05.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 05:05:54 -0800 (PST)
Subject: Re: [PATCH] linux/const.h: Explain how __is_constexpr() works
To:     Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Martin Uecker <Martin.Uecker@med.uni-goettingen.de>,
        Ingo Molnar <mingo@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20220131204357.1133674-1-keescook@chromium.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <dc86fdf7-3202-e836-6f71-af1e2458b105@rasmusvillemoes.dk>
Date:   Tue, 1 Feb 2022 14:05:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220131204357.1133674-1-keescook@chromium.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2022 21.43, Kees Cook wrote:
> The __is_constexpr() macro is dark magic. Shed some light on it with
> a comment to explain how and why it works.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Cc: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Jon, since this is pure comment, do you want to take it through the docs tree?
> ---
>  include/linux/const.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/include/linux/const.h b/include/linux/const.h
> index 435ddd72d2c4..7122d6a1f8ce 100644
> --- a/include/linux/const.h
> +++ b/include/linux/const.h
> @@ -7,6 +7,30 @@
>   * This returns a constant expression while determining if an argument is
>   * a constant expression, most importantly without evaluating the argument.
>   * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
> + *
> + * Details:
> + * - sizeof() is an integer constant expression, and does not evaluate the
> + *   value of its operand; it only examines the type of its operand.
> + * - The results of comparing two integer constant expressions is also
> + *   an integer constant expression.
> + * - The use of literal "8" is to avoid warnings about unaligned pointers;
> + *   these could otherwise just be "1"s.

Just the second 8, the first could be a 0 or 12345 or whatever.

> + * - (long)(x) is used to avoid warnings about 64-bit types on 32-bit
> + *   architectures.
> + * - The C standard defines an "integer constant expression" as different
> + *   from a "null pointer constant" (an integer constant 0 pointer).

I don't see the point of this bullet. Yes, an ICE is a distinct concept
from a null pointer constant, obviously. One is defined in terms of the
other - and your parenthesis is not an accurate paraphrase of the
definition of a null pointer constant.

> + * - The conditional operator ("... ? ... : ...") returns the type of the
> + *   operand that isn't a null pointer constant. This behavior is the
> + *   central mechanism of the macro.
> + * - If (x) is an integer constant expression, then the "* 0l" resolves it
> + *   into a null pointer constant

yes, because then it becomes "An integer constant expression with the
value 0,".

, which forces the conditional operator
> + *   to return the type of the last operand: "(int *)".
> + * - If (x) is not an integer constant expression, then the type of the
> + *   conditional operator is from the first operand: "(void *)".

Not entirely correct (and by "first" you probably meant second). It's
better to just quote chapter-and-verse.

C99, 6.5.15.6:

[...]
if one operand is a
null pointer constant, the result has the type of the other operand;
otherwise, one operand
is a pointer to void or a qualified version of void, in which case the
result type is a
pointer to an appropriately qualified version of void.

I.e., the second and third operands are treated symmetrically in the
standard.

> + * - sizeof(int) == 4 and sizeof(void) == 1.
> + * - The ultimate comparison to "sizeof(int)" chooses between either:
> + *     sizeof(*((int *) (8)) == sizeof(int)   (x was a constant expression)
> + *     sizeof(*((void *)(8)) == sizeof(void)  (x was not a constant expression)

Actually, since the first operand (the condition) is a non-zero number,
the _value_ of the whole expression is the value of the _second_
operand, but with a _type_ determined by the above rules. So the whole
ternary operator evalutes to either

  (void *)((void *)((long)(x) * 0l))

or

  (int *)((void *)((long)(x) * 0l))


I don't think adding slightly inaccurate comments would help a future
reader at all. Then it's better to just stick to Linus' "it's art, and
art should not be explained".

Rasmus
