Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590A04C8C8D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 14:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbiCAN0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 08:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiCAN0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 08:26:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004274F463;
        Tue,  1 Mar 2022 05:25:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0BC8B818F6;
        Tue,  1 Mar 2022 13:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D31C340EE;
        Tue,  1 Mar 2022 13:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646141123;
        bh=fGz211pe0N4hyHlm5ps1Sr0ecSqu09vLb2sUW2Ygypw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TXUqAPpHc5mJtTLGkJ51l+Bmm/zQtdTknQzZXT8z/uv6Km7AH05nVGfqg0rgSb0AO
         BEacJl8Zyb1mlYH7TfRz/WQksEWh4b2JRZhk5kM10pZilXoDDBZtLY1STg+DE0EEIn
         nc7vDElSc5HMHgkROk231um8inriyX+/f2GxITTykQz7ket8ytOx5MjtTeywt7ChME
         zQQTlzb1t6p1sHx6nSEf2EpOvkbnGcCOOshpNjApc7sufnhjO7rBGQ01U4VGvzytfl
         c0oBfgF/qr69PwAMmMQHbJHLPlQ0cXX1fNEeaAZvTJos7/Cwn7Cekyz9LyzwnWiGT4
         9c/eq5pEzXL+Q==
Date:   Tue, 1 Mar 2022 13:25:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Rob Herring <robh+dt@kernel.org>, Pratyush Yadav <p.yadav@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] spi: fsl-spi: Implement trailing bits
Message-ID: <Yh4evlYQXru8c++N@sirena.org.uk>
References: <cover.1646060734.git.christophe.leroy@csgroup.eu>
 <fe4a3946a66ede73f6d6871700f2aaf0171372a1.1646060734.git.christophe.leroy@csgroup.eu>
 <YhzqbYW1q5bPNWXn@sirena.org.uk>
 <7afaab3d-50e0-4716-18d4-41eabc2a9cb9@csgroup.eu>
 <Yhz0/1kiAy7Mlgtv@sirena.org.uk>
 <fa51ac07-9cba-a8b5-89ed-c51a8a12d452@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0U1od5J5OqUDXV6E"
Content-Disposition: inline
In-Reply-To: <fa51ac07-9cba-a8b5-89ed-c51a8a12d452@csgroup.eu>
X-Cookie: You have a message from the operator.
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0U1od5J5OqUDXV6E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 01, 2022 at 12:53:58PM +0000, Christophe Leroy wrote:

> My understanding today is that this trailing transfer with chipselect=20
> OFF is to be added at the end of transfer_one_message().

Yes.

> It can be implemented in the core transfer_one_message() for drivers=20
> implementing transfer_one(). For the other drivers not having=20
> transfer_one() but having transfer_one_message(), it must be implemented=
=20
> in the driver's transfer_one_message().

> Am I right ?

Yes.

> fsl-spi driver is the one I need to support this new functionnality and=
=20
> it has its own transfer_one_message().

> What would you expect ?

Well, if the fsl-spi driver has a good reason for open coding
transfer_message() it could continue to do it, however looking at the
driver it seems like it's only the little bit at the start to optimise
the trasfer width in CPU mode which looks like it could easily be moved
to a prepare_message() callback and save a bunch of code so it'd be good
to convert it.  I guess it shouldn't be strictly essential though.

--0U1od5J5OqUDXV6E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIeHr0ACgkQJNaLcl1U
h9CdLwf+OjYGDExE28BCAFXXyZLYcQHLkDfa219TAYxNuE0upFLoAXBPlCeWYQtB
2eCk0YJTARvPcwJXkNrv99HibRUA6Fjr0HpbGfTdmSKrwkHlx3XTYirMGj0cQyOL
1qBOngx+onkeS2+t0p8uxwA4xE+bOci9zUP0OF7oQI60cdWJukl8jK6Bq5uOwULR
/VuL1ACetClUtnCrJQxCGn9VNLJa+jkKc+PzF7pMWXYw8iWtd9qPnAkPRzvOCBnE
N14RdzDR8bDyXgJNJp0FchRC83G+eA/c2c4n8QAGj9YkklGHKO2+0kMt7wpjVio+
hFIp1TxpVQlIxJXsD26VO/hJrm+39Q==
=bVV1
-----END PGP SIGNATURE-----

--0U1od5J5OqUDXV6E--
