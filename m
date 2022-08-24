Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB0059F5C0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 10:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbiHXIwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 04:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236090AbiHXIwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 04:52:06 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B3977540
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 01:52:00 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id j6so12151051qkl.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 01:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=dg9IP5hlktbkw1xdJeMq6Y8R8Sy1tdC0F/hgQSHESME=;
        b=lRP1bcKSvhPJS+z8dahme9kO819HB7pOpSkmrcA8mD1itM3GdZTwyquSD2FrVKVInr
         MIXBrKXgZJqm0+mPR5AhqAGYL49jiWjyPKV9deGh+0xdbSRcFgC8mFhph4QdxbpSBEOA
         bP5QXgeWqwD23CTOTKqs0C5eqWRGnk6CzeQ6o/reGsj8XXAVoRBK8DAMVBx4fZOo5/oE
         nCIBlnj+iU6u+Wz8uNApfZdNHCj1zvfOH/JZSpF4WYZXD41GYKM2+EKfX+edQARFCZGe
         meeo8lDsp6AJT1PuWm+kFajrYOB6K0hMVJcIU7Jj+4ThNL/aj7Ls+86TOKbMNGkwkKoS
         6YlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=dg9IP5hlktbkw1xdJeMq6Y8R8Sy1tdC0F/hgQSHESME=;
        b=1n3rpsXGXiPfMESFZOwlyIZCroDUrK1OC6cExngLYziqAtmSnjpDW+W7zSG+CoJdYv
         m4Q9yXTfbC/VYke/8sxmmwg4D9VYnEiwCWSDZ73PzhaREPXWDsdlSIRuwE0oVdiGHLLS
         b7uZp+BT4xAja74PcozqnYcvIv/jnNTiPQhiavafWsFJBFAf5suwp9A/5666tK7p+LfF
         9X3Anbl7XOqnVyPGDzTkYVd2RyujcYT8nTgCxQx1RDiFq4FXFlH8Hq5W9m+CbDneV2EC
         NmiAtgzxZICFmPFBDHzCWjSzVKsSh5I1jEiK/H30YKwDn3etaXyJQwVv4COu5FfVNbOW
         ppjA==
X-Gm-Message-State: ACgBeo2918GUGWG5DiNPh4CRmmamJTIwVL4Arw65wE9VtAj8Mwa++Obj
        1T4goMrlCpIMICHv618iPie9/+KwJpxArycBuMH2kw==
X-Google-Smtp-Source: AA6agR7CN/OWNouJFE8a1efFeP8/YWZr0a0wGr6W4Qv8VQT0xrn49PM+ZFvi+KpTW5dFsaFRvEnSwljR3/XtZ4ScRQI=
X-Received: by 2002:a37:6905:0:b0:6bb:5827:e658 with SMTP id
 e5-20020a376905000000b006bb5827e658mr19459191qkc.735.1661331119571; Wed, 24
 Aug 2022 01:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <202208221331.71C50A6F@keescook> <a5df4929-24aa-79bf-c5d0-98efbf323132@intel.com>
 <CAEAAPHa3g0QwU=DZ2zVCqTCSh-+n2TtVKrQ07LvpwDjQ-F09gA@mail.gmail.com>
 <b4f0dca5-1d15-67f7-4600-9a0a91e9d0bd@intel.com> <26078f2a-67be-4aa1-bbb2-dcd1168c9d12@www.fastmail.com>
In-Reply-To: <26078f2a-67be-4aa1-bbb2-dcd1168c9d12@www.fastmail.com>
From:   =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>
Date:   Wed, 24 Aug 2022 10:51:48 +0200
Message-ID: <CAEAAPHae8Lr3KfqfLpK3w5F3MPFoG4HJLxX3cMgbKpmQ_jp6Og@mail.gmail.com>
Subject: Re: PKU usage improvements for threads
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000430e0405e6f8cbb0"
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

--000000000000430e0405e6f8cbb0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 23, 2022 at 8:24 PM Andy Lutomirski <luto@kernel.org> wrote:
>
>
>
> On Tue, Aug 23, 2022, at 11:12 AM, Dave Hansen wrote:
> > On 8/23/22 04:08, Stephen R=C3=B6ttger wrote:
> >> On Mon, Aug 22, 2022 at 11:11 PM Dave Hansen <dave.hansen@intel.com> w=
rote:
> >>> On 8/22/22 13:40, Kees Cook wrote:
> >>>> 1) It appears to be a bug that a thread without the correct PK can m=
ake
> >>>> VMAs covered by a separate PK, out from under other threads. (e.g. m=
map
> >>>> a new mapping to wipe out the defined PK for it.) It seems that PK c=
hecks
> >>>> should be made when modifying VMAs.
> >>>
> >>> Could you give an example of this?  Is this something along the lines=
 of
