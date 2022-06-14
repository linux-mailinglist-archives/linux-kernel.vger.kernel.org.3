Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2C554AD17
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352888AbiFNJSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiFNJSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:18:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C2040919;
        Tue, 14 Jun 2022 02:18:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CDE11B817BF;
        Tue, 14 Jun 2022 09:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1EC9C3411B;
        Tue, 14 Jun 2022 09:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655198307;
        bh=qY4QYFNySUnbFd+YjwBFvK08ESBS0Xn6VzgWab0zmPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c0Y8DLqiCpxygssmgukH6NsS6c5FANeyOctlu7871eAXxmG2RF0SQ7FUvon0Zvdpj
         hccgCoLBLztOp5CCVvg+Sg24g3fQhdO76kzMbdsYwvf7RKtdIigEBuJzAl8LHcINR6
         hhr8mAs/a0WdlZ0OMduJdrc8sTlnisaMJUDotbr1aI3lX4HK4DfftodMiMxtU3Kj3g
         toLw2BkYx13L9W3dvaCEoZUb4pRqNw8vHJGRfv70m90HjNl5z8C8YfH5MrtRK/kN+0
         Tvo8GoYkrBl462NLl2DqA7eQ/owxjt+ZP+dfXTu989Sr5iMkEK3UGIT/vrU7HF75ga
         BwBQjUVDE7ZXA==
Date:   Tue, 14 Jun 2022 10:18:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     matti.vaittinen@fi.rohmeurope.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: regulator: BD71837 PMIC resume during noirq phase?
Message-ID: <YqhSXuHMR6kuFu/A@sirena.org.uk>
References: <573166b75e524517782471c2b7f96e03fd93d175.camel@puri.sm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+fR1QCK73X/HcG0b"
Content-Disposition: inline
In-Reply-To: <573166b75e524517782471c2b7f96e03fd93d175.camel@puri.sm>
X-Cookie: DYSLEXICS OF THE WORLD, UNTIE!
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+fR1QCK73X/HcG0b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 14, 2022 at 11:06:06AM +0200, Martin Kepplinger wrote:

> and regulator_enable() in imx-pgc is called from genpd_resume_noirq().
>=20
> At this point, does any workaround or fix come to your mind I could
> test? I guess i2c needs to be resumed too...
>=20
> Why does power domain only implement resume_noirq? How could I untangle
> this?

Indeed - if a power domain is controlling regulators then I'd not expect
things to go well if it tries to resume without interrupts, there will
be some things that can be done purely with GPIOs but that's depending
on the hardware having wired things up that way and the operations
needed by the power domain mapping well onto what can be done with
GPIOs.

--+fR1QCK73X/HcG0b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKoUl4ACgkQJNaLcl1U
h9A1yAf/Vx51C3O2i71jqkYFMKLPNfdrjqstyeRZT4HprhHHZUNGMWRhgBlrJsPt
hR/FEJVsh0kG3KpCqp1ktcWf5h5NjHEuISgCFVUZCrOHwlD2y4RNBza1msTwVrCb
gmXgtyhCqgYEkDQplyrjTO2HbdmY2d7Yp7R4aU9KteWnH+S3/bpWqZNdMvAeFskM
DQ/6ZRlGk8xTpIQtW7s2RvAekPfYhSUihffMKIz7QwtbaYeyQnGzYb7yzgXHbELo
+HqfCb+AmiXs0BnfKOefC6Q1a2BOcjmrKX8a/O84B7hJdRYqEnCFqf87YAoMa5+c
2m8TChKdHhRObPq49xmkzZNunZQsyw==
=WUL+
-----END PGP SIGNATURE-----

--+fR1QCK73X/HcG0b--
