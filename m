Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87DD5A4E3F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiH2NfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiH2NfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:35:19 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132904DB7A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1661780115;
        bh=TwdAnZTgoj4EYEJwsRSSBSF3le/kWOA9MA+6UkrMJuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gPriV1snZWAJnOMBQq3lW6JNaPqN66GxTiKaq8D6a7q+9clLZ+x/AOWezXdsBluAB
         u7XrsElOvTmUXqxuDD4peuLrcadeobkIb2/ndMK8jwsUYSV9ksdsiVre8BEMEQuKo1
         puenuWwYkUxIvNDjV66pnQGz7q79LpdYuHDIXIfg=
Received: from xry111-x57s1.. (unknown [IPv6:240e:358:11dd:1900:dc73:854d:832e:5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id A7BF866905;
        Mon, 29 Aug 2022 09:35:09 -0400 (EDT)
From:   Xi Ruoyao <xry111@xry111.site>
To:     loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v6 3/6] LoongArch: Use model("extreme") attribute for per-CPU variables in module if CONFIG_AS_HAS_EXPLICIT_RELOCS
Date:   Mon, 29 Aug 2022 21:31:43 +0800
Message-Id: <20220829133146.15236-4-xry111@xry111.site>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220829133146.15236-1-xry111@xry111.site>
References: <20220829133146.15236-1-xry111@xry111.site>
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

On LoongArch, The "address" of a per-CPU variable symbol is actually an
offset from $r21.  The value is nearing the loading address of main
kernel image, but far from the address of modules.  We need to tell the
compiler that a PC-relative addressing with 32-bit offset is not
sufficient for local per-CPU variables.

After some discussion with GCC maintainers, we implemented this
attribute to indicate that a PC-relative addressing with 64-bit offset
should be used.

This attribute should be available in GCC 13 release.  Some early GCC 13
snapshots may support -mexplicit-relocs but lack this attribute, we
simply reject them.

Signed-off-by: Xi Ruoyao <xry111@xry111.site>
Link: https://gcc.gnu.org/r13-2199
---
 arch/loongarch/Makefile             | 3 +++
 arch/loongarch/include/asm/percpu.h | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index 1563747c4fa8..593818a61741 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -53,6 +53,9 @@ LDFLAGS_vmlinux			+= -G0 -static -n -nostdlib
 # combination of a "new" assembler and "old" compiler is not supported.  Either
 # upgrade the compiler or downgrade the assembler.
 ifdef CONFIG_AS_HAS_EXPLICIT_RELOCS
+ifeq ($(shell echo '__has_attribute(model)' | $(CC) -E -P - 2> /dev/null), 0)
+$(error "C compiler must support model attribute if using explicit relocs")
+endif
 cflags-y			+= -mexplicit-relocs
 else
 cflags-y			+= $(call cc-option,-mno-explicit-relocs)
diff --git a/arch/loongarch/include/asm/percpu.h b/arch/loongarch/include/asm/percpu.h
index 0bd6b0110198..dd7fcc553efa 100644
--- a/arch/loongarch/include/asm/percpu.h
+++ b/arch/loongarch/include/asm/percpu.h
@@ -8,6 +8,14 @@
 #include <asm/cmpxchg.h>
 #include <asm/loongarch.h>
 
+#if defined(MODULE) && defined(CONFIG_AS_HAS_EXPLICIT_RELOCS)
+/* The "address" (in fact, offset from $r21) of a per-CPU variable is close
+ * to the load address of main kernel image, but far from where the modules are
+ * loaded.  Tell the compiler this fact.
+ */
+# define PER_CPU_ATTRIBUTES __attribute__((model("extreme")))
+#endif
+
 /* Use r21 for fast access */
 register unsigned long __my_cpu_offset __asm__("$r21");
 
-- 
2.37.0

