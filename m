Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273784FF82D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 15:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbiDMNw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 09:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235949AbiDMNwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 09:52:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628AF26571
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:49:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E752361943
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4ADC385A3;
        Wed, 13 Apr 2022 13:49:55 +0000 (UTC)
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
Subject: [PATCH RFC 2/4] mm, personality: Implement memory-deny-write-execute as a personality flag
Date:   Wed, 13 Apr 2022 14:49:44 +0100
Message-Id: <20220413134946.2732468-3-catalin.marinas@arm.com>
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

The aim of such policy is to prevent a user task from inadvertently
creating an executable mapping that is or was writeable (and
subsequently made read-only).

An example of mmap() returning -EACCESS if the policy is enabled:

	mmap(0, size, PROT_READ | PROT_WRITE | PROT_EXEC, flags, 0, 0);

Similarly, mprotect() would return -EACCESS below:

	addr = mmap(0, size, PROT_READ | PROT_EXEC, flags, 0, 0);
	mprotect(addr, size, PROT_READ | PROT_WRITE | PROT_EXEC);

With the past vma writeable permission tracking, mprotect() below would
also fail with -EACCESS:

	addr = mmap(0, size, PROT_READ | PROT_WRITE, flags, 0, 0);
	mprotect(addr, size, PROT_READ | PROT_EXEC);

While the above could be achieved by checking PROT_WRITE & PROT_EXEC on
mmap/mprotect and denying mprotect(PROT_EXEC) altogether (current
systemd MDWE approach via SECCOMP BPF filters), we want the following
scenario to succeed:

	addr = mmap(0, size, PROT_READ | PROT_EXEC, flags, 0, 0);
	mprotect(addr, size, PROT_READ | PROT_EXEC | PROT_BTI);

where PROT_BTI enables branch tracking identification on arm64.

The choice for a DENY_WRITE_EXEC personality flag, inherited on fork()
and execve(), was made by analogy to READ_IMPLIES_EXEC.

Note that it is sufficient to check for VM_WAS_WRITE in
map_deny_write_exec() as this flag is always set on VM_WRITE mappings.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/mman.h             | 10 ++++++++++
 include/uapi/linux/personality.h |  1 +
 mm/mmap.c                        |  3 +++
 mm/mprotect.c                    |  5 +++++
 4 files changed, 19 insertions(+)

diff --git a/include/linux/mman.h b/include/linux/mman.h
index 2d841ddae2aa..17e91a1bdfb3 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -166,4 +166,14 @@ calc_vm_flag_bits(unsigned long flags)
 }
 
 unsigned long vm_commit_limit(void);
+
+static inline bool map_deny_write_exec(unsigned long vm_flags)
+{
+	if (IS_ENABLED(CONFIG_ARCH_ENABLE_DENY_WRITE_EXEC) &&
+	    (current->personality & DENY_WRITE_EXEC) &&
+	    (vm_flags & VM_EXEC) && (vm_flags & VM_WAS_WRITE))
+		return true;
+	return false;
+}
+
 #endif /* _LINUX_MMAN_H */
diff --git a/include/uapi/linux/personality.h b/include/uapi/linux/personality.h
index 49796b7756af..c8d924be3dcd 100644
--- a/include/uapi/linux/personality.h
+++ b/include/uapi/linux/personality.h
@@ -22,6 +22,7 @@ enum {
 	WHOLE_SECONDS =		0x2000000,
 	STICKY_TIMEOUTS	=	0x4000000,
 	ADDR_LIMIT_3GB = 	0x8000000,
+	DENY_WRITE_EXEC =	0x10000000,
 };
 
 /*
diff --git a/mm/mmap.c b/mm/mmap.c
index 3aa839f81e63..8e894270a80e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1579,6 +1579,9 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 			vm_flags |= VM_NORESERVE;
 	}
 
+	if (map_deny_write_exec(vm_flags))
+		return -EACCES;
+
 	addr = mmap_region(file, addr, len, vm_flags, pgoff, uf);
 	if (!IS_ERR_VALUE(addr) &&
 	    ((vm_flags & VM_LOCKED) ||
diff --git a/mm/mprotect.c b/mm/mprotect.c
index b69ce7a7b2b7..ff0d13a4c1ed 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -627,6 +627,11 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 			goto out;
 		}
 
+		if (map_deny_write_exec(newflags)) {
+			error = -EACCES;
+			goto out;
+		}
+
 		/* Allow architectures to sanity-check the new flags */
 		if (!arch_validate_flags(newflags)) {
 			error = -EINVAL;
