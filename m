Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121D452C91B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 03:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbiESBEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 21:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiESBEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 21:04:06 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4F8CE16;
        Wed, 18 May 2022 18:04:05 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L3WpD0q9bz4xLb;
        Thu, 19 May 2022 11:04:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652922244;
        bh=/lTfB5Yo9vq8/12Z1ICjN1vGtjSA+U+1BxuwnWU6U+M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tiOsO//6JFfd8vDYysehXupg607QTOzRDMtuIRdfM6Q5G/6wR4cTxydkdFPYHsBXG
         1LG04CLMDL5+6U80CID5ZD9YpblrswXI7HxgdYDiel/ETr2lV1JEZSt5ViAHKpXxAq
         Ae+R0er7BbQp8jjrEECXj7h4d4B5siTEZUN5lO9ewOB9+anKIMNMNdc3BLLmqQ9SrF
         And0YOmV/EdS5sM0wnlOId7OC5T1/WIxb3rgQliG8aIGpOwyRw/qTmvXsaMEblD2jE
         IbJdC62uJgL6DFmU+pMNN3byX4u/w/4ludiicHVFWCymQSWdV0z2iwOniUzs1eHW4N
         2f64vyR1aefqw==
Date:   Thu, 19 May 2022 11:04:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bob Moore <robert.moore@intel.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: linux-next: manual merge of the pm tree with the loongarch tree
Message-ID: <20220519110403.7e797df7@canb.auug.org.au>
In-Reply-To: <20220519110008.586bc47f@canb.auug.org.au>
References: <20220519105448.74a4447e@canb.auug.org.au>
        <20220519110008.586bc47f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mPnFcxN/Iq/SvJA1b_FDJJK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mPnFcxN/Iq/SvJA1b_FDJJK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 19 May 2022 11:00:08 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Thu, 19 May 2022 10:54:48 +1000 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> > =20
>=20
> >  +	u32 count;
> >  +};
> >  +
> >  +/* LPC Interrupt Controller */
> >  +
> >  +struct acpi_madt_lpc_pic {
> >  +	struct acpi_subtable_header header;
> >  +	u8 version;
> >  +	u64 address;
> >  +	u16 size;
> >  +	u8 cascade;
> > ++
> > + /* 17: OEM data */
> > +=20
> > + struct acpi_madt_oem_data {
> > + 	u8 oem_data[0];
> >   };
> >  =20
> >   /* =20
>=20
> I missed adding the closing brace after struct acpi_madt_lpc_pic.  I
> have added that to my resolution now.

Not a good morning :-( I also forgot the comma after
"ACPI_MADT_TYPE_RESERVED =3D 24".  Added now.

--=20
Cheers,
Stephen Rothwell

--Sig_/mPnFcxN/Iq/SvJA1b_FDJJK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKFl4MACgkQAVBC80lX
0GwXCwf/QS0iiQXgsSu7PcYTldYLsTU1MCJx2VqxYueCfMi51ELhzqiizQtrVuZE
pU41Mq6lPxvxSNMDtNZQu1UZVZmVfAD6Y8bu5JKdInS3mesUqq5qscS2SXSgNZp0
dDoa5pi4JL5cpmGdOlCYKUCvvwf46B31toKmnsmUU8c/xeQXfm1teEqZenwE7MWT
N93HlxXyWur9D6LJyFxYkyYEVNjg0j3QYqRfXc0Qo3QWZDMbCcHF3hr6W4rYuLXm
yOr0M9PCNmPA87XjR/jaNiLLsyfz4QPz2KCH8ebfDsEidNHtv9Re5alKfmHrB4C4
Ef2tAO3eAAugABbIblSGbXv2JtaZ0Q==
=3DpB
-----END PGP SIGNATURE-----

--Sig_/mPnFcxN/Iq/SvJA1b_FDJJK--
