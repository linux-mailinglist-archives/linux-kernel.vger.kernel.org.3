Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293054D93FF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 06:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242929AbiCOFjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 01:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbiCOFjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 01:39:03 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD85F3C;
        Mon, 14 Mar 2022 22:37:49 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KHhy36zS8z4xRB;
        Tue, 15 Mar 2022 16:37:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647322668;
        bh=I3Md9Wu+rXCekQ9TIyD4E1Jl3dFK5nZ9S4CAzhVMEG8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NiLhsVZgjCvvW0GRG6dpmaiYmOppcTKvuBtkT+kuzOGDvlG6ecvHoxQFeDc9hZ1dq
         YdMijfxKkFWgqrZgf6YCEFyljpFPDtaKB3H3bf+2H0YC0KRbXSqc+h81HHgWdK5q42
         jcHAaDaaWdkWZxBnjIW8oCYfEtanpmT5Y9/zwhJ5azCBfhCFtInaW1jWqJWpwqFAuK
         DZqzS2P6WyZTH/EnM1+m5aLwVZgiyLA2e++JwXst8qfCWgAHzhSVjBOYeDc7loKjgQ
         Z2GoOng0MuweT83goRvBKARdKQmqhelKWY20lbFptBgRBcezU/26nP5oMcMoqrZL1q
         AOnPEk1nDiF/g==
Date:   Tue, 15 Mar 2022 16:37:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the tip tree
Message-ID: <20220315163747.3e11ad15@canb.auug.org.au>
In-Reply-To: <20220315162327.53f7139f@canb.auug.org.au>
References: <20220315140644.369d98d6@canb.auug.org.au>
        <20220315162327.53f7139f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Fk/whrzBZEABgv+GiSKQFUO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Fk/whrzBZEABgv+GiSKQFUO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 15 Mar 2022 16:23:27 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Tue, 15 Mar 2022 14:06:44 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > After merging the irqchip tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >=20
> > arch/x86/kernel/cpuid.o: warning: objtool: file already has .orc_unwind=
 section, skipping
> > make[3]: *** [/home/sfr/next/next/scripts/Makefile.modfinal:61: arch/x8=
6/kernel/cpuid.ko] Error 255
> > arch/x86/kernel/msr.o: warning: objtool: file already has .orc_unwind s=
ection, skipping
> > make[3]: *** [/home/sfr/next/next/scripts/Makefile.modfinal:61: arch/x8=
6/kernel/msr.ko] Error 255
> > arch/x86/events/intel/intel-uncore.o: warning: objtool: file already ha=
s .retpoline_sites, skipping
> > arch/x86/events/intel/intel-uncore.o: warning: objtool: file already ha=
s .ibt_endbr_seal, skipping
> > arch/x86/events/intel/intel-uncore.o: warning: objtool: file already ha=
s .orc_unwind section, skipping
> > make[3]: *** [/home/sfr/next/next/scripts/Makefile.modfinal:61: arch/x8=
6/events/intel/intel-uncore.ko] Error 255
> >=20
> > I couldn't see anything int the irqchip tree that would cause this,
> > so I deleted my object directory and redid the build and this time
> > it succeeded.
> >=20
> > I suspect some change in the tip tree has brought this on (it is merged
> > just a bit before the irqchip tree). =20
>=20
> This time after the merging usb trees:
>=20
> drivers/phy/qualcomm/phy-qcom-usb-hs.o: warning: objtool: file already ha=
s .orc_unwind section, skipping
> make[3]: *** [scripts/Makefile.modfinal:61: drivers/phy/qualcomm/phy-qcom=
-usb-hs.ko] Error 255
> drivers/phy/qualcomm/phy-qcom-usb-hsic.o: warning: objtool: file already =
has .orc_unwind section, skipping
> make[3]: *** [scripts/Makefile.modfinal:61: drivers/phy/qualcomm/phy-qcom=
-usb-hsic.ko] Error 255
>=20
> I just removed the drivers/phy/qualcomm directory from the object tree
> and rebuilt.
>=20
> Then got this:
>=20
> drivers/phy/ti/phy-tusb1210.o: warning: objtool: file already has .orc_un=
wind section, skipping
> make[3]: *** [/home/sfr/next/next/scripts/Makefile.modfinal:61: drivers/p=
hy/ti/phy-tusb1210.ko] Error 255
>=20
> So removed the drivers/phy/ti directory and rebuilt and the build
> succeeded.
>=20
> I assume that something is being left around or reprocessed when it
> should not be.

Maybe commit

  8856dadf7ad3 ("Kbuild: Allow whole module objtool runs")

?

--=20
Cheers,
Stephen Rothwell

--Sig_/Fk/whrzBZEABgv+GiSKQFUO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIwJisACgkQAVBC80lX
0GwOKQf/VmiNnr36IEaDTWouwCaohGm5c4EslYAwPWXzfj2jMbp1SKBd+0hv7B5C
o9DG9rmLdtsD8d4uRrX1L7jez3YJOv3YRFhSA4R34VkDeCvx7JqHxAxR5CIjPcpr
magpmh7PEsrIzqwkSTTf9T6yjSJLZxHlHG8hv/9lvCRFE2/wxMLTbU+6KCIA2a1L
pOAjgb64iG6NweGD1DhyEwtp7Q5BJidrWKk/akD0tVmXaaek5ZGFFSjDm74uOTgR
RNpk9Z+xjT4hzjqa7ve0k/V84JxSbY+kT86HTd/G10V5M66H8F6/OHCwZOhHoFlG
rB4UGEKcdY2woVS7ymgiUDZpt6aSqA==
=Zgtw
-----END PGP SIGNATURE-----

--Sig_/Fk/whrzBZEABgv+GiSKQFUO--
