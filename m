Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BA2508B79
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358061AbiDTPFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354534AbiDTPFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:05:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE053EABD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:01:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5FD861856
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:01:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F551C385A1;
        Wed, 20 Apr 2022 15:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650466918;
        bh=2vIiY1L64BcyRyAV+vdLWojloBWckIp6ZU0kUPht5UU=;
        h=From:To:Cc:Subject:Date:From;
        b=DYTF+ijch4goHtfn6Rz5jPqeV+0zU6CH8r3wCjAM9kkyEXhq22MQWG/L9ryu31j82
         rnPJM+aLVuNJKZAUmXyxqFZhIrnWoHawjeuf5fAAVwpkGooaKvgjJ6wQgpDQMhhKpm
         Ul0JX2UVFTpRkhlv3esMcmP8IlNG39tnQB9n40NEnxWxcIjtmEjwXbfkFJup+6sLzX
         cZcAD/nBriBYgo8SdZi5nKU7eXe32KLpBQTt581FbU4ZngVdK5Bjp0Rd7FPU3+bVNv
         GfDUmF8A44gHAl1wAFX/+N97vo1WJuQSbVoC/QIuVHkQpDmHLFC9ftF3IOB3i8G77+
         Zx56gAEKoXayw==
From:   Mike Rapoport <rppt@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Kirill Shutemov <kirill.shutemov@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/mm/ptdump: display page encryption state
Date:   Wed, 20 Apr 2022 18:01:49 +0300
Message-Id: <20220420150149.1691573-1-rppt@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

When memory encryption is enabled, for instance in SEV guest, it is useful
to see what memory ranges are mapped as encrypted in the kernel page tables
and what ranges are left plain.

Add printing of 'ENC' for the encrypted ranges to the page table dumps.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---

v2: use cc_is_enc() instead of _PAGE_ENC as Dave suggested for TDX
compatibility

 arch/x86/include/asm/coco.h   | 10 ++++++++++
 arch/x86/mm/dump_pagetables.c |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/coco.h b/arch/x86/include/asm/coco.h
index 3d98c3a60d34..cfc85a080a22 100644
--- a/arch/x86/include/asm/coco.h
+++ b/arch/x86/include/asm/coco.h
@@ -17,6 +17,11 @@ void cc_set_mask(u64 mask);
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
 u64 cc_mkenc(u64 val);
 u64 cc_mkdec(u64 val);
+
+static inline bool cc_is_enc(u64 prot)
+{
+	return cc_mkdec(prot) != prot;
+}
 #else
 static inline u64 cc_mkenc(u64 val)
 {
@@ -27,6 +32,11 @@ static inline u64 cc_mkdec(u64 val)
 {
 	return val;
 }
+
+static inline bool cc_is_enc(u64 prot)
+{
+	return false;
+}
 #endif
 
 #endif /* _ASM_X86_COCO_H */
diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index e1b599ecbbc2..0eaa0cc0b3b1 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -201,6 +201,10 @@ static void printk_prot(struct seq_file *m, pgprotval_t pr, int level, bool dmsg
 			pt_dump_cont_printf(m, dmsg, "PCD ");
 		else
 			pt_dump_cont_printf(m, dmsg, "    ");
+		if (cc_is_enc(pr))
+			pt_dump_cont_printf(m, dmsg, "ENC ");
+		else
+			pt_dump_cont_printf(m, dmsg, "    ");
 
 		/* Bit 7 has a different meaning on level 3 vs 4 */
 		if (level <= 3 && pr & _PAGE_PSE)

base-commit: b2d229d4ddb17db541098b83524d901257e93845
-- 
2.34.1

