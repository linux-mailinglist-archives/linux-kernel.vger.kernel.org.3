Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485BB583F37
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238107AbiG1Mtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236073AbiG1Mtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:49:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E76B2D1FE
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:49:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9C4261CD7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 12:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A971C433C1;
        Thu, 28 Jul 2022 12:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659012585;
        bh=RJfAOfmvK/rilfnXANYko3DXP68QgByaIWuAhbZ0yCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wx6F4/RMbXOnmZID/zC6bsRe1t383AkdW+uRAW7m80H1h5d0ymb4emDU2qOF12crB
         OU9XxtVZ1g0ZrplTT/FP81PykTaLHx6MZBNC0cvbG6yfvWsuisu3h6OwnPmXqleqR1
         djs4cUJjDXn5zYsLLe5I0gX8NlNr3bcgBlPopXTp3+GJTyUojrrUiDY91niXyXSSZP
         3svhvyD7XS5uCZLd07fP+wCrnOm4IJ4QEFAZ8pXdv/GIOSEwUvgWPllEa597pKfE1d
         VZn8QXIux6hPfmCqK6alq398q03hmTMeX+GPg+PhQBgAGWOyfnTHwJRJFYhr3hs4H9
         fhTdg+OFA2L7Q==
Date:   Thu, 28 Jul 2022 13:49:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc:     alsa-devel@alsa-project.org, vsujithkumar.reddy@amd.com,
        Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, ssabakar@amd.com,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] ASoC: amd: acp: Initialize list to store acp_stream
 during pcm_open
Message-ID: <YuKF4l68sLKkjcmQ@sirena.org.uk>
References: <20220728124057.54259-1-venkataprasad.potturu@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NWn5k3WLWCxoBmQv"
Content-Disposition: inline
In-Reply-To: <20220728124057.54259-1-venkataprasad.potturu@amd.com>
X-Cookie: People respond to people who respond.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NWn5k3WLWCxoBmQv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 28, 2022 at 06:10:50PM +0530, Venkata Prasad Potturu wrote:

> @@ -104,14 +105,13 @@ static irqreturn_t i2s_irq_handler(int irq, void *d=
ata)
> =20
>  	ext_intr_stat =3D readl(ACP_EXTERNAL_INTR_STAT(adata, rsrc->irqp_used));
> =20
> -	for (i =3D 0; i < ACP_MAX_STREAM; i++) {
> -		stream =3D adata->stream[i];
> +	spin_lock_irqsave(&adata->acp_lock, flags);
> +	list_for_each_entry(stream, &adata->stream_list, list) {

If we're already in an interrupt handler here (presumably not a threaded
one) why are we using irqsave?

--NWn5k3WLWCxoBmQv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLiheIACgkQJNaLcl1U
h9BYKgf9HZUjAFMC+N+Sj6rLDvzwJdpVJEJLijic78G7hVRhGmMh16NQ5gAkJ5FJ
eC9ZzLSjESMqTM5dNSlQ+Su0xhI2kyhZHYXRqp0zlSULQoyipO+APdRI38/J6V5x
pOaRbLaLpsPViMo42CFbPYznDXszd9+VdALzaxlnYykfQktYeWSHGu9vHxLo57Gw
OsPsPLgpMcqfAohkzvb1Blj0Wpmj2RuxK1pQdDTOoQiMESp/Zal5yh4mtNMWKCiO
zJxKgZeuRDmXmbXhKCwyLZUV/Z/IObkQ+aIOV0qLTp1G5Z/9BQXYvGqZr/IHkw/o
QgCLUAX7K3HiK+pr+GB8xH6iUDusTg==
=zBfv
-----END PGP SIGNATURE-----

--NWn5k3WLWCxoBmQv--
