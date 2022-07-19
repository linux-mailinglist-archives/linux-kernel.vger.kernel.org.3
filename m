Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1754657A565
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239625AbiGSRcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239611AbiGSRb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:31:58 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8A45A885
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 10:31:57 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id z25so26072448lfr.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 10:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dv1bYnIgCFQyqgMxHk73wKzGxehcFImay3A0aOyYKIk=;
        b=i37X1J/iwWK1Lbon97TdOmcmYm9uKeU4xfyYFfTrkHrx2EbRHcNt2H3w1+g6GMYV9O
         GoE+oHCWYFgLOji0arAmJ03o6uWpqTbQx2QXttsYfkPD2Ywy03Kwq0hq+tg2MgWTaT9j
         TNOGYxub3NLsHi0gJGTfdtjQUQIM733/QZql/JGOLeNxytYBXj7mJEVBbOtoQXtZqssg
         piKQIGNfWkVn7hY+yDkT8Vut/KFT1ueQybSaSX6Ykn+ibZl6Rx1xj2rIVZFcgqqQFNgz
         Zqq46E/99ATJwztPON4/xffrdHnuMoPql1e8kOrIAt2abvRnmbd8qdGdrDs3POqtIGnM
         TMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dv1bYnIgCFQyqgMxHk73wKzGxehcFImay3A0aOyYKIk=;
        b=m3CyXcoxX1Ur9aq1yqO2Mt+7lT/LsxZtPUDUaiHR9P3KvNTrB9tBGj3CG9El+brngK
         0ydyOZ52TlLjzR3bmDFxfViOlp7BNLvxOY7FZiTVASmdFCZrgJwGQuN5AfakbyMlRoS9
         pimPECfQlh4AQowTYNZccahsjCZ89hHER35n33pJMhNgeFHEQaVyEVv03Uint5pL4Tl0
         4kYEcRgt9sDKc4pJoY95eKQexvxsHfI1qy6VzvNn2bOuPOk+eDaPWxCJuDpuie7r5wVP
         gN3bajjbdlvqRJCWp56s8UYHpF1yTIKUUCx1dsbDe/cncBBpHExLxYlhDOrfipAsgz/B
         s8mg==
X-Gm-Message-State: AJIora8zAIBzxILrxtPuLP2pc9WQASXSmFLNy8ipNNFud1Q8xVGlzb3D
        8yBWuOxBQojJVEQcdaPvIyh4i4OvO4WK5lpuceMOZ1JCBcc=
X-Google-Smtp-Source: AGRyM1tYCnJ7XVHFH8hAdLWTBZqk8UDwo091pxn45tcb+6X7elltQFIN+TQYiivxgb9kZSDk3vsezq3CeiMut5fETyE=
X-Received: by 2002:a05:6512:e9a:b0:489:c681:da2b with SMTP id
 bi26-20020a0565120e9a00b00489c681da2bmr17282193lfb.626.1658251915687; Tue, 19
 Jul 2022 10:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdnN67xFL22oWfqrKjvES4vjSB3KNhm401LtoC7igO+4Vg@mail.gmail.com>
 <20220718230626.1029318-1-justinstitt@google.com>
In-Reply-To: <20220718230626.1029318-1-justinstitt@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 19 Jul 2022 10:31:44 -0700
Message-ID: <CAKwvOdmbAn3cbzr9PJNCbO0oF=gLmiFBCjZRgx5eF5QjQywCmQ@mail.gmail.com>
Subject: Re: [PATCH v4] lib/test_printf.c: fix clang -Wformat warnings
To:     Justin Stitt <justinstitt@google.com>
Cc:     andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, pmladek@suse.com,
        rostedt@goodmis.org, senozhatsky@chromium.org, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Jul 18, 2022 at 4:06 PM Justin Stitt <justinstitt@google.com> wrote=
