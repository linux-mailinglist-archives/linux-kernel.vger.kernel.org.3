Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD02F54B2E1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243101AbiFNOPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242805AbiFNOPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:15:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54E8B33891
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655216135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JctC2m2+QZN18u2MNb2HvFmHLpXv366LEOSyUu6TasQ=;
        b=iDnpfzdKKza6TuZmcvl+vbofoPO7jDrSkkz7OdC8+TPKF9DR8BL3KseY8nqTMPGuFn9O2h
        6DZ9KPeUG5NQWnBHQaCI+YJ7puia/mzwaJRfCSIrT+Xwyh4VTvPZOSGQJARQRJ5CM5TkWk
        c9SHn7ojEpCT2axlHqkg6JSovCbIegs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-jTzZCP9PPUawlDPopva-5Q-1; Tue, 14 Jun 2022 10:15:34 -0400
X-MC-Unique: jTzZCP9PPUawlDPopva-5Q-1
Received: by mail-qk1-f199.google.com with SMTP id s11-20020a05620a254b00b006a6a23ff939so7522687qko.17
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 07:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-transfer-encoding:user-agent
         :mime-version;
        bh=JctC2m2+QZN18u2MNb2HvFmHLpXv366LEOSyUu6TasQ=;
        b=F8AitUP8PxLCdzvdabSA7LnNGODyeVgNjp+fZvA/MMkbBs0Y1Lk8N+hY9y+TSgHfl+
         ZOM7zwUCUJi0tHwGhGm7cQQtPwAoQpHSv6xj3UzyAcVScr76Krs49hebFoxpjJFtF/JN
         3jAcET3CL1Mq6qQylhow3MJp3UZ/dMlxAh/n8/LibS/OKCQvm1DmYoKc5ZWhgIcJtyP0
         hOpr3MCzUo2EUs74awHuRmjcksCuuqYm5Lro/qwD5345yuK+8euSdLDegV/APuo4L5cb
         lY9ir7Fw+x1R+vd37aZ0iP8WmPc+/G0Hd6rX4QkbXtEIrq+MJnbZ09k7MPPF3vVWFaiN
         EpNw==
X-Gm-Message-State: AJIora+8b9DXMP/IGfghxRM1vCdBHJK86VvjlM/ry0ZkIVvu6fq0zq1j
        1pkZ26MzYKX7e2kB9/Uf5iyQSTh4pR3ly79C6uTZnDxsjFRnqkcAgsCwp8aq+MDVGltM9Z5zo5u
        WVzGHDbOGcHfKHJZ5verVaXms
X-Received: by 2002:ad4:5c4a:0:b0:464:5920:7c1a with SMTP id a10-20020ad45c4a000000b0046459207c1amr3579678qva.58.1655216133915;
        Tue, 14 Jun 2022 07:15:33 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sUmVYfieNEUEGblxVDH6VoXBlZfAPSf7IbUAfA0HBAtNoDeIhDejnqioeqYTK2ssE5LXtTUg==
X-Received: by 2002:ad4:5c4a:0:b0:464:5920:7c1a with SMTP id a10-20020ad45c4a000000b0046459207c1amr3579632qva.58.1655216133401;
        Tue, 14 Jun 2022 07:15:33 -0700 (PDT)
Received: from m8.users.ipa.redhat.com ([93.56.163.49])
        by smtp.gmail.com with ESMTPSA id h20-20020a05620a245400b006a32bf19502sm9394754qkn.60.2022.06.14.07.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 07:15:32 -0700 (PDT)
Message-ID: <831c7380f7d89fd8fb3a3043cf3b3d01001ae0be.camel@redhat.com>
Subject: Re: [PATCH 0/2] certs: Add FIPS self-test for signature verification
From:   Simo Sorce <simo@redhat.com>
To:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 14 Jun 2022 10:15:24 -0400
In-Reply-To: <165515741424.1554877.9363755381201121213.stgit@warthog.procyon.org.uk>
References: <165515741424.1554877.9363755381201121213.stgit@warthog.procyon.org.uk>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-06-13 at 22:56 +0100, David Howells wrote:
> Hi Herbert,
>=20
> If you could look over this pair of patches?  The second patch adds a sim=
ple
> selftest to allow the signature verification code so that it can be FIPS
> compliant.  The first moves load_certificate_list() to the asymmetric key=
 code
> to make this easier and renames it.
>=20
> I generated the test data myself, but I'm open to using some standard tes=
t
> data if you know of some; we don't want too much, however, as it's
> incompressible.  Also, it has avoid blacklist checks on the keys it is us=
ing,
> lest the UEFI blacklist cause the selftest to fail.
>=20
> The patches can be found on the following branch:
>=20
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/lo=
g/?h=3Dkeys-fixes
>=20
> David
> ---
> David Howells (2):
>       certs: Move load_certificate_list() to be with the asymmetric keys =
code
>       certs: Add FIPS selftests
>=20
>=20
>  certs/Makefile                           |   4 +-
>  certs/blacklist.c                        |   8 +-
>  certs/common.c                           |  57 ------
>  certs/common.h                           |   9 -
>  certs/system_keyring.c                   |   6 +-
>  crypto/asymmetric_keys/Kconfig           |  10 +
>  crypto/asymmetric_keys/Makefile          |   2 +
>  crypto/asymmetric_keys/selftest.c        | 224 +++++++++++++++++++++++
>  crypto/asymmetric_keys/x509_loader.c     |  57 ++++++
>  crypto/asymmetric_keys/x509_parser.h     |   9 +
>  crypto/asymmetric_keys/x509_public_key.c |   8 +-
>  include/keys/asymmetric-type.h           |   3 +
>  12 files changed, 321 insertions(+), 76 deletions(-)
>  delete mode 100644 certs/common.c
>  delete mode 100644 certs/common.h
>  create mode 100644 crypto/asymmetric_keys/selftest.c
>  create mode 100644 crypto/asymmetric_keys/x509_loader.c
>=20
>=20

Reviewed-by: Simo Sorce <simo@redhat.com>

--=20
Simo Sorce
RHEL Crypto Team
Red Hat, Inc



