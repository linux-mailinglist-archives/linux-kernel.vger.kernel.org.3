Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7D9597A5B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 01:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241981AbiHQXrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 19:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbiHQXrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 19:47:04 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F8B2C0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 16:47:03 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-11ba6e79dd1so52022fac.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 16:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=aC7spQ6mns9sY6bME9cmTBRezYWt8Xqt9i5kKnlkce0=;
        b=E9wDbev/vIC2PFpjKf4QDSJ08Yp16HZi71i6DBOqdIoEQlg61bSJ8/DHcgomgXjWm8
         WJlctaEvn305HmzX7t6fFRqmBppikwH5yzqNZeEaEiJESA5ck54O71gHxxWS+DlOT/li
         cck4XHYzc7uBrrz8VlHctXh0fBxvXBcBXTWMLrX3Rr8j0kLIa22r4WeqEfEF3Hlw6cTl
         Is78+KVPhxEEp7tW33c7Xw3r7ZDjZFRrMw2BaNbO1TkaQ9f18SweXKEJPSd3tnMq60HZ
         aU5N3S2xExJzuUrG0PLbDG0C5nKCPs7iCXPl/aVgbzcuiEd10FngcCNw4F9r/36TTkGA
         fwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=aC7spQ6mns9sY6bME9cmTBRezYWt8Xqt9i5kKnlkce0=;
        b=pZj7HCuKcRdpf0QfhM/19DNz+FJPeM9FLP0lqf0E1ctucQO2Xddz8OEBM3j70qxGNA
         B6BBnEpoK9hoBz8BU8Em0kbe1t5/v0Ru262EXd9ADkQF+Ivl0xgBmPCv+MIAbElD2eIC
         pRuuTMcigDmNEVCVyNOqYd59DMzbjfbvMWdBjhEQF099LEC945O8HXwjcpNbmo75si+Y
         2mA7k/gO/GK05lV4PknDJWSpCPAcrmwWv+111lqlhtTc0+Xw485+9zYyw9oiZyNgzv/5
         vqQVvLwzreC+wK/VTN+KCwleubJxl2O2ENLyOh2XzFICg7r1Q8PshHkaY43nlju4uENV
         pgfQ==
X-Gm-Message-State: ACgBeo04xycFs7/rPixK7Q+y4uGbLAMWRFbGxAGsYgKSHa16JRothoYw
        wKRtGyrtg8bjE+zGPwgJLH9NyDJDg5wmi/BKLlqox1QplclAdQ==
X-Google-Smtp-Source: AA6agR45y2Rwb52uDHZLOXUFDpVpW8zrJBCmPQV1F4U0zRr0kpa4dPvDPXEN5HehPGhGOBGBYkEiqsJJwq7ZPMCrMY0=
X-Received: by 2002:a05:6870:738c:b0:11b:a9f3:3f8f with SMTP id
 z12-20020a056870738c00b0011ba9f33f8fmr166089oam.229.1660780023018; Wed, 17
 Aug 2022 16:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220804190320.262510-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20220804190320.262510-1-alexandre.belloni@bootlin.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 17 Aug 2022 16:46:50 -0700
Message-ID: <CAKwvOd=3N8_Rx1P8J7pVnjM6sEzJA233BnwmD1VyMRqgujq2_Q@mail.gmail.com>
Subject: Re: [PATCH] init/Kconfig: fix CC_HAS_ASM_GOTO_TIED_OUTPUT test with dash
To:     alexandre.belloni@bootlin.com,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 4, 2022 at 12:03 PM <alexandre.belloni@bootlin.com> wrote:
>
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
>
> When using dash as /bin/sh, the CC_HAS_ASM_GOTO_TIED_OUTPUT test fails
> with a syntax error which is not the one we are looking for:

