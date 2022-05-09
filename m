Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EEA51F523
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbiEIHFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbiEIGxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:53:53 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B64319CED6;
        Sun,  8 May 2022 23:49:59 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KxWxb0xMdz4xTX;
        Mon,  9 May 2022 16:49:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652078981;
        bh=mHuXKOrIm4sqA5NAMPx2n4I8mF2Ewt7kyakoDhd7gBY=;
        h=Date:From:To:Cc:Subject:From;
        b=L2CXLkYvDWbEtrWXvoq9OUsSDlr4HZMnTHM3Ss+R4OlsNuhdiiV1bQlTkZ0yHgZaF
         Knlh0QlJktCi/CzuaynUpYmfQ9zyFEHISmEaeci+jYVfnroPPwcwhXX2CBoIQ/eNvF
         FpYRhDxEUGH2sJ4RK2JSAxiogrRhOOHTQbWKi8nHsQtpUBZufihSMYDclImJUJaEjQ
         s/n5M0euKySw3Tp3NMGPafRN7K4+e4qxhXM8kv44QRsG9KiKbDY5c+1xsnBu2cdpgB
         xB5Z8bifvbV41HqKf2lXhZxBHuz8q9UvUDWTjtcgKgPKKokDsQdniZKvqP9LjhfKct
         yQ+pxqlmVGafA==
Date:   Mon, 9 May 2022 16:49:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@suse.de>, Brian Gerst <brgerst@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the userns tree with the tip tree
Message-ID: <20220509164937.037a2b95@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/99hhZ7mqForv3W9qyuAuin/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/99hhZ7mqForv3W9qyuAuin/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the userns tree got a conflict in:

  arch/x86/kernel/process.c

between commit:

  3a24a60854d2 ("x86/32: Remove lazy GS macros")

from the tip tree and commit:

  5bd2e97c868a ("fork: Generalize PF_IO_WORKER handling")

from the userns tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/x86/kernel/process.c
index 4037aaaf0260,d20eaad52a85..000000000000
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@@ -193,10 -193,14 +195,10 @@@ int copy_thread(struct task_struct *p,=20
  	if (sp)
  		childregs->sp =3D sp;
 =20
- 	if (unlikely(p->flags & PF_IO_WORKER)) {
 -#ifdef CONFIG_X86_32
 -	task_user_gs(p) =3D get_user_gs(current_pt_regs());
 -#endif
 -
+ 	if (unlikely(args->fn)) {
  		/*
- 		 * An IO thread is a user space thread, but it doesn't
- 		 * return to ret_after_fork().
+ 		 * A user space thread, but it doesn't return to
+ 		 * ret_after_fork().
  		 *
  		 * In order to indicate that to tools like gdb,
  		 * we reset the stack and instruction pointers.

--Sig_/99hhZ7mqForv3W9qyuAuin/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ4uYEACgkQAVBC80lX
0Gz7mAf+LCxH5hea6TR1vorqaXnF+WrOFZK+HWNJ31Zc1Jbo+gPG8JLON/m3E3jI
RRovyox3WdpOSV9ZKwJVmH5prXYHoOWEuJQ8DNVFeODBFYNYzWMqcr4mlGHv4cFD
vn9rTSvUzWxchbv5iL0vy6DAn2gIws+APfZlghP2d3fiFjk6q+c1P2dMVtUS3t9z
RU8zRL945bTfVFYmM+gRYu4B7HhyjmTSduNKSeKryOoY3TYfZIIxwSPJoOkQyPK0
Ap8qB4l3v0KcdSptswz7jO9YFulWjSmiV/bqW+jBLeKGpTsZOrRdL+5nksb9lkeQ
spuVEOFCUZ6pf7RnjjQTqs8JMa+/Zw==
=VYqk
-----END PGP SIGNATURE-----

--Sig_/99hhZ7mqForv3W9qyuAuin/--
