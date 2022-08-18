Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1555989F3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 19:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344802AbiHRRGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 13:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345503AbiHRRE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 13:04:29 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B7BCCE15
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 10:01:52 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 27IH1Zpl028826
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 02:01:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 27IH1Zpl028826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1660842096;
        bh=vkptGwpdWxNC4/ZxNabYI+NnMITPEotjDWTGlSNZq/g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ohmGUYBRrsdFjG8pl6+dDU9VIRTZw7UE9GFxJFkjBY/hNzhWCDYIOLSUZJwBvf3if
         jMzdYIURl4cioeKAVR/hJiMPNGV/GdUzngpLx4FF5CU7eRYKBspnEJ6Xac0bCXGI5C
         ZGZ2pHzDy2sisG9NaPhZBDcjjHW56+0gIFed6L4SNQNhnUmTtAPOsV2JXxRSI4uxOd
         zBTks8zA5u2slN7bO3azDqhbrF/cwC7514+Y+kkjNWSsLzP8fMdhO4fXQ6FTbURGnq
         cVWkPqhBdtDAxo2IwtAKG1Wg6QPpiXNFMLzVIVYWSeBEncu7mXfofHmW2heOAJHdYh
         HZN1eds7/ScjQ==
X-Nifty-SrcIP: [209.85.221.47]
Received: by mail-wr1-f47.google.com with SMTP id ba1so2428750wrb.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 10:01:35 -0700 (PDT)
X-Gm-Message-State: ACgBeo2yKXNCnQ1RlhV6Nw/7cK8Y2GwQ7B6ygXWN4pbxJyG1Cj38j1yJ
        9gDeb9JRKANiTisPyJG0Mj2u3zIwthzkYI+eoLQ=
X-Google-Smtp-Source: AA6agR4588D+oh4PyZgx8wCY5u9s770I7Xdh/Yj/QAh2TrDES4+n5RtYzlubBg+kVCTmjsApnwCcOPbddOKl/FXqlxs=
X-Received: by 2002:a5d:6d89:0:b0:225:16c2:6816 with SMTP id
 l9-20020a5d6d89000000b0022516c26816mr2173039wrs.380.1660842094350; Thu, 18
 Aug 2022 10:01:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220804190320.262510-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20220804190320.262510-1-alexandre.belloni@bootlin.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 19 Aug 2022 02:00:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNASC-tqQ81=R1NUOXNhf-=S9pUnni-7jmbPjgYaXxf0PZQ@mail.gmail.com>
Message-ID: <CAK7LNASC-tqQ81=R1NUOXNhf-=S9pUnni-7jmbPjgYaXxf0PZQ@mail.gmail.com>
Subject: Re: [PATCH] init/Kconfig: fix CC_HAS_ASM_GOTO_TIED_OUTPUT test with dash
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 5, 2022 at 4:03 AM <alexandre.belloni@bootlin.com> wrote:
>
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
>
> When using dash as /bin/sh, the CC_HAS_ASM_GOTO_TIED_OUTPUT test fails
> with a syntax error which is not the one we are looking for:
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







It is well known that 'echo' command is not portable
when used with escape sequences.
'printf' will do in such situations.


The POSIX spec [1] also mentions this:

  "If the first operand is -n, or if any of the operands contain a
<backslash> character,
   the results are implementation-defined."


  "It is not possible to use echo portably across all POSIX systems
  unless both -n (as the first argument) and escape sequences are omitted."


[1] : https://pubs.opengroup.org/onlinepubs/9699919799/utilities/echo.html






So, the issue for this case is '\n'.
Do we need it?


Even with '\n' dropped, I still can detect the bug of clang-13.



[For clang 13]


$ echo 'int foo(int *x) { asm goto (".long (%l[bar]) - .": "+m"(*x)
::: bar); return *x; bar: return 0; }' | clang-13 -x c - -c -o
/dev/null
<stdin>:1:29: error: invalid operand in inline asm: '.long (${1:l}) - .'
int foo(int *x) { asm goto (".long (%l[bar]) - .": "+m"(*x) ::: bar);
return *x; bar: return 0; }
                            ^
<stdin>:1:29: error: unknown token in expression
<inline asm>:1:9: note: instantiated into assembly here
        .long () - .
               ^
2 errors generated.




[For clang 14]

$ echo 'int foo(int *x) { asm goto (".long (%l[bar]) - .": "+m"(*x)
::: bar); return *x; bar: return 0; }' | clang-14 -x c - -c -o
/dev/null
$ echo $?
0





So, please drop '\n' and check if it is OK.

That will be simpler for back-porting.






--=20
Best Regards
Masahiro Yamada
