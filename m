Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC5057E181
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 14:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbiGVMj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 08:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGVMj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 08:39:26 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A5712D3C;
        Fri, 22 Jul 2022 05:39:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DAEC4CE298D;
        Fri, 22 Jul 2022 12:39:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556E5C341C6;
        Fri, 22 Jul 2022 12:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658493558;
        bh=reo/ib00n5m+LWpxQNHW524LhAEgtB16+S++fAo8aq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KcYByditoxl5567yIa+4FJMfsSOtc3+hN/RUEiPGf7JvWQV7WkkSO+E7Z7yN0dsM2
         ORt4rIVf6TotHLfZfn2Z1DE476PlztiHwtyvyl5wZs5yo8iXKMeNoTWuwjXws9oFyX
         sJbQqvOjcrDJFvgdf4DjT21G28LduiqKJu0OkaOpOtgKvOiJ/1INk7Jl0x5j/z5AGO
         wqtAT9h6bZcCFZRKRmmM6Y2EdiYmLGGoi0MUwPdnd+8tRgyrq5VpUWgmF7TUsbt8MH
         SdemVfxX1og+Yo/6qjVvR4waQtZpxNH7sQOdoONG9G/nJxk2H/NpqCs0z0mdUs76sA
         f/C1TNarFJ0TA==
Date:   Fri, 22 Jul 2022 13:39:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     jerome Neanne <jneanne@baylibre.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, nm@ti.com,
        kristo@kernel.org, khilman@baylibre.com, narmstrong@baylibre.com,
        msp@baylibre.com, j-keerthy@ti.c, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 08/14] regulator: drivers: Add TI TPS65219 PMIC
 regulators support
Message-ID: <YtqabjVY1vRgjZlM@sirena.org.uk>
References: <20220719091742.3221-1-jneanne@baylibre.com>
 <20220719091742.3221-9-jneanne@baylibre.com>
 <YtayikFdidxXXubS@sirena.org.uk>
 <b89db08e-3a06-5a8d-2c24-eb087ee3ca7e@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AdXhuxafCon3MFtt"
Content-Disposition: inline
In-Reply-To: <b89db08e-3a06-5a8d-2c24-eb087ee3ca7e@baylibre.com>
X-Cookie: Yow!  I want my nose in lights!
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AdXhuxafCon3MFtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 22, 2022 at 12:12:05PM +0200, jerome Neanne wrote:
> On 19/07/2022 15:32, Mark Brown wrote:
> > On Tue, Jul 19, 2022 at 11:17:36AM +0200, Jerome Neanne wrote:

> Refactoring the code with regulator_notifier_call_chain, I realized that
> some of the events in TPS65219 are not listed as standard REGULATOR_EVENT=
 in
> consumer.h
>=20
> This is the case for below event list:
> REGULATOR_EVENT_SCG (ShortCut to Gnd)
>=20
> REGULATOR_EVENT_RV (Residual Voltage)
>=20
> REGULATOR_EVENT_RV_SD (Residual Voltage ShutDown)
>=20
> Should I add those events to the list of standard regulator events and
> assign a code? (if yes, any rule for the values?)
> Would it fit with some other predefined standard macro defined elsewhere?
> (if yes, could you point me to the right location?)

Map them onto the existing values, the exact mapping will depend on what
those events mean, force disable or out of regulation look like likely
candidates for example.  If there's anything that's just not covered
then perhaps a new event type is needed.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--AdXhuxafCon3MFtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLamm0ACgkQJNaLcl1U
h9CTNwf+MmL0jEXkElQkkVYG52kUipqcMhcoQHdU8TpmK7UKX6H7ys25iMSC9vXb
qsCTgXed08X6ebAO0y0dKs0v2BtH9fw7o93RrYt7K4asw+nkLB8z0KBnpq5CDkIC
8aplky3yKeJVZ57GNA429EffUTFzcH5Gza8mNfxr4100p3vTjcqUb5Fbd0VBYV/c
up+F4WvnxBhZkGSB/E4tAYvP53s8nLe8FjUqJGXIP9Cl6t/Qr1hAMkaLArjiqhly
rZCFl1pf5wRuTxny/WSQCB573fEnM2jCQoUClZ9JfSvpM/NbWlGJPk9xXkt3lNd4
o8OFtt3LT/KazHn+2Qs1efoCNgvkMQ==
=+O3u
-----END PGP SIGNATURE-----

--AdXhuxafCon3MFtt--
