Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A284E8AEC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 00:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbiC0Wts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 18:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiC0Wtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 18:49:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72A41260A
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 15:48:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47EE860E84
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 22:48:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387FDC340EC;
        Sun, 27 Mar 2022 22:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648421286;
        bh=JDJbDBAduWIPsFOyXVglXB/KwMzaEh2PeuQslWr4wlY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R04snnB9ihr7timKbzEnDwzwbdxX7BEAAb5WRQK7BUI3KJVAXrARA6OTqsXcoD41b
         x62m9/7tVs4ooKMBe9KOYZfpgyxrPDftmiagk17vTrXNgbtdhH05f9r3yC8mMJN4sV
         zMazDFtTHI6HOokJgCu077OryLsTq4eESSdIDy03WJZnUB5iLIOvMHYHgi5M9UDMMY
         wumBePkeX7uPqVnINvuTyQFO3MptqdJ1HGuqiIgBzeO1dzLPyXg0YTfWHzLDuvaUNA
         9ZY/JirIuODckh1TBe5e6wOuKVjkr+8Uv6oqRId3bNSKxXNxzDULJjQZCgcYsAi2Na
         Whi0/86coMAhA==
Date:   Sun, 27 Mar 2022 23:48:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: wm8994: Add an off-on delay for WM8994 variant
Message-ID: <YkDpozx+ZmSWwwH0@sirena.org.uk>
References: <CY4PR04MB05676D46494F722485CE7551CB1C9@CY4PR04MB0567.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RfuYbMqjCs6wiIyl"
Content-Disposition: inline
In-Reply-To: <CY4PR04MB05676D46494F722485CE7551CB1C9@CY4PR04MB0567.namprd04.prod.outlook.com>
X-Cookie: <Omnic> another .sig addition
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RfuYbMqjCs6wiIyl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 27, 2022 at 03:15:53PM -0700, Jonathan Bakker wrote:

> =20
> +	/* WM8994 requires an off-on delay while others do not */
> +	if (ldo->wm8994->type =3D=3D WM8994)
> +		wm8994_ldo_desc[id].off_on_delay =3D 36000;

You shouldn't modify the description - this wouldn't work in the
unusual situation where there were one of these devices and is a
bad pattern to set in case someone copies this to another device
where it's more likely there could be multiple instances.  It is
much better to provide two descriptions and select the one which
is needed at runtime.

--RfuYbMqjCs6wiIyl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJA6aIACgkQJNaLcl1U
h9CoLwf9H+lweZrus196h+g+F+zAZQvK2650ZTzT1MQ200HmcydXwvZp/sSJ06wK
Yt2WfBxwX0QoYn0rWcepMD0qunVJzt2W8q7Vb/NzYJ3wE/5BaZH5UKnf+GIGVA/N
gaAhH3Iz8gYdb8Lf5GwS89pxFiOmAJarRO0OyQGOn2RzvmKWLPnLqrd2T/ek9xCv
moa9ZjnC1LRc8t7p17DwmxRzFSk1K/UnDbERCbcnWw9TpnqZYqHWcXEmAHYUrb5y
pX3wj6sX3sNUHOnhJFQ2e83FQWsaFoYn3xJN0xOd0MhOhW56Gu8+1cCKkfuJkoR8
SjP9K4jVHslCIAX8fcQuqE6eTFg9tA==
=er8D
-----END PGP SIGNATURE-----

--RfuYbMqjCs6wiIyl--
