Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C3A5659B7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbiGDPYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiGDPYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:24:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC33325C8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 08:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656948275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qSA7OcLGYjU0sRoCxoa9txlJrzyMxtOkMFo8ipJ20Yo=;
        b=SLl0qsjhUcLGX13BJLd3DKij6gXs6Bgo8Pqz3ni/5aZ7+T3TNnlhUPZRcuBfx3hFocBtVM
        0dTisV8lnCoalTfJXK8+fHftzqXYP4vJ9WBQ6T5+7Nf21L8MNYV975Lr2XWJlQwsTtTHqt
        xFJQ3cpfCVX1wsS3oDKiM6MIn1+XHVU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-83-m2LoYMSbOLOhxbhPdfzRLg-1; Mon, 04 Jul 2022 11:24:34 -0400
X-MC-Unique: m2LoYMSbOLOhxbhPdfzRLg-1
Received: by mail-ed1-f70.google.com with SMTP id v16-20020a056402349000b00435a1c942a9so7437613edc.15
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 08:24:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qSA7OcLGYjU0sRoCxoa9txlJrzyMxtOkMFo8ipJ20Yo=;
        b=TLWFu3B/iVZpuqVQZuiJW8Z59oIcItW22GnqF4nj4905BpBwPZoquogoIizr2BHpJl
         VDwDqZdrBGh2FrQ+BlikrKhZw7Daqyd0LLvKULTd4pWCHdi0vwMqGM+ckyLVy9CWIhf4
         0ntgovx4mXGOZpLLWWI7fDL7DLLKIXrCz8RySDJC+1AMduArpA5zg6Ng9t8LJ0k3RCY1
         u2eXdHC05qr8gXJwyOBduYG6pYD7xLUJ+QW172Dc5KnzYLYZxJqpyn6YJZuI8UOg037q
         9kFi+HlUphDwKkM374azLYn062mPpYHVfxmo1YCxN54Zq18Wz+xcBVud5Ax9x9Lky0Gx
         ckcw==
X-Gm-Message-State: AJIora+Xfv03I85RgQJX6edyh5EPN2rsoDKSTzVS6gFYGeYPuFW7xhhJ
        iMuHBjcf09Pf48miMrFpAe0mt1NnJa4HlhvSchJgRfSpbTchLOm02Ej2gqYBFZOztC0+XpQZLFy
        VHG3bm6L9f2AOZaU3d3Ba+dPX3vJPVQSs7ZmHjSmQ
X-Received: by 2002:aa7:c14f:0:b0:435:7b75:fd06 with SMTP id r15-20020aa7c14f000000b004357b75fd06mr39744705edp.352.1656948273793;
        Mon, 04 Jul 2022 08:24:33 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sYjCQWvQYbnccTCJMS3aOztm4z+Onr9KdEXCSVyaACudZlQINEAmwyL9voj4SeB4EEiLyA2N+3rLDNY2fffUg=
X-Received: by 2002:aa7:c14f:0:b0:435:7b75:fd06 with SMTP id
 r15-20020aa7c14f000000b004357b75fd06mr39744681edp.352.1656948273603; Mon, 04
 Jul 2022 08:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <202207030630.6SZVkrWf-lkp@intel.com> <CAMusb+SaQOEw_deYyT-nB43Jvmy8W1Bd5gJrpcgvtMOTiEaoNg@mail.gmail.com>
 <CAMusb+QDk4CutzAGg-ZVmndnDh9N9q=HK1-Se=r6ebxPpdLp2g@mail.gmail.com>
In-Reply-To: <CAMusb+QDk4CutzAGg-ZVmndnDh9N9q=HK1-Se=r6ebxPpdLp2g@mail.gmail.com>
From:   Vlad Dronov <vdronov@redhat.com>
Date:   Mon, 4 Jul 2022 17:24:22 +0200
Message-ID: <CAMusb+QJ3yvEF8rUQ7=4Xf4dGG3Bs_ZOb2muJPKQ9ftXO+mX5g@mail.gmail.com>
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