Thanks for the patch, though I think I'd rather see `/bin/bash`
hardcoded. Bash is a non-optional requirement as of
commit da4288b95baa ("scripts/check-local-export: avoid 'wait $!' for
process substitution")
scripts/ is kind of a mess...

>
> <stdin>: In function =E2=80=98foo=E2=80=99:
> <stdin>:1:29: warning: missing terminating " character
> <stdin>:1:29: error: missing terminating " character
> <stdin>:2:5: error: expected =E2=80=98:=E2=80=99 before =E2=80=98+=E2=80=
=99 token
> <stdin>:2:7: warning: missing terminating " character
> <stdin>:2:7: error: missing terminating " character
> <stdin>:2:5: error: expected declaration or statement at end of input
>
> Move all the CC_HAS_ASM_GOTO tests to scripts/gcc-goto.sh to solve the
> escaping issues.
>
> Fixes: 1aa0e8b144b6 ("Kconfig: Add option for asm goto w/ tied outputs to=
 workaround clang-13 bug")
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  init/Kconfig        |  6 +++---
>  scripts/gcc-goto.sh | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 3 deletions(-)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index c984afc489de..9903a11cfe7d 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -71,16 +71,16 @@ config CC_CAN_LINK_STATIC
>         default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG=
_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m32-flag) -static)
>
>  config CC_HAS_ASM_GOTO
> -       def_bool $(success,$(srctree)/scripts/gcc-goto.sh $(CC))
> +       def_bool $(success,$(srctree)/scripts/gcc-goto.sh goto $(CC))
>
>  config CC_HAS_ASM_GOTO_OUTPUT
>         depends on CC_HAS_ASM_GOTO
> -       def_bool $(success,echo 'int foo(int x) { asm goto ("": "=3Dr"(x)=
 ::: bar); return x; bar: return 0; }' | $(CC) -x c - -c -o /dev/null)
> +       def_bool $(success,$(srctree)/scripts/gcc-goto.sh goto_output $(C=
C))
>
>  config CC_HAS_ASM_GOTO_TIED_OUTPUT
>         depends on CC_HAS_ASM_GOTO_OUTPUT
>         # Detect buggy gcc and clang, fixed in gcc-11 clang-14.
> -       def_bool $(success,echo 'int foo(int *x) { asm goto (".long (%l[b=
ar]) - .\n": "+m"(*x) ::: bar); return *x; bar: return 0; }' | $CC -x c - -=
c -o /dev/null)
> +       def_bool $(success,$(srctree)/scripts/gcc-goto.sh goto_tied_outpu=
t $(CC))
>
>  config TOOLS_SUPPORT_RELR
>         def_bool $(success,env "CC=3D$(CC)" "LD=3D$(LD)" "NM=3D$(NM)" "OB=
JCOPY=3D$(OBJCOPY)" $(srctree)/scripts/tools-support-relr.sh)
> diff --git a/scripts/gcc-goto.sh b/scripts/gcc-goto.sh
> index 8b980fb2270a..aa9498b74df8 100755
> --- a/scripts/gcc-goto.sh
> +++ b/scripts/gcc-goto.sh
> @@ -3,6 +3,11 @@
>  # Test for gcc 'asm goto' support
>  # Copyright (C) 2010, Jason Baron <jbaron@redhat.com>
>
> +TEST=3D$1
> +shift
> +
> +case $TEST in
> +    "goto")
>  cat << "END" | $@ -x c - -fno-PIE -c -o /dev/null
>  int main(void)
>  {
> @@ -20,3 +25,29 @@ entry:
>         return 0;
>  }
>  END
> +    ;;
> +
> +    "goto_output")
> +cat << "END" | $@ -x c - -c -o /dev/null
> +int foo(int x) {
> +       asm goto ("": "=3Dr"(x) ::: bar);
> +       return x;
> +       bar: return 0;
> +}
> +END
> +    ;;
> +
> +    "goto_tied_output")
> +cat << "END" | $@ -x c - -c -o /dev/null
> +int foo(int *x) {
> +       asm goto (".long (%l[bar]) - .\n": "+m"(*x) ::: bar);
> +       return *x;
> +       bar: return 0;
> +}
> +END
> +    ;;
> +
> +    *)
> +       exit -1
> +    ;;
> +esac
> --
> 2.37.1
>


--=20
Thanks,
~Nick Desaulniers
