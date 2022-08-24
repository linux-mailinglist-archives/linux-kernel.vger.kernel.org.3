Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F364559FE31
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238326AbiHXPYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiHXPY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:24:29 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356DC98D0F;
        Wed, 24 Aug 2022 08:24:28 -0700 (PDT)
Received: from zn.tnic (p200300ea971b9859329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:9859:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8E96D1EC050F;
        Wed, 24 Aug 2022 17:24:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1661354666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=Ci0U3F3izy2V+8BAKmp3jJpbmsFnaxCYTLleVjbaD3w=;
        b=V+eE5qce1FU2RQE9Z8ksj0+iFMNDlADHMzVGM0Au/bypbrhDQaNYEE9yO0zg1hDaJdDkDI
        P8j2zxEMfNIOkblUsNEsj9SHBfcxjefzt+FPfLKJ0kwetKC3YeIaIqIwOj6Iv9jXFbb8gr
        pdndUxo+LElH47iBoO6nrhYON/kJ9kU=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Michael Matz <matz@suse.de>, linux-toolchains@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/sev: Mark snp_abort() noreturn
Date:   Wed, 24 Aug 2022 17:24:20 +0200
Message-Id: <20220824152420.20547-1-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Mark both the function prototype and definition as noreturn in order to
prevent the compiler from doing transformations which confuse objtool
like so:

  vmlinux.o: warning: objtool: sme_enable+0x71: unreachable instruction

This triggers with gcc-12.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/sev.h | 2 +-
 arch/x86/kernel/sev.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 4a23e52fe0ee..ebc271bb6d8e 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -195,7 +195,7 @@ void snp_set_memory_shared(unsigned long vaddr, unsigned int npages);
 void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
-void snp_abort(void);
+void __init __noreturn snp_abort(void);
 int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *fw_err);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 4f84c3f11af5..a428c62330d3 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2112,7 +2112,7 @@ bool __init snp_init(struct boot_params *bp)
 	return true;
 }
 
-void __init snp_abort(void)
+void __init __noreturn snp_abort(void)
 {
 	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 }
-- 
2.35.1

