Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72914CBA11
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 10:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbiCCJWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 04:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiCCJWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 04:22:33 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D3A16BCE3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 01:21:46 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id j17so6840521wrc.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 01:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y9X5CZmLkY6TNZs6lMA/oZ6eqmTpcufmazQv7PqHPhc=;
        b=MMvJtHtDwRVfKdmGnhFvhmDonWg2KIgz9WIZtXDc84H4OKImjKB/x2J51zregACO9Z
         uqW7/UTizbB35hiQ+OKnNxvy8NFhA3yyPEHfXnKjblOWC0xzayYT71GymY+J0GFB+Pd8
         r4Rc1WmilcD7W60+I8EUfO1BykOEqMxmOXpxdberX6tiyOtvsaIG+weKzh9PW5a2ld84
         yR3A+B7F9FExya5JgP5+iawsnJb+Gl6Q0Ljdu17bFO9ROb7dwfAynvc4Vex9C6pm7H9E
         kZYw2Pbnl17eOT27WY9GoYVbeZGFXAf1Tt2t5deV04dcGDejRvi8Oi9BgbTV6Twiqqgd
         T9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y9X5CZmLkY6TNZs6lMA/oZ6eqmTpcufmazQv7PqHPhc=;
        b=s4NT+PdNTPD/qi2HezSoCslRUphIKbv/wmUjzZ1kAvrTOocMFaZ8K/xCSX3XSOE7BJ
         RHbD7LRnRP4RywgnNhTK/1VJAcO0QmkpmO34VLL0RzPMmg5PBr77wJHWR7DWnsFxCy8W
         PSOyK/u0mhe8S3Mf31/TOnjQG7zeMOGsI1PaYFHU6GuBu7wlfLpEuTlyJqwxVzebUOS+
         e1x3qJ+R7JVSHSAJ0nLCreZTrw5eK3oI4FNXfw221r+ebWyqx8MKGsHtJnd41lAZbmCL
         xKcRdxT12LNlhV5oCGob/gTYUn7Na7Ux3Jry24tSQCS01LBF2YKYHZdCtrtJsv9RSWOM
         q0gA==
X-Gm-Message-State: AOAM530SDWbTMbOPvH5131a8smo4V4uQ8Wu36YsFnH1qsNtyrxxSZBoS
        J0ZJgjowveJ8pbeTfgw0wz5+hprAyxLWIl0oSxetZw==
X-Google-Smtp-Source: ABdhPJyo/tBPMi81OvH3XVNEsDr9A4Qx46p9PVGCzWdv4zHPWbdRkCKBx5LelcuRgFFis4thWh3nYiUlGk4vFG/uOwg=
X-Received: by 2002:adf:910a:0:b0:1ed:c3fc:2dcf with SMTP id
 j10-20020adf910a000000b001edc3fc2dcfmr26125526wrj.430.1646299305322; Thu, 03
 Mar 2022 01:21:45 -0800 (PST)
MIME-Version: 1.0
References: <20220227184517.504931-1-keescook@chromium.org>
In-Reply-To: <20220227184517.504931-1-keescook@chromium.org>
From:   David Gow <davidgow@google.com>
Date:   Thu, 3 Mar 2022 17:21:33 +0800
Message-ID: <CABVgOSkck0hmYjtm=aWynq=Mw=PFcnkGsVMk4n=ShWR07WT-ig@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Convert overflow and stackinit to KUnit
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Daniel Latypov <dlatypov@google.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kbuild@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        llvm@lists.linux.dev, x86@kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000004f81e505d94cedf4"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000004f81e505d94cedf4
Content-Type: text/plain; charset="UTF-8"

