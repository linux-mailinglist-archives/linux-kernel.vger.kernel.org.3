Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5493B4B5099
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353517AbiBNMuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:50:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353486AbiBNMuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:50:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637034B85C;
        Mon, 14 Feb 2022 04:50:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4A1161468;
        Mon, 14 Feb 2022 12:50:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67EFC340E9;
        Mon, 14 Feb 2022 12:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644843003;
        bh=dCZAZFFTFztaUC3w9E7PynQEzmnHStV4WtGOFsBCoMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NxuzBnXVhRj04xQho/0LIHIQWG+EkuGcsPcdH80rm/QChJgLscBCwiEIrFWu1I9Ig
         UgkI+xyU50G6u5+t+lNJSNW/HEtSdBRL0oOzFH83eXtZQbIQ92FiYwkLov3vpZGIln
         NU8XzL8C6+/lhtAy4CvvbKb/v1blCUd1Vzi66K2EETkJn51JpahjmH3s+YByDuW9ja
         Wv8BQ8RFp0aQs9sfW9RMtGqDJgjgwf0WTeSYGUA0j9DIxcQME/GuHEWBH8qrFL0uHQ
         KFdJUAeG/I0dONMbAe6iDvOZwc7uzp5t6mTegnEiF+qjW7LkoDWHkGsp+1lwNnBHsy
         UrI0lE4UaIkAA==
Date:   Mon, 14 Feb 2022 12:49:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jon Lin <jon.lin@rock-chips.com>
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] spi: rockchip: Preset cs-high and clk polarity in
 setup progress
Message-ID: <YgpP9j80OuhkCN8p@sirena.org.uk>
References: <20220211034344.4130-1-jon.lin@rock-chips.com>
 <20220211034344.4130-2-jon.lin@rock-chips.com>
 <YgZHalrdhhilxROt@sirena.org.uk>
 <4222ce7d-a1e3-1728-fec2-976946b06ba9@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WgfHOPUjhPwyc1Eh"
Content-Disposition: inline
In-Reply-To: <4222ce7d-a1e3-1728-fec2-976946b06ba9@rock-chips.com>
X-Cookie: Am I in GRADUATE SCHOOL yet?
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WgfHOPUjhPwyc1Eh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 14, 2022 at 04:40:19PM +0800, Jon Lin wrote:
> =E5=9C=A8 2022/2/11 19:24, Mark Brown =E5=86=99=E9=81=93:

> > > +   cr0 |=3D ((spi->mode & 0x3) << CR0_SCPH_OFFSET);
> > > +   if (spi->mode & SPI_CS_HIGH)
> > > +           cr0 |=3D BIT(spi->chip_select) << CR0_SOI_OFFSET;

> > What ensures that this read/modify/write doesn't race with a transfer
> > running on another client device in the case where the controller has
> > more than one device connected?  Similarly with the mode, though it's
> > not great to have devices with different modes connected to a single
> > controller.

> I have no idea how to deal with the conflict configuration between
> different cs, and also I find nothing strategy in others spi drivers.
> As we all know, some configurations should be consistent for different
> CS devices, such as SPI_CPOL, so I suggest the framework to make
> corresponding early warning prompts.

As covered in the documentation setup() for one device may run while
another is active, therefore if multiple devices are configured in the
same register you should use a lock to ensure there can't be multiple
writes.  Note that the above appears to not just be setting the mode but
also the chip select so if you've got two SPI_CS_HIGH devices then
they'll both be going in and separately setting cr0.

--WgfHOPUjhPwyc1Eh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIKT/YACgkQJNaLcl1U
h9AZKAf/VpLE2vWn6R3N7yXYDuY8eeyBOVUEXfG484ts/lnv56h0WYC6lFZRT6Ge
4yg6uV+fWsAsC+jbNXgNg5+AOpVwuN/fDkAN/5E3bVOAVTnTaWDvT0A7U1YvsP+u
IGrkUB3RTshl8j/w7V2v7axa+tWkEH8s6lkz1T+UhgqQFPeFtQfuHY6kRbuFYAGW
IOs1d3Au4t0jQmhhT3dT9Q/2Cm0lM7nOCNxqh/JbkPD/G6Va1NKYh2dLSUgR2pZe
tkD6K1gmx05dWC+olXHVLYu8ZHuqjJysmrrwpQM7pprHZAShZ8+MYW8UGnYPJ+Bx
6k2s6LozuXeMH+w3ygNO8f4axFUKVQ==
=xViN
-----END PGP SIGNATURE-----

--WgfHOPUjhPwyc1Eh--
