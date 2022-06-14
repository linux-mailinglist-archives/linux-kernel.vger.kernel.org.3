Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A7454AE1B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 12:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351345AbiFNKQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 06:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbiFNKQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 06:16:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E84A46C8B;
        Tue, 14 Jun 2022 03:16:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 647E3B817E0;
        Tue, 14 Jun 2022 10:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B69C3411B;
        Tue, 14 Jun 2022 10:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655201780;
        bh=9ERUcLB6d+TQPmFdYA4ZdtjoUd5ph1q6+6yNmsUj4O8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RGr2f0vmGyHowRBOd/c0Z2bqSbBm1sfbnO4qAg6g0qGxGBv6nseo1OazOpT/SYf7+
         56DCPlzjz5Ye0Emms2o9IBmCBjiczFyPWWCNbFaDZYipsLmBMAnXFADzUB0CHFbhNA
         ZrWOln6Yzho+tJS4ttL7Jh8oVryS0hvn3+OkAcSwwF2YgBCEGXQquwYoN1sDyGmYZD
         P5haf0phyHe4k9l/LvU2CFiKL8eyU/GUJwzSfaxFrBil8VquWVruvwiJHus67cnet9
         rq7i0dyDfgGO33n6YlLbC67TuP4Zo+so0Hj/JDg04Ji9PnLz1NSeNiAwR+eKVsTG8K
         Cl2fspzdYzqXA==
Date:   Tue, 14 Jun 2022 11:16:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     matti.vaittinen@fi.rohmeurope.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: regulator: BD71837 PMIC resume during noirq phase?
Message-ID: <Yqhf7/3B0l9+3dQH@sirena.org.uk>
References: <573166b75e524517782471c2b7f96e03fd93d175.camel@puri.sm>
 <YqhSXuHMR6kuFu/A@sirena.org.uk>
 <8024d9e3b885941084740cb0fb2fc9117acdd069.camel@puri.sm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FwJPrEqu2igwCvTs"
Content-Disposition: inline
In-Reply-To: <8024d9e3b885941084740cb0fb2fc9117acdd069.camel@puri.sm>
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


--FwJPrEqu2igwCvTs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 14, 2022 at 11:57:18AM +0200, Martin Kepplinger wrote:
> Am Dienstag, dem 14.06.2022 um 10:18 +0100 schrieb Mark Brown:

> > Indeed - if a power domain is controlling regulators then I'd not
> > expect
> > things to go well if it tries to resume without interrupts, there
> > will
> > be some things that can be done purely with GPIOs but that's
> > depending
> > on the hardware having wired things up that way and the operations
> > needed by the power domain mapping well onto what can be done with
> > GPIOs.
>=20
> and what's the danger when resuming power domains later?:

If there's a device that needs to early resume in a power domain that
needs to do something on resume then presumably this will mess up the
ordering.  You probably need a separate power domain type, or both
operations.

--FwJPrEqu2igwCvTs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKoX+4ACgkQJNaLcl1U
h9DzTAf/Z849hL5DvEmR4+zZ0xjMVbRyk6QwD+kgL6iJDZh56FTqanaJGZt+MdCp
iaVFZxus2dh+BGlOtcK4GLiHcwKBOBqDpMvcbmDxhdORn/2tEGFfUudRZ3XUWHe8
3ZX/qeMZ+zcrPNh8HwKXKUeQ+jlj94q9fpe6kEBVR7qWHtDrREZdCWONoIv8dyVP
Gw8MibcEoMDWOsEqIf0t0JrKNJdJwBNln7CwXCnpeoLfbtI3ovdxnAtzwsUDhfuv
HqQik+m9bIgEDhvZL5ORm6SKsYC4YHYKI6mNDgxNKsVFoPP7zJIEVYA0+2zsHI0w
IR50e/+h50xP1W6jkmkDA7S6bCBQAQ==
=NKop
-----END PGP SIGNATURE-----

--FwJPrEqu2igwCvTs--
