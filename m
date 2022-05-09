Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1A05209AE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 01:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbiEIXtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 19:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbiEIXsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 19:48:40 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782C72181ED;
        Mon,  9 May 2022 16:44:45 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KxySq75XRz4xXS;
        Tue, 10 May 2022 09:44:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652139884;
        bh=RAFdPek578p4jWXnDLY7OrZu51aV1DEy41hBo/B9p30=;
        h=Date:From:To:Cc:Subject:From;
        b=L8gJh/RRsIPXFfolqHvw1uksKdtcR3EFZXUBsTuSeQMaGTWQOTUss2zvzgJ+JbmAT
         CSWoe6o1iDsCnBKpSlGRFDopJTBroCFtwvTLd7LJAINr3a/rv77wXJ+BidspW1yy/W
         fI7NuAI7PjpZtlHB6yQ9AVq31+LgQf1Ictbfn7aHg0bo8WU0Jz/aTO3wEIJQTj0BxR
         zxA/rve3kWJW58O/h4dCsx8WREDXd99xk8qIGg5kGwMFcl24b4/BohCy0W4qFcOzCs
         JMfqIJxg2WXhHLozx9IIZUbxnieWZE10G1rjAituuEhXD8Nf57lKBlwwfmLrIOsQuk
         LsJ/av03HWAng==
Date:   Tue, 10 May 2022 09:44:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: linux-next: manual merge of the m68knommu tree with the m68k tree
Message-ID: <20220510094442.26826532@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vbD7UTZnh34VrwPfwmTliay";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vbD7UTZnh34VrwPfwmTliay
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the m68knommu tree got a conflict in:

  arch/m68k/kernel/ptrace.c

between commit:

  c862fe70b023 ("m68k: Wire up syscall_trace_enter/leave for m68k")

from the m68k tree and commit:

  0d91043d8bdf ("m68knommu: implement minimal regset support")

from the m68knommu tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/m68k/kernel/ptrace.c
index daebccdd2c09,4349b9c4dd68..000000000000
--- a/arch/m68k/kernel/ptrace.c
+++ b/arch/m68k/kernel/ptrace.c
@@@ -284,3 -292,60 +286,59 @@@ asmlinkage void syscall_trace_leave(voi
  	if (test_thread_flag(TIF_SYSCALL_TRACE))
  		ptrace_report_syscall_exit(task_pt_regs(current), 0);
  }
 -#endif /* CONFIG_COLDFIRE */
+=20
+ #if defined(CONFIG_BINFMT_ELF_FDPIC) && defined(CONFIG_ELF_CORE)
+ /*
+  * Currently the only thing that needs to use regsets for m68k is the
+  * coredump support of the elf_fdpic loader. Implement the minimum
+  * definitions required for that.
+  */
+ static int m68k_regset_get(struct task_struct *target,
+ 			   const struct user_regset *regset,
+ 			   struct membuf to)
+ {
+ 	struct pt_regs *ptregs =3D task_pt_regs(target);
+ 	u32 uregs[ELF_NGREG];
+=20
+ 	ELF_CORE_COPY_REGS(uregs, ptregs);
+ 	return membuf_write(&to, uregs, sizeof(uregs));
+ }
+=20
+ enum m68k_regset {
+ 	REGSET_GPR,
+ #ifdef CONFIG_FPU
+ 	REGSET_FPU,
+ #endif
+ };
+=20
+ static const struct user_regset m68k_user_regsets[] =3D {
+ 	[REGSET_GPR] =3D {
+ 		.core_note_type =3D NT_PRSTATUS,
+ 		.n =3D ELF_NGREG,
+ 		.size =3D sizeof(u32),
+ 		.align =3D sizeof(u16),
+ 		.regset_get =3D m68k_regset_get,
+ 	},
+ #ifdef CONFIG_FPU
+ 	[REGSET_FPU] =3D {
+ 		.core_note_type =3D NT_PRFPREG,
+ 		.n =3D sizeof(struct user_m68kfp_struct) / sizeof(u32),
+ 		.size =3D sizeof(u32),
+ 		.align =3D sizeof(u32),
+ 	}
+ #endif /* CONFIG_FPU */
+ };
+=20
+ static const struct user_regset_view user_m68k_view =3D {
+ 	.name =3D "m68k",
+ 	.e_machine =3D EM_68K,
+ 	.ei_osabi =3D ELF_OSABI,
+ 	.regsets =3D m68k_user_regsets,
+ 	.n =3D ARRAY_SIZE(m68k_user_regsets)
+ };
+=20
+ const struct user_regset_view *task_user_regset_view(struct task_struct *=
task)
+ {
+ 	return &user_m68k_view;
+ }
+ #endif /* CONFIG_BINFMT_ELF_FDPIC && CONFIG_ELF_CORE */

--Sig_/vbD7UTZnh34VrwPfwmTliay
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ5p2oACgkQAVBC80lX
0GyTIgf+P3qOJktWHK43hMlsjb31iad0pr3XxwqHDx4UklSB3aVAho5keKErnoEv
vZbfDZ+Uh/+LU8QzLCJnCEzn68OTbRw00z3w3Z0a9W8Gsn7qm4DILbzbzIq2k8+7
w9VAgWLSh3cFsm1BCzAxFSYeCYiULmWGxQyJoA6IgmspireqPDg3C1l47UH8qbot
++MRO4Z47jVgmrhuuxwV8COgc9nookMuXWJCnUmmpraMohW3NxzZxR3oQuZJ0rH1
uMMdYINA1ppK1Nu5N7q0imBqfvxBuyQHiSLziPEnKcuCHgYFKIf4XTyxCEm/IMOo
0YvUvVW+AqDfyjVMM1kbB3oiGzX0DQ==
=LC/E
-----END PGP SIGNATURE-----

--Sig_/vbD7UTZnh34VrwPfwmTliay--
