Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BCC4D93B1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 06:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344846AbiCOFYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 01:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243553AbiCOFYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 01:24:47 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C792701;
        Mon, 14 Mar 2022 22:23:34 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KHhdX1vk8z4xRB;
        Tue, 15 Mar 2022 16:23:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647321809;
        bh=PzfOwLIHk92zj4bTFUWfNQ0WtSCJwHrXwlUpHj1Vyqg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qMjwyYnoBpUIOCiKEgyIm71jpZqqiFfb1fbXwPzOQ58OCDruI5RvxZebPIxF0ZN/b
         uDydWzsPkRlMZIBlVYR8am4Ptm5/qhp+RTW9BPNnkccdHbnRSGAM/zSaJITDGnOEu4
         vjmMsSXIi58zQgowP46l50YopdhBg/zHqrw1HyH3qRX7Jj1KrosP9Uiis/zwVWxLCJ
         JmOW/VWpu7kxuN50nl2NY8/2RlPUqkEN2ZPZjiBwSVOICpgTzFjU9ZTeQsvHX27kr2
         xeUfNy2QrtZ8jR5+2FgUQG8x8Du9sHhiGHUTSRd1/ykyW8ZaR3Qtnz2VBsvNi8KbXN
         3Ed9m9IEobfTA==
Date:   Tue, 15 Mar 2022 16:23:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the tip tree
Message-ID: <20220315162327.53f7139f@canb.auug.org.au>
In-Reply-To: <20220315140644.369d98d6@canb.auug.org.au>
References: <20220315140644.369d98d6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/h_.gzv4g=6AWUKhKDF5tTAo";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/h_.gzv4g=6AWUKhKDF5tTAo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 15 Mar 2022 14:06:44 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the irqchip tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> arch/x86/kernel/cpuid.o: warning: objtool: file already has .orc_unwind s=
ection, skipping
> make[3]: *** [/home/sfr/next/next/scripts/Makefile.modfinal:61: arch/x86/=
kernel/cpuid.ko] Error 255
> arch/x86/kernel/msr.o: warning: objtool: file already has .orc_unwind sec=
tion, skipping
> make[3]: *** [/home/sfr/next/next/scripts/Makefile.modfinal:61: arch/x86/=
kernel/msr.ko] Error 255
> arch/x86/events/intel/intel-uncore.o: warning: objtool: file already has =
.retpoline_sites, skipping
> arch/x86/events/intel/intel-uncore.o: warning: objtool: file already has =
.ibt_endbr_seal, skipping
> arch/x86/events/intel/intel-uncore.o: warning: objtool: file already has =
.orc_unwind section, skipping
> make[3]: *** [/home/sfr/next/next/scripts/Makefile.modfinal:61: arch/x86/=
events/intel/intel-uncore.ko] Error 255
>=20
> I couldn't see anything int the irqchip tree that would cause this,
> so I deleted my object directory and redid the build and this time
> it succeeded.
>=20
> I suspect some change in the tip tree has brought this on (it is merged
> just a bit before the irqchip tree).

This time after the merging usb trees:

drivers/phy/qualcomm/phy-qcom-usb-hs.o: warning: objtool: file already has =
.orc_unwind section, skipping
make[3]: *** [scripts/Makefile.modfinal:61: drivers/phy/qualcomm/phy-qcom-u=
sb-hs.ko] Error 255
drivers/phy/qualcomm/phy-qcom-usb-hsic.o: warning: objtool: file already ha=
s .orc_unwind section, skipping
make[3]: *** [scripts/Makefile.modfinal:61: drivers/phy/qualcomm/phy-qcom-u=
sb-hsic.ko] Error 255

I just removed the drivers/phy/qualcomm directory from the object tree
and rebuilt.

Then got this:

drivers/phy/ti/phy-tusb1210.o: warning: objtool: file already has .orc_unwi=
nd section, skipping
make[3]: *** [/home/sfr/next/next/scripts/Makefile.modfinal:61: drivers/phy=
/ti/phy-tusb1210.ko] Error 255

So removed the drivers/phy/ti directory and rebuilt and the build
succeeded.

I assume that something is being left around or reprocessed when it
should not be.

--=20
Cheers,
Stephen Rothwell

--Sig_/h_.gzv4g=6AWUKhKDF5tTAo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIwIs8ACgkQAVBC80lX
0GxmLAf7Bu1Kk56hsxpHDI3nmC85Nvv8og2l+H1IqSxhSth7AaWe5dcG9bnGjuRQ
CEfzrXWhoaSaty//Sxl1zMMYR1bs3qiEo80vrayyWMigt+7uWV5QqdVpIwaHOGSU
XaSdMdQ/I1GnDOuxih6AOE3M+U3Stsq//InzK2X2CwCNu+KWErY0s/KCNhEstvoM
jnPQ/UokG2L24PjyNLQemqg29jHTnojw5fMB5vg7n3gSccgET0BgcGWtx+0YGaGo
q75mg83t4YoDHmskL7Z8SyRGnFe4hduyOppa+9iUg8GFgzuEFdXSMD4SDzYdsDCr
XOs/IyVPz5q2z7Jt3yCW2cERccETDA==
=rwhc
-----END PGP SIGNATURE-----

--Sig_/h_.gzv4g=6AWUKhKDF5tTAo--
