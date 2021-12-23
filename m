Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C0647E79D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 19:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349830AbhLWS1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 13:27:04 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52860 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349767AbhLWS1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 13:27:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EFDB61F41
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 18:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673BDC36AE5;
        Thu, 23 Dec 2021 18:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640284021;
        bh=4U8UtwVy0KszuMa67n1hL7aI5XZh6iDm1CqeBYOSGDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MCyLkLPZupeIqlIzPLu8CFnZ+okNCpZea/S7RsWdAb/6lC1ohbhVoaPzCy9xgRnOb
         1N/yZGlSFEHdb2mvgGP9E2iKTm8Zaf+ZgwTm+FhjybeLoKStaLOYe+K7e8hYzesYPV
         aZoG1CbP59GpsSL+K5SZtpYTAaOePATQyAbXQZuJKnCqV/LM/V7IbeDERfCet4E5b5
         k8Xd276foRyBp/vjq2ZGHwA9hiByMtLnkQzMreRf3gPUc3NJ03xMttEeOSQsSojYLU
         Vi1j61JokYUPtQ7Xmvr4WREO/21kPvbXmfDDdjzSABP3mzX0XmwOh6vp9GktK908xM
         6crW5tp4dxOwQ==
Date:   Thu, 23 Dec 2021 18:26:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, vkoul@kernel.org,
        vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH 7/7] soundwire: intel: remove PDM support
Message-ID: <YcS/cPb0UXsc9SWm@sirena.org.uk>
References: <20211213054634.30088-1-yung-chuan.liao@linux.intel.com>
 <20211213054634.30088-8-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oH+CFB7uVqhnu6IS"
Content-Disposition: inline
In-Reply-To: <20211213054634.30088-8-yung-chuan.liao@linux.intel.com>
X-Cookie: A modem is a baudy house.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oH+CFB7uVqhnu6IS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 13, 2021 at 01:46:34PM +0800, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>=20
> While the hardware supports PDM streams, this capability has never
> been tested or enabled on any product, so this is dead-code. Let's
> remove all this.

This doesn't build with current code, I'm guessing due to a Soundwire
dependency I don't have:

/mnt/kernel/drivers/soundwire/intel.c:1142:3: error: 'const struct snd_soc_=
dai_ops' has no member named 'set_sdw_stream'; did you mean 'set_stream'?
 1142 |  .set_sdw_stream =3D intel_pdm_set_sdw_stream,
      |   ^~~~~~~~~~~~~~
      |   set_stream
/mnt/kernel/drivers/soundwire/intel.c:1142:20: error: initialization of 'in=
t (*)(struct snd_pcm_substream *, struct snd_pcm_hw_params *, struct snd_so=
c_dai *)' from incompatible pointer type 'int (*)(struct snd_soc_dai *, voi=
d *, int)' [-Werror=3Dincompatible-pointer-types]
 1142 |  .set_sdw_stream =3D intel_pdm_set_sdw_stream,
      |                    ^~~~~~~~~~~~~~~~~~~~~~~~
/mnt/kernel/drivers/soundwire/intel.c:1142:20: note: (near initialization f=
or 'intel_pdm_dai_ops.hw_params')
/mnt/kernel/drivers/soundwire/intel.c:1143:3: error: 'const struct snd_soc_=
dai_ops' has no member named 'get_sdw_stream'; did you mean 'get_stream'?
 1143 |  .get_sdw_stream =3D intel_get_sdw_stream,
      |   ^~~~~~~~~~~~~~
      |   get_stream
/mnt/kernel/drivers/soundwire/intel.c:1143:20: error: initialization of 'in=
t (*)(struct snd_pcm_substream *, struct snd_soc_dai *)' from incompatible =
pointer type 'void * (*)(struct snd_soc_dai *, int)' [-Werror=3Dincompatibl=
e-pointer-types]
 1143 |  .get_sdw_stream =3D intel_get_sdw_stream,
      |                    ^~~~~~~~~~~~~~~~~~~~
/mnt/kernel/drivers/soundwire/intel.c:1143:20: note: (near initialization f=
or 'intel_pdm_dai_ops.hw_free')
cc1: all warnings being treated as errors
make[3]: *** [/mnt/kernel/scripts/Makefile.build:287: drivers/soundwire/int=
el.o] Error 1
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [/mnt/kernel/scripts/Makefile.build:549: drivers/soundwire] Er=
ror 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/mnt/kernel/Makefile:1846: drivers] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:219: __sub-make] Error 2

--oH+CFB7uVqhnu6IS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHEv28ACgkQJNaLcl1U
h9COhQf/XJITxI7uwmAdAs5euRIHx45jbk3mP4sDaiWxN/zxKpNsUhk9g1K/aBuo
Vcdo0H4FKTG5R/PvxRC14VTcDd3NexCOqmUgDxsR6WP0DLNqYPSYO+2RcHqWv/zb
MMpn3TIgNO4nGEmIrLaygph/u4t814+TUlCD8wjnXdkJgzXwwXk2EcrHfibCOetX
9WWWRB59W5ULjHVveRjxdYzRakTpLNAmthvU0R7OdfLcXW/u8v9rHmN4TAhXvx9w
wK7gabo+1fU16VIiNUSVLcwhVRbcyijIPPU6n0T7oiGbgQgVi0a/ihCUa+MHAYn5
4MZMyaEPEwOOaHmnZuS43gmkq7y8eQ==
=abL6
-----END PGP SIGNATURE-----

--oH+CFB7uVqhnu6IS--
