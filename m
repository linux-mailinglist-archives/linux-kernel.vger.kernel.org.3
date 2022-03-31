Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0931F4ED17D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 04:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352445AbiCaCCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 22:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352438AbiCaCCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 22:02:15 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A965859A55
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 19:00:29 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id bi13-20020a05600c3d8d00b0038c2c33d8f3so891477wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 19:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e1Po5qC3Q3c0yObkkm28UonpuS5bMxmyIhuDfuJ6G0k=;
        b=QxKmQ8c9oUDAwlApZtTOb/QA4YFhjIzje/zHifmcwaxM5qta6cndVn/IcDDKRGOD+2
         od7/XISAYayz9jsIUiQaw4POXTlRdc6Z2Uzg0K0+vQb6I24RUmFhx8BINqM9VoeekSQ+
         MdctGQSVe1bhfOXQDk11HzykYxlwUjGgQ4rqmTz5ZvTz8TQzPUMRSNcYeDk+E1GfqEqF
         cKkZqBeuvg+ZQASZAzvFJP9I39N915bznKdTG0Y1Z61O2H0vkxKZuPg0y4Ef1yyeOi5U
         JZLmykBb2ltaAF33qrB+lZGEJm8tOuawr72oUjdFPLEyE+JSPI86GWPZZPYPYLAxqkOl
         oLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e1Po5qC3Q3c0yObkkm28UonpuS5bMxmyIhuDfuJ6G0k=;
        b=BmcV7PuUcMfb9uCc5+tVgKw/AklG+aCtH1X/VRykfvGPClqrHjVGdfsdWpXeFRSAfe
         FO5DB4WeP3qEJLACYbyY5ITB8kaLyc4yQW12m0p6ar6WgRXUpSgBAoPLSAi4c6pSm+ax
         8zALeHQ5bcaFrw7by/M5zHy6XqqluY59U0LtGiha2dJqoSqUS21/PZzjhWtq3uFiI/KI
         amDqLRnDbmTOU3JrkK4MmgWqcG0UtwFJfrq0d8srgqt2WcryZP8fb35gSCZ1AXWP4OCZ
         VvWlT+perZD9L5X/7MBHsIN3AiVxXennoohz/qxjQzrX1vlAvWeau1uAN6CecU/1FUzp
         rQOA==
X-Gm-Message-State: AOAM531wiSbfIR+ipdWoE2Fuyl+bKWzzIYAQBxpRHyKWqgm0Bu9iwecL
        Kv4f8MdsUeq7R4Gb0eCnXntXe189AIAK0DiQ+tjBXA==
X-Google-Smtp-Source: ABdhPJwc7cIZrbcDtT8oN3Uc/i8d7OuUgxfn6/gsSmmOZtKtUns5P8AZUjMI9YJfo8Xv3zrLvlgeH46KQa1wtE9NM+0=
X-Received: by 2002:a1c:7906:0:b0:38c:8cfa:cbb0 with SMTP id
 l6-20020a1c7906000000b0038c8cfacbb0mr2445694wme.163.1648692028147; Wed, 30
 Mar 2022 19:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220330234528.1426991-1-nathan@kernel.org> <20220330234528.1426991-3-nathan@kernel.org>
In-Reply-To: <20220330234528.1426991-3-nathan@kernel.org>
From:   David Gow <davidgow@google.com>
Date:   Thu, 31 Mar 2022 10:00:17 +0800
Message-ID: <CABVgOSnX+bYKvGeJDeKpM8tCe_fCzYC4=6Eh3EUV54SK2SC7Bg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "um: clang: Strip out -mno-global-merge from USER_CFLAGS"
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Kees Cook <keescook@chromium.org>,
        linux-kbuild@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>, llvm@lists.linux.dev,
        patches@lists.linux.dev
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000b3572005db7a0607"
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

--000000000000b3572005db7a0607
Content-Type: text/plain; charset="UTF-8"

On Thu, Mar 31, 2022 at 7:46 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> This reverts commit 6580c5c18fb3df2b11c5e0452372f815deeff895.
>
> This patch is buggy, as noted in the patch linked below. The root cause
> has been solved by removing '-mno-global-merge' for the entire kernel.
>
> Link: https://lore.kernel.org/r/20220322173547.677760-1-nathan@kernel.org/
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---

Looks good to me: getting rid of -mno-global-merge entirely is nicer, anyway.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

--000000000000b3572005db7a0607
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
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCD9
dTJ3C1ML/jXUB2jWCjpYGFbLWDtAavKA8DvwSr7e/TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjAzMzEwMjAwMjhaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAJCySVqF1qIZbPhMhq6+/
BvcbQuYwUKMwe64ZdWNCNfa8ZM1DhEk/gwp5+lnmAeIYSuDIwql+RplAPAn1+nQPWh2nP7kT5Bpa
pjACyaLX21TYfsQe4ctBRsdJKikKu1t+TQRRen4a7xOEM+jk7l04bEbSPiyEULQFodzPKYw6Xhd6
YS2MX0OPOuLS4ACybo1cm8MgAxyVC3O8SrIUPTSVHHFIkhTxjOrto/H2ubz9FEbWzH9gVVKzc56b
zK46MsKKeULiygPXgY4ta1HTm3NG2hQfhFF/FVu4TOsq4eJpuk0A/8g71GH8OWeBs97pubzKg3Sx
NBPCKJ7ivys9Vbi1zA==
--000000000000b3572005db7a0607--
