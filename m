Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227335A71C5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbiH3XUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbiH3XTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:19:35 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB9FA3D75;
        Tue, 30 Aug 2022 16:17:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MHNVc6mZRz4xG6;
        Wed, 31 Aug 2022 09:16:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1661901418;
        bh=766lshPeCDdy1ppiyHkNn459FrfhkjxB7x2mn46uqkE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tVaeVIibxJ/oZG2ZHD3jLeQUA7mMWIb/u79lwx8GeLyldgVqpokGSQslybxHEztY+
         K27iurqzOTPgK5pZ09/y6fRiSJ1f0u7qbCtNycg1YL0L2KDj2OgMcF4kqct4VIQYYX
         h6+ab7YRXSj1cg3+6eiBX2z0kTDL3KVIjc5BDmXSNOVgkx3lY5Lw6ZyXfcRIGGoMqc
         CheHF9rz3/29Hpfgwdc/NNPYCa7iuE2gFJHzxHBOTvqVaIsvA99FzJgoMr4oEwVNYd
         4I5G49fsvHy6q2BzflWOj9IRStfo3M7N/YmTCV2/vee2Gj4WnsHA9q7jAsjmsI9nw7
         2cjJSB8paJuJg==
Date:   Wed, 31 Aug 2022 09:16:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: linux-next: build warnings after merge of the broadcom tree
Message-ID: <20220831091654.45d5ed41@canb.auug.org.au>
In-Reply-To: <20220815105419.4df1005b@canb.auug.org.au>
References: <20220725095913.31e859ec@canb.auug.org.au>
        <df8f4765-a804-cb50-bbb5-475925ba2036@milecki.pl>
        <20220815105419.4df1005b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SkSaMRxy1h_L3z9ywqkDu=.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SkSaMRxy1h_L3z9ywqkDu=.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 15 Aug 2022 10:54:19 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Mon, 25 Jul 2022 12:33:48 +0200 Rafa=C5=82 Mi=C5=82ecki <rafal@milecki=
.pl> wrote:
> >
> > On 25.07.2022 01:59, Stephen Rothwell wrote: =20
> > > After merging the broadcom tree, today's linux-next build (arm
> > > multi_v7_defconfig) produced these warnings:
> > >=20
> > > arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /=
axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
> > > arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /=
axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
> > > arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /=
axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)   =
=20
> >=20
> > This is expected. My commit ef126d3f58d25 ("ARM: dts: BCM5301X: Add
> > basic PCI controller properties") reduced following warnings:
> >=20
> > arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@12000: 'device=
_type' is a required property
> >          From schema: /lib/python3.9/site-packages/dtschema/schemas/pci=
/pci-bus.yaml
> > arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@12000: 'ranges=
' is a required property
> >          From schema: /lib/python3.9/site-packages/dtschema/schemas/pci=
/pci-bus.yaml
> > arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@12000: '#addre=
ss-cells' is a required property
> >          From schema: /lib/python3.9/site-packages/dtschema/schemas/pci=
/pci-bus.yaml
> > arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@12000: '#size-=
cells' is a required property
> >          From schema: /lib/python3.9/site-packages/dtschema/schemas/pci=
/pci-bus.yaml
> >=20
> >=20
> > down to this one:
> >=20
> > arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dtb: pcie@12000: 'ranges=
' is a required property
> >          From schema: /lib/python3.9/site-packages/dtschema/schemas/pci=
/pci-bus.yaml
> >=20
> >=20
> > and basically does the right thing (adds required properties).
> >=20
> >=20
> > I'm fully aware "ranges" need to be added (it's mentioned in the commit)
> > and it's one of next things on my BCM5301X list.
> >=20
> > So while my commits triggers that problem it also reduces warnings so
> > I'd say it's acceptable.

Not from my point of view:  I was not getting any warnings and now I am
getting 254 lines of warnings :-(
 =20
> So, is something being done about these introduced warnings?

I am still seeing these warnings.

The above commit is now

  61dc1e3850a6 ("ARM: dts: BCM5301X: Add basic PCI controller properties")

--=20
Cheers,
Stephen Rothwell

--Sig_/SkSaMRxy1h_L3z9ywqkDu=.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMOmmYACgkQAVBC80lX
0Gyewwf/XL8mC40VJ4gxQyr4xSabO+CCkfHLJnhCedxm5Ea/KNiLVmmbtv/gFAmW
m5nmmV6+pbSrgGK6wn8JldqxycZK9w3bbSf3g6gfUVQ4xioq7j139iY5v55jh2Bl
qiEwTdN71vrcF4oQsEbVLoDa3sY3qB+SPnWQHeFlPUZbeaEdr9KpjaR2ueWnZHiR
PJvUnoryNu1frHkUv5W151irOOgueMgqAK2P1F5it1VyPxyJvlmsaHKfzD3tbqQ1
mvv5E8O8AlDnsVoZrwfDU3yGol2F809Z9seJKiZEEHg5PLaYkQornZEZzCKNzavm
IcABr1e4RWG65uVKL4iKOuhCM3yerw==
=uVq2
-----END PGP SIGNATURE-----

--Sig_/SkSaMRxy1h_L3z9ywqkDu=.--
