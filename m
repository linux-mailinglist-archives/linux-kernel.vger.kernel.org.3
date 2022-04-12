Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7551D4FDD86
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345374AbiDLLKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348306AbiDLLIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:08:02 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3556D85E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:00:54 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 3AF211F444E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649757653;
        bh=HPiTDVueKNU/TOwKxs3+euO8AAobj3H/uPs0cSthAG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gWrnjNV5CmSYL9CuyzCEuB/k4WFbCnzmUcRyk/XdGkft7FpRmyvca/8QN8YDTQfcE
         1jhZUCbS7NDNB5nFfgF1n485Di8PK4H4um+Wz22tHIzT2f6IJeUGuMp+hPNtLJ1pf+
         UC8pvXjOB7Z56HTPwKmNBKd8lz0LKg4JowmSu0uRNr5aS9TEjykRYZDFXwVHiMK2bt
         lT5ReXpCb6M+IleOMucxRim+l97xvdAWuCMqfW/HqoRsX1R1MkHpdVeSEDhq3TX3ky
         8Ni4fErgRpH1zXsRYEmq9SnNNTabXL3WAnJVJMQLJMPn5VS3qrX7Q9ur8P/r83CJFG
         asEHtRq40j9YQ==
Received: by mercury (Postfix, from userid 1000)
        id 22FA11060340; Tue, 12 Apr 2022 12:00:51 +0200 (CEST)
Date:   Tue, 12 Apr 2022 12:00:51 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HSI: omap_ssi: Fix refcount leak in ssi_probe
Message-ID: <20220412100051.g2mx734l3ogz4tcw@mercury.elektranox.org>
References: <20220404085234.11435-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ixa6kldo263d7ftb"
Content-Disposition: inline
In-Reply-To: <20220404085234.11435-1-linmq006@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ixa6kldo263d7ftb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 04, 2022 at 08:52:32AM +0000, Miaoqian Lin wrote:
> When returning or breaking early from a
> for_each_available_child_of_node() loop, we need to explicitly call
> of_node_put() on the child node to possibly release the node.
>=20
> Fixes: b209e047bc74 ("HSI: Introduce OMAP SSI driver")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/hsi/controllers/omap_ssi_core.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/hsi/controllers/omap_ssi_core.c b/drivers/hsi/contro=
llers/omap_ssi_core.c
> index 44a3f5660c10..eb9820158318 100644
> --- a/drivers/hsi/controllers/omap_ssi_core.c
> +++ b/drivers/hsi/controllers/omap_ssi_core.c
> @@ -524,6 +524,7 @@ static int ssi_probe(struct platform_device *pd)
>  		if (!childpdev) {
>  			err =3D -ENODEV;
>  			dev_err(&pd->dev, "failed to create ssi controller port\n");
> +			of_node_put(child);
>  			goto out3;
>  		}
>  	}
> --=20
> 2.17.1
>=20

--ixa6kldo263d7ftb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmJVTdIACgkQ2O7X88g7
+ppUIQ//T7c/a0qTM32ohIR1Ub6EjXz7gD34N39VYe8WSU66275ZD25TQ/fPQSqO
zSQ+ih1eV2oCHsr33EUqS5SkIsAYrG6J0IXM/Qg8u9yW6MzOenwVQAbsMIIsf9l2
ezMDYmJNJASyZHcOMsBp0YYfNmcUVlTFSAcZzsUE0ti4rfVr4vYI+Qg+y0Fj6bDd
Zt43pTPeIe29KLHDxmIcvgmxh3w4YOlQ1NcJkbw3KdK7ATZdlXS9fHCwA+e/s5XN
vIj5HezNbtDihY6AOhiFmeSd4KB1dD6IvMzGDDSoGyNDKeWK2H5noXD6A74m4ahg
3nu+VZ9YLJ+YL8vSijvdO+TNZf1nDfRWHWM3PVdpxrJpgNmIIt7Z4T5zUHW4vjGa
iUIpeOY6nQaX3rgdm5/Ghe1NVE0Mxg7OakAQKt+EPmBKb8VaIG4H1FmGtlHAiJng
jfRaF5wbtKqpCr53n/bakV2Jb8A8qXxnQHUG55al+oQQgXCx282551mHTbxVTPeA
CU5yajV9nEx/6WMPfHExwWR57XOv73RbnC0xzs4Tur/DweApHlH0rqi0iEmDfLgx
6lmnX3qXXuvgyt0/WlipDScetMIGrdeST/X5z5rk29Br/3jXyUVZ2ed7JmzMDuNM
f5ZqVk42EqzAEotHVEjfujgrtJarZ5I4Vb60F5WVfHh5JkUft3E=
=jxKn
-----END PGP SIGNATURE-----

--ixa6kldo263d7ftb--