On Mon, Feb 28, 2022 at 2:45 AM Kees Cook <keescook@chromium.org> wrote:
>
> Hi,
>
> These changes all build on each other, so I'm sending this as a series
> to hopefully reduce confusion. I chose "v3" because it seemed the least
> confusing of various options.
>
> The um changes are needed to get Clang building with um to test the
> stackinit KUnit test more easily (i.e. needing neither GCC 12 nor QEMU).
>
> -Kees
>
> David Gow (2):
>   um: Cleanup syscall_handler_t definition/cast, fix warning
>   um: Remove unused timeval_to_ns() function
>
> Kees Cook (5):
>   overflow: Provide constant expression struct_size
>   lib: overflow: Convert to Kunit
>   um: Allow builds with Clang
>   lib: stackinit: Convert to KUnit
>   UAPI: Introduce KUnit userspace compatibility
>
>  arch/um/os-Linux/execvp.c                   |   1 +
>  arch/um/os-Linux/time.c                     |   6 -
>  arch/x86/um/shared/sysdep/syscalls_64.h     |   5 +-
>  arch/x86/um/user-offsets.c                  |   9 +-
>  include/linux/overflow.h                    |  10 +-
>  include/uapi/misc/kunit.h                   | 181 +++++++
>  lib/Kconfig.debug                           |  38 +-
>  lib/Makefile                                |   6 +-
>  lib/{test_overflow.c => overflow_kunit.c}   | 562 +++++++++-----------
>  lib/{test_stackinit.c => stackinit_kunit.c} | 268 ++++------
>  scripts/Makefile.clang                      |   1 +
>  11 files changed, 593 insertions(+), 494 deletions(-)
>  create mode 100644 include/uapi/misc/kunit.h
>  rename lib/{test_overflow.c => overflow_kunit.c} (54%)
>  rename lib/{test_stackinit.c => stackinit_kunit.c} (67%)
>
> --

Thanks for putting all of these together. Apart from some minor
checkpatch warnings (some of which are inevitable, some of which are
trivial "don't put a space here" things) and an issue with the KUnit
userspace compatibility layer misreporting failed suites, this all
worked pretty well on my machine.

(There's also still a warning with -mno-global-merge on uml
USER_CFLAGS users which shows up with clang, but that's a minor issue
at best. I've sent out a patch to fix it up, though I'm not 100%
convinced it's the right solution:
https://lore.kernel.org/linux-kselftest/20220303090643.241747-1-davidgow@google.com/
)

Otherwise, this series is:
Tested-by: David Gow <davidgow@google.com>

(And, as a note to anyone else trying to apply it on another branch,
it has a prerequisite of:
https://lore.kernel.org/linux-hardening/20220124232342.3113350-1-keescook@chromium.org/
)

Cheers,
-- David

--0000000000004f81e505d94cedf4
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
G7p3AiuB2sgfq6cOpbO5MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBsL34EJkCtu9Nu
2+R6l1Qzno5Gl+N2Cm6/YLujukDGYa1JW27txXiilR9dGP7yl60HYyG2Exd5i6fiLDlaNEw0SqzE
dw9ZSIak3Qvm2UybR8zcnB0deCUiwahqh7ZncEPlhnPpB08ETEUtwBEqCEnndNEkIN67yz4kniCZ
jZstNF/BUnI3864fATiXSbnNqBwlJS3YkoaCTpbI9qNTrf5VIvnbryT69xJ6f25yfmxrXNJJe5OG
ncB34Cwnb7xQyk+uRLZ465yUBkbjk9pC/yamL0O7SOGYUclrQl2c5zzGuVBD84YcQGDOK6gSPj6w
QuBfOooZPOyZZZ8AMih7J980MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAr
LHyDiURCeL8ULmRDQqU9XtRoaljljA0AsBR5Y7LUWDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjAzMDMwOTIxNDVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAO31Q4wqB4VIgYbdf3BbX
3tB9PKDT3mSIBGDi28W+82DnwCPtlIR8F0aPuGCjrPUQIo7wBdSD62CP+q3wvyJZHWYrPWGTFwk6
m4ymEm8zo8gjzSWKXXVlEVl9L6bGIVEqByDQa47frdaHiGotHyv36/euWFAakPLGv5DYchLX2+if
RLOXbEvl2y30e1ChsPNBIEKWiWyyR26wvPb+AqCOFyPrZU8Ifhsy9+AdNjxEnsK50m/4dnd9IpoX
p1mZ6MYZHfnY6rn62fp3IdiOK7CaoXfxzFEX/QRTYw0rmimvEzZg7dhrQKw1DFvkozWSJ5b7IBxo
Co76w8wtp9tFTxBFtw==
--0000000000004f81e505d94cedf4--
