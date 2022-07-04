Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F72565925
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbiGDO7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbiGDO67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:58:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25B6F62D4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656946738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rp477veCl7PiPqX7ATXvfpa+/m/k7gEuL107Sf46ZoE=;
        b=InATMP3Db3b+9MtOq7+z77rjlsp/iDT3AUhsqekfCvL8uP6t2iXoLxOw2V6jA6VCKOUd8N
        26o3qY+CsoavWHOoPSxRJAlZpoT6lgbfy5NYMYTQiot1GHfDlmiN2sE57mEhYBuwHZYxe6
        sAv50kRoXTmN0siNUbKSI/FzU8nkZw4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-Cg1C5LFHN8e5UejlDacuOg-1; Mon, 04 Jul 2022 10:58:57 -0400
X-MC-Unique: Cg1C5LFHN8e5UejlDacuOg-1
Received: by mail-ed1-f69.google.com with SMTP id o11-20020a056402438b00b0043676efd75dso7416436edc.16
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 07:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rp477veCl7PiPqX7ATXvfpa+/m/k7gEuL107Sf46ZoE=;
        b=AU2h+UuVxurEdNYvUywrUuvPxUFLD78ud4yBuEDa2zKF2vYcjAqOR4Bk6Y6X5SZaGT
         NMJctlmECjobIqFdox+W7RUWL3BmDLgcXflD3MC5KIHU0Tyk1ogdGxxCdloZq/VSuu/O
         2tS9tGtY9msa04y/5Zy+U3jEY0hbDFY+wGGCmaaI+uKSzifkNpGxPpBnYcAJsUjYyHr4
         +r/YTpRqVTYfH28La2D/27D9MBXi50W4h1o0h0vKEmYx9ytETabqjPkThFcSr0G/Rb6e
         3pLm7uxI/BjhYh+MaqavkN+EY1y36Sox8sTlSb1WBu8sOySQS6+DVOyRs4pu2/Oc+jRR
         XBRQ==
X-Gm-Message-State: AJIora9X5kcIXsVv4JqLJ8n26ErmHIK3Q4sDqtyoh4gul/6ijhIcWIbw
        KMR6dNYSvSHTT7A+SqrditVdmSKLwO+DYrtuLwZIL3/A/6M3d7rW7Y1423mxMiK1zohMJcJXuwe
        wYFrkcvo4AKFEFtIn+fynPLOXUg34CjysVVpW5Ms8
X-Received: by 2002:a17:906:106:b0:722:e997:a365 with SMTP id 6-20020a170906010600b00722e997a365mr29647724eje.169.1656946735381;
        Mon, 04 Jul 2022 07:58:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1thwncGZmmQa0F9XjnPTXANoTpIHVUgQC/I3ykRj+tm0piO1n7NA1uIwuGAP4WvfmzetRkPwybegbG0MAymnZY=
X-Received: by 2002:a17:906:106:b0:722:e997:a365 with SMTP id
 6-20020a170906010600b00722e997a365mr29647706eje.169.1656946735195; Mon, 04
 Jul 2022 07:58:55 -0700 (PDT)
MIME-Version: 1.0
References: <202207030630.6SZVkrWf-lkp@intel.com> <CAMusb+SaQOEw_deYyT-nB43Jvmy8W1Bd5gJrpcgvtMOTiEaoNg@mail.gmail.com>
In-Reply-To: <CAMusb+SaQOEw_deYyT-nB43Jvmy8W1Bd5gJrpcgvtMOTiEaoNg@mail.gmail.com>
From:   Vlad Dronov <vdronov@redhat.com>
Date:   Mon, 4 Jul 2022 16:58:44 +0200
Message-ID: <CAMusb+QDk4CutzAGg-ZVmndnDh9N9q=HK1-Se=r6ebxPpdLp2g@mail.gmail.com>
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

