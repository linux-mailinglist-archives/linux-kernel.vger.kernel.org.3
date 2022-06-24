Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D755055903A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 06:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiFXEoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 00:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiFXEoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 00:44:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 865DF53A58;
        Thu, 23 Jun 2022 21:44:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7563413D5;
        Thu, 23 Jun 2022 21:44:03 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.41.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AC2FD3F66F;
        Thu, 23 Jun 2022 21:43:55 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     hch@infradead.org, christophe.leroy@csgroup.eu,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        x86@kernel.org, openrisc@lists.librecores.org,
        linux-xtensa@linux-xtensa.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-um@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 01/26] mm/mmap: Build protect protection_map[] with __P000
Date:   Fri, 24 Jun 2022 10:13:14 +0530
Message-Id: <20220624044339.1533882-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220624044339.1533882-1-anshuman.khandual@arm.com>
References: <20220624044339.1533882-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build protect generic protection_map[] array with __P000, so that it can be
moved inside all the platforms one after the other. Otherwise there will be
build failures during this process. CONFIG_ARCH_HAS_VM_GET_PAGE_PROT cannot
be used for this purpose as only certain platforms enable this config now.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/mm.h | 2 ++
 mm/mmap.c          | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index bc8f326be0ce..47bfe038d46e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -424,7 +424,9 @@ extern unsigned int kobjsize(const void *objp);
  * mapping from the currently active vm_flags protection bits (the
  * low four bits) to a page protection mask..
  */
+#ifdef __P000
 extern pgprot_t protection_map[16];
+#endif
 
 /*
  * The default fault flags that should be used by most of the
diff --git a/mm/mmap.c b/mm/mmap.c
index 61e6135c54ef..b01f0280bda2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -101,6 +101,7 @@ static void unmap_region(struct mm_struct *mm,
  *								w: (no) no
  *								x: (yes) yes
  */
+#ifdef __P000
 pgprot_t protection_map[16] __ro_after_init = {
 	[VM_NONE]					= __P000,
 	[VM_READ]					= __P001,
@@ -119,6 +120,7 @@ pgprot_t protection_map[16] __ro_after_init = {
 	[VM_SHARED | VM_EXEC | VM_WRITE]		= __S110,
 	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= __S111
 };
+#endif
 
 #ifndef CONFIG_ARCH_HAS_VM_GET_PAGE_PROT
 pgprot_t vm_get_page_prot(unsigned long vm_flags)
-- 
2.25.1