:
>
> see warnings:
> | lib/test_printf.c:157:52: error: format specifies type 'unsigned char'
> | but the argument has type 'int' [-Werror,-Wformat]
> test("0|1|1|128|255",
> | "%hhu|%hhu|%hhu|%hhu|%hhu", 0, 1, 257, 128, -1);
> -
> | lib/test_printf.c:158:55: error: format specifies type 'char' but the
> | argument has type 'int' [-Werror,-Wformat] test("0|1|1|-128|-1",
> | "%hhd|%hhd|%hhd|%hhd|%hhd", 0, 1, 257, 128, -1);
> -
> | lib/test_printf.c:159:41: error: format specifies type 'unsigned
> short'
> | but the argument has type 'int' [-Werror,-Wformat]
> | test("2015122420151225", "%ho%ho%#ho", 1037, 5282, -11627);
>
> There's an ongoing movement to eventually enable the -Wformat flag for
> clang. Previous patches have targeted incorrect usage of
> format specifiers. In this case, however, the "incorrect" format
> specifiers are intrinsically part of the test cases. Hence, fixing them
> would be misaligned with their intended purpose. My proposed fix is to
> simply disable the warnings so that one day a clean build of the kernel
> with clang (and -Wformat enabled) would be possible. It would also keep
> us in the green for alot of the CI bots.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks for humoring all of our requests. I'm happy with the result.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
> changes from v1 -> v2:
> * moved NOWARN macro definition to a more appropriate location
> * using __diag_ignore_all (thanks Nathan)
> * using local scoping for code blocks instead of __VA_ARGS__ (thanks
> * Nick)
> * indented affected test cases (thanks Andy)
>
> changes from v2 -> v3:
> * reinserted commit message
> * remove Andy's Suggested-by tag
> * add issue tracker link
>
> changes from v3 -> v4:
> * better macro indentation and usage string (thanks Nick)
>
>  lib/test_printf.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index 07309c45f327..f78044c1efaa 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -30,6 +30,12 @@
>  #define PAD_SIZE 16
>  #define FILL_CHAR '$'
>
> +#define NOWARN(option, comment, block) \
> +       __diag_push(); \
> +       __diag_ignore_all(#option, comment); \
> +       block \
> +       __diag_pop();
> +
>  KSTM_MODULE_GLOBALS();
>
>  static char *test_buffer __initdata;
> @@ -154,9 +160,11 @@ test_number(void)
>         test("0x1234abcd  ", "%#-12x", 0x1234abcd);
>         test("  0x1234abcd", "%#12x", 0x1234abcd);
>         test("0|001| 12|+123| 1234|-123|-1234", "%d|%03d|%3d|%+d|% d|%+d|=
% d", 0, 1, 12, 123, 1234, -123, -1234);
> -       test("0|1|1|128|255", "%hhu|%hhu|%hhu|%hhu|%hhu", 0, 1, 257, 128,=
 -1);
> -       test("0|1|1|-128|-1", "%hhd|%hhd|%hhd|%hhd|%hhd", 0, 1, 257, 128,=
 -1);
> -       test("2015122420151225", "%ho%ho%#ho", 1037, 5282, -11627);
> +       NOWARN(-Wformat, "Intentionally test narrowing conversion specifi=
ers.", {
> +               test("0|1|1|128|255", "%hhu|%hhu|%hhu|%hhu|%hhu", 0, 1, 2=
57, 128, -1);
> +               test("0|1|1|-128|-1", "%hhd|%hhd|%hhd|%hhd|%hhd", 0, 1, 2=
57, 128, -1);
> +               test("2015122420151225", "%ho%ho%#ho", 1037, 5282, -11627=
);
> +       })
>         /*
>          * POSIX/C99: =C2=BBThe result of converting zero with an explici=
t
>          * precision of zero shall be no characters.=C2=AB Hence the outp=
ut
> --
> 2.37.0.170.g444d1eabd0-goog
>
>


--=20
Thanks,
~Nick Desaulniers
