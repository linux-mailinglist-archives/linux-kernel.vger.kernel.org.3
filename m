Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20FA544871
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbiFIKO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiFIKO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:14:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4722050F9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 03:14:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A12761D11
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 10:14:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1152EC34114;
        Thu,  9 Jun 2022 10:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654769664;
        bh=SLw1oSh+8LUTAZT86qz5LL5HQ2TFx0Zf2q1ZombaJqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tfix+sQxFrhbG0Y9h+v2ocj77Fd3DTdWQcMlDxIi6ta9xlyq1qJn280WrFP3O7lYu
         QWasQ5U9BF63aUGKU7x2eW7eopTW/u2vAjTJs5k/KqKFv1a36N+1MPsti0O+XSUkln
         sYB1YBaD1gArh8Bvv6GXjU3GnLU2rVNkuQCE5JBIdPpKmnqYQEAkSrTr329fDqEDGg
         EvObnl14kCVvij6xo249k/y51bHZklpWgMheotdNVx/UjYqn4VuOjT12yvoOKiGFls
         sOz2OA/75CeE2/pNpJA1Ixxdsi6vZOEngzFmnaf4Oh5n+UpaT90PFHjFP9LJaBe3Xb
         inHHVfokmRBcg==
Date:   Thu, 9 Jun 2022 11:14:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Zhang, Tianfei" <tianfei.zhang@intel.com>
Cc:     "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wu, Hao" <hao.wu@intel.com>, "trix@redhat.com" <trix@redhat.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: Re: [PATCH v1] regmap: add generic indirect regmap support
Message-ID: <YqHH+oX/90KXv8dN@sirena.org.uk>
References: <20220607013755.594554-1-tianfei.zhang@intel.com>
 <Yp9PdZn2Xu/oqiA8@sirena.org.uk>
 <alpine.DEB.2.22.394.2206071714420.3001206@rhweight-WRK1>
 <YqB9O8HhZV2tXo8g@sirena.org.uk>
 <BN9PR11MB548315C03B09D841B6392E63E3A49@BN9PR11MB5483.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pnYC1NmSS39gOaw/"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB548315C03B09D841B6392E63E3A49@BN9PR11MB5483.namprd11.prod.outlook.com>
X-Cookie: Space is limited.
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pnYC1NmSS39gOaw/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 08, 2022 at 11:54:26PM +0000, Zhang, Tianfei wrote:

> > > Would a different name help?
> >=20
> > This wouldn't address the major problem which is...
> >=20
> > > > > +	writel(0, ctx->base + INDIRECT_CMD_OFF);
> > > > > +	ret =3D readl_poll_timeout((ctx->base + INDIRECT_CMD_OFF), cmd,
> > > > > +				 (!cmd), INDIRECT_INT_US,
> > INDIRECT_TIMEOUT_US);
> > > > > +	if (ret)
> > > > > +		dev_err(ctx->dev, "%s timed out on clearing cmd 0x%xn",
> > > > > +__func__, cmd);
> >=20
> > > > ...and this doesn't look particularly generic, it looks like it's
> > > > for some particular controller/bridge?
> >=20
> > ...that this appears to be entirely specific to some particular device,=
 it's got
> > things like hard coded register addresses and timeouts which mean it ca=
n't be
> > reused.
>=20
> Yet, this is a register access hardware controller/bridge widely used in =
FPGA IP blocks, like PMCI, HSSI.
> How about we change the patch title like this:

> regmap: add indirect register controller support

No, please enage with my feedback above.

--pnYC1NmSS39gOaw/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKhx/kACgkQJNaLcl1U
h9BkuQf7B56QFQztdHtVqb/2t5HdOuKXMNcFF8CV8OVFl8cAdPXPakXcAW5FpAUE
V4ag+gzdzhZjnaxJ0rF8k5lRDYIZbx4au4oYIrFyJ07Q+va0ezLmKfaisf2IXyuv
hTXpx+k+j1aBSVh0dAxquKn5tt3Mjq1CEhDiBLyfCyAlEAdyG3Ad7PuQpA3d8Moc
vzuhzLMf6kMRkRR0njHzvtGtevdaJSmRy3Pm41GNkctZzcyWdidxa8FT45Xcv9E5
DFoTU+pvKG/e93lx+KIwrjXdtHcSvF3kIiy9JtWRitrwkjvP6aFNtHCjyU7Oyuv/
04A6GBCGJhvQ2FxUvWS+dFuj8yO55Q==
=rgTb
-----END PGP SIGNATURE-----

--pnYC1NmSS39gOaw/--
