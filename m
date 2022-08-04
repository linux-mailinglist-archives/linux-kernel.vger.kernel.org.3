Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AFB589E01
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 16:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240116AbiHDO7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 10:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240108AbiHDO7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 10:59:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0333C8FA
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 07:59:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BA0CB8253E
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 14:59:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3F7C433C1;
        Thu,  4 Aug 2022 14:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659625172;
        bh=MG/OLbjvUhmhCpOzmNodao8upPyMUSDGDlCf4g1Eh8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c0CgKr7ehUtGuS3wp8y8m8OtWbhfEOxk49tcM/MH4FlGcXmpiu6UyWwDl9JQLoS8U
         HNGhEvCTp4Ux90AuEx9zSWQLTkXTo5P1EZL9RJEUbFELp6pjuIqPjvieYGGJ3EMXi8
         jGO+iVCvN14kxXkFuuorjPcXDUUzlo0LHgWvcybGLswb4Ie/FstY+nsdybl8IxPPpz
         tkxl53aibDN5URDHncyDCfT3sVlxslwrQXBOZx99tGeH5lY7fu4KFi7ts5522MIV7X
         htz2sr7xYv82aOqR8tmW7XQDtQC4EdRb/h1Q6XqW8RcSo8PlevvXVrTQZ9j59UJ+Mk
         vE5znSwjnW5mw==
Date:   Thu, 4 Aug 2022 15:59:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "chunxu.li" <chunxu.li@mediatek.com>
Cc:     pierre-louis.bossart@linux.intel.com,
        peter.ujfalusi@linux.intel.com, lgirdwood@gmail.com,
        angelogioacchino.delregno@collabora.com, daniel.baluta@nxp.com,
        matthias.bgg@gmail.com, yc.hung@mediatek.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, sound-open-firmware@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        project_global_chrome_upstream_group@mediatek.com
Subject: Re: [PATCH 1/2] ASoC: SOF: Introduce optional callback
 of_machine_select
Message-ID: <YuvezrxOnAJTLKt9@sirena.org.uk>
References: <20220804091359.31449-1-chunxu.li@mediatek.com>
 <20220804091359.31449-2-chunxu.li@mediatek.com>
 <YuvG4drwG/rYoozp@sirena.org.uk>
 <644d24503899e6ed8b6a7321979e11e46577a610.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h0hDaRGCHYmaxJ2S"
Content-Disposition: inline
In-Reply-To: <644d24503899e6ed8b6a7321979e11e46577a610.camel@mediatek.com>
X-Cookie: Did I say 2?  I lied.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h0hDaRGCHYmaxJ2S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 04, 2022 at 10:36:07PM +0800, chunxu.li wrote:

> Thanks for you advice, I'll remove the callback function, and directly
> call sof_of_machine_select() in sof_machine_check() as following.
>=20
> int sof_machine_check(struct snd_sof_dev *sdev)
> {
> 	}
>=20
> =09
> +	of_mach =3D sof_of_machine_select(sdev);
> +	if (of_mach) {
> +		sof_pdata->of_machine =3D of_mach;
> +		return 0;
> +	}

Looks good.

--h0hDaRGCHYmaxJ2S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLr3s0ACgkQJNaLcl1U
h9CNtgf/XRsA3q6DYLqEaEXV4tXIlM8fA/R/M0YDmHq6Ue+jq26vdS+Af5jl77wB
FIpNpuihB4hPSw02XTLtF7vyGr2FovaTLOCQcYI1YFv/HdKvw2e/F7CGKbopburY
DaP2S1j4l5n/cEGFht//jtFMR1wlmgLPcjcSCx62mZpAqvUulCjnjL5EMhyygC2W
n+80WJg3AH1EzsDtYEsvjs7xI7zswHcamarrPa3Wgl/FIiAS99nk1PH17AKIlncB
Gl/wOsK9p5nDKqiKGrLmVuC80G6DOC2NcvMmu+zgElXU6SmUsytHQQWuWxfJ9jpr
PQ16skJvJ9CihoHwi7dYaA8P6h3J5Q==
=uDFa
-----END PGP SIGNATURE-----

--h0hDaRGCHYmaxJ2S--
