Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E374DD53F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 08:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbiCRHcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 03:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiCRHcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 03:32:22 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FCE2409B;
        Fri, 18 Mar 2022 00:31:04 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KKbKL1pPrz4xc1;
        Fri, 18 Mar 2022 18:31:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647588663;
        bh=R46NlN+rYs6doRFo+GJBndwKot6DC5GziYeiRObNQ4U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h4NBXydz457IEgAXIQbv0VKGseeU5MXQExWtc8m627tChqBEUC6Ssgsa7Ali75icZ
         Mei/PNECQ96W7RjYFTt1cgtN4jbrbXTm+2iNy+jR6NH2MkuABS04UIr4DJF3pkRZha
         JQ09v8zVqzsqyl/Vq5bpJ6QjFHbn3Dd/+nDgtza5Sjv7YaznBKj4Q1og51WQoELBps
         45aI9t2+esXErdmZt9Wnuc/XXNCe2Q+eYlNt1ejRJTegFa0zZutgWzZgUhSnVH4N40
         a7UGKOl1WRZ96zAjrjpQf4YLj3fkpkrj7u85r8cBFKdmmbrv4ftJAhBBuocjpKjcnD
         1HLPzwlVfBplQ==
Date:   Fri, 18 Mar 2022 18:31:01 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joey Gouly <joey.gouly@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the pinctrl tree
Message-ID: <20220318183101.16b8d056@canb.auug.org.au>
In-Reply-To: <20220120142539.6d1fac12@canb.auug.org.au>
References: <20211027220118.71a229ab@canb.auug.org.au>
        <874k92bu4q.wl-maz@kernel.org>
        <20211028080331.6d199082@sal.lan>
        <20220120142539.6d1fac12@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/JdXxFheYXenaqAtzYWbWblL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JdXxFheYXenaqAtzYWbWblL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 20 Jan 2022 14:25:39 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Thu, 28 Oct 2021 08:03:31 +0100 Mauro Carvalho Chehab <mchehab@kernel.=
org> wrote:
> >
> > Em Wed, 27 Oct 2021 12:10:45 +0100
> > Marc Zyngier <maz@kernel.org> escreveu:
> >  =20
> > > On Wed, 27 Oct 2021 12:01:18 +0100, Stephen Rothwell <sfr@canb.auug.o=
rg.au> wrote:   =20
> > > >=20
> > > > After merging the pinctrl tree, today's linux-next build (htmldocs)
> > > > produced this warning:
> > > >=20
> > > > include/linux/gpio/driver.h:284: warning: Function parameter or mem=
ber 'parent_handler_data_array' not described in 'gpio_irq_chip'
> > > >=20
> > > > Introduced by commit
> > > >=20
> > > >   cfe6807d82e9 ("gpio: Allow per-parent interrupt data")
> > > >=20
> > > > But may actually be a problem with the tool :-(     =20
> > >=20
> > > I guess the tool doesn't like having two fields that are part of a
> > > union documented together... Happy to tweak it if someone tells me how
> > > this should be written.   =20
> >=20
> > Yes, that's the case. See, when you do:
> >=20
> > 	/**
> > 	 * @parent_handler_data:
> > 	 * @parent_handler_data_array:
> > 	 *
> > 	 * Data associated, and passed to, the handler for the parent
> > 	 * interrupt. Can either be a single pointer if @per_parent_data
> > 	 * is false, or an array of @num_parents pointers otherwise.  If
> > 	 * @per_parent_data is true, @parent_handler_data_array cannot be
> > 	 * NULL.
> > 	 */
> > 	union {
> > 		void *parent_handler_data;
> > 		void **parent_handler_data_array;
> > 	};
> >=20
> > The tool will understand it as an undocumented "parent_handler_data" and
> > a documented "parent_handler_data_array".
> >=20
> > It has to do that, as otherwise it won't get cases where people just ad=
ds a
> > @foo: as a template but actually forgets to fill it.
> >=20
> > The solution would be to add a description for both, e. g. something
> > similar to:
> >=20
> > 	/**
> > 	 * @parent_handler_data:
> > 	 *
> > 	 * If @per_parent_data is false, contains a single pointer=20
> > 	 * with the data associated, and passed to, the handler for the=20
> > 	 * parent interrupt.
> > 	 *
> > 	 * @parent_handler_data_array:
> > 	 *
> > 	 * If @per_parent_data is true, it should contain an array of=20
> > 	 * @num_parents pointers with the data associated, and passed to,
> > 	 * the handler for the parent interrupt. Cannot be NULL.
> > 	 */ =20
>=20
> I am still getting this warning.

I am still getting this warning.

--=20
Cheers,
Stephen Rothwell

--Sig_/JdXxFheYXenaqAtzYWbWblL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmI0NTUACgkQAVBC80lX
0GxkhQf/V09aUv7iiBT8ilAVTFUnmXb8qqoPUne7JZP/57vK9JvPYbzwWRFRHy3s
HcbEwC+hi5R8pkbQwTNtZkSDYmpgucAdWBjCVJhj3FF51YpYqVVl6JyX9RlQgR8s
tBA9M0SCMt9fhLAlRk8FFoNww04uG4Jifr++KMbrnLEmwaHIi5H0FrU9KJB8DgHR
G+U2F6LDO2MSvqrMYkgrjeRJNtYq/jOG+G9D7xsFfMzQxUkJ59ZYepfAZ6scENYC
TrKLLX7h9e/qAVW4Kn8CdXNOsoykgHWYYi5Ma+UXektZ9XKCKzie8KXtT9U2va5Z
ROTpoA3tT2MWIl9HCmaOAW6igvtj5g==
=bDUN
-----END PGP SIGNATURE-----

--Sig_/JdXxFheYXenaqAtzYWbWblL--
