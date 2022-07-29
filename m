Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB0C58499C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 04:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbiG2CKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 22:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiG2CJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 22:09:58 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB30479EE4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1659060594;
        bh=eKojhGSrp5Nzdwbp8zmcNPFzO/9cxIKBEXrBgbRon5Q=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=INJrpYgHv2XlnNjM4pbSiZAbH0MW6V2t5UKFYKfWXk3q4ctNIAA15gp0axYAKqkI3
         xszjq0BkKPashPapR2nhymh8LpfgQxTKrhXNxpY/NUyPF+bku/oNdq36ScE8oh9TjE
         uwp21KUPp1dmVQZ1I9jsSwPPZSEVrqL/ijk9Re8U=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 2E83A65929;
        Thu, 28 Jul 2022 22:09:52 -0400 (EDT)
Message-ID: <4da7ce6a6e5b6d609c37ebf6815caacc3b3b8297.camel@xry111.site>
Subject: [PATCH v3 3/4] LoongArch: Remove -fplt and -Wa,-mla-* from CFLAGS
From:   Xi Ruoyao <xry111@xry111.site>
To:     loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Date:   Fri, 29 Jul 2022 10:09:51 +0800
In-Reply-To: <bb7824d39a694b13069718c2b8193379f79229b4.camel@xry111.site>
References: <bb7824d39a694b13069718c2b8193379f79229b4.camel@xry111.site>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-fplt is the default of all supported compilers (GCC, and maybe Clang in
the future), so it needs not to be explicitly specified.

-Wa,-mla-* options were used to prevent the assembler from generating
GOT accesses for "la.local" and "la.global" macros.  But GCC >=3D 13 will
generate GOT access explicitly without use of these macros, so these
options are ineffective for symbol addressing in C code with GCC >=3D 13.
Now we can handle GOT and GOT-based relocations properly, so we can
remove these options and use GOT access for both GCC 12 and 13
(or newer).

GAS <=3D 2.39 does not support "la.got [reg], [sym] + [offset]" with a
non-zero offset.  So in the assembly code we explicitly use "la.pcrel"
instead of "la" (now defaulted to "la.got") where a PC-relative
addressing is suitable, in order to work around this limitation and keep
the compatibility with old toolchains.

Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/loongarch/Makefile      |  4 ----
 arch/loongarch/kernel/head.S | 10 +++++-----
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index 039dcc4fe1f3..800349ea9310 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -40,10 +40,6 @@ endif
=20
 cflags-y			+=3D -G0 -pipe -msoft-float
 LDFLAGS_vmlinux			+=3D -G0 -static -n -nostdlib
-KBUILD_AFLAGS_KERNEL		+=3D -Wa,-mla-global-with-pcrel
-KBUILD_CFLAGS_KERNEL		+=3D -Wa,-mla-global-with-pcrel
-KBUILD_AFLAGS_MODULE		+=3D -Wa,-mla-global-with-abs
-KBUILD_CFLAGS_MODULE		+=3D -fplt -Wa,-mla-global-with-abs,-mla-local-with-=
abs
=20
 cflags-y +=3D -ffreestanding
 cflags-y +=3D $(call cc-option, -mno-check-zero-division)
diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
index 74ea7bf6c8d6..193329ed6e8c 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -60,17 +60,17 @@ SYM_CODE_START(kernel_entry)			# kernel entry point
 	la.abs		t0, 0f
 	jirl		zero, t0, 0
 0:
-	la		t0, __bss_start		# clear .bss
+	la.pcrel	t0, __bss_start		# clear .bss
 	st.d		zero, t0, 0
-	la		t1, __bss_stop - LONGSIZE
+	la.pcrel	t1, __bss_stop - LONGSIZE
 1:
 	addi.d		t0, t0, LONGSIZE
 	st.d		zero, t0, 0
 	bne		t0, t1, 1b
=20
-	la		t0, fw_arg0
+	la.pcrel	t0, fw_arg0
 	st.d		a0, t0, 0		# firmware arguments
-	la		t0, fw_arg1
+	la.pcrel	t0, fw_arg1
 	st.d		a1, t0, 0
=20
 	/* KSave3 used for percpu base, initialized as 0 */
@@ -78,7 +78,7 @@ SYM_CODE_START(kernel_entry)			# kernel entry point
 	/* GPR21 used for percpu base (runtime), initialized as 0 */
 	or		u0, zero, zero
=20
-	la		tp, init_thread_union
+	la.pcrel	tp, init_thread_union
 	/* Set the SP after an empty pt_regs.  */
 	PTR_LI		sp, (_THREAD_SIZE - 32 - PT_SIZE)
 	PTR_ADD		sp, sp, tp
--=20
2.37.0


