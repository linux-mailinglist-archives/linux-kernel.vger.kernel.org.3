Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97AC257858D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbiGROfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbiGROfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:35:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B72A101DA
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:35:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4184B81624
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 14:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57FA4C341CA;
        Mon, 18 Jul 2022 14:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658154921;
        bh=/EskvqncNfuAlLHtEQSMFsRi3mTIEdrZ+Id+muUNZhg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qRsmvWnhdUNqnTtXbX0z81G4NiR2SiczBVyOs4xO64HN37dMh1IhWzD4G/2DXSzOO
         x+aGWLLQfXE7sSokrksfOKJCmI1ZrsqHl8HS+zsGjZba7Mr+r5p7794ESZV4kJnAdL
         uRELAreXDIdTKbyCS+UThL0rTh3uk+DbuZUXP2boH+lm2ZNbh2RrZQORBcerGACV8k
         hColTf074kEWtSaaGFNQ7l4WeEaHYR5pD73+IYU5H6cNWZ9mhdyf//8kz4sandvbyj
         n8mvGyX4M7rK1YKqRx+BmrHalz/A6LjRifKu02HsyHIlpgoUOQpChVQJCpEi1A7f85
         nl1kyilu/z1bQ==
Date:   Mon, 18 Jul 2022 15:35:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        wtli@nuvoton.com, steve@sk2.org, Vijendar.Mukunda@amd.com,
        alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] ASoC: nau8821: Found a bug when removing the module
Message-ID: <YtVvpKe9SX7OAPUF@sirena.org.uk>
References: <CAMhUBjm2KOZZj=M3=yLvLm4QcNYpOTa+2_dPcHr7nHm4GE73DA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FvMj+3yP1v5LZGNx"
Content-Disposition: inline
In-Reply-To: <CAMhUBjm2KOZZj=M3=yLvLm4QcNYpOTa+2_dPcHr7nHm4GE73DA@mail.gmail.com>
X-Cookie: The greatest remedy for anger is delay.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FvMj+3yP1v5LZGNx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 16, 2022 at 05:12:38PM +0800, Zheyu Ma wrote:
> Hello,
>=20
> I found a bug in the driver nau8821.
>=20
> When removing the module, I got a warning:
>=20
> [   64.226442] nau8821 0-0010: remove
> [   64.227621] ------------[ cut here ]------------
> [   64.227918] WARNING: CPU: 5 PID: 243 at kernel/irq/devres.c:144
> devm_free_irq+0x80/0x8c
> [   64.235307] Call trace:
> [   64.235501]  devm_free_irq+0x80/0x8c
> [   64.235746]  nau8821_i2c_remove+0x28/0x3c [snd_soc_nau8821]
> [   64.236982]  i2c_device_remove+0xcc/0xf8

I'm guessing you have no interrupt on this platform, or that jack detect
isn't used since the driver currently only requests the interrupt when
that's enabled (which is a bit dodgy but not the immediate issue).  I've
sent a patch

	https://lore.kernel.org/r/20220718140405.57233-1-broonie@kernel.org

--FvMj+3yP1v5LZGNx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLVb6MACgkQJNaLcl1U
h9CG+gf/XKoOdFy8AVhZ0NTrBOtMJo96SDkS8JOiKEiT5sh4gXMXC1UkXde32QcZ
gRuPtxSDku10rL7qtMY2mTnZVKEAzmbb4L8lVSFi4FFgs3f/Yag/9ZgSuW3yOmoW
FWtJ4wQCTx+9nJucks0c8kMCj476Bg1CKLjRcxf/vvmW4RNhtVdPhSw8hmb1kwNd
qxzwcI2oDNC4xa4ijGipIWJ9BLqzz/bGrGIp+xqt9oTqH6bilZvUcIRXfkJrzgwu
aj1JiX4R9O7D6hQqAuSVGioLLjvUy9pSZr0QHB5qSepqb+WUapITYh9+YHlkGuAW
zVthcPrcLBT3rEITmqprJCUUsKoCfg==
=VvsL
-----END PGP SIGNATURE-----

--FvMj+3yP1v5LZGNx--