On Mon, Jul 4, 2022 at 4:58 PM Vlad Dronov <vdronov@redhat.com> wrote:
>
> Hi,
>
> On Mon, Jul 4, 2022 at 4:35 PM Vlad Dronov <vdronov@redhat.com> wrote:
> >
> > Hi,
> >
> > On Sun, Jul 3, 2022 at 12:51 AM kernel test robot <lkp@intel.com> wrote=
:
> > > ...
> > > config: s390-buildonly-randconfig-r005-20220703 (https://download.01.=
org/0day-ci/archive/20220703/202207030630.6SZVkrWf-lkp@intel.com/config)
> > > ...
> > >    s390-linux-ld: lib/crypto/chacha20poly1305.o: in function `chacha_=
crypt':
> > > >> include/crypto/chacha.h:100: undefined reference to `chacha_crypt_=
arch'
> > > >> s390-linux-ld: include/crypto/chacha.h:100: undefined reference to=
 `chacha_crypt_arch'
> > > ...
> > > Kconfig warnings: (for reference only)
> > >    WARNING: unmet direct dependencies detected for CRYPTO_LIB_CHACHA2=
0POLY1305
> > >    Depends on (CRYPTO_ARCH_HAVE_LIB_CHACHA || !CRYPTO_ARCH_HAVE_LIB_C=
HACHA && (CRYPTO_ARCH_HAVE_LIB_POLY1305 || !CRYPTO_ARCH_HAVE_LIB_POLY1305 &=
& CRYPTO
> >
> > Ok, this is either weird or I do not understand how the Kconfig system =
works.
> >
> > What I look at is CRYPTO_LIB_CHACHA20POLY1305 definition:
> >
> > [ lib/crypto/Kconfig ]
> > config CRYPTO_LIB_CHACHA20POLY1305
> >     tristate "ChaCha20-Poly1305 AEAD support (8-byte nonce library vers=
ion)"
> >     depends on CRYPTO_ARCH_HAVE_LIB_CHACHA || !CRYPTO_ARCH_HAVE_LIB_CHA=
CHA
> >     depends on CRYPTO_ARCH_HAVE_LIB_POLY1305 || !CRYPTO_ARCH_HAVE_LIB_P=
OLY1305
> >     depends on CRYPTO
> >
> > and this test's random config (s390-buildonly-randconfig-r005-20220703)=
:
> >
> > $ grep -e CRYPTO_LIB_CHACHA20POLY1305 -e CRYPTO_ARCH_HAVE_LIB_CHACHA
> > -e CRYPTO_ARCH_HAVE_LIB_POLY1305 -e CRYPTO=3D config
> > CONFIG_CRYPTO=3Dy
> > CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=3Dm
> > CONFIG_CRYPTO_LIB_CHACHA20POLY1305=3Dy
> > // missing CRYPTO_ARCH_HAVE_LIB_POLY1305 implies =3Dn (I guess?)
> >
> > I'm following the canonical "Kconfig Language" doc (
> > https://www.kernel.org/doc/html/latest/kbuild/kconfig-language.html )
> > which states:
> >
> > > - dependencies: =E2=80=9Cdepends on=E2=80=9D <expr>
> > > This defines a dependency for this menu entry. If multiple dependenci=
es are defined, they are connected with =E2=80=98&&=E2=80=99.
> >
> > and
> >
> > >         '!' <expr>                           (6)
> > >         <expr> '&&' <expr>                   (7)
> > >         <expr> '||' <expr>                   (8)
> > >
> > > 6. Returns the result of (2-/expr/).
> > > 7. Returns the result of min(/expr/, /expr/).
> > > 8. Returns the result of max(/expr/, /expr/).
> > > An expression can have a value of =E2=80=98n=E2=80=99, =E2=80=98m=E2=
=80=99 or =E2=80=98y=E2=80=99 (or 0, 1, 2 respectively for calculations).
> >
> > So calculating:
> >
> > (CRYPTO_ARCH_HAVE_LIB_CHACHA || !CRYPTO_ARCH_HAVE_LIB_CHACHA) &&
> > (CRYPTO_ARCH_HAVE_LIB_POLY1305 || !CRYPTO_ARCH_HAVE_LIB_POLY1305) &&
> > CRYPTO
> >
> > I find it equal to:
> >
> > (m || !m) && (n || !n) && y  =3D>  m && y && y  =3D>  m
> >
> > So CRYPTO_LIB_CHACHA20POLY1305 should be no higher than M, but it is
> > =3DY in a config file =3D> weird :\ (or me wrong somewhere).
> >
> > WDYT?
>
> Ok, I should have tested this beforehand. With the configs set as above:
>
> CONFIG_CRYPTO=3Dy
> CONFIG_CRYPTO_CHACHA20_X86_64=3Dm // implies the next line =3Dm
> CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=3Dm
> CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305 is not set // =3Dn
>
> "make menuconfig" allows only =3Dn and =3Dm for CRYPTO_LIB_CHACHA20POLY13=
05 indeed.
> So the test robot has fed an invalid config to a build process. Let me
> forward this thread to lkp@lists.01.org to report this issue.

Hi,

False alarm, I apologize.

CRYPTO_LIB_CHACHA20POLY1305=3Dy was selected by CONFIG_WIREGUARD=3Dy:

config WIREGUARD
    tristate "WireGuard secure network tunnel"
    depends on NET && INET
    depends on IPV6 || !IPV6
    select CRYPTO_LIB_CHACHA20POLY1305

$ grep -e CONFIG_WIREGUARD=3D -e CONFIG_NETDEVICES=3D -e CONFIG_NET_CORE=3D
-e CONFIG_NET=3D -e CONFIG_INET=3D -e CONFIG_IPV6=3D config
CONFIG_NET=3Dy
CONFIG_INET=3Dy
CONFIG_IPV6=3Dy
CONFIG_NETDEVICES=3Dy
CONFIG_NET_CORE=3Dy
CONFIG_WIREGUARD=3Dy

This breaks the "In general use select only for non-visible symbols
(no prompts anywhere)
and for symbols with no dependencies" rules from the "Kconfig
Language" doc, but I'm not
sure how to proceed from here.

Best regards,
Vladis Dronov | Red Hat, Inc. | The Core Kernel | Senior Software Engineer

