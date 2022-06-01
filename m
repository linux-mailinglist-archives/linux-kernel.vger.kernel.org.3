Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C55153B088
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 02:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbiFAX2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 19:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiFAX2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 19:28:20 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7383129EE9;
        Wed,  1 Jun 2022 16:28:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LD5162Xjyz4xCy;
        Thu,  2 Jun 2022 09:28:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1654126094;
        bh=PA+H35NDQk1TI9jEKfQWGo9nRbd//LyZDZLrF1etDvA=;
        h=Date:From:To:Cc:Subject:From;
        b=SUqV+PBDcWinahwIi5ooIgKK9nt4s7isOG1nC7nqjZ995kO+ES+QmEgKMLoj0EZB4
         vUdG/qW7Wb0NzPYhJLJVe5/4I7p5estNTH3qDO61z1gIWjnUtAF+TYgPX7kxv/wBdg
         mBZI0I/vF7OOLdqt1l0PJPAbs6gOclmopKBQN6XGoJqxT6qQA1tPuQqznn2oYa9I5n
         eK6brR4oUP6BSQpwfi7wYQFkGYRlOIwvyS9udGWmYMQV0QLMolC8SvSbLaQZf6vV6E
         xgUZPBaf1jZnajHyBTQWezKghsz5STIgU4NM0tdMS4Vc/vECqQaEt2CEovciXe7WtR
         6lDsz+RdWdyyA==
Date:   Thu, 2 Jun 2022 09:28:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     David Lebrun <david.lebrun@uclouvain.be>,
        "David S. Miller" <davem@davemloft.net>,
        David Vrabel <david.vrabel@citrix.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Shannon Zhao <shannon.zhao@linaro.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the kbuild tree
Message-ID: <20220602092809.04008a86@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZmM.WWEr0GVGkFCxpVonMKH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZmM.WWEr0GVGkFCxpVonMKH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kbuild tree, today's linux-next build (arm
multi_v7_defconfig) produced these warnings:

WARNING: modpost: vmlinux.o(___ksymtab_gpl+mdio_bus_init+0x0): Section mism=
atch in reference from the variable __ksymtab_mdio_bus_init to the function=
 .init.text:mdio_bus_init()
The symbol mdio_bus_init is exported and annotated __init=20
Fix this by removing the __init annotation of mdio_bus_init or drop the exp=
ort.

WARNING: modpost: vmlinux.o(___ksymtab+xfrm4_protocol_init+0x0): Section mi=
smatch in reference from the variable __ksymtab_xfrm4_protocol_init to the =
function .init.text:xfrm4_protocol_init()
The symbol xfrm4_protocol_init is exported and annotated __init=20
Fix this by removing the __init annotation of xfrm4_protocol_init or drop t=
he export.

The x86_64 allmodconfig build added these:

WARNING: modpost: vmlinux.o(___ksymtab_gpl+xen_xlate_map_ballooned_pages+0x=
0): Section mismatch in reference from the variable __ksymtab_xen_xlate_map=
_ballooned_pages to the function .init.text:xen_xlate_map_ballooned_pages()
The symbol xen_xlate_map_ballooned_pages is exported and annotated __init=20
Fix this by removing the __init annotation of xen_xlate_map_ballooned_pages=
 or drop the export.

WARNING: modpost: vmlinux.o(___ksymtab_gpl+ixp4xx_timer_setup+0x0): Section=
 mismatch in reference from the variable __ksymtab_ixp4xx_timer_setup to th=
e function .init.text:ixp4xx_timer_setup()
The symbol ixp4xx_timer_setup is exported and annotated __init=20
Fix this by removing the __init annotation of ixp4xx_timer_setup or drop th=
e export.

WARNING: modpost: vmlinux.o(___ksymtab_gpl+hv_init_clocksource+0x0): Sectio=
n mismatch in reference from the variable __ksymtab_hv_init_clocksource to =
the function .init.text:hv_init_clocksource()
The symbol hv_init_clocksource is exported and annotated __init=20
Fix this by removing the __init annotation of hv_init_clocksource or drop t=
he export.

WARNING: modpost: net/ipv6/ipv6.o(___ksymtab+seg6_hmac_init+0x0): Section m=
ismatch in reference from the variable __ksymtab_seg6_hmac_init to the func=
tion .init.text:seg6_hmac_init()
The symbol seg6_hmac_init is exported and annotated __init=20
Fix this by removing the __init annotation of seg6_hmac_init or drop the ex=
port.
Exposed by commit

  cf2cbe28c6a2 ("modpost: fix section mismatch check for exported init/exit=
 sections")

Introduced by commits

  90eff9096c01 ("net: phy: Allow splitting MDIO bus/device support from PHY=
s")
  2f32b51b609f ("xfrm: Introduce xfrm_input_afinfo to access the the callba=
cks properly")
  243848fc018c ("xen/grant-table: Move xlated_setup_gnttab_pages to common =
place")
  13e0b4059b98 ("clocksource/drivers/ixp4xx: Add driver")
  dd2cb348613b ("clocksource/drivers: Continue making Hyper-V clocksource I=
SA agnostic")
  bf355b8d2c30 ("ipv6: sr: add core files for SR HMAC support")

--=20
Cheers,
Stephen Rothwell

--Sig_/ZmM.WWEr0GVGkFCxpVonMKH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKX9gkACgkQAVBC80lX
0GwrqAf9GidzbmaYnDmJGcB1wMjxbo/M8OlNc+kLE6vnJ+Jkj+B6sq0mLdU3Nsp1
fH0I0OJRgDDNANUL/0jh7rIFOqK1rPyDbxBKrwa/THemsdjGgAcna0aR2t2bFVIY
pRLkSyCwRcpI5xcyJ+yiR6cgjbEJbKQciK1VA8Ze2Vb7N/DqGWyiHGYerw33iJpB
sqXKAhf3LKnkYFLwgFozgZMNmQA7VTA9aJpOgQ3VyvxlMpHGPDNEijUKliPsgPDb
dKBpjdkESNH2g1XuxpMh4kFS6Q63+3OBY+EhFXSyt6jjXqDPOVu9woyn1ZFbRR0N
TCPXFEh3aXA0MMzv34qrCO4D65SjMA==
=WoTT
-----END PGP SIGNATURE-----

--Sig_/ZmM.WWEr0GVGkFCxpVonMKH--
