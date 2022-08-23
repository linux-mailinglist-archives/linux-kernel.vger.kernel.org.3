Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D4A59E4DD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 16:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241344AbiHWODc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 10:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244614AbiHWOCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 10:02:17 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235819A9CC
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 04:10:21 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id y4so10244430qvp.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 04:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=+XqOaRoy1y4JBfRqyfC9QYWSmLvu18qQOjiXWzEmCVM=;
        b=QttMrLHBm0dAZodMMTbB/uIOgvV41Y6zMp2O/9BIhfVfW/sC8IBXhP1ySJBdAFw4lu
         QpKBKYGFT0gw0U2c6HW8PI+0n6R22wWtBfuJOFL5V3eI+gAEO3ElkCcsAQrSv5pOp9UQ
         kdonnBDtrMkr5qcNr6o1cE8N7afY3KWUF5wnAIMwWtXF5AlTtD2LLmQLs0VvFyJxogZC
         Qy93Wqn+gHduYz+7BGYmQHbpVOTjiQsZycQVovJE+nuc+aRdscZ7MBj816XPsARFZ0XG
         NnpfSAzMakiJVxMs4/rarMOvWBTTUDyhLsbfDfSiQnxFKbg+dENLmRe9W5hiuzG8Qk1w
         yiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+XqOaRoy1y4JBfRqyfC9QYWSmLvu18qQOjiXWzEmCVM=;
        b=xoIiz4zlH3nR3y+oBIJ9y/hzSNiz8/+9kB6Ff7OXX5XqXJKCTo+VCm6AW1OaNsWANI
         RnSkMa59zIuuBF8vEGEVI7iaCbBmIR0b9+iB4KPPd3qI7K1Q+GnzDXWToZc9OtNCmjbL
         6KKIqABfJXv2FjmGuDoL1SSmbw/FYs7+hlYMG4pcZM5lsSnBianja7Zye/yZ5Iwch4ZF
         w089TEjwXBcPTkV0nH48zsJsjvb2/+QcoxH1n8/+KsBuw1IhInnoZxCIvITsYBWNgAXa
         5JfbPg07lraMrnxGIIL/AvFFGoO7SwZpPUaiNuAdJcvimVzhTEKA4uUoOz1ts3S2p18R
         G4Rw==
X-Gm-Message-State: ACgBeo122LjmANya9kIDntH4ghVmyIqpnR1iB64lNVkeOYJpM6O0Xp2l
        T91S8soMNJV/nHXocZQr2rNqqdvktKd3Tp71sRPpb0ZciuSMSg==
X-Google-Smtp-Source: AA6agR65NtY7xtJzjSXhhq4X5U5zcsS7oy5L7P2tT2koYwqF5eAIY/GgnWIdHTikiqfJxfOtSycI0+0wGe5QEmKvgS8=
X-Received: by 2002:a0c:aa16:0:b0:496:cfac:217d with SMTP id
 d22-20020a0caa16000000b00496cfac217dmr11872610qvb.121.1661252933588; Tue, 23
 Aug 2022 04:08:53 -0700 (PDT)
MIME-Version: 1.0
References: <202208221331.71C50A6F@keescook> <a5df4929-24aa-79bf-c5d0-98efbf323132@intel.com>
In-Reply-To: <a5df4929-24aa-79bf-c5d0-98efbf323132@intel.com>
From:   =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>
Date:   Tue, 23 Aug 2022 13:08:42 +0200
Message-ID: <CAEAAPHa3g0QwU=DZ2zVCqTCSh-+n2TtVKrQ07LvpwDjQ-F09gA@mail.gmail.com>
Subject: Re: PKU usage improvements for threads
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000003cf8a05e6e69722"
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

--00000000000003cf8a05e6e69722
Content-Type: text/plain; charset="UTF-8"

Hey Dave,

> I'd love to hear more why this behavior is useful and how it will be used.

The background is that we want to build a way to temporarily isolate threads
from each other, which we then want to use for CFI for V8 (Chrome's
JavaScript engine).