On Mon, Jul 4, 2022 at 4:35 PM Vlad Dronov <vdronov@redhat.com> wrote:
>
> Hi,
>
> On Sun, Jul 3, 2022 at 12:51 AM kernel test robot <lkp@intel.com> wrote:
> > ...
> > config: s390-buildonly-randconfig-r005-20220703 (https://download.01.or=
g/0day-ci/archive/20220703/202207030630.6SZVkrWf-lkp@intel.com/config)
> > ...
> >    s390-linux-ld: lib/crypto/chacha20poly1305.o: in function `chacha_cr=
ypt':
> > >> include/crypto/chacha.h:100: undefined reference to `chacha_crypt_ar=
ch'
> > >> s390-linux-ld: include/crypto/chacha.h:100: undefined reference to `=
chacha_crypt_arch'
> > ...
> > Kconfig warnings: (for reference only)
> >    WARNING: unmet direct dependencies detected for CRYPTO_LIB_CHACHA20P=
OLY1305
> >    Depends on (CRYPTO_ARCH_HAVE_LIB_CHACHA || !CRYPTO_ARCH_HAVE_LIB_CHA=
CHA && (CRYPTO_ARCH_HAVE_LIB_POLY1305 || !CRYPTO_ARCH_HAVE_LIB_POLY1305 && =
CRYPTO
>
> Ok, this is either weird or I do not understand how the Kconfig system wo=
rks.
>
> What I look at is CRYPTO_LIB_CHACHA20POLY1305 definition:
>
> [ lib/crypto/Kconfig ]
> config CRYPTO_LIB_CHACHA20POLY1305
>     tristate "ChaCha20-Poly1305 AEAD support (8-byte nonce library versio=
n)"
>     depends on CRYPTO_ARCH_HAVE_LIB_CHACHA || !CRYPTO_ARCH_HAVE_LIB_CHACH=
A
>     depends on CRYPTO_ARCH_HAVE_LIB_POLY1305 || !CRYPTO_ARCH_HAVE_LIB_POL=
Y1305
>     depends on CRYPTO
>
> and this test's random config (s390-buildonly-randconfig-r005-20220703):
>
> $ grep -e CRYPTO_LIB_CHACHA20POLY1305 -e CRYPTO_ARCH_HAVE_LIB_CHACHA
> -e CRYPTO_ARCH_HAVE_LIB_POLY1305 -e CRYPTO=3D config
> CONFIG_CRYPTO=3Dy
> CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=3Dm
> CONFIG_CRYPTO_LIB_CHACHA20POLY1305=3Dy
> // missing CRYPTO_ARCH_HAVE_LIB_POLY1305 implies =3Dn (I guess?)
>
> I'm following the canonical "Kconfig Language" doc (
> https://www.kernel.org/doc/html/latest/kbuild/kconfig-language.html )
> which states:
>
> > - dependencies: =E2=80=9Cdepends on=E2=80=9D <expr>
> > This defines a dependency for this menu entry. If multiple dependencies=
 are defined, they are connected with =E2=80=98&&=E2=80=99.
>
> and
>
> >         '!' <expr>                           (6)
> >         <expr> '&&' <expr>                   (7)
> >         <expr> '||' <expr>                   (8)
> >
> > 6. Returns the result of (2-/expr/).
> > 7. Returns the result of min(/expr/, /expr/).
> > 8. Returns the result of max(/expr/, /expr/).
> > An expression can have a value of =E2=80=98n=E2=80=99, =E2=80=98m=E2=80=
=99 or =E2=80=98y=E2=80=99 (or 0, 1, 2 respectively for calculations).
>
> So calculating:
>
> (CRYPTO_ARCH_HAVE_LIB_CHACHA || !CRYPTO_ARCH_HAVE_LIB_CHACHA) &&
> (CRYPTO_ARCH_HAVE_LIB_POLY1305 || !CRYPTO_ARCH_HAVE_LIB_POLY1305) &&
> CRYPTO
>
> I find it equal to:
>
> (m || !m) && (n || !n) && y  =3D>  m && y && y  =3D>  m
>
> So CRYPTO_LIB_CHACHA20POLY1305 should be no higher than M, but it is
> =3DY in a config file =3D> weird :\ (or me wrong somewhere).
>
> WDYT?

Ok, I should have tested this beforehand. With the configs set as above:

CONFIG_CRYPTO=3Dy
CONFIG_CRYPTO_CHACHA20_X86_64=3Dm // implies the next line =3Dm
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=3Dm
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305 is not set // =3Dn

"make menuconfig" allows only =3Dn and =3Dm for CRYPTO_LIB_CHACHA20POLY1305=
 indeed.
So the test robot has fed an invalid config to a build process. Let me
forward this thread to
lkp@lists.01.org to report this issue.

Best regards,
Vladis Dronov | Red Hat, Inc. | The Core Kernel | Senior Software Engineer

