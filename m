Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDAA484773
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 19:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236107AbiADSHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 13:07:01 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53086 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbiADSHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 13:07:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 876936154F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 18:07:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34CDC36AED;
        Tue,  4 Jan 2022 18:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641319620;
        bh=txfvS+Gitakuv4kkZ9OkxwiKDa6QdbuL+sIHK0c2OxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TODSu9PkSjLNlNUJyBzC+8Cdt+Ux36ZiJX6gytEt0Sg56BXO3Eo1sgHAjb6ZJ53U6
         03ekSEye8DfpM2W7iS7LpZ//U+8LjI7GaY1fi09XDA+FbBnRWVEkBOPCaA+bCKqJ2B
         UcAmuTuICA5nzHRaPCUcIjm41628b+o0qXaQopyYLY9i5PO4mMSGS5/60uLRMvchqz
         6SlVOosnsr5UNzLgSvKMyCUOYZ8mbpw7fKA4uh/1AStk5NpgZK7aGSmAWu9DNWTW9i
         swxQBKY3tXMy4CqNMly8wyByj2/HWX9TQDMEJ2AGBFWaFlSxz9Ck2BETWKTUDHkDnV
         xpKmO8fLsT+MQ==
Date:   Tue, 4 Jan 2022 18:06:54 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ASoC: imx-card: Need special setting for ak4497 on
 i.MX8MQ
Message-ID: <YdSMvtXHsYWl7E0U@sirena.org.uk>
References: <1641292835-19085-1-git-send-email-shengjiu.wang@nxp.com>
 <1641292835-19085-2-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wM9Rnn4bmiJ3jtwv"
Content-Disposition: inline
In-Reply-To: <1641292835-19085-2-git-send-email-shengjiu.wang@nxp.com>
X-Cookie: The horror... the horror!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wM9Rnn4bmiJ3jtwv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 04, 2022 at 06:40:33PM +0800, Shengjiu Wang wrote:

>  			/* sai may support mclk/bclk = 1 */
> -			if (of_find_property(np, "fsl,mclk-equal-bclk", NULL))
> +			if (of_find_property(np, "fsl,mclk-equal-bclk", NULL)) {
>  				link_data->one2one_ratio = true;
> +			} else {
> +				int i;
> +
> +				/*
> +				 * i.MX8MQ don't support one2one ratio, then
> +				 * with ak4497 only 16bit case is supported.
> +				 */
> +				for (i = 0; i < ARRAY_SIZE(ak4497_fs_mul); i++) {

Shouldn't this be keyed off checking that we are actually running with
an ak4497?

--wM9Rnn4bmiJ3jtwv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHUjL0ACgkQJNaLcl1U
h9DLtQf+NYjFfOunR2kagpHatM3uw3vj6y2ywBhn8AKl0Ar0TPugAPIBV7cClQVk
1sHU5pGUol0aOrSl9c/y+uccKTxxK+dZs3jnI2RX3u8n9UdW/tsiQepu/rkVgMYy
SZdNhfcCp0VkJGYq8099YjMoo0zH4WUC5b5Ph0Jb0c80dixXJ2LCFtcKoKaxMkHZ
oYCJrpeu1LWU4b9hqgjkuRpFpU2ihQWuHQQwMIXzqk2+zdRYbyGabWRdxnyN2F+8
3LHLlPlUXGdyomQfUFWu//LqMI1Yi/xqHDeyk1Oi7WFduA4WvFuSrwtaHDqSpX9E
ds+WpmNO0leJRKzk7+c+U8iIqlXt3g==
=8shi
-----END PGP SIGNATURE-----

--wM9Rnn4bmiJ3jtwv--
