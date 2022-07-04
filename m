Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1CD565A0F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbiGDPm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbiGDPm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:42:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C227411150
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 08:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656949343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MGd7OqCVLSIk3s/hNwZLX3PiQhPPaj954X7lngiwA4U=;
        b=GXWKdjuyW6fr2eySSZNCiFF05iqsLSxVt9/+Re8+XssmD+CqB7wSXFi0U3glfCXVWdw9BY
        pXr0mYrBH02vf9AKgW++xCv8Ycy7Th1nVWqKTWZeMBaT1p+IQHAfCInMt133lgkNkR2skM
        qAGVu8iS9Mu5LrF/tn2lgyvtWFHf+Fs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-Mok7sfyAPZaMmVB1wN8wCg-1; Mon, 04 Jul 2022 11:42:22 -0400
X-MC-Unique: Mok7sfyAPZaMmVB1wN8wCg-1
Received: by mail-ej1-f71.google.com with SMTP id sb34-20020a1709076da200b00722f4a9865bso2146610ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 08:42:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MGd7OqCVLSIk3s/hNwZLX3PiQhPPaj954X7lngiwA4U=;
        b=a6tSuYqcVURjvr3DWqP09WyjipyEX13mDxlQWzzbYPwq8lP/VtQa6e5v3J5ylZiU08
         3sJ8SidzrGBjGRsB+M3qiTWkEq2iZ+u1Lfmcg6DX3B1ZtUPW4It03EU9q/CAi2Of53UX
         7Y3HC8wTa8//2uSP/s2XdBuoXVqkKYIhvVHYhSplUz2XipTHa29es8Zj1SkMul/Ok3NL
         E+jfdcmfAyfncqEvc5EC1FOU+FRiqxR3xonRLTr4CSM71NJRZK5hPv2Vi+vjNbxHIJFp
         OrhybqPKOUqZ05WwjWYJSu6C55AkRY0O2dzLVWLoMB57yL+z3YKHWvgSvvvQrTQzlbPa
         6BeA==
X-Gm-Message-State: AJIora/XbxcZItoxA301+5kHMZbuA4JaPYfEKFR4VkHQBRr83oHI80iv
        3FTPYfKXG/ZhNrzJ1NWxaqM8QdQQv0tUPIuFwjZljF9FShtisf5GyqpB8XjyMpM4V2wxJZy3FG6
        BROkb4HYi5fwnvMViNpX1Do3rmUGoCICk5ORtNOQq
X-Received: by 2002:a17:906:846c:b0:72a:4b4f:b1b1 with SMTP id hx12-20020a170906846c00b0072a4b4fb1b1mr25677882ejc.255.1656949341506;
        Mon, 04 Jul 2022 08:42:21 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1twfELMKHQeInh05UizCL74nTFNrxBe/aZ3Hpa9WOiP13EXTPSUwbH9V0M3WCjy/Ib+xvA7s9VPORK/3AYIjPc=
X-Received: by 2002:a17:906:846c:b0:72a:4b4f:b1b1 with SMTP id
 hx12-20020a170906846c00b0072a4b4fb1b1mr25677865ejc.255.1656949341327; Mon, 04
 Jul 2022 08:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <202207030630.6SZVkrWf-lkp@intel.com> <CAMusb+SaQOEw_deYyT-nB43Jvmy8W1Bd5gJrpcgvtMOTiEaoNg@mail.gmail.com>
 <CAMusb+QDk4CutzAGg-ZVmndnDh9N9q=HK1-Se=r6ebxPpdLp2g@mail.gmail.com> <CAMusb+QJ3yvEF8rUQ7=4Xf4dGG3Bs_ZOb2muJPKQ9ftXO+mX5g@mail.gmail.com>
