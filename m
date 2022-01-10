Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F04C489BDF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbiAJPK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235938AbiAJPKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:10:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB25C061748;
        Mon, 10 Jan 2022 07:10:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DAC88B8165F;
        Mon, 10 Jan 2022 15:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44546C36AE5;
        Mon, 10 Jan 2022 15:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641827413;
        bh=MGzC556nKR0dVQ6gSVYjbaWQh+60dstnaOHoo1NOZjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ARKO1tgoRALqL8E1t3ipqW7VNh5E4qbeBt2kv5w7xgrpce0bq5ZC81GitpTuxN8f0
         qPKW03UQ6pRzvOiZ63FTqjtIaw8r3IVqBz+xS0HRxysB8iogY6mMIvN0W7AC6z7PtD
         thQbcgtHf8ypL+N9nHHfo9RyHtH9onnw+c+xDlP+N0dxRA8YS3w2zt2ZIL5wNytCyo
         gzLOkgPu1BGzQmgEm1ReBS+20es/e2Pi9a7aeI6Q9iRdsbgSfdB0MJ3smmvZroKtLX
         yETANUY+ZcXNM8s6owxAxe5W4vw2lXQuzCp1SJVU2Izrd78FjxekwvMC54FJRZM11U
         mWZa5SeMFhcpQ==
Date:   Mon, 10 Jan 2022 15:10:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Pavel Machek <pavel@denx.de>,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] ASoC: sh: rz-ssi: Add functions to get/set substream
 pointer
Message-ID: <YdxMT02wvvWw85Bn@sirena.org.uk>
References: <20220110094711.8574-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220110094711.8574-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y4b7ElNLAh3ZTjz4"
Content-Disposition: inline
In-Reply-To: <20220110094711.8574-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Cookie: Do you have lysdexia?
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y4b7ElNLAh3ZTjz4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 10, 2022 at 09:47:11AM +0000, Lad Prabhakar wrote:

> +static struct snd_pcm_substream *rz_ssi_get_substream(struct rz_ssi_stream *strm)
> +{
> +	struct rz_ssi_priv *ssi = strm->priv;
> +	struct snd_pcm_substream *substream;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ssi->lock, flags);
> +	substream = strm->substream;
> +	spin_unlock_irqrestore(&ssi->lock, flags);

This locking doesn't seem useful, we just take a copy of the lock and
then immediately return so the lock isn't protecting anything in
particular - the caller can happily continue using the substream after
the variable has been updated.

--Y4b7ElNLAh3ZTjz4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHcTE4ACgkQJNaLcl1U
h9DPAAf+IAkg3KteUe/ieJ1Mvb5V/kn7FqPeS1zDEmVPRr1WAZks5Nw5wudB7zLY
3uXD6RwCJxdiQghBfPTxt8bRSFY2NYKa75uNjnSda+npj7R2lxFiztz9lnVuAV/+
qFbrDSNncJViJiW4eKECDiqauxti2L4uh7BRpJQvoFqj3HZI7e8aBXlrq5NE7FWj
dLCfj0j1LewVsyssuYTaUhon9Z6brx1ruUF1Ywm+WpAW452UO9YWEzmzew1x6CBF
DTMjtJxRB+gL5NWTZwEUDL1j+g+IVdY8qF3u4NpMIhxAXru5QGqn8Rz0KnbmWv+x
a/sWc17NS+a12yyyoTpR47X7pUPmPA==
=HvrJ
-----END PGP SIGNATURE-----

--Y4b7ElNLAh3ZTjz4--
