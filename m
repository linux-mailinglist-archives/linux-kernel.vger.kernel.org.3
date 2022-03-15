Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F2C4D92CE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 04:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344085AbiCODIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 23:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiCODH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 23:07:59 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648934831E;
        Mon, 14 Mar 2022 20:06:47 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KHdbn5272z4xvb;
        Tue, 15 Mar 2022 14:06:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647313606;
        bh=IhpVU9bgd6Uwqfo1Fdy+B8SD1q428GdjNh//42pcbhk=;
        h=Date:From:To:Cc:Subject:From;
        b=tywJTbb0PpKJa0aUS77gDkBev4Jua2DjrWPXFkFzVelDUt0a9PNsbGu01zsOZRarR
         ceWzFcJBleELo3EfolxcIyW0iIXESBa/ymMD8Hxkf1fdeYtHKkmoJWHERrJgxVL6Fp
         zyBgrUaqXN26BamV7zoelUjcGWjgDLs9DaNYqUqMogCDLq4kwSJ4nfKhdlnaXk3Mii
         rb3Ssc5suzRqb3LARnDiMsJHzCEENQzW45Xxy0Rf8VS73BGiuAGqv6W55Tru9i4+KZ
         3zorSCSYqr34sB0UlE7WYL432ZXfhjAnKRyX2Rwqoc0SyQ/xvdBC5NtEQ2yZSnaXoe
         rum34xLlwRCvg==
Date:   Tue, 15 Mar 2022 14:06:44 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the tip tree
Message-ID: <20220315140644.369d98d6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hrl.uv1WV6B6jO1.mvFu5/P";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hrl.uv1WV6B6jO1.mvFu5/P
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the irqchip tree, today's linux-next build (x86_64
allmodconfig) failed like this:

arch/x86/kernel/cpuid.o: warning: objtool: file already has .orc_unwind sec=
tion, skipping
make[3]: *** [/home/sfr/next/next/scripts/Makefile.modfinal:61: arch/x86/ke=
rnel/cpuid.ko] Error 255
arch/x86/kernel/msr.o: warning: objtool: file already has .orc_unwind secti=
on, skipping
make[3]: *** [/home/sfr/next/next/scripts/Makefile.modfinal:61: arch/x86/ke=
rnel/msr.ko] Error 255
arch/x86/events/intel/intel-uncore.o: warning: objtool: file already has .r=
etpoline_sites, skipping
arch/x86/events/intel/intel-uncore.o: warning: objtool: file already has .i=
bt_endbr_seal, skipping
arch/x86/events/intel/intel-uncore.o: warning: objtool: file already has .o=
rc_unwind section, skipping
make[3]: *** [/home/sfr/next/next/scripts/Makefile.modfinal:61: arch/x86/ev=
ents/intel/intel-uncore.ko] Error 255

I couldn't see anything int the irqchip tree that would cause this,
so I deleted my object directory and redid the build and this time
it succeeded.

I suspect some change in the tip tree has brought this on (it is merged
just a bit before the irqchip tree).

--=20
Cheers,
Stephen Rothwell

--Sig_/hrl.uv1WV6B6jO1.mvFu5/P
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIwAsQACgkQAVBC80lX
0GyK7AgAkKUFWX75GJPYedI9Vw8DS0u9pHQ54nEFCylXwKRnK6Zl1INVuax8ODvB
/DMSxWEZ/CHwdkHoj0kjJI5ySIosm50HATJfI5QpOPPMc2LN6LZJnDIOTWnUxTSl
azhGjCUj8/XCa3OF73jMsypgK8mkUDtI4NRQFXHqCIS/3U0W/+3PZZVSPJV88DRi
aq43XiYMkWwaRXxnbLV7qwFGFOJYfyKWPQk3JhnQiMAFqI4rH+tI0RkYzzZMFHkK
0nTS5lgStLht6T2Lbi3Mb0i5lX+lyLOKHpPtIwvte8tCIhXbjUYL4DWTRHknnhhh
OfZpfXdpd3H+wiKUXQZIKp00VbjQdA==
=JFf3
-----END PGP SIGNATURE-----

--Sig_/hrl.uv1WV6B6jO1.mvFu5/P--
