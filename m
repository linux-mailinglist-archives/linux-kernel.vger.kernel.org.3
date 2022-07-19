Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8EE5791A8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 06:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbiGSEKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 00:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbiGSEJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 00:09:59 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BD03E765;
        Mon, 18 Jul 2022 21:09:57 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ln52R2hSGz4xXF;
        Tue, 19 Jul 2022 14:09:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658203793;
        bh=QvJ/FceJdvHwM73DpSa5VCJrfobFpvQQEAqrJjR4+50=;
        h=Date:From:To:Cc:Subject:From;
        b=mkWGYmAJSfBMFoupPUG8j/8Xq5pAz1k2v7XLLuThpxL4Td+mjH1tPRXQgyeUU9sJA
         +oTmtpXy3r/7T2MEsP4P2a4R/c2LylmJobBcDXn8O+FB1d86nEBqaY6PmC9aJFIAWd
         8ZjRc4W+r1BG+ejkZj7b7QzqCegEZ15pXSuNCcIthAOwVGa8sLyLCqerjPoCMiePVw
         lwnf4QeqmWav6vYz86qrDBCfHu626uPcHmsA3/kmjaCp0hb/qSVNF05yMZVO+Qwk91
         bLIxPFFxEu8icLiY/vHKjLKuTe9igRNFatxAeIG+L3V/dQayFUXm3WfD0SqxP83wYy
         7YEqU36INaDTQ==
Date:   Tue, 19 Jul 2022 14:09:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     Borislav Petkov <bp@suse.de>, Coiby Xu <coxu@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the tip tree with the integrity tree
Message-ID: <20220719140950.67296570@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2REtEWfzEoKM.S8d/NObwI1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2REtEWfzEoKM.S8d/NObwI1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  arch/x86/kernel/kexec-bzimage64.c

between commit:

  c903dae8941d ("kexec, KEYS: make the code in bzImage64_verify_sig generic=
")

from the integrity tree and commit:

  68b8e9713c8e ("x86/setup: Use rng seeds from setup_data")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/x86/kernel/kexec-bzimage64.c
index f299b48f9c9f,b9bdb40364a6..000000000000
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@@ -17,6 -17,8 +17,7 @@@
  #include <linux/kernel.h>
  #include <linux/mm.h>
  #include <linux/efi.h>
 -#include <linux/verification.h>
+ #include <linux/random.h>
 =20
  #include <asm/bootparam.h>
  #include <asm/setup.h>

--Sig_/2REtEWfzEoKM.S8d/NObwI1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLWLo4ACgkQAVBC80lX
0GyWlwf/beoR63X8M01XkW+ECW3+xTckMcf30XYHAkdevi8SIVho25t+kxVwMyEE
tQ9GvOqs50v0O0vvKUgda+j/yE1r/JyvNCJCFqWwbA+EfF7NqoYfhc+ZKUTmo9FY
HKIIP+WO9tY+jf/AzpVMjnHJ6IX/SV7JXoekeYIMe6us8RWF1PAHxHzs3Wx4MoZ0
B5+a2DZeR5ijawGTub5kUl1TeaCD0LtH5C9kVyHQq9f+rFzsZ+cRi25C+LBzWRzp
QqcydfhyiccKi0C1QNWHvA9EgwbE76f0hkBfvv/qhc38DOyC8ykXRI5kd/jWbQrV
WQ9a2zq2or/+wFne28rM4c2LhgMoPw==
=GC2v
-----END PGP SIGNATURE-----

--Sig_/2REtEWfzEoKM.S8d/NObwI1--
