Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA05E4C638A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 08:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbiB1HFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 02:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbiB1HFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 02:05:01 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D003459A49;
        Sun, 27 Feb 2022 23:04:21 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K6WZr03jbz4xcd;
        Mon, 28 Feb 2022 18:04:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646031860;
        bh=aASHzSowQHuyexsfskNosRGiKowYjOmTJ/cbgGN/tvo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QNCv4PEEhlecVBuE0afhxl/lzPzGXf7gLhm9EoSMZ/92WQMCqmi9Vs09o5hLl+9/L
         KTWUJpimLIfOm33EdFREY9JhohB8suxVn+ZPlvMLezZ2CYxwEV3UY0ylYoq9nlwzl+
         +2Ydlv+qHIR2xCrrSwRMaUnnshthAJG0doKzSBHkUMWdambk/+tpyCe/vl0ZnlI23Q
         bF5DAYyjJwkkbxotAKUa1VUyLfLYOt7w3Q82xYUVq+O5GAMebFewsrqvHZVI9HQsaM
         x69OeUbk5BiDFmLsk9QhJPhTA1v0aLVp4Tfm88THVhB8i2SCp3/dmKP9WjpFfkO4N3
         ZSKPKRAr5OSrg==
Date:   Mon, 28 Feb 2022 18:04:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marc Zyngier <maz@kernel.org>
Cc:     broonie@kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the pinctrl tree with the irqchip
 tree
Message-ID: <20220228180419.3e0a9f91@canb.auug.org.au>
In-Reply-To: <20220221223216.3616980-1-broonie@kernel.org>
References: <20220221223216.3616980-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aYFkvPjWaW0IiZ95fR8py1X";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aYFkvPjWaW0IiZ95fR8py1X
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 21 Feb 2022 22:32:16 +0000 broonie@kernel.org wrote:
>
> Today's linux-next merge of the pinctrl tree got a conflict in:
>=20
>   drivers/pinctrl/pinctrl-starfive.c
>=20
> between commit:
>=20
>   0d872ed9e2148 ("pinctrl: starfive: Move PM device over to irq domain")
>=20
> from the irqchip tree and commit:
>=20
>   64fd52a4d3ce6 ("pinctrl: starfive: Use a static name for the GPIO irq_c=
hip")
>=20
> from the pinctrl tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> diff --cc drivers/pinctrl/pinctrl-starfive.c
> index 5be9866c2b3c0,0e4ff4c709f87..0000000000000
> --- a/drivers/pinctrl/pinctrl-starfive.c
> +++ b/drivers/pinctrl/pinctrl-starfive.c
> @@@ -1307,8 -1308,8 +1308,6 @@@ static int starfive_probe(struct platfo
>   	sfp->gc.base =3D -1;
>   	sfp->gc.ngpio =3D NR_GPIOS;
>  =20
> - 	starfive_irq_chip.name =3D sfp->gc.label;
>  -	starfive_irq_chip.parent_device =3D dev;
> --
>   	sfp->gc.irq.chip =3D &starfive_irq_chip;
>   	sfp->gc.irq.parent_handler =3D starfive_gpio_irq_handler;
>   	sfp->gc.irq.num_parents =3D 1;

This is now a conflict between the irqchip tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/aYFkvPjWaW0IiZ95fR8py1X
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIcc/MACgkQAVBC80lX
0Gw1xAf8CA1S2R2jSQ8sMReMRjsyslcpM+vfENRQtUejShVKXqNMObKnEoQKvaBV
lKPO64vefjFxr2i23z8t4pE24znVOLYB0j7cyGOJhswCPJovkGHqBRCkkuYhpbh3
TqGwyW+m7qvAjDlwlqnPSmW9iT1UjE11QjvDnb9kEn/t8fyCTv764qHJygfDg4kp
fp7ftAzlWGY36A7PJvpXqwKONSTuZTJ4HhQIWBAMCLGcePz7hc7/LKe/VcHXWCBc
1JOnOfKDmn0cQUJykvyOWSP9XzOvHWo40Hbv1VQsdLgUuoIJqu0CryY0n0rQOGNr
wuENEIpQQMg3WYUEB2ot9qKRA2pOBQ==
=qgke
-----END PGP SIGNATURE-----

--Sig_/aYFkvPjWaW0IiZ95fR8py1X--
