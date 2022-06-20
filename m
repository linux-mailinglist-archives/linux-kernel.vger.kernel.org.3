Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E9F552053
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243176AbiFTPQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243066AbiFTPQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:16:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16ECA65BF
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 08:06:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8614860F85
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 15:06:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4341DC3411B;
        Mon, 20 Jun 2022 15:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655737559;
        bh=30bUgYkE58y/tfhWoWExyJKJwkRteOnIMFUM7GJATck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mUKULYIoKfzav1Mowvjal+nJKHco9Kht5rLuuBy6WhmEA0607is7HGcJODV7syg0S
         eGPVptRNHnD/ZI+bwpiOG6CwgJM5RxJD7QSGYcXvBeMmgl7haGSG87GBka6+l3WFTB
         HVCFsLrfBbV3ut+tHImgwhG+MmDgV4oO7bfi7H6GyHo2B8A6r6joSEqRPs3dLmY5lG
         BCkUatAoITWZV76MH6Jr0UjPKpFqi00DBsnduFfIxmlpYUxgMYI3cssBftHD/eOXwk
         VMxASv+oSgsrSTFFiPzwUVjiD4H5YaF3D6U7q//vw+K6Sq+jsdtXOoUPV54i804Ww6
         Fj5wYAkcZwynA==
Date:   Mon, 20 Jun 2022 16:05:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dong Aisheng <aisheng.dong@nxp.com>
Cc:     linux-kernel@vger.kernel.org, dongas86@gmail.com,
        l.stach@pengutronix.de, peng.fan@nxp.com, shawnguo@kernel.org
Subject: Re: [PATCH RFC 1/2] regmap: add option to disable debugfs
Message-ID: <YrCM0reni+x/KWsG@sirena.org.uk>
References: <20220620134758.1286480-1-aisheng.dong@nxp.com>
 <20220620134758.1286480-2-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w6/RnThi4AoDAs3H"
Content-Disposition: inline
In-Reply-To: <20220620134758.1286480-2-aisheng.dong@nxp.com>
X-Cookie: Good day to avoid cops.  Crawl to work.
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URI_DOTEDU autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w6/RnThi4AoDAs3H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 20, 2022 at 09:47:57PM +0800, Dong Aisheng wrote:
> The regmap core will create debugfs by default for each instance.
> However, it's fairly possible that some devices may not work properly
> with regmap registers dump via debugfs due to it may be in suspend
> state (e.g. Power domain is off).
>=20
> Current regmap core does not support runtime pm for MMIO bus.
> Although there have been several retries [1] in community but finally
> didn't get accepted.
>=20
> This patch adds an option to allow drivers to claim no debugfs support
> due to possible platform limitations.
>=20
> 1. Link: https://lkml.iu.edu/hypermail/linux/kernel/1204.0/01646.html

As indicated in the message you're linking to here if the device can't
be accessed it should be being put in cache only mode which will ensure
that nothing can do any physical accesses.

--w6/RnThi4AoDAs3H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKwjNEACgkQJNaLcl1U
h9BZSwf/Xa5fqERKUAqb0rz8NlQCQTHcgSDHZZIRuRgZ8jiSwihmf122nGNvSGD1
GOm2MJEvT4KZBhCf7oihtXnc3uraecq2a2pk3m2oRV1UN3zzKrT9EG+Io4sQkI8Q
1JbrKOVbeU0sv/DU5fqh1kQEvPIOq1py+Cbhnjds/e5dvz29XI0lHx9vsQcyASto
ki+8VVP1kbd1xAzsFP0SnZVoTa7u0HQVw+Nxh5+BBT8VJzjBX/xG4bNQF729lDfL
c4PmI8FKpq33EozUj1kRfSlLfY06XKpyfXc4pSvM1EAeglFijD2QN9QiCwwAEnoF
9N2dGv6Vlz2kT9Hf3GGdwYKtS30acA==
=ahj6
-----END PGP SIGNATURE-----

--w6/RnThi4AoDAs3H--
