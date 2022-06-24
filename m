Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07C1559C7F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 16:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbiFXOhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 10:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbiFXOhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:37:02 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF24A563AC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 07:36:53 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 058F86000F;
        Fri, 24 Jun 2022 14:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656081411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xDw6yLjQXYdImD1b38J6a4KT0sSwWeEKKVw++nHyiiw=;
        b=GBxJLAsyGFOR7YXJ3b4olBaDJSFns7lV4HmQmwrj3DjgMCKbU2icOOKzmjc+EMul1fe9jA
        +0If9CrUQeij0YepDQtCI7n4sW9FwarvheMa8DB0lTTyyGVTGNSFEdBkPp+5tTgidpI4Eh
        tzQm5LqkArdPvo+055PB17JYqLEOWfE27u2f/Ljv1i5t1Xy9hgwVuv9bRrFDj5Gsy+C2jT
        u1BHUrNEb+oI9BPrxMiuNUF+2Dt2kXh4O2IRZLT2c4/kIdckKcENhLcmNlVwERawDZLi7B
        XGz96yohFeR1z9dg6h29VIotoeGdSJFbt5jj5KESfvkxHuGXtmDtiHpPKbHz9w==
Date:   Fri, 24 Jun 2022 16:36:50 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        airlied@linux.ie, daniel@ffwll.ch, mripard@kernel.org
Subject: Re: [PATCH -next] drm/logicvc: add missing of_node_put() in
 logicvc_layers_init()
Message-ID: <YrXMAvuHJgls+wNM@aptenodytes>
References: <20220614112112.1537319-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xxTdvUN19r+Gzqln"
Content-Disposition: inline
In-Reply-To: <20220614112112.1537319-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xxTdvUN19r+Gzqln
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On Tue 14 Jun 22, 19:21, Yang Yingliang wrote:
> The of_node_put() need be called in error path in logicvc_layers_init().
>=20
> Fixes: efeeaefe9be5 ("drm: Add support for the LogiCVC display controller=
")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Thanks for the fix!

Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul

> ---
>  drivers/gpu/drm/logicvc/logicvc_layer.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/logicvc/logicvc_layer.c b/drivers/gpu/drm/lo=
gicvc/logicvc_layer.c
> index bae1c7f99569..00a37563a6dc 100644
> --- a/drivers/gpu/drm/logicvc/logicvc_layer.c
> +++ b/drivers/gpu/drm/logicvc/logicvc_layer.c
> @@ -610,8 +610,11 @@ int logicvc_layers_init(struct logicvc_drm *logicvc)
>  		}
> =20
>  		ret =3D logicvc_layer_init(logicvc, layer_node, index);
> -		if (ret)
> +		if (ret) {
> +			of_node_put(layer_node);
> +			of_node_put(layers_node);
>  			goto error;
> +		}
> =20
>  		of_node_put(layer_node);
>  	}
> --=20
> 2.25.1
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--xxTdvUN19r+Gzqln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmK1zAIACgkQ3cLmz3+f
v9FN7Qf+LIL1J4SHKzIrLJHuIEUfhHXkXKC8tqdNPVLJP7DFRbJyiHzqRLF0KzDd
7/X2s5prFv14Fd0/uSUB2IVz1hIdwR1cSJ5BqXC2qAuFvNqO00OGho6uOqDCUYKn
Zos0vutZM/2ha2cV3JunHcooZk1Quw+qrUw6Al8aFFg088CZsVngKj3hI80QkID4
RPGJcQ25iRBQdSI7jxtyqHV47xJ3ZnQ+kTDkrkvJ/AbCs5sxPZMgyVfM+fRPuAOD
F8kV0Vt7MzRp4sunrtsoDuwnsr0Il+odbx9W9z6M/VMYuV2ZIUSGOglY74JLR0aV
3ZzGDtLtSrjL0DAMu4qT5fONgxuRTA==
=7SJk
-----END PGP SIGNATURE-----

--xxTdvUN19r+Gzqln--
