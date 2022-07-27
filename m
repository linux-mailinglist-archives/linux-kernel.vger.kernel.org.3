Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825D4582C1E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 18:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239616AbiG0QmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 12:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239238AbiG0Qli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 12:41:38 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F1E5B783
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1658939381;
        bh=5uWlBqSdy2RPXpPwAJasX2ffP9FsCCAt1xQrucd15uE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OpQy5wSbA7dWTR3bn656uDvmG/mlT/P6ZI96Voa5qTeK1Vq4TWpncb5MS+OaJX+mz
         1XQ0HhQ+DX1OP+BOznPPVsBVcB2raCCtbmA4XY1/CS2PZW6Agv/tj+ujn2wV8rdrks
         ndK8/A+E1blc08HcrDtXY/pHtkmPR+sB3UUeDcv0=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 40DDD66986;
        Wed, 27 Jul 2022 12:29:39 -0400 (EDT)
Message-ID: <4f09c81c22d0a16883a6914a8f7209957386c07c.camel@xry111.site>
Subject: [PATCH 4/5] LoongArch: Stop using undocumented assembler options
From:   Xi Ruoyao <xry111@xry111.site>
To:     loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 28 Jul 2022 00:29:38 +0800
In-Reply-To: <385f63bcbee8e37c42f479ce9cdc7e7d731d419b.camel@xry111.site>
References: <385f63bcbee8e37c42f479ce9cdc7e7d731d419b.camel@xry111.site>
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

Now we can handle GOT and GOT-based relocations properly, remove the
undocumented `-Wa,-mla-{global,local}-with-{pcrel,abs}` assembler hacks.

Adjust assembly code to explicitly use "la.pcrel" where necessary.

Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/loongarch/Makefile      |  5 +----
 arch/loongarch/kernel/head.S | 10 +++++-----
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index 039dcc4fe1f3..9552c7880d34 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -40,10 +40,7 @@ endif
=20
 cflags-y			+=3D -G0 -pipe -msoft-float
 LDFLAGS_vmlinux			+=3D -G0 -static -n -nostdlib
-KBUILD_AFLAGS_KERNEL		+=3D -Wa,-mla-global-with-pcrel
-KBUILD_CFLAGS_KERNEL		+=3D -Wa,-mla-global-with-pcrel
-KBUILD_AFLAGS_MODULE		+=3D -Wa,-mla-global-with-abs
-KBUILD_CFLAGS_MODULE		+=3D -fplt -Wa,-mla-global-with-abs,-mla-local-with-=
abs
+KBUILD_CFLAGS_MODULE		+=3D -fplt
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