One of the main challenges we have is to protect the JIT compiled code from
an attacker with an arbitrary read/write primitive. For that, we're
planning to use PKU
to have access to some trusted memory, i.e. memory that can't be
corrupted by the
attacker.
You can find more details on our plans here:
https://docs.google.com/document/d/1O2jwK4dxI3nRcOJuPYkonhTkNQfbmwdvxQMyXgeaRHo/edit?usp=sharing

While designing this mitigation, we came up with two attack vectors for which we
believe we need help from the kernel to fix them, which are the two cases Kees
mentioned:
1) an attacker controlling some argument to certain VMA operations
like munmap().
2) an attacker corrupting the saved signal context on a signal handler stack.

On Mon, Aug 22, 2022 at 11:11 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 8/22/22 13:40, Kees Cook wrote:
> > 1) It appears to be a bug that a thread without the correct PK can make
> > VMAs covered by a separate PK, out from under other threads. (e.g. mmap
> > a new mapping to wipe out the defined PK for it.) It seems that PK checks
> > should be made when modifying VMAs.
>
> Hi Kees,
>
> Could you give an example of this?  Is this something along the lines of
> a mmap(MAP_FIXED) wiping out an earlier mapping?  Or, is it more subtle
> than that?

Yes, that's one example. And the same applies to other operations on the
VMA. E.g. another case we'd like to prevent would be munmap(addr) where
addr is covered by a pkey to which the calling thread doesn't have access
permissions to.
You can find more details in this doc:
https://docs.google.com/document/d/1qqVoVfRiF2nRylL3yjZyCQvzQaej1HRPh3f5wj1AS9I/edit?usp=sharing

> > 2) It would be very helpful to have a mechanism for the signal stack to
> > be PK aware, in the sense that the kernel would switch to a predefined
> > PK. i.e. having a new interface to sigaltstack() which includes a PK.
>
> Are you thinking that when switching to the sigaltstack that it would
> also pick up a specific PKRU value?  Or, that it would ensure that PKRU
> allows access to the sigaltstack's pkey?

Either of those would work for us.

> Logically something like this:
>
>         stack_t sas = {
>                 ss_sp = stack_ptr;
>                 ss_flags = ... flags;
>                 ss_size = ...;
>                 ss_pkey = 12;
>         };
>
> Then the kernel would set up RSP to point to ss_sp, and do (logically):
>
>    pkkru &= ~(3<<(12*2)); // clear Write and Access-disable for pkey-12
>
> before building the signal frame running the signal handler?

Yeah, that would work for our use case.
We also have a doc discussing this in more detail :) :
https://docs.google.com/document/d/1OlnJbR5TMoaOAJsf4hHOc-FdTmYK2aDUI7d2hfCZSOo/edit?usp=sharing&resourcekey=0-v9UJXONYsnG5PlCBbcYqIw

--00000000000003cf8a05e6e69722
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
IA59aUSAHQoq1fWFZvrMA0mLtIjuPBVgJV2mC6yR5Ds1MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTIyMDgyMzExMDg1NFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQow
CwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCkq8eTzU8O+vbm8Kal
MX/jDSR84A6rCdDyPOdcjxO56DDzjbWH+70K7TyuDL/iVdAsCwx7doW6Guamv8ffYYZzRVK/NH/g
GNLabMR9khSDek3JVCLff1dcsaWC4mMTkDHdFvb34liFoygLEFMlAETZFKw9mdgyof8bqEPdvLn3
1fr8Inb1PktbybMaqXdS1X7FPWFeZKdh/RQWJiX2gtJs0lfsaHUkAv0f5TOOJnCRx1lAYh7WjMmI
tSdgq0NTCx19Stlevbf78xwuy7WePOXpSivKh6WN4xag2VIsyN/m9KULx/c4nwV/VZa9UZfhse2r
mV5qiP236lv98HvZ9yj1
--00000000000003cf8a05e6e69722--
