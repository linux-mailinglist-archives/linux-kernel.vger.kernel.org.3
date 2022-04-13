Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C58B4FF82B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 15:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbiDMNwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 09:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiDMNwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 09:52:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967441FCFF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:49:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4177AB824C8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDBAC385A6;
        Wed, 13 Apr 2022 13:49:51 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lennart Poettering <lennart@poettering.net>,
        =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Cc:     Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Topi Miettinen <toiwoton@gmail.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-abi-devel@lists.sourceforge.net
Subject: [PATCH RFC 1/4] mm: Track previously writeable vma permission
Date:   Wed, 13 Apr 2022 14:49:43 +0100
Message-Id: <20220413134946.2732468-2-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220413134946.2732468-1-catalin.marinas@arm.com>
References: <20220413134946.2732468-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support a memory-deny-write-execute policy for mprotect()
and prevent a previously writeable mapping from being made executable,
track the past VM_WRITE permission via a new VM_WAS_WRITE flag that is
not cleared on permission change.

VM_WAS_WRITE is a high VMA flag and since not all architectures may want
this feature, only define it if CONFIG_ARCH_ENABLE_DENY_WRITE_EXEC is
selected, otherwise it is VM_NONE (zero).

Note that the new VM_WAS_WRITE flag would prevent merging of an always
read-only vma with a previously writeable vma that was made read-only. I
don't consider this a common case and even if we somehow allow such
merging, it would be confusing for the user if a read-only vma inherits
a VM_WAS_WRITE flag or the VM_WAS_WRITE flag is dropped.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/mm.h   | 6 ++++++
 include/linux/mman.h | 8 +++++++-
 mm/Kconfig           | 4 ++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e34edb775334..bec37abc0773 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -317,6 +317,12 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
 #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
 
+#ifdef CONFIG_ARCH_ENABLE_DENY_WRITE_EXEC
+#define VM_WAS_WRITE		BIT(37)	/* only with ARCH_USES_HIGH_VMA_FLAGS */
+#else
+#define VM_WAS_WRITE		VM_NONE
+#endif
+
 #ifdef CONFIG_ARCH_HAS_PKEYS
 # define VM_PKEY_SHIFT	VM_HIGH_ARCH_BIT_0
 # define VM_PKEY_BIT0	VM_HIGH_ARCH_0	/* A protection key is a 4-bit value */
diff --git a/include/linux/mman.h b/include/linux/mman.h
index b66e91b8176c..2d841ddae2aa 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -141,10 +141,16 @@ static inline bool arch_validate_flags(unsigned long flags)
 static inline unsigned long
 calc_vm_prot_bits(unsigned long prot, unsigned long pkey)
 {
-	return _calc_vm_trans(prot, PROT_READ,  VM_READ ) |
+	unsigned long vm_flags =
+	       _calc_vm_trans(prot, PROT_READ,  VM_READ ) |
 	       _calc_vm_trans(prot, PROT_WRITE, VM_WRITE) |
 	       _calc_vm_trans(prot, PROT_EXEC,  VM_EXEC) |
 	       arch_calc_vm_prot_bits(prot, pkey);
+
+	if (vm_flags & VM_WRITE)
+		vm_flags |= VM_WAS_WRITE;
+
+	return vm_flags;
 }
 
 /*
diff --git a/mm/Kconfig b/mm/Kconfig
index 034d87953600..f140109f2a1e 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -822,6 +822,10 @@ config ARCH_USES_HIGH_VMA_FLAGS
 config ARCH_HAS_PKEYS
 	bool
 
+config ARCH_ENABLE_DENY_WRITE_EXEC
+	bool
+	depends on ARCH_USES_HIGH_VMA_FLAGS
+
 config PERCPU_STATS
 	bool "Collect percpu memory statistics"
 	help
