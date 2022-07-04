Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9805658B7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbiGDOfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbiGDOft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:35:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C18C05F70
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656945347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UWn8vpHqr/tRsNkcZQpjikpuU5VBHUd8JIMbOKw3t24=;
        b=dk56OqnDrq7NNLKZBFzUF+oB+BqbYw9fgCgsr9P0Dqwke7CHHyL3LFz+/LdvmOyz25JHhS
        AWcBqhhgQVbRaJH/F+98jAf+aI6QDky0/vfCgghGSehm64nXCnB9jt6BdXkayNNE72i6qD
        pfNnvs0XpEba6itr0r7mBLeTb16iwEQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-12-vjRYt7AMNtaNegJwyc3ukg-1; Mon, 04 Jul 2022 10:35:46 -0400
X-MC-Unique: vjRYt7AMNtaNegJwyc3ukg-1
Received: by mail-ed1-f69.google.com with SMTP id g7-20020a056402424700b00435ac9c7a8bso7321790edb.14
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 07:35:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UWn8vpHqr/tRsNkcZQpjikpuU5VBHUd8JIMbOKw3t24=;
        b=hwRvK+lQY0AnVFOpyWXuXy5soW7eNb52RTYu8JDuUpGbfwcjbjE4czq3exJYQkoKrn
         oNgVdWncurqYnuvlDg9t9170c0GI46q1AGMj0w5uJvuoiTtHXvZ9FN1naIhRR/BfNkZO
         hzGeEEOobcYK8B/+qnfeiASymH2nK1CqrjuxkFi2F6jtv/oqlMtmTNQeI6A5UiVX/+Wp
         7U0myQWXw5JiWMNRpVfBUxLeJcyoFjKJyiG34GtqBh4qP34af/x2ELTm1jpbOZ6rlFUH
         1vb08D6fz5mXaQO7jLJTkcjkgSYWCmxW9S6gnIgc8KhclABZVzhKpzWjLstTNUgOS2xo
         O+xg==
X-Gm-Message-State: AJIora9kkaXtfc4sxCVdrjDB2jV8DcU8FKLOlAlY8/oGt0dL8CL0BwDD
        pN6muDREHV92SXd+KDpz3iV3BoYYF8vmewLKzN43I+zRMs+7wyb7QqZ0oFnxcliz7GUPqKj5Nzd
        JRDosrf5b5r05+fmy9nO68O+cO8CMnoo6JRn6MK3L
X-Received: by 2002:a17:906:3f09:b0:712:466:e04a with SMTP id c9-20020a1709063f0900b007120466e04amr29119874ejj.719.1656945345478;
        Mon, 04 Jul 2022 07:35:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tFZYI0aWfp1BXwW63KBcCAtkxMubwjflTV0zoODfOVXD+tv747Cyg15Gtnsk77hYTi0xjaUCf18jA+aWLFh3g=
X-Received: by 2002:a17:906:3f09:b0:712:466:e04a with SMTP id
 c9-20020a1709063f0900b007120466e04amr29119849ejj.719.1656945345282; Mon, 04
 Jul 2022 07:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <202207030630.6SZVkrWf-lkp@intel.com>
In-Reply-To: <202207030630.6SZVkrWf-lkp@intel.com>
From:   Vlad Dronov <vdronov@redhat.com>
Date:   Mon, 4 Jul 2022 16:35:34 +0200
Message-ID: <CAMusb+SaQOEw_deYyT-nB43Jvmy8W1Bd5gJrpcgvtMOTiEaoNg@mail.gmail.com>
Subject: Re: include/crypto/chacha.h:100: undefined reference to `chacha_crypt_arch'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Harald Freudenberger <freude@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jul 3, 2022 at 12:51 AM kernel test robot <lkp@intel.com> wrote:
> ...
> config: s390-buildonly-randconfig-r005-20220703 (https://download.01.org/=
0day-ci/archive/20220703/202207030630.6SZVkrWf-lkp@intel.com/config)
> ...
>    s390-linux-ld: lib/crypto/chacha20poly1305.o: in function `chacha_cryp=
t':
> >> include/crypto/chacha.h:100: undefined reference to `chacha_crypt_arch=
'
> >> s390-linux-ld: include/crypto/chacha.h:100: undefined reference to `ch=
acha_crypt_arch'
> ...
> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for CRYPTO_LIB_CHACHA20POL=
Y1305
>    Depends on (CRYPTO_ARCH_HAVE_LIB_CHACHA || !CRYPTO_ARCH_HAVE_LIB_CHACH=
A && (CRYPTO_ARCH_HAVE_LIB_POLY1305 || !CRYPTO_ARCH_HAVE_LIB_POLY1305 && CR=
YPTO

Ok, this is either weird or I do not understand how the Kconfig system work=
s.

What I look at is CRYPTO_LIB_CHACHA20POLY1305 definition:

[ lib/crypto/Kconfig ]
config CRYPTO_LIB_CHACHA20POLY1305
    tristate "ChaCha20-Poly1305 AEAD support (8-byte nonce library version)=
"
    depends on CRYPTO_ARCH_HAVE_LIB_CHACHA || !CRYPTO_ARCH_HAVE_LIB_CHACHA
    depends on CRYPTO_ARCH_HAVE_LIB_POLY1305 || !CRYPTO_ARCH_HAVE_LIB_POLY1=
305
    depends on CRYPTO

and this test's random config (s390-buildonly-randconfig-r005-20220703):

$ grep -e CRYPTO_LIB_CHACHA20POLY1305 -e CRYPTO_ARCH_HAVE_LIB_CHACHA
-e CRYPTO_ARCH_HAVE_LIB_POLY1305 -e CRYPTO=3D config
CONFIG_CRYPTO=3Dy
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=3Dm
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=3Dy
// missing CRYPTO_ARCH_HAVE_LIB_POLY1305 implies =3Dn (I guess?)

I'm following the canonical "Kconfig Language" doc (
https://www.kernel.org/doc/html/latest/kbuild/kconfig-language.html )
which states:

> - dependencies: =E2=80=9Cdepends on=E2=80=9D <expr>
> This defines a dependency for this menu entry. If multiple dependencies a=
re defined, they are connected with =E2=80=98&&=E2=80=99.

and

>         '!' <expr>                           (6)
>         <expr> '&&' <expr>                   (7)
>         <expr> '||' <expr>                   (8)
>
> 6. Returns the result of (2-/expr/).
> 7. Returns the result of min(/expr/, /expr/).
> 8. Returns the result of max(/expr/, /expr/).
> An expression can have a value of =E2=80=98n=E2=80=99, =E2=80=98m=E2=80=
=99 or =E2=80=98y=E2=80=99 (or 0, 1, 2 respectively for calculations).

So calculating:

(CRYPTO_ARCH_HAVE_LIB_CHACHA || !CRYPTO_ARCH_HAVE_LIB_CHACHA) &&
(CRYPTO_ARCH_HAVE_LIB_POLY1305 || !CRYPTO_ARCH_HAVE_LIB_POLY1305) &&
CRYPTO

I find it equal to:

(m || !m) && (n || !n) && y  =3D>  m && y && y  =3D>  m

So CRYPTO_LIB_CHACHA20POLY1305 should be no higher than M, but it is
=3DY in a config file =3D> weird :\ (or me wrong somewhere).

WDYT?

Best regards,
Vladis Dronov | Red Hat, Inc. | The Core Kernel | Senior Software Engineer

