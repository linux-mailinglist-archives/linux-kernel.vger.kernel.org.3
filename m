Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9324D9683
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345953AbiCOInt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343500AbiCOInr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:43:47 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B262B4CD62;
        Tue, 15 Mar 2022 01:42:33 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KHn3C5Dkrz4xvg;
        Tue, 15 Mar 2022 19:42:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647333752;
        bh=3LBWFpfo5KWICck/UJ51RLvAZ87sUmvXzLs4u5w3HjE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AkD5MiHn21Wk1lb1TEiUPo8CEmmxIcVq+vVvh6k8IuU/4iV0tK2vAAJ5P0vlAHnDa
         b94dvSpyXaXMqHR6ZIDE0sa46PlUH8pFQEBNz1MtOgzFzTTHALirDAJOndOsSV6Ynr
         kHxYyc7Nha/kV6tVxJPeq9PQJFrb3qbZMQGReeSdn6W/AWhtLx7mcCsaBb6lkwtVIS
         +/4NCO5Yyr04hOZn/yP1zcqRr0xFKe7c/L4JdWNplJ3VvgwshIsW+pBh7U0CjbBjkt
         1IC8BjNHgTMFj2Eovm//2YZIc/4CqjbdyAlPjSHVTB50r7OZYadzTw2OjLLfstOzjI
         kKHTWK2B5epyw==
Date:   Tue, 15 Mar 2022 19:42:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the tip tree
Message-ID: <20220315194230.62aec8ce@canb.auug.org.au>
In-Reply-To: <20220315163747.3e11ad15@canb.auug.org.au>
References: <20220315140644.369d98d6@canb.auug.org.au>
        <20220315162327.53f7139f@canb.auug.org.au>
        <20220315163747.3e11ad15@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xUX22JvAl0N4LuI3+MZnM1d";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xUX22JvAl0N4LuI3+MZnM1d
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 15 Mar 2022 16:37:47 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Tue, 15 Mar 2022 16:23:27 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > On Tue, 15 Mar 2022 14:06:44 +1100 Stephen Rothwell <sfr@canb.auug.org.=
au> wrote: =20
> > >
> > > After merging the irqchip tree, today's linux-next build (x86_64
> > > allmodconfig) failed like this:
> > >=20
> > > arch/x86/kernel/cpuid.o: warning: objtool: file already has .orc_unwi=
nd section, skipping
> > > make[3]: *** [/home/sfr/next/next/scripts/Makefile.modfinal:61: arch/=
x86/kernel/cpuid.ko] Error 255
> > > arch/x86/kernel/msr.o: warning: objtool: file already has .orc_unwind=
 section, skipping
> > > make[3]: *** [/home/sfr/next/next/scripts/Makefile.modfinal:61: arch/=
x86/kernel/msr.ko] Error 255
> > > arch/x86/events/intel/intel-uncore.o: warning: objtool: file already =
has .retpoline_sites, skipping
> > > arch/x86/events/intel/intel-uncore.o: warning: objtool: file already =
has .ibt_endbr_seal, skipping
> > > arch/x86/events/intel/intel-uncore.o: warning: objtool: file already =
has .orc_unwind section, skipping
> > > make[3]: *** [/home/sfr/next/next/scripts/Makefile.modfinal:61: arch/=
x86/events/intel/intel-uncore.ko] Error 255
> > >=20
> > > I couldn't see anything int the irqchip tree that would cause this,
> > > so I deleted my object directory and redid the build and this time
> > > it succeeded.
> > >=20
> > > I suspect some change in the tip tree has brought this on (it is merg=
ed
> > > just a bit before the irqchip tree).   =20
> >=20
> > This time after the merging usb trees:
> >=20
> > drivers/phy/qualcomm/phy-qcom-usb-hs.o: warning: objtool: file already =
has .orc_unwind section, skipping
> > make[3]: *** [scripts/Makefile.modfinal:61: drivers/phy/qualcomm/phy-qc=
om-usb-hs.ko] Error 255
> > drivers/phy/qualcomm/phy-qcom-usb-hsic.o: warning: objtool: file alread=
y has .orc_unwind section, skipping
> > make[3]: *** [scripts/Makefile.modfinal:61: drivers/phy/qualcomm/phy-qc=
om-usb-hsic.ko] Error 255
> >=20
> > I just removed the drivers/phy/qualcomm directory from the object tree
> > and rebuilt.
> >=20
> > Then got this:
> >=20
> > drivers/phy/ti/phy-tusb1210.o: warning: objtool: file already has .orc_=
unwind section, skipping
> > make[3]: *** [/home/sfr/next/next/scripts/Makefile.modfinal:61: drivers=
/phy/ti/phy-tusb1210.ko] Error 255
> >=20
> > So removed the drivers/phy/ti directory and rebuilt and the build
> > succeeded.
> >=20
> > I assume that something is being left around or reprocessed when it
> > should not be. =20
>=20
> Maybe commit
>=20
>   8856dadf7ad3 ("Kbuild: Allow whole module objtool runs")
>=20
> ?

