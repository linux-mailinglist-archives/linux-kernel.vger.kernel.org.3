Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673164F0CBC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 00:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376533AbiDCWQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 18:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376527AbiDCWQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 18:16:57 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12BA39832;
        Sun,  3 Apr 2022 15:15:02 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KWp9w1Ygwz4xNl;
        Mon,  4 Apr 2022 08:14:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649024101;
        bh=DNrSg3IB84omGQByPHM0Q/GGcPsrF3VYeUh2LBkVAFs=;
        h=Date:From:To:Cc:Subject:From;
        b=rCPEtowJJd4amAjz1HaPKgd5kdNiway/ws8FdOPobXJfLZoIsR9h6Kp2wOgGj8BdU
         lMhuUF508zUPjAkl8eaWfS7W7j5202O60Hq8Lw3hXY5Q81xMXTPDqrR1Il1Khcn1KN
         0VhPQOKqEJ6VVbDJAQamGGkds2vQqIjTVlGlcLMRQctBqaqfRlyG2l5CK8WtXqIiPZ
         I9UstoiP8hYbJSujBEEZQ5iT6X9WYRcAap/Y0IOt4DqRKVk4oHacqPpNeqpuatV6d/
         nv+8DSstqEkwA3+Cv0fL0XAKCmn4zCRCAbA9kcsGqYWiJaodgY1uTVeNkrageMabmB
         IK+4+1nRqfyNg==
Date:   Mon, 4 Apr 2022 08:14:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     Guo Ren <guoren@kernel.org>, Guo Ren <guoren@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: linux-next: manual merge of the csky tree with Linus' tree
Message-ID: <20220404081455.1539a4c2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Xg26LXvvziYCCI/VSmhHaXx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Xg26LXvvziYCCI/VSmhHaXx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the csky tree got a conflict in:

  arch/riscv/kernel/signal.c

between commit:

  93917ad50972 ("RISC-V: Add support for restartable sequence")

from Linus' tree and commit:

  0f713062b0ee ("riscv: compat: signal: Add rt_frame implementation")

from the csky tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/riscv/kernel/signal.c
index 9f4e59f80551,27d8f39228c4..000000000000
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@@ -258,10 -264,13 +264,15 @@@ static void handle_signal(struct ksigna
  		}
  	}
 =20
 +	rseq_signal_deliver(ksig, regs);
 +
+ #ifdef CONFIG_COMPAT
  	/* Set up the stack frame */
- 	ret =3D setup_rt_frame(ksig, oldset, regs);
+ 	if (is_compat_task())
+ 		ret =3D compat_setup_rt_frame(ksig, oldset, regs);
+ 	else
+ #endif
+ 		ret =3D setup_rt_frame(ksig, oldset, regs);
 =20
  	signal_setup_done(ret, ksig, 0);
  }

--Sig_/Xg26LXvvziYCCI/VSmhHaXx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJKHF8ACgkQAVBC80lX
0Gywawf/YQwmK6z+UzQvmanME4EKr+cYQATtiNKlfGfOjSeInhGT21j50GKq6O5J
HrUC0le+fH/iOEnycJpgzzJm1h3GKi1m6Touf1PNWOHjY99paIsTUHpocOcv5e+U
sRMxwjNUA6nMTzkhqfpWz/XM+Sl0sQqqhHe2fBvKNwtxz4eeVF3BZQRrkg/oahPQ
odwsGT43FGC8EIn56UY3Aj9YSCUaEnRvQOsWPr12k027y6svo09rgZuy7FGBcL+E
n52oYxaK1ndlRPQv5lG2EN80LgyTyGzh9KUUKlhhKh8mp42f3eqUm0bLHERN4EIK
vPGNvPx8NfBEyBk2n+SCscQpUxq6Jg==
=f51/
-----END PGP SIGNATURE-----

--Sig_/Xg26LXvvziYCCI/VSmhHaXx--