In-Reply-To: <CAMusb+QJ3yvEF8rUQ7=4Xf4dGG3Bs_ZOb2muJPKQ9ftXO+mX5g@mail.gmail.com>
From:   Vlad Dronov <vdronov@redhat.com>
Date:   Mon, 4 Jul 2022 17:42:10 +0200
Message-ID: <CAMusb+Rr9_TBLad1UQN52nWBN48j8V1c8GmMPNz=ezsEZfGKOg@mail.gmail.com>
Subject: Re: include/crypto/chacha.h:100: undefined reference to `chacha_crypt_arch'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Harald Freudenberger <freude@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 4, 2022 at 5:24 PM Vlad Dronov <vdronov@redhat.com> wrote:
>
> Hi,
>
> On Mon, Jul 4, 2022 at 4:58 PM Vlad Dronov <vdronov@redhat.com> wrote:
> >
> > Hi,
> >
> > On Mon, Jul 4, 2022 at 4:35 PM Vlad Dronov <vdronov@redhat.com> wrote:
> > >
> > > Hi,
> > >
> > > On Sun, Jul 3, 2022 at 12:51 AM kernel test robot <lkp@intel.com> wro=
te:
> > > > ...
> > > > config: s390-buildonly-randconfig-r005-20220703 (https://download.0=
1.org/0day-ci/archive/20220703/202207030630.6SZVkrWf-lkp@intel.com/config)
> > > > ...
> > > >    s390-linux-ld: lib/crypto/chacha20poly1305.o: in function `chach=
a_crypt':
> > > > >> include/crypto/chacha.h:100: undefined reference to `chacha_cryp=
t_arch'
> > > > >> s390-linux-ld: include/crypto/chacha.h:100: undefined reference =
to `chacha_crypt_arch'
> > > > ...
> > > > Kconfig warnings: (for reference only)
> > > >    WARNING: unmet direct dependencies detected for CRYPTO_LIB_CHACH=
A20POLY1305
> > > >    Depends on (CRYPTO_ARCH_HAVE_LIB_CHACHA || !CRYPTO_ARCH_HAVE_LIB=
_CHACHA && (CRYPTO_ARCH_HAVE_LIB_POLY1305 || !CRYPTO_ARCH_HAVE_LIB_POLY1305=
 && CRYPTO
> > >
> > > Ok, this is either weird or I do not understand how the Kconfig syste=
m works.
> > >
> > > What I look at is CRYPTO_LIB_CHACHA20POLY1305 definition:
> > >
> > > [ lib/crypto/Kconfig ]
> > > config CRYPTO_LIB_CHACHA20POLY1305
> > >     tristate "ChaCha20-Poly1305 AEAD support (8-byte nonce library ve=
rsion)"
> > >     depends on CRYPTO_ARCH_HAVE_LIB_CHACHA || !CRYPTO_ARCH_HAVE_LIB_C=
HACHA
> > >     depends on CRYPTO_ARCH_HAVE_LIB_POLY1305 || !CRYPTO_ARCH_HAVE_LIB=
_POLY1305
> > >     depends on CRYPTO
> > >
> > > and this test's random config (s390-buildonly-randconfig-r005-2022070=
3):
> > >
> > > $ grep -e CRYPTO_LIB_CHACHA20POLY1305 -e CRYPTO_ARCH_HAVE_LIB_CHACHA
> > > -e CRYPTO_ARCH_HAVE_LIB_POLY1305 -e CRYPTO=3D config
> > > CONFIG_CRYPTO=3Dy
> > > CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=3Dm
> > > CONFIG_CRYPTO_LIB_CHACHA20POLY1305=3Dy
> > > // missing CRYPTO_ARCH_HAVE_LIB_POLY1305 implies =3Dn (I guess?)
> > >
> > > I'm following the canonical "Kconfig Language" doc (
> > > https://www.kernel.org/doc/html/latest/kbuild/kconfig-language.html )
> > > which states:
> > >
> > > > - dependencies: =E2=80=9Cdepends on=E2=80=9D <expr>
> > > > This defines a dependency for this menu entry. If multiple dependen=
cies are defined, they are connected with =E2=80=98&&=E2=80=99.
> > >
> > > and
> > >
> > > >         '!' <expr>                           (6)
> > > >         <expr> '&&' <expr>                   (7)
> > > >         <expr> '||' <expr>                   (8)
> > > >
> > > > 6. Returns the result of (2-/expr/).
> > > > 7. Returns the result of min(/expr/, /expr/).
> > > > 8. Returns the result of max(/expr/, /expr/).
> > > > An expression can have a value of =E2=80=98n=E2=80=99, =E2=80=98m=
=E2=80=99 or =E2=80=98y=E2=80=99 (or 0, 1, 2 respectively for calculations)=
.
> > >
> > > So calculating:
> > >
> > > (CRYPTO_ARCH_HAVE_LIB_CHACHA || !CRYPTO_ARCH_HAVE_LIB_CHACHA) &&
> > > (CRYPTO_ARCH_HAVE_LIB_POLY1305 || !CRYPTO_ARCH_HAVE_LIB_POLY1305) &&
> > > CRYPTO
> > >
> > > I find it equal to:
> > >
> > > (m || !m) && (n || !n) && y  =3D>  m && y && y  =3D>  m
> > >
> > > So CRYPTO_LIB_CHACHA20POLY1305 should be no higher than M, but it is
> > > =3DY in a config file =3D> weird :\ (or me wrong somewhere).
> > >
> > > WDYT?
> >
> > Ok, I should have tested this beforehand. With the configs set as above=
:
> >
> > CONFIG_CRYPTO=3Dy
> > CONFIG_CRYPTO_CHACHA20_X86_64=3Dm // implies the next line =3Dm
> > CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=3Dm
> > CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305 is not set // =3Dn
> >
> > "make menuconfig" allows only =3Dn and =3Dm for CRYPTO_LIB_CHACHA20POLY=
1305 indeed.
> > So the test robot has fed an invalid config to a build process. Let me
> > forward this thread to lkp@lists.01.org to report this issue.
>
> Hi,
>
> False alarm, I apologize.
>
> CRYPTO_LIB_CHACHA20POLY1305=3Dy was selected by CONFIG_WIREGUARD=3Dy:
>
> config WIREGUARD
>     tristate "WireGuard secure network tunnel"
>     depends on NET && INET
>     depends on IPV6 || !IPV6
>     select CRYPTO_LIB_CHACHA20POLY1305
>
> $ grep -e CONFIG_WIREGUARD=3D -e CONFIG_NETDEVICES=3D -e CONFIG_NET_CORE=
=3D
> -e CONFIG_NET=3D -e CONFIG_INET=3D -e CONFIG_IPV6=3D config
> CONFIG_NET=3Dy
> CONFIG_INET=3Dy
> CONFIG_IPV6=3Dy
> CONFIG_NETDEVICES=3Dy
> CONFIG_NET_CORE=3Dy
> CONFIG_WIREGUARD=3Dy
>
> This breaks the "In general use select only for non-visible symbols
> (no prompts anywhere)
> and for symbols with no dependencies" rules from the "Kconfig
> Language" doc, but I'm not
> sure how to proceed from here.

JFYI: fed with a config in question, "make menuconfig" just silently change=
s
CONFIG_CRYPTO_CHACHA_S390=3Dm to =3Dy
and, accordingly,
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=3Dm to =3Dy
thus allowing a correct build.

Still not sure how to proceed from here with this clarification above.

Best regards,
Vladis Dronov | Red Hat, Inc. | The Core Kernel | Senior Software Engineer

