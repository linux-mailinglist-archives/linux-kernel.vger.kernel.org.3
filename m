Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036044E48E9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 23:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237588AbiCVWIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 18:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237512AbiCVWIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:08:32 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B9B6F4BC;
        Tue, 22 Mar 2022 15:07:03 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KNQZB1hCtz4xMW;
        Wed, 23 Mar 2022 09:06:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647986822;
        bh=EsSxbDR9FaVnz6o0uFGQYD9/VmUeFlXQQpVgqKg3qZU=;
        h=Date:From:To:Cc:Subject:From;
        b=YNqRNXLpPWoAreaWDoEPBErmxhMyJd8ZkYGpTfz+WkOTmMRKZMT1ZrmxjiLYf0C/i
         WcGSHEyT0DmudFZLSdfL+np4ZtedELPc/SSe7HmyXCZHMhTDOQRX4YhmqfotCVrT2k
         FFaZrfBolwMq/mt96co4/bTTejX0nXAd+FY+/UYoCmzqD+UDm8Yj3ooKz+ZS/San8k
         e90CHL4yX+8xNRtReidt3RLWUGQeYoMK3NqCW+VZtLwcV7sKvSN2bmGkcO0eq/03t9
         xN0uejTlXFY/bWeduvegXmUESqcj1MTCXw3zveCDzK6mLljYFRUafZi+6T+lV0kjSj
         ArBl81pxkrlOg==
Date:   Wed, 23 Mar 2022 09:06:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Atish Patra <atishp@atishpatra.org>,
        Atish Patra <atishp@rivosinc.com>,
        Changbin Du <changbin.du@gmail.com>,
        Changbin Du <changbin.du@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: linux-next: manual merge of the risc-v tree with Linus' tree
Message-ID: <20220323090657.6538b9f6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/W+LMvh3XRYfEBCImGNDrQWK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/W+LMvh3XRYfEBCImGNDrQWK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the risc-v tree got a conflict in:

  arch/riscv/kernel/Makefile

between commit:

  22e2100b1b07 ("riscv: fix oops caused by irqsoff latency tracer")

from Linus' tree and commit:

  9dc6ce802136 ("RISC-V: Remove the current perf implementation")

from the risc-v tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/riscv/kernel/Makefile
index ffc87e76b1dd,fb63b462ff85..000000000000
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@@ -51,9 -51,6 +51,8 @@@ obj-$(CONFIG_MODULE_SECTIONS)	+=3D module
  obj-$(CONFIG_FUNCTION_TRACER)	+=3D mcount.o ftrace.o
  obj-$(CONFIG_DYNAMIC_FTRACE)	+=3D mcount-dyn.o
 =20
 +obj-$(CONFIG_TRACE_IRQFLAGS)	+=3D trace_irq.o
 +
- obj-$(CONFIG_RISCV_BASE_PMU)	+=3D perf_event.o
  obj-$(CONFIG_PERF_EVENTS)	+=3D perf_callchain.o
  obj-$(CONFIG_HAVE_PERF_REGS)	+=3D perf_regs.o
  obj-$(CONFIG_RISCV_SBI)		+=3D sbi.o

--Sig_/W+LMvh3XRYfEBCImGNDrQWK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmI6SIEACgkQAVBC80lX
0Gwcewf/W6wFEr+iKaAZte9wLwLBnQ2TccYSimXqLexuh4r0huIsd+DsVQ1yAnbT
927xwqDHuALGJ1CosaTOb4/1ErSmiuW1lysK5tssL9vJyvIcrGfS57W+dQcyD8lS
SUdxUAcOQwz83W3sVBWH2cUXd4CKQvIR0LQwQJbY8xJp6UYSk0PUKNSCPcUFF9Ks
aowrMKWHg5v0U1tq+emiikTmEVQUxdJkBg+LvPkRS4G4JOI4E7jb252n1jaRUKcY
2EsredlMppGzp+BuWv75nvq1+bVC6qIutu4kWlF7sW6DLpUYA65sijJVttVpVAA1
M+Qc/l2pax7C23HSNomyS6aGJallNg==
=eWdh
-----END PGP SIGNATURE-----

--Sig_/W+LMvh3XRYfEBCImGNDrQWK--
