Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98674C00E5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbiBVSF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbiBVSF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:05:27 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196C217288D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:05:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 82B83CE1801
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 18:05:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08619C340E8;
        Tue, 22 Feb 2022 18:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645553098;
        bh=4rGunFeowv1Q7DwwOPcd8Fc+MZiAHpzWeM0Krnzv4VM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HM7ygPwgt7MgTBoq2EwQ9W8wWn2YcRDZepg0PMGUEB5XnA/zV2IhUp8hVtJxxL1u2
         o648rmQHhU/CZX2bNh1McSd7PgMs6cjeJoeBIQY8xPn3fWyOnnFZ3ZKiBzM9JMRmFi
         7eR6mFk5zWq6luOdz58sjZNZ3PlVCIu3XY8/ZXMBdn1FLE3ABYXi45ZgDI5xpTkW/k
         4RACbVXMF6OpDgQRlMEEJ83ZiKpOtQGnOFRek8geYZutCY/ii88o6xzUNWaxbT7KMI
         fxSEpzZTDIKMN3qpWcK3bX8jlwUdmoSNdsIRMK57ddxoThA7Ul1zf3MFaVrPvxPRvG
         sclUXAwb9/W6A==
Date:   Tue, 22 Feb 2022 18:04:53 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com
Subject: Re: [PATCH 10/16] ASoC: codecs: rx-macro: fix tlv min max range
Message-ID: <YhUlxX461J9bskg3@sirena.org.uk>
References: <20220222115933.9114-1-srinivas.kandagatla@linaro.org>
 <20220222115933.9114-11-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4fuKPQSv5bl+QP9H"
Content-Disposition: inline
In-Reply-To: <20220222115933.9114-11-srinivas.kandagatla@linaro.org>
X-Cookie: I smell a wumpus.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4fuKPQSv5bl+QP9H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 22, 2022 at 11:59:27AM +0000, Srinivas Kandagatla wrote:
> on Qualcomm codecs gain tlv control specifies min max range as both
> negative to positive numbers like
>=20
> SOC_SINGLE_S8_TLV("... Volume", ..,  -84, 40, gain)
>=20
> However with recent boundary checks added in commit 817f7c9335ec0
> ("ASoC: ops: Reject out of bounds values in snd_soc_put_volsw())
> setting a value above 40 gain will fail.
>=20
> So fix this min max range correctly to
> SOC_SINGLE_S8_TLV("... Volume", ..,  0, 124, gain)
> so that users can now set gain correctly

Are you sure this isn't a bug in the core?  -84..40 should be a valid
range for a signed control.  See Marek's fix in 9bdd10d57a ("ASoC: ops:
Shift tested values in snd_soc_put_volsw() by +min") though that only
kicks in for systems with a platform_max.  I can't immediately spot any
other issues for S8 but I could be missing something.

--4fuKPQSv5bl+QP9H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIVJcUACgkQJNaLcl1U
h9DDlQf/f2Ci6r9z/pr5qr0/dF0MmFwhyBNnZ33/mSONg5YGjV+uQQnjoVsAfTPT
30EXf2rI5VaRs6J2SrQIExE/fUhMJLkydyG4loHwr212AM4preDD9P00c0Mn8UkX
q/eVLRLvFDLg08uBD2+xz0EzaqgF9bPcJ0Cxir+UWJG87Ai6W4k+5xy6TG5K5C5S
QVuQZXuh2OKMRnlH+naPv6jjYhlHSRfIX3PwPdDvUluH/4fxJDhmZch71ogzkHsc
sVxjDB2Rt73k/YT+74BzMLzn/cWVNYN18ZbQud2Q+WedRzbnH/uEoSsJWUX4bGbU
tmv3Xzsr4xHQd9jeJcpZs5BCD13Qlg==
=y7ad
-----END PGP SIGNATURE-----

--4fuKPQSv5bl+QP9H--
