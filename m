Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579895A2248
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245646AbiHZHuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245683AbiHZHu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:50:29 -0400
X-Greylist: delayed 176 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 26 Aug 2022 00:50:25 PDT
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de [IPv6:2a01:238:400:200::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB7BB6D53
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 00:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1661500043;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=nFkPTuodI/k/JNgjBWCQcc1KB3gIcqkAHXpmV4sz5SM=;
    b=C1cdIM/+Wh2ioGnBOj0FSxHUHslQvFS2disLfuXeBtg5h76o7WC23v63DPP5jMa/83
    5J7rKOinOhe6UVPE4gg7iyTNU6FOtYrerwwenKtaG6+QAhRDXPb9nxeEyJ5Jp3Y6oalI
    eiK82GEUwCYUq8yxsm3j/AJVGeT+Taha+WXKbwk+z2wTprZjqCz7CcmcL44yDsutXFv5
    QV3N9FcJFo3G3SjkB4HMjgUiXkAMer/4UJX1E7yr6ygYmNXOOBO4K8GbJVVWfDAQotLc
    /HzJho5suv86y/baAymWLYnX9RReJyK23kZJb9Nz9vnEueXFnIb/MFP/2yxD1JYyo8AY
    UQXA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zmgLKehaO2hZDSTWbg/LOA=="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id k44a27y7Q7lJVpb
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 26 Aug 2022 09:47:19 +0200 (CEST)
From:   Stephan Mueller <smueller@chronox.de>
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: kdf108_init() takes over 250 ms
Date:   Fri, 26 Aug 2022 09:47:17 +0200
Message-ID: <2658706.V0ylg0ELTe@tauon.chronox.de>
In-Reply-To: <MW5PR84MB1842811C4EECC0F4B35B5FB3AB709@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <6d6b6bcf-cab8-695b-568a-c1372ac531ee@molgen.mpg.de> <MW5PR84MB1842811C4EECC0F4B35B5FB3AB709@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 23. August 2022, 22:10:01 CEST schrieb Elliott, Robert (Server=
s):

Hi Robert,

> > -----Original Message-----
> > From: Paul Menzel <pmenzel@molgen.mpg.de>
> > Sent: Tuesday, August 23, 2022 9:52 AM
> > To: Stephan M=C3=BCller <smueller@chronox.de>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>; David S. Miller
> > <davem@davemloft.net>; linux-crypto@vger.kernel.org; LKML <linux-
> > kernel@vger.kernel.org>
> > Subject: kdf108_init() takes over 250 ms
> >=20
> > Dear Stephan,
> >=20
> > On the Dell XPS 13 9370 with Debian sid/unstable, I noticed with Linux
> > 5.18.16, that  `crypto_kdf108_init()` takes 263 ms to run even with
> > disabled self-tests:
> >=20
>=20
> ...
>=20
> > [    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-5.18.0-4-amd64
> > root=3DUUID=3D56f398e0-1e25-4fda-aa9f-611dece4b333 ro quiet
> > module_blacklist=3Dpsmouse initcall_debug log_buf_len=3D4M cryptomgr.no=
tests
>=20
> ...
>=20
> > [    0.272127] calling  crypto_kdf108_init+0x0/0x149 @ 1
> > [    0.530787] Freeing initrd memory: 39332K
> > [    0.534667] alg: self-tests disabled
> > [    0.534701] alg: self-tests for CTR-KDF (hmac(sha256)) passed
> > [    0.534703] initcall crypto_kdf108_init+0x0/0x149 returned 0 after
> > 262573 usecs
>=20
> ...
>=20
> >=20
> > With self-tests enabled it=E2=80=99s only less than a millisecond longe=
r.
> >=20
> > ```
> > [    0.282389] calling  crypto_kdf108_init+0x0/0x149 @ 1
> > [    0.541096] Freeing initrd memory: 39332K
> > [    0.545674] alg: self-tests for CTR-KDF (hmac(sha256)) passed
> > [    0.545676] initcall crypto_kdf108_init+0x0/0x149 returned 0 after
> > 263284 usecs
> > ```
>=20
>=20
> crypto_kdf108_init() call its self-test function directly rather
> that alg_test(), which implements that notests flag. Maybe it
> should go through alg_test().

You are right that it does not uses the alg_test. This is because the KDF i=
s=20
just a helper and not implemented as a template. I initially wanted and=20
provided a patch that turns the KDFs into templates which then would be abl=
e=20
to go though alg_test. It was not accepted, but instead only service functi=
ons=20
where accepted.

The reason for not accepting the template approach was that a complete new =
API=20
is needed to accommodate the KDFs. Initially I called the API "rng" because=
 a=20
KDF and a PRNG are very very similar in nature: they take an arbitrary stri=
ng=20
as input (the seed/key/personalization/additional info/label string) and=20
provide an arbitrary output (mathematically you can even use both=20
interchangeably for the same purposes - although cryptographically speaking=
=20
you do not want that). As this concept cannot be covered with the existing=
=20
APIs, a KDF cannot be rolled into those existing APIs as template. Side not=
e:=20
the same question around such new API will appear as soon as somebody asks =
for=20
SHAKE to be added.

A low hanging fruit would be to also deactivate the KDF test when the notes=
t=20
option is selected.

>=20
> Outside of that, check that Tim's x86-optimized SHA-256 module
> is loaded, so it is used rather than the generic implementation.
> One my system, that improves the kdf108 initialization time=20
> from 1.4 s to 0.38 s:
>=20
> With sha256_generic:
>   initcall sha256_generic_mod_init+0x0/0x16 returned 0 after 0 usecs
>   ...
>   initcall crypto_kdf108_init+0x0/0x18d returned 0 after 1425640 usecs
>=20
> With sha256_ssse3 (using its AVX2 implementation):
>   initcall sha256_ssse3_mod_init+0x0/0x1bf returned 0 after 12148 usecs
>   ...
>   initcall crypto_kdf108_init+0x0/0x153 returned 0 after 382799 usecs
>=20
> That's controlled by CONFIG_CRYPTO_SHA256_SSSE3.

The test is performed during kernel boot time with the available=20
implementation - the self test uses "hmac(sha256)". If the AVX2 is not=20
registered at that time with the kernel crypto API, it will not be availabl=
e=20
for use. But it is not possible to hard-code the use of the AVX implementat=
ion=20
or any other implementation as it is not guaranteed to be present.

The issue would be alleviated it would go through alg_test though.

>=20
>=20


Ciao
Stephan


