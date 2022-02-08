Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5384ADA50
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359849AbiBHNo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbiBHNo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 08:44:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C049C03FECE;
        Tue,  8 Feb 2022 05:44:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29D5560B23;
        Tue,  8 Feb 2022 13:44:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BA3C004E1;
        Tue,  8 Feb 2022 13:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644327892;
        bh=gu1lM0Rv9DCMR8zhSFa7X6w8lK33nztv12R7zJr4ESA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZwNc1cccdB41SwRmW9HutUa3OWLDVHqsUVOjmyhH29h4OlwGahcPp8QWDuQ3x1IIh
         LTmYuUWLsdybJSNiJF4lvGIxHqpJCA1FVG3xuL6Z4K7g81FuiIZKE76gTl5jmJ+5ME
         bhTtcBHaRYGYESr1JWOPlZxEdf0gpa/pQon3RzsgJ2KRjUKU5SWY83NB9mj8vaAz3x
         iDh4U8daYSrCHfC2QsLWHEJ3YXXSYDEqBjE3EgfsWDeqYq0Q+AzBsc8dKExJkPUt2G
         YqPFlF8x50XG7CWcz35yEb8d0ZxzrgpcefdLBf1hx+U70fMADJf87jdHcmUEY8jbD8
         QpOtYjX4d5zvg==
Date:   Tue, 8 Feb 2022 13:44:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Prasad Kumpatla <quic_pkumpatl@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>
Subject: Re: [PATCH v2] regmap-irq: Use regmap_irq_update_bits instead of
 regmap_write
Message-ID: <YgJzz5GFsKBteYyg@sirena.org.uk>
References: <20220119142953.1804-1-quic_pkumpatl@quicinc.com>
 <CGME20220208122955eucas1p2d4e32f51224242e9ebd0bce58b9c04ca@eucas1p2.samsung.com>
 <39f1b598-58ca-1e3d-3065-8dd692ee7c9f@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bGkYXeNT7w8NEyD+"
Content-Disposition: inline
In-Reply-To: <39f1b598-58ca-1e3d-3065-8dd692ee7c9f@samsung.com>
X-Cookie: This is your fortune.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bGkYXeNT7w8NEyD+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 08, 2022 at 01:29:55PM +0100, Marek Szyprowski wrote:
> Hi Prasad,
>=20
> On 19.01.2022 15:29, Prasad Kumpatla wrote:
> > With the existing logic by using regmap_write() all the bits in
> > the register are being updated which is not expected. To update only the
> > interrupt raised bit and not tocuhing other bits, replace regmap_write()
> > with regmap_irq_update_bits().
> >
> > This patch is to fix the issue observed in MBHC button press/release ev=
ents.
> >
> > Fixes: 3a6f0fb7b8eb ("regmap: irq: Add support to clear ack registers")
> > Signed-off-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
>=20
> There is something wrong with this patch. Since it landed in linux-next=
=20
> (20220204) I get an interrupt storm on two of my test devices:

I'll just revert it for now.

--bGkYXeNT7w8NEyD+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmICc84ACgkQJNaLcl1U
h9Dcpwf/ZuoJ3isPhFf8jelGmKPzrCWi40feOyhm3CWL/l7usejsTkiUPR7NpV8g
QjGdxc+NJaaIcuFGf30EL7r/xZmOfw7rwEBj/tWH56YJS2xKxIRuT/T59WOHbe1c
+7geKmc8uCPErb/5J8PJWLpSurDpsqIDu3O/o6WfgF5FfIJeRjE30uhvdklEpy1o
XjMq1+8C4Bzp2FrKQLmMuEAem29GJb7FTgdMslly/MEKSXoQZtDY+ToF96flLg6w
UCx4up1xa852G9gTXvKvNqtCJvyw/fC6Fdu1EUbabDVz35yiCmLPVePtBhdzgIVl
ig8kR6VmcKsbsrze0yB1Sm4MuqdQhQ==
=RHEL
-----END PGP SIGNATURE-----

--bGkYXeNT7w8NEyD+--
