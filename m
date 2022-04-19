Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F0B5070B0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353469AbiDSOik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353415AbiDSOig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:38:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836ED20182
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:35:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D75FE61309
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:35:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FCCC385A7;
        Tue, 19 Apr 2022 14:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650378953;
        bh=LjnCyPNtQJfDI+l6n9Xmrfv8Jamh27OH0gnhsfJepDU=;
        h=From:To:Cc:Subject:Date:From;
        b=d/Ddy8+ytbjKCXwmjOTe9ZVtxYuKFlhiaRbjrBpaxcElVYaLRZie/krzQweTwKPib
         YjzvrbakQJeCts9q/zUCINqx9dBrOURa2mhiKBMKM/Afo7CYRAYxZuZ9Bynf6mD7+e
         zyRkwN0Ap4hpme8eglcRm7SMCYuhl6cmT29T+hUphEkI1Lh6Kcgs6W8O2mFuZ1hMLc
         1OyxiEmwOry88qusIa7oJ1Y1vZIieaaaB5c2OcAqkdN2DR4Uanz9RspQE/M13Tpu/7
         tqDm5n9YjJ3EUgE+pKcWAxftjQckb9lieli7Bov0ZN0NtfKKAulr2R80Ap/2AOrxI3
         RNhRxm2aR5DTw==
From:   Mike Rapoport <rppt@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/mm/ptdump: display page encryption state
Date:   Tue, 19 Apr 2022 17:35:45 +0300
Message-Id: <20220419143545.30295-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 arch/x86/mm/dump_pagetables.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index e1b599ecbbc2..187dd17b8780 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -201,6 +201,10 @@ static void printk_prot(struct seq_file *m, pgprotval_t pr, int level, bool dmsg
 			pt_dump_cont_printf(m, dmsg, "PCD ");
 		else
 			pt_dump_cont_printf(m, dmsg, "    ");
+		if (pr & _PAGE_ENC)
+			pt_dump_cont_printf(m, dmsg, "ENC ");
+		else
+			pt_dump_cont_printf(m, dmsg, "    ");
 
 		/* Bit 7 has a different meaning on level 3 vs 4 */
 		if (level <= 3 && pr & _PAGE_PSE)

base-commit: b2d229d4ddb17db541098b83524d901257e93845
-- 
2.28.0