And after merging the scsi tree:

arch/x86/crypto/aegis128-aesni.o: warning: objtool: file already has .stati=
c_call_sites section, skipping
arch/x86/crypto/aegis128-aesni.o: warning: objtool: file already has .retpo=
line_sites, skipping
arch/x86/crypto/aegis128-aesni.o: warning: objtool: file already has .ibt_e=
ndbr_seal, skipping
arch/x86/crypto/aegis128-aesni.o: warning: objtool: file already has .orc_u=
nwind section, skipping
arch/x86/crypto/aesni-intel.o: warning: objtool: file already has .static_c=
all_sites section, skipping
arch/x86/crypto/aesni-intel.o: warning: objtool: file already has .ibt_endb=
r_seal, skipping
arch/x86/crypto/aesni-intel.o: warning: objtool: file already has .orc_unwi=
nd section, skipping
arch/x86/crypto/aegis128-aesni.o: warning: objtool: file already has .stati=
c_call_sites section, skipping
arch/x86/crypto/aegis128-aesni.o: warning: objtool: file already has .retpo=
line_sites, skipping
arch/x86/crypto/aegis128-aesni.o: warning: objtool: file already has .ibt_e=
ndbr_seal, skipping
arch/x86/crypto/aegis128-aesni.o: warning: objtool: file already has .orc_u=
nwind section, skipping
arch/x86/crypto/aesni-intel.o: warning: objtool: file already has .static_c=
all_sites section, skipping
arch/x86/crypto/aesni-intel.o: warning: objtool: file already has .ibt_endb=
r_seal, skipping
arch/x86/crypto/aesni-intel.o: warning: objtool: file already has .orc_unwi=
nd section, skipping
arch/x86/kernel/cpu/mce/mce-inject.o: warning: objtool: file already has .s=
tatic_call_sites section, skipping
arch/x86/kernel/cpu/mce/mce-inject.o: warning: objtool: file already has .r=
etpoline_sites, skipping
arch/x86/kernel/cpu/mce/mce-inject.o: warning: objtool: file already has .o=
rc_unwind section, skipping
arch/x86/kernel/cpuid.o: warning: objtool: file already has .orc_unwind sec=
tion, skipping
arch/x86/kernel/msr.o: warning: objtool: file already has .orc_unwind secti=
on, skipping
crypto/aegis128.o: warning: objtool: file already has .static_call_sites se=
ction, skipping
crypto/aegis128.o: warning: objtool: file already has .orc_unwind section, =
skipping
crypto/arc4.o: warning: objtool: file already has .orc_unwind section, skip=
ping
crypto/async_tx/async_memcpy.o: warning: objtool: file already has .static_=
call_sites section, skipping
crypto/async_tx/async_memcpy.o: warning: objtool: file already has .retpoli=
ne_sites, skipping
crypto/async_tx/async_memcpy.o: warning: objtool: file already has .orc_unw=
ind section, skipping

and so on ...

I finally got fed up with rebuilding and so reverted these commits

  c7d90e15b895 ("x86: Fix {int3,ibt}_selftest() vs LTO")
  8959fcf5650e ("x86/alternative: Use .ibt_endbr_seal to seal indirect call=
s")
  49f8cb48085d ("objtool: Find unused ENDBR instructions")
  b87d2fcee362 ("objtool: Validate IBT assumptions")
  df280fcb49f9 ("objtool: Add IBT/ENDBR decoding")
  51727f8e4a1a ("objtool: Read the NOENDBR annotation")
  8856dadf7ad3 ("Kbuild: Allow whole module objtool runs")

--=20
Cheers,
Stephen Rothwell

--Sig_/xUX22JvAl0N4LuI3+MZnM1d
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIwUXcACgkQAVBC80lX
0GzM2Af+K92PRl+zHuxwYC66rCvOeqikgiVklVadTooAEDjBlqXRblt0ODiRkSmD
aKOKe9R3vdnSnh/J7jAT6AvH5CGtkPaxAzcaf8PSJYQGydAL4W0kItcDikThiCVK
SUh8ud//UA9CxNhcY8c6hxRqyDvpphMNPsNcGluIeJGBT5oFh4RgijwBXbdqeM8M
3pZNfSb7THCUjnDOgKDDT7Z1G1ulf54emHMR2ggIv6BKnz07Cl6/k4CjIcHx3hl6
9JEetwehAjazzdOse5Ng6NF65SN9V4EFZgJ0D996HqJZSrBxg3OGJnF4areKXbDm
C+zixvyXA3YZ4c1CGpBGtTNyl8bZUQ==
=Fu1e
-----END PGP SIGNATURE-----

--Sig_/xUX22JvAl0N4LuI3+MZnM1d--