> >>> a mmap(MAP_FIXED) wiping out an earlier mapping?  Or, is it more subt=
le
> >>> than that?
> >>
> >> Yes, that's one example. And the same applies to other operations on t=
he
> >> VMA. E.g. another case we'd like to prevent would be munmap(addr) wher=
e
> >> addr is covered by a pkey to which the calling thread doesn't have acc=
ess
> >> permissions to.
> >
> > Yeah, that's something for which our defenses are quite weak.  But, it
> > also calls for a very generic mm/ solution and not something specific a=
t
> > all to pkeys.

We were also thinking about if this should be a more generic feature instea=
d of
being tied to pkeys. I.e. the doc above has an alternative proposal to intr=
oduce
something like a memory seal/unseal syscall.
I was personally leaning towards using pkeys for this for a few reasons:
* intuitively it would make sense to me to extend PKEY_DISABLE_ACCESS
  to also mean disable all changes to the memory, not just the data.
* We couldn't come up with another use case for the more generic API that
  doesn't include pkeys.
* Fewer syscalls for our use case, since we already set the pkey on the map=
pings
  we want to become immutable.
That being said, either approach works for us.

> > The concept would make a good lightning talk at Plumbers of LSF/MM.
>
> This kind of thing seems questionable to me. If the attacker controls sys=
call arguments, they can do almost anything. ISTM a CFI scheme should aim t=
o prevent that bogus call in the first place, e.g. by preventing a problema=
tic call.

I'm not sure that CFI can solve this problem since the attacker
doesn't change the
control flow in this attack. We will definitely have to ensure that
certain syscall
arguments can't be controlled by the attacker, e.g. if the protection
bits of an mmap
syscall are ever spilled to the stack, that would be one way to bypass
the mitigation
and we have to ensure in userspace that this doesn't happen.
However, this seems infeasible for common syscalls like munmap. If any thre=
ad
wants to unmap a page, it's likely that the data for that came from a
place that the
attacker might have corrupted.

> Which makes me think that the actual solution is to have syscall intercep=
tion support changing PKRU, perhaps via sigaltstack.

Can you expand on this? I didn't really understand what you meant.

>
> >
> >>>> 2) It would be very helpful to have a mechanism for the signal stack=
 to
> >>>> be PK aware, in the sense that the kernel would switch to a predefin=
ed
> >>>> PK. i.e. having a new interface to sigaltstack() which includes a PK=
.
> >>>
> >>> Are you thinking that when switching to the sigaltstack that it would
> >>> also pick up a specific PKRU value?  Or, that it would ensure that PK=
RU
> >>> allows access to the sigaltstack's pkey?
> >>
> >> Either of those would work for us.
> >>
> >>> Logically something like this:
> >>>
> >>>         stack_t sas =3D {
> >>>                 ss_sp =3D stack_ptr;
> >>>                 ss_flags =3D ... flags;
> >>>                 ss_size =3D ...;
> >>>                 ss_pkey =3D 12;
> >>>         };
> >>>
> >>> Then the kernel would set up RSP to point to ss_sp, and do (logically=
):
> >>>
> >>>    pkkru &=3D ~(3<<(12*2)); // clear Write and Access-disable for pke=
y-12
> >>>
> >>> before building the signal frame running the signal handler?
> >>
> >> Yeah, that would work for our use case.
> >> We also have a doc discussing this in more detail :) :
> >
> > That doesn't seem like it would be too much of a stretch.  There's a
> > delicate point when building the stack frame that the kernel would need
> > to move over to the new PKRU value to build the frame before it writes
> > the *OLD* value to the frame.  But, it's far from impossible.
> >
> > I also bet we could do this with minimal new ABI.  There's already a
> > ->ss_flags field.  We could assign a flag to mean that stack_t doesn't
> > end at '->ss_size' and that there's a pkey value *after* ss_size.  I do
> > think having a single pkey that is made accessible before signal entry
> > is a more flexible ABI than taking an explicit PKRU value.
> >
> > I think that would allow just reusing sys_sigaltstack().
>
> sys_sigaltstack() is already pretty much useless with SHSTK, and it=E2=80=
=99s kinda busted with AVX512. How about we just add a whole new non-kludgy=
 API?

--000000000000430e0405e6f8cbb0
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
IGCAQv4TB00xA5r9sOKK5ve3vEw1MI5woZJAf2Zfjj1PMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTIyMDgyNDA4NTIwMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQow
CwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB5ucXYftUCRmiwKc/g
jhy4FOOE+ngnNFPsWiWFfvpvWNEfYAI5+daFcqsPpiO0ivlD/4Z57Dts4nNLboEZOL/Qqvjq4t2Y
/nyec6jGGbbo9Ck5kvYT82/K9DFWLGujroNUa5fw0PCv9u3zSswQ1NIglfbwpvggjDeYEy8+FxmV
ru8Wl86XR2+Anfi0/xJEWA9S8ZSpuVKzCRa5IdFLc3cWkSeezz8zZQ7SjbxVwMCctGIIJtDJB+WT
NqdFAcFI54bbPnj0/71jw8rBNslOB0Ar6xJowbLiMO3NbYmzYN6x2KWwvypl9MCckTmVW+SPPbrP
y5CTFD6Tx0OwDX4mpIy4
--000000000000430e0405e6f8cbb0--
