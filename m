Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D451516AF6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 08:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383517AbiEBGtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 02:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383509AbiEBGtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 02:49:35 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93322CE31;
        Sun,  1 May 2022 23:46:04 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KsDBZ2hlsz4yST;
        Mon,  2 May 2022 16:45:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651473959;
        bh=cv1v5tbo/xmzZTbekmVXWWQW6pw/SMOAYxx313R0thY=;
        h=Date:From:To:Cc:Subject:From;
        b=NWiHWOidjS3ATJyCuqUj3/timFPReo2a+ks8Wm+W9KM3lMQMow/kItQFqTpFCP93c
         h6FkwK2dhchfSTPRS0BbrxLQbtOIkHh33St2w0y7O/+QfO6O5Zux0Cu9GAbUY3RMAB
         thjI4rv8ubaNYWGxRUM6YLt1nASh43bN+N3mqyuIpYecvR1qtT3S1Q2mp9kWUY2/Gx
         splwfvY019iVOEL7Re0cf72juxjJCY4tI5+AHj5Ui0REvzGyosW9Z8OSEsgovnNTwr
         tZ8m00/3dm1tIV4D8MdqxBWS1+kWbsNiOrO8TcUga2gJ9UD7PZ8iI+bbV04Yc7Ix8e
         qpCeVrVyXOWIA==
Date:   Mon, 2 May 2022 16:45:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the pinctrl tree with the gpio-intel
 tree
Message-ID: <20220502164557.3cbb18ca@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/C4XRv.Z1y/fAR2p2UX_RBh+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/C4XRv.Z1y/fAR2p2UX_RBh+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the pinctrl tree got a conflict in:

  drivers/pinctrl/stm32/pinctrl-stm32.c

between commit:

  bb949ed9b16b ("pinctrl: stm32: Switch to use for_each_gpiochip_node() hel=
per")

from the gpio-intel tree and commit:

  c954531bc5d8 ("pinctrl: stm32: improve bank clocks management")

from the pinctrl tree.

I fixed it up (I think, see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/pinctrl/stm32/pinctrl-stm32.c
index 7aecd0efde07,b308e7bb7487..000000000000
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@@ -1544,34 -1508,44 +1506,38 @@@ int stm32_pctl_probe(struct platform_de
  		return -ENOMEM;
 =20
  	i =3D 0;
 -	for_each_available_child_of_node(np, child) {
 +	for_each_gpiochip_node(dev, child) {
  		struct stm32_gpio_bank *bank =3D &pctl->banks[i];
 +		struct device_node *np =3D to_of_node(child);
 =20
 -		if (of_property_read_bool(child, "gpio-controller")) {
 -			bank->rstc =3D of_reset_control_get_exclusive(child,
 -								    NULL);
 -			if (PTR_ERR(bank->rstc) =3D=3D -EPROBE_DEFER) {
 -				of_node_put(child);
 -				return -EPROBE_DEFER;
 -			}
 -
 -			bank->clk =3D of_clk_get_by_name(child, NULL);
 -			if (IS_ERR(bank->clk)) {
 -				if (PTR_ERR(bank->clk) !=3D -EPROBE_DEFER)
 -					dev_err(dev,
 -						"failed to get clk (%ld)\n",
 -						PTR_ERR(bank->clk));
 -				of_node_put(child);
 -				return PTR_ERR(bank->clk);
 -			}
 -			i++;
 +		bank->rstc =3D of_reset_control_get_exclusive(np, NULL);
 +		if (PTR_ERR(bank->rstc) =3D=3D -EPROBE_DEFER) {
 +			fwnode_handle_put(child);
 +			return -EPROBE_DEFER;
  		}
 -	}
 =20
 -	for_each_available_child_of_node(np, child) {
 -		if (of_property_read_bool(child, "gpio-controller")) {
 -			ret =3D stm32_gpiolib_register_bank(pctl, child);
 -			if (ret) {
 -				of_node_put(child);
 +		bank->clk =3D of_clk_get_by_name(np, NULL);
 +		if (IS_ERR(bank->clk)) {
 +			if (PTR_ERR(bank->clk) !=3D -EPROBE_DEFER)
 +				dev_err(dev, "failed to get clk (%ld)\n", PTR_ERR(bank->clk));
 +			fwnode_handle_put(child);
 +			return PTR_ERR(bank->clk);
 +		}
 +		i++;
 +	}
 =20
 -				for (i =3D 0; i < pctl->nbanks; i++)
 -					clk_disable_unprepare(pctl->banks[i].clk);
 +	for_each_gpiochip_node(dev, child) {
 +		ret =3D stm32_gpiolib_register_bank(pctl, child);
 +		if (ret) {
 +			fwnode_handle_put(child);
+=20
 -				return ret;
 -			}
++			for (i =3D 0; i < pctl->nbanks; i++)
++				clk_disable_unprepare(pctl->banks[i].clk);
+=20
 -			pctl->nbanks++;
 +			return ret;
  		}
 +
 +		pctl->nbanks++;
  	}
 =20
  	dev_info(dev, "Pinctrl STM32 initialized\n");

--Sig_/C4XRv.Z1y/fAR2p2UX_RBh+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJvfiUACgkQAVBC80lX
0GwXVwf9FFN5pt22fnKTt8bzG4sU1/RTSNEgQyvlEHNo9ZbrWn36CFX1EeoNTVnc
82EMuetW4I2oo5Uq8JBt6D/kmnc2nwp2h8rp3qwY/cSu4X8MD9vonXkKhbPebB7C
oum+K/hk9o1asdHD/KjlaxXgLXg+A/nUjOKYBobVBLvRsgglqpCDYZRXrcMPUqAJ
+BOvQ8EczPl4007zlp5Y10U507Z924qa/JhmgRqKJm0LtYy+5FhZSo2yF1yg0pBA
kLE0ZsaLF3PU/8WhbIK0pEngcrPsKh+dTdqwnpwi7l+Mspawt4TrNDLPdinRApOA
TH+CuhcAFvjOW1sakelp/5GymImpVQ==
=6y8B
-----END PGP SIGNATURE-----

--Sig_/C4XRv.Z1y/fAR2p2UX_RBh+--
