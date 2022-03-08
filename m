Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEC14D2465
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 23:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350778AbiCHWg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 17:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241131AbiCHWgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 17:36:24 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCE6593A0;
        Tue,  8 Mar 2022 14:35:25 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KCqsR3pKQz4xv3;
        Wed,  9 Mar 2022 09:35:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646778923;
        bh=MMCKyxgyWkiOwcgLDRKWqBD3CwHy7EOwypYeKOivHzI=;
        h=Date:From:To:Cc:Subject:From;
        b=jnP5Y0wUrSVsSArWRhW4d8RdwhJO7kOQBTxjTZSiTl1swQxwyE/Od9T+y1ERQXkyQ
         XQskNOCPEDHgNX3QP2EJlf/2gHzle/Xr5H0GV0RRhL91p2lUJAvdcl/tlWhMojGXX7
         CzERCIJpjxHymk8XKdwhsG/ulY+ue9U3xahblcTFJg7QpbrAsC1nuuqNNMw9aNY490
         gfuGMxUhQrIaSDwIMDJYg2HAPxS5kIYrXsWOiF9z/GaFj6B8G3HX0qPG5k1JOuYGfi
         SxCS8GHFQZym3WlA+sD7Gv8PGxTDy3op8gE+6HcMSwb3PFk5t7mXVcl5hnZWU65PRC
         /hP5qJiIUl73g==
Date:   Wed, 9 Mar 2022 09:35:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: linux-next: manual merge of the arm tree with Linus' tree
Message-ID: <20220309093519.4a9026a7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kjE=kqQ__xA+59aEWtywkIL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kjE=kqQ__xA+59aEWtywkIL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the arm tree got a conflict in:

  arch/arm/kernel/traps.c

between commit:

  04e91b732476 ("ARM: early traps initialisation")

from Linus' tree and commits:

  a1c510d0adc6 ("ARM: implement support for vmap'ed stacks")
  d31e23aff011 ("ARM: mm: make vmalloc_seq handling SMP safe")

from the arm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm/kernel/traps.c
index 5d58aee24087,2dec6944e5dd..000000000000
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@@ -878,5 -840,72 +893,72 @@@ void __init early_trap_init(void *vecto
  	 * memory area. The address is configurable and so a table in the kernel
  	 * image can be used.
  	 */
 -#endif
  }
 +#endif
+=20
+ #ifdef CONFIG_VMAP_STACK
+=20
+ DECLARE_PER_CPU(u8 *, irq_stack_ptr);
+=20
+ asmlinkage DEFINE_PER_CPU(u8 *, overflow_stack_ptr);
+=20
+ static int __init allocate_overflow_stacks(void)
+ {
+ 	u8 *stack;
+ 	int cpu;
+=20
+ 	for_each_possible_cpu(cpu) {
+ 		stack =3D (u8 *)__get_free_page(GFP_KERNEL);
+ 		if (WARN_ON(!stack))
+ 			return -ENOMEM;
+ 		per_cpu(overflow_stack_ptr, cpu) =3D &stack[OVERFLOW_STACK_SIZE];
+ 	}
+ 	return 0;
+ }
+ early_initcall(allocate_overflow_stacks);
+=20
+ asmlinkage void handle_bad_stack(struct pt_regs *regs)
+ {
+ 	unsigned long tsk_stk =3D (unsigned long)current->stack;
+ #ifdef CONFIG_IRQSTACKS
+ 	unsigned long irq_stk =3D (unsigned long)this_cpu_read(irq_stack_ptr);
+ #endif
+ 	unsigned long ovf_stk =3D (unsigned long)this_cpu_read(overflow_stack_pt=
r);
+=20
+ 	console_verbose();
+ 	pr_emerg("Insufficient stack space to handle exception!");
+=20
+ 	pr_emerg("Task stack:     [0x%08lx..0x%08lx]\n",
+ 		 tsk_stk, tsk_stk + THREAD_SIZE);
+ #ifdef CONFIG_IRQSTACKS
+ 	pr_emerg("IRQ stack:      [0x%08lx..0x%08lx]\n",
+ 		 irq_stk - THREAD_SIZE, irq_stk);
+ #endif
+ 	pr_emerg("Overflow stack: [0x%08lx..0x%08lx]\n",
+ 		 ovf_stk - OVERFLOW_STACK_SIZE, ovf_stk);
+=20
+ 	die("kernel stack overflow", regs, 0);
+ }
+=20
+ #ifndef CONFIG_ARM_LPAE
+ /*
+  * Normally, we rely on the logic in do_translation_fault() to update sta=
le PMD
+  * entries covering the vmalloc space in a task's page tables when it fir=
st
+  * accesses the region in question. Unfortunately, this is not sufficient=
 when
+  * the task stack resides in the vmalloc region, as do_translation_fault(=
) is a
+  * C function that needs a stack to run.
+  *
+  * So we need to ensure that these PMD entries are up to date *before* th=
e MM
+  * switch. As we already have some logic in the MM switch path that takes=
 care
+  * of this, let's trigger it by bumping the counter every time the core v=
malloc
+  * code modifies a PMD entry in the vmalloc region. Use release semantics=
 on
+  * the store so that other CPUs observing the counter's new value are
+  * guaranteed to see the updated page table entries as well.
+  */
+ void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
+ {
+ 	if (start < VMALLOC_END && end > VMALLOC_START)
+ 		atomic_inc_return_release(&init_mm.context.vmalloc_seq);
+ }
+ #endif
+ #endif

--Sig_/kjE=kqQ__xA+59aEWtywkIL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIn2icACgkQAVBC80lX
0GzCIwf+KOy+sm0cOp7p1IYxKIBypyKiIk8Zctdz9iMfpLn63wAFfjiq/q51ABlU
RBU/ny5BBQ57arkCYnhjNt6RiS8qm3362vnmn6Fst3NAOHKLfuq0YTy6xLaM9/Qh
FE3e6SSzZctNm/Jy7svmpdYKnBXxHRUxM4NjGvR91O7CDrA7YGkhPI8hxc5tihuF
q8H1sE13idst6AqV48ScHjoTiIIKpTIU3cKibiJX/R6yWS/ycWJ3hr2KeYaDAl+7
q4Y9QNjivAna4l9PAlXK2AxcyDAQds5R26e0DE/sC8AHkqpZt0qvL4HKuAfhx9Zb
ZtcQpc1o5T6bRzpWB6/2R3ViYPKg4A==
=iCiu
-----END PGP SIGNATURE-----

--Sig_/kjE=kqQ__xA+59aEWtywkIL--
