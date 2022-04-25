Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A124450E435
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbiDYPVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbiDYPVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:21:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3D6B6E4B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:18:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5225B60E06
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 15:18:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7E6C385A7;
        Mon, 25 Apr 2022 15:18:35 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Machado <luis.machado@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>
Subject: [PATCH] elf: Fix the arm64 MTE ELF segment name and value
Date:   Mon, 25 Apr 2022 16:18:33 +0100
Message-Id: <20220425151833.2603830-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately, the name/value choice for the MTE ELF segment type
(PT_ARM_MEMTAG_MTE) was pretty poor: LOPROC+1 is already in use by
PT_AARCH64_UNWIND, as defined in the AArch64 ELF ABI
(https://github.com/ARM-software/abi-aa/blob/main/aaelf64/aaelf64.rst).

Update the ELF segment type value to LOPROC+2 and also change the define
to PT_AARCH64_MEMTAG_MTE to match the AArch64 ELF ABI namespace. The
AArch64 ELF ABI document is updating accordingly (segment type not
previously mentioned in the document).

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Fixes: 761b9b366cec ("elf: Introduce the ARM MTE ELF segment type")
Cc: Will Deacon <will@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Luis Machado <luis.machado@arm.com>
Cc: Richard Earnshaw <Richard.Earnshaw@arm.com>
---

Luckily, the commit being fixed here only went in for 5.18-rc1, so there is no
ABI change in a mainline release.

FYI, the corresponding pull request for the AArch64 ELF ABI:

https://github.com/ARM-software/abi-aa/pull/148

I don't expect any further change to the segment name/value.

 Documentation/arm64/memory-tagging-extension.rst | 4 ++--
 arch/arm64/kernel/elfcore.c                      | 2 +-
 include/uapi/linux/elf.h                         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/arm64/memory-tagging-extension.rst b/Documentation/arm64/memory-tagging-extension.rst
index dd27f78d7608..dbae47bba25e 100644
--- a/Documentation/arm64/memory-tagging-extension.rst
+++ b/Documentation/arm64/memory-tagging-extension.rst
@@ -228,10 +228,10 @@ Core dump support
 -----------------
 
 The allocation tags for user memory mapped with ``PROT_MTE`` are dumped
-in the core file as additional ``PT_ARM_MEMTAG_MTE`` segments. The
+in the core file as additional ``PT_AARCH64_MEMTAG_MTE`` segments. The
 program header for such segment is defined as:
 
-:``p_type``: ``PT_ARM_MEMTAG_MTE``
+:``p_type``: ``PT_AARCH64_MEMTAG_MTE``
 :``p_flags``: 0
 :``p_offset``: segment file offset
 :``p_vaddr``: segment virtual address, same as the corresponding
diff --git a/arch/arm64/kernel/elfcore.c b/arch/arm64/kernel/elfcore.c
index 2b3f3d0544b9..98d67444a5b6 100644
--- a/arch/arm64/kernel/elfcore.c
+++ b/arch/arm64/kernel/elfcore.c
@@ -95,7 +95,7 @@ int elf_core_write_extra_phdrs(struct coredump_params *cprm, loff_t offset)
 	for_each_mte_vma(current, vma) {
 		struct elf_phdr phdr;
 
-		phdr.p_type = PT_ARM_MEMTAG_MTE;
+		phdr.p_type = PT_AARCH64_MEMTAG_MTE;
 		phdr.p_offset = offset;
 		phdr.p_vaddr = vma->vm_start;
 		phdr.p_paddr = 0;
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 787c657bfae8..7ce993e6786c 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -42,7 +42,7 @@ typedef __s64	Elf64_Sxword;
 
 
 /* ARM MTE memory tag segment type */
-#define PT_ARM_MEMTAG_MTE	(PT_LOPROC + 0x1)
+#define PT_AARCH64_MEMTAG_MTE	(PT_LOPROC + 0x2)
 
 /*
  * Extended Numbering
