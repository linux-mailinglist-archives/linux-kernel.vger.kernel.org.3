Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296AF578D31
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 00:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236403AbiGRWAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbiGRWAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:00:38 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A5530569
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:00:37 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id u13so21721027lfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 15:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4LCLHgQVQuXh0W/cqwPKu45ik98XylTXSBFO2vmTL+g=;
        b=j5ZRqt6bbWc4wkqolT6AXcJVpi/kkId/WpIKSB2kv3l3leT/RFiY1Juj3mdIudCBHP
         V2fxKSqCETby/Ndly0e/sKtL5++LF3KC6mRb5hprroZZcMk7KgUr/nmfXNGBU+IXo7/f
         Lj4wmEYEV7OcorVp315Zwmf45QIVssR3yFJSOTHAh1iFlnWIybUtVwyf5KPMplWED1I3
         KcifCpwyCcwMs56wjcCQn8TY26dkay+B4YTNt2dCbeR4sq6O/KwYd1NuPMm1bCnqZC/+
         CS9GyvMNmcEthsrj0qBLy/pkdVJacJ48CW8C2KNON0AnERavShMGU38d4z+TDU2SB0+s
         2mGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4LCLHgQVQuXh0W/cqwPKu45ik98XylTXSBFO2vmTL+g=;
        b=TE38IqsOw+f84VFf0UpQrgnA/zy0TPihFR/GYu0gTZBwN2RHaYviJnvqNMkRRFP6Vy
         cQqSEGYXYPgGArdPFBZDBB6XEz7CKBjKB7H/0q4yoMk+rv/yLmidzX0hhqtMhAHJIfHn
         AiPRMoHIkkyNwxpeP6NhpOyDxA4ts6nQomnoDTEw8/MEniwLlvRXx1gc440ww7qzlLvz
         8ihgNuz+ETkU6h6pCDVIYOBpjbxxnwtyYZ31X1h/h3r5Z1d3Ky1ZNVrEA5FuBO2E4ZPG
         4ilTHPUAnTGba0HHwXGp78mUn+lHP152agyVM65MeTfWJm1nUHUZoRJi2/x/UmaKUDmb
         Z6xQ==
X-Gm-Message-State: AJIora8VmRTK4fbQH/AVRPplJdqlhGe3N4s2exkhQYeCyBHaZ8H3PpDu
        y31m+P1fOnbh0SRl8OHdqUPIzM+sIB/c1ME9DwXF0A==
X-Google-Smtp-Source: AGRyM1sLA1Yy8ek17iu9KSUkDUlL9KugMNkQWspyJLCV7p6tBEDx2AlBJ0xbtaPU3/afk/wiEAE4EzJ9F8P1iJ16gHE=
X-Received: by 2002:a05:6512:e9a:b0:489:c681:da2b with SMTP id
 bi26-20020a0565120e9a00b00489c681da2bmr15211089lfb.626.1658181635855; Mon, 18
 Jul 2022 15:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220629235326.480858-1-justinstitt@google.com> <20220718172934.4155189-1-justinstitt@google.com>
In-Reply-To: <20220718172934.4155189-1-justinstitt@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 18 Jul 2022 15:00:24 -0700
Message-ID: <CAKwvOdnN67xFL22oWfqrKjvES4vjSB3KNhm401LtoC7igO+4Vg@mail.gmail.com>
Subject: Re: [PATCH v3] lib/test_printf.c: fix clang -Wformat warnings
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

/On Mon, Jul 18, 2022 at 10:29 AM Justin Stitt <justinstitt@google.com> wro=
te:
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
> ---
> changes from v1 -> v2:
> * moved NOWARN macro definition to a more appropriate location
> * using __diag_ignore_all (thanks Nathan)
> * using local scoping for code blocks instead of __VA_ARGS__ (thanks Nick=
)
> * indented affected test cases (thanks Andy)
>
> changes from v2 -> v3:
> * reinserted commit message
> * remove Andy's Suggested-by tag
> * add issue tracker link
>
>  lib/test_printf.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index 07309c45f327..1b1755ce9fa7 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -30,6 +30,9 @@
>  #define PAD_SIZE 16
>  #define FILL_CHAR '$'
>
> +#define NOWARN(option, comment, block) \
> +               __diag_push() __diag_ignore_all(#option, comment) block _=
_diag_pop()

Do you mind putting these 4 on distinct lines with \ at the end of the
lines, and terminate the statements with an additional ; if that
doesn't produce new warnings about empty statements? Maybe something
like:

+#define NOWARN(option, comment, block) \
+  __diag_push(); \
+  __diag_ignore_all(#option, comment); \
+ block \
+ __diag_pop();

(sorry for not formatting that myself, remember to use tabs vs
spaces).  To me, it seems more readable from a quick glance to have
these be distinct lines.  You'll find open coded uses of __diag_push
and friends add the semicolon, even if not strictly necessary.

> +
>  KSTM_MODULE_GLOBALS();
>
>  static char *test_buffer __initdata;
> @@ -154,9 +157,11 @@ test_number(void)
>         test("0x1234abcd  ", "%#-12x", 0x1234abcd);
>         test("  0x1234abcd", "%#12x", 0x1234abcd);
>         test("0|001| 12|+123| 1234|-123|-1234", "%d|%03d|%3d|%+d|% d|%+d|=
% d", 0, 1, 12, 123, 1234, -123, -1234);
> -       test("0|1|1|128|255", "%hhu|%hhu|%hhu|%hhu|%hhu", 0, 1, 257, 128,=
 -1);
> -       test("0|1|1|-128|-1", "%hhd|%hhd|%hhd|%hhd|%hhd", 0, 1, 257, 128,=
 -1);
> -       test("2015122420151225", "%ho%ho%#ho", 1037, 5282, -11627);
> +       NOWARN(-Wformat, "Disables clang -Wformat warning", {

Technically, this is disabling -Wformat for all compilers.  How about
a comment string like "Intentionally test narrowing conversion
specifiers"?

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
> 2.37.0.rc0.161.g10f37bed90-goog
>


--=20
Thanks,
~Nick Desaulniers
