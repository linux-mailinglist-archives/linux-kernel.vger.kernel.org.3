Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037075A107B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241687AbiHYMah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241863AbiHYMab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:30:31 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72031EADB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:30:29 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id u6so10605881qvp.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=wiCykRjNG5aXymX/0UiYu4hmVbZXK79fb6nY5wytKIw=;
        b=Ix208VK359V5KibBVb3GlrVUCJuQWgnCSe9SAfWGwqxNtueEmKLo5FG+lGUKZL0/90
         QmRP1NYur+bb6t1+r9JlSFkxjqM3g6XtBLlerE9OAOl5Y8JtkUJmWNuuIVAAfKC0MIDG
         QG9fGUXs3tHax5wR8S563PWefrwdIqZZZAd0IVgWflSKkf2Wn1CE225+BpHMCSMZlmwD
         We3sg5Yy8iXvX8d3+FoH2WjLHZM84Fy+465hg9WJR9NHjGjlTCfJ9w1ve7TcHbTrS2J2
         peSpXMKEup3GQwy2TJZg9zdAUqTbnDlLhysYIu7HNM4JK4x40ac0UrLidKSBsBBYlGP6
         ppGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=wiCykRjNG5aXymX/0UiYu4hmVbZXK79fb6nY5wytKIw=;
        b=TdXBgLpN0msEaHNjzYXF5Knqp6ch0ScueIkpcWzmD+UD62aIGNwh+XW2QogWVThbIy
         /zoZRbA/50Lkj2qGdPIswy/DZGSktaWENGF4uizh/q69xmlhMSyuNF1uLMrOMUjWEuuT
         JRZwb7vkZ22ATMCiol4XaQfMB+OJKT2GbHABOa3o95XfWcnhIi1zwNjP6vAxlfCdsHLI
         qKrbaMooz6/CAMOR/ueCLAWkeGlm1z+NrdL2kkJ0+kEf6+OTmjRUY64ApcjZhlp6O4G+
         u9O9P9fZ51yxVeToA5CPF37pF4krQgjer0Aag3u5axvrwzH1epGzTu5Zb9S2AMAxqjDE
         SHVw==
X-Gm-Message-State: ACgBeo1cabypAd45hEJkUBcN0028yvjAjrVybTnjW0TzB27d2c/XkQVc
        3pd3GGPAUGFNIIBb+lJ56zx6H53DLo1+mcBAG/5huA==
X-Google-Smtp-Source: AA6agR5VLN8p2OEFYOkpQE2TkVOFOAWbomdLLoXpljsepZTMnJfh3O/n3dODYOmdOjyqMf82X9zWVQ/cegEhTylSbOM=
X-Received: by 2002:ad4:5caf:0:b0:496:b2ee:3706 with SMTP id
 q15-20020ad45caf000000b00496b2ee3706mr3300438qvh.58.1661430628682; Thu, 25
 Aug 2022 05:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <202208221331.71C50A6F@keescook> <a5df4929-24aa-79bf-c5d0-98efbf323132@intel.com>
 <CAEAAPHa3g0QwU=DZ2zVCqTCSh-+n2TtVKrQ07LvpwDjQ-F09gA@mail.gmail.com>
 <b4f0dca5-1d15-67f7-4600-9a0a91e9d0bd@intel.com> <26078f2a-67be-4aa1-bbb2-dcd1168c9d12@www.fastmail.com>
 <CAEAAPHae8Lr3KfqfLpK3w5F3MPFoG4HJLxX3cMgbKpmQ_jp6Og@mail.gmail.com> <c36eb441-e93e-4beb-bdf2-1e6285f7a187@www.fastmail.com>
In-Reply-To: <c36eb441-e93e-4beb-bdf2-1e6285f7a187@www.fastmail.com>
From:   =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>
Date:   Thu, 25 Aug 2022 14:30:17 +0200
Message-ID: <CAEAAPHYTUYdtBLn4RsmNXMeaT8OvQ_k+Vy4uYdy_aSnaW79fcQ@mail.gmail.com>
Subject: Re: PKU usage improvements for threads
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000007639d605e70ff614"
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

--0000000000007639d605e70ff614
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 24, 2022 at 6:28 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 8/24/22 01:51, Stephen R=C3=B6ttger wrote:
> >>> Yeah, that's something for which our defenses are quite weak.  But, i=
t
> >>> also calls for a very generic mm/ solution and not something specific=
 at
> >>> all to pkeys.
> > We were also thinking about if this should be a more generic feature in=
stead of
> > being tied to pkeys. I.e. the doc above has an alternative proposal to =
introduce
> > something like a memory seal/unseal syscall.
> > I was personally leaning towards using pkeys for this for a few reasons=
:
> > * intuitively it would make sense to me to extend PKEY_DISABLE_ACCESS
> >   to also mean disable all changes to the memory, not just the data.
>
> It would make some sense, but we can't do it with the existing
> PKEY_DISABLE_ACCESS ABI.  It would surely break existing users if they
> couldn't munmap() memory that was PKEY_DISABLE_ACCESS.

