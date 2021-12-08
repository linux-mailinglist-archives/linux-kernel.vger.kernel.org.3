Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B5446D505
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 15:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbhLHOIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 09:08:46 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57036 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbhLHOIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 09:08:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02535B820EE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 14:05:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D3CC00446;
        Wed,  8 Dec 2021 14:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638972311;
        bh=vS1icKEjwwFDMks8ZEP6VHIjK8xXwV7tmx3OxQCGPa4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dh7WNodLKyM24s9Wp1+uYZ2KSzJJiWdKVYrtanLmUsv5t74iYftQAw7bWw1LWAoqM
         KcIppoQBS6hxp5ZRgslT2XUDa6tLwcW5ONQvitQfNtXSgV7NBS9GkpD79iLRZA5OWR
         vK80u83eimkFeQZqEGYY7JXOvy6dnJU+0zcpuMZlErwmfBgzrCPjZFZABzOLAuwoTl
         cev27RMFydVyvCKmKLnQhnMINCX50WrNNS93repBbTmN0L/EEdIe6XrYPVkEeqouhD
         h/+tTMhO+9WcrrOAGggEJXxBIxfbxk/iDjygQZ/3Z9bX+F2YC9ryGL2Gntp52Jc0rt
         0VRSylJGxhwYw==
Date:   Wed, 8 Dec 2021 14:05:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Qing Wang <wangqing@vivo.com>
Cc:     Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound: fsl: add missing put_device() call in
 imx_hdmi_probe()
Message-ID: <YbC7kffqjbqoPkW5@sirena.org.uk>
References: <1638881818-3407-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rKb0zWUnE/0QDh3m"
Content-Disposition: inline
In-Reply-To: <1638881818-3407-1-git-send-email-wangqing@vivo.com>
X-Cookie: Alex Haley was adopted!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rKb0zWUnE/0QDh3m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 07, 2021 at 04:56:58AM -0800, Qing Wang wrote:
> From: Wang Qing <wangqing@vivo.com>
>=20
> of_find_device_by_node() takes a reference to the embedded struct device=
=20
> which needs to be dropped when error return.

=2E..

>  	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
>  	if (!data) {
> +		put_device(&cpu_pdev->dev);

If it's of_find_device_by_node() you need an of_node_put() since you're
dropping a reference on the OF node.

--rKb0zWUnE/0QDh3m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGwu5AACgkQJNaLcl1U
h9DDOQf+J5zK6lF7fGbSzDyocKgHfhSXm+Zi4VikzTPBrRjWBzR7I7Xb3EzyftoK
q8scd1RieKQjYG9+EwWFxAiw3o+L68/BfzK7PGEiiH6PoyGCl0woc87FdYofTIzV
bfWOkjr2i151MEEhmI7Ho00H6jrCvoAYlmyV5aZhjEkv5jLwpzkM0Otk0SIfE5Kw
pzi4d0B35D1JthsWkLp8c4R9SD1zN7G1U/RgXbBTkd3Bcj5LgFK0UpEHKt/ahqqE
mWhpqjAC9q3V0M8T4KLW1riUZ3S2UpW0KYF8y1aoFlrUN8opchz1FFR6J88ddhpi
/KdYZR2CzkcCZcFbxRILlTIJy5q6rw==
=vpxc
-----END PGP SIGNATURE-----

--rKb0zWUnE/0QDh3m--
