Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4505A3959
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 19:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiH0R4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 13:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiH0R4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 13:56:00 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6B4E1A8B
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 10:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1661622945;
        bh=YGYJfp6hCx6eH/Nfs4eCDr4R+EBIr89AN05AxFZ+kgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YfmnvIQhShxhFIXVDAToyJ1ELWZL6QeJ2yG/WcjvdQMttr3TJG0L2yuIPNe7LpV6I
         5lUzVvu8gddgVi3Hx8by36u0fpLbY4swYaZO442keZQYcwb99WzXFbnP6tVXqoC6v7
         Sv83fJxeO4H0BPiv58PAQL2AfqynQATsXTUqo7is=
Received: from xry111-x57s1.. (unknown [IPv6:240e:358:1157:dc00:dc73:854d:832e:4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id B3FEB667FF;
        Sat, 27 Aug 2022 13:55:39 -0400 (EDT)
From:   Xi Ruoyao <xry111@xry111.site>
To:     loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH 3/8] LoongArch: Define ELF relocation types added in v2.00 ABI
Date:   Sun, 28 Aug 2022 01:54:31 +0800
Message-Id: <20220827175436.156464-4-xry111@xry111.site>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220827175436.156464-1-xry111@xry111.site>
References: <20220827175436.156464-1-xry111@xry111.site>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These relocation types are used by GNU binutils >= 2.40 and GCC >= 13.
Add their definitions so we will be able to use them in later patches.

Link: https://github.com/loongson/LoongArch-Documentation/pull/57
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/loongarch/include/asm/elf.h | 37 ++++++++++++++++++++++++++++++++
 arch/loongarch/kernel/module.c   |  2 +-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/elf.h b/arch/loongarch/include/asm/elf.h
index 5f3ff4781fda..7af0cebf28d7 100644
--- a/arch/loongarch/include/asm/elf.h
+++ b/arch/loongarch/include/asm/elf.h
@@ -74,6 +74,43 @@
 #define R_LARCH_SUB64				56
 #define R_LARCH_GNU_VTINHERIT			57
 #define R_LARCH_GNU_VTENTRY			58
+#define R_LARCH_B16				64
+#define R_LARCH_B21				65
+#define R_LARCH_B26				66
+#define R_LARCH_ABS_HI20			67
+#define R_LARCH_ABS_LO12			68
+#define R_LARCH_ABS64_LO20			69
+#define R_LARCH_ABS64_HI12			70
+#define R_LARCH_PCALA_HI20			71
+#define R_LARCH_PCALA_LO12			72
+#define R_LARCH_PCALA64_LO20			73
+#define R_LARCH_PCALA64_HI12			74
+#define R_LARCH_GOT_PC_HI20			75
+#define R_LARCH_GOT_PC_LO12			76
+#define R_LARCH_GOT64_PC_LO20			77
+#define R_LARCH_GOT64_PC_HI12			78
+#define R_LARCH_GOT_HI20			79
+#define R_LARCH_GOT_LO12			80
+#define R_LARCH_GOT64_LO20			81
+#define R_LARCH_GOT64_HI12			82
+#define R_LARCH_TLS_LE_HI20			83
+#define R_LARCH_TLS_LE_LO12			84
+#define R_LARCH_TLS_LE64_LO20			85
+#define R_LARCH_TLS_LE64_HI12			86
+#define R_LARCH_TLS_IE_PC_HI20			87
+#define R_LARCH_TLS_IE_PC_LO12			88
+#define R_LARCH_TLS_IE64_PC_LO20		89
+#define R_LARCH_TLS_IE64_PC_HI12		90
+#define R_LARCH_TLS_IE_HI20			91
+#define R_LARCH_TLS_IE_LO12			92
+#define R_LARCH_TLS_IE64_LO20			93
+#define R_LARCH_TLS_IE64_HI12			94
+#define R_LARCH_TLS_LD_PC_HI20			95
+#define R_LARCH_TLS_LD_HI20			96
+#define R_LARCH_TLS_GD_PC_HI20			97
+#define R_LARCH_TLS_GD_HI20			98
+#define R_LARCH_32_PCREL			99
+#define R_LARCH_RELAX				100
 
 #ifndef ELF_ARCH
 
diff --git a/arch/loongarch/kernel/module.c b/arch/loongarch/kernel/module.c
index 638427ff0d51..755d91ef8d85 100644
--- a/arch/loongarch/kernel/module.c
+++ b/arch/loongarch/kernel/module.c
@@ -296,7 +296,7 @@ typedef int (*reloc_rela_handler)(struct module *mod, u32 *location, Elf_Addr v,
 
 /* The handlers for known reloc types */
 static reloc_rela_handler reloc_rela_handlers[] = {
-	[R_LARCH_NONE ... R_LARCH_SUB64]		     = apply_r_larch_error,
+	[R_LARCH_NONE ... R_LARCH_RELAX]		     = apply_r_larch_error,
 
 	[R_LARCH_NONE]					     = apply_r_larch_none,
 	[R_LARCH_32]					     = apply_r_larch_32,
-- 
2.37.0