Our thought was that this could be opt-in with a prctl().

> But, making it part of the mprotect() ABI wouldn't be the worst thing in
> the world.  Since we have a pkey_mprotect(), any mprotect()-based
> mechanism could even reuse the existing pkey syscalls.
>
> I do agree with Andy, though, that I'm not quite sure what the attack
> model is here.  If an attacker can make arbitrary system calls, surely
> protecting one little altstack VMA isn't doing to help much.

Note that we don't assume arbitrary syscalls. We only expect the
attacker to be able to control a subset of arguments to a subset of
syscalls.
We run with a seccomp filter that greatly limits available syscalls.
And for arguments, we will ensure in code that sensitive arguments
won't touch attacker-writable memory (e.g. the prot argument in
mprotect()).
But this is hard to do for things like munmap(addr), that's why we're
hoping that the kernel can help us out for that subset of syscalls.

> >> This kind of thing seems questionable to me. If the attacker controls =
syscall arguments, they can do almost anything. ISTM a CFI scheme should ai=
m to prevent that bogus call in the first place, e.g. by preventing a probl=
ematic call.
>
>
> What I'm trying to say is: CFI, by itself, can protect syscalls by making=
 sure that callers are safe.  So, for example, if all munmap() callers do:
>
> if (addr is dangerous)
>   abort();
> else
>   munmap();
>
> Then, with CFI, an attacker can't get to the actual munmap without first =
doing the dangerous check.  And you can implement this entirely in user cod=
e.
>
> With syscall user dispatch (this thing: https://lwn.net/Articles/828510/ =
-- sorry, I meant that when I typed interception), you even have a way to i=
ntercept *all* munmap() calls, for example.

Ah I see. Yeah, you're right. It should be possible to do these checks
in user code. Though, it would come with some challenges.
For once, the `addr is dangerous` check is not as easy as in kernel
space since AFAIK we can't check the pkey of a given address.
So we'd probably switch our stack and pkey state to traverse some data
structure to verify this. That, or keeping a dedicated range for these
protected mappings.
I'm also not sure if this would lead to noticeable perf regressions,
hopefully these memory management operations should not be in any hot
paths.
I'll investigate more if this would be a feasible alternative for us.

Side note: it seems like seccomp already allows us to do this instead
of syscall user dispatch or is there a feature in the latter that
would be useful?

--0000000000007639d605e70ff614
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPoQYJKoZIhvcNAQcCoIIPkjCCD44CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz7MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
1Xnj+ucP771ZQkdCPPi3x0wwTAYDVR0gBEUwQzBBBgkrBgEEAaAyASgwNDAyBggrBgEFBQcCARYm
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/BAIwADCBmgYI
KwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2Nh
L2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJlLmdsb2JhbHNp
Z24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgwFoAUfMwKaNei
6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9iYWxzaWduLmNv
bS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEBADYMYgn8YeSC
2azHCuUUELdSMX6zHgtp7pnHsAiW/DcbzNyWqavhuxKjDZGVqBEL8XslGKMHroyP9GLRYy3fOG6K
lTeSsnfQOkON4y/SaN6ew/5jl46udymNieA3FhCFrpqt5VD+LvUmSxF/8WBTTp3vfiWfymRY+CaH
4BqizkeEPW9WLDJVTu/65GqHNNG37YRMjRJI88mM3vQeNHiAXyxsGtK9AihqMu0hEx9eXLQudQNV
XwfOaOvZENWKMhRgnYwvv2v1wFu92T8vxPqdCXMhGnhaUMtLSnOx8ootxQxQ47AXJmXkDvTfT/LL
kpP0rI1cT2p1cY52eOyHtAHIZtQxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIzIFNNSU1FIENB
IDIwMjACEAEzs8uGCAkxDfyX6SyV9lkwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIE
IGodrXzBCjAva3knVkhZ9p5TDodZgVZFXXJWP1zEeP3vMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTIyMDgyNTEyMzAyOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQow
CwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBYT5urYvNHxCb8w6Q6
2aS6wQ0Ai/JvTENj3FJQNwpK8zLKzS9nJUMImTh4r38CMA5tkX06sqQsG3E4Sorv12e5lLZ8NmoG
5LkHEDozGolrd2FuZslw79A7fg2gGcPO6v3dklcE/lswVYFiIMANsE1nT7+sXjHyObyXK7TJ/5Hq
V/pesLPCowPq2ts020ARIXPa8H+AaO4NA6cNAjZioDrHIUyhU6Os/qT0jWMAIo7sb5cirKTz03hM
b28yuqKqPBkFEAm/AqHqs0lwuRD0p05BaOUabae6ikgi5tfl5lrRduXej4DOA3Injlx9OkqjH2pz
MWz3iVSvligjNq0bALOJ
--0000000000007639d605e70ff614--
