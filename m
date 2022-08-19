Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D0C599DA4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 16:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349349AbiHSOin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 10:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349361AbiHSOih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 10:38:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6943F4CA2E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:38:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22344B827E9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 14:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA86BC433C1;
        Fri, 19 Aug 2022 14:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660919912;
        bh=TvKxoPTWbVRabhPk9a4rPqMy4W63RDOrWmCVASuqvME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DEw47xgVqQEc1ADODU8BOwMIN++XRhfxnJMDhqIpSrFIOm8UKx0XIP43U+0Z7e6nO
         K6nMS2zbJOu0JMRqJWKn9it4HYcxAYgo7hycLxzfKs/S2pJZzOvfG2OggbFz7tJ2My
         MhFb5P915YjGQyzAcmOiSKdzavmPZeKXzotNBrpnXn4h3vTagxWRXUkvd4H2c3j/eq
         VZj+uGVGwCGClhhydiXBDP5lp7agNisAixBkhJJ7U29kpqRIVvBJLS7+xz7MrUdhtm
         5IuaTEYM+zgIb4avftvHqVX1ftelNpfrhgfVp5RISdOi4xtRPo9Ni7Na7olPpWWdzx
         lGdk33jLIJPbA==
Date:   Fri, 19 Aug 2022 15:38:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        gregkh@linuxfoundation.org, rafael@kernel.org, jic23@kernel.org,
        "linux@rasmusvillemoes.dk>" <linux@rasmusvillemoes.dk>,
        tglx@linutronix.de, andy.shevchenko@gmail.com,
        kernel <kernel@sberdevices.ru>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] regmap: introduce value tracing for regmap bulk
 operations
Message-ID: <Yv+gY34CRfqu3sCS@sirena.org.uk>
References: <20220816181451.5628-1-ddrokosov@sberdevices.ru>
 <20220818121515.6azkxyqetnunwsc6@CAB-WSD-L081021.sigma.sbrf.ru>
 <87mtc1wtjz.wl-maz@kernel.org>
 <Yv5eMcmNOmyLmd++@sirena.org.uk>
 <5793e1a9ef6d5a8fafd3f22cda0bb5e4@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LxcsmEkn3CkIR9C+"
Content-Disposition: inline
In-Reply-To: <5793e1a9ef6d5a8fafd3f22cda0bb5e4@kernel.org>
X-Cookie: Price does not include taxes.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LxcsmEkn3CkIR9C+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 19, 2022 at 03:25:44PM +0100, Marc Zyngier wrote:
> On 2022-08-18 16:43, Mark Brown wrote:
> > On Thu, Aug 18, 2022 at 02:49:20PM +0100, Marc Zyngier wrote:

> > > I don't care much about regmap as a MMIO backend, but it strikes me as
> > > odd that you end up with multiple ways of logging the same stuff (with
> > > a memcpy in the middle of it).

> > > Why can't this be done with a small amount of trace post-processing?

> > At the minute we don't put the actual data for the bulk transfers into
> > the trace so the information simply isn't there.

> But isn't that what this patch should do?

I'd imagine so based on a quick glance at the description, I've not
actually reviewed it yet, but in that case I'm not sure what your
concern is here?

> We also have recently merged the CONFIG_TRACE_MMIO_ACCESS which
> already dumps all sort of MMIO crap^Winformation.

Yes, that'd also cover it for MMIO based regmaps when enabled but
obviously other buses exist and can also be accessed via regmap.

> Surely there should be a more common approach to this.

There's an argument for tracing at each abstraction layer since they're
generally all doing *something*, people will look to the layer they're
accessing and for things like tracing register accesses with buses like
I2C and SPI regmap is adding the register semantics on top of a bus
that's just a byte stream.  Even on buses with a native concept of an
address there's stuff like paging which might be added on depending on
the device.  They should probably all follow a similar pattern but I'm
not sure we can do everything at once.

--LxcsmEkn3CkIR9C+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmL/oGIACgkQJNaLcl1U
h9DX6Qf+OoBjfgFoO3Xhy+eR2uouLwxbrGR8U/XABS5j60khFX9z7qeEFen0sTLC
0hbhuRHdXALOdsn8VW3xRINy0OEyVqngLxRGJwFBihY8tChOHkyI9F1gKc0VhjYM
B1afQt28gy//Ci4yrYFg+mqOuEZJOKiygQSHNtkRZthn5nd83Oz06Zjik0APr6n+
RPomVD9CMlaX8Naz6BeF7NHL2zrSU33sBEdMpqU2Ze4sWAP523cLkICC7sX4R0Za
Cjag/ctllqxmCVLxghbZJL+mK1YxNN0l+zkJ5OOpmhi+LZFU8OBuQrTtf0mdFe2o
vAjgi9Lq8RfTOeodMV9gB0vBiVCKdw==
=RN6r
-----END PGP SIGNATURE-----

--LxcsmEkn3CkIR9C+--
