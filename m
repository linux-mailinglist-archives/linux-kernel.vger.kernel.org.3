Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EC44E68C7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 19:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352741AbiCXSi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 14:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243007AbiCXShv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 14:37:51 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490FCB8212
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 11:36:19 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E6D5A1EC064D;
        Thu, 24 Mar 2022 19:36:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1648146978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FHbaewdQrmtEVCXaKAQngIcqqKfzYTCQIr5noHjEhwM=;
        b=NZrEyS+hazxucQY4zq1BgShVdzf5yEFH2pdw2yrmHJAzTQHj0cTRYz2Reh4890QrPkCQYg
        1W7xD71pSS1TvJLiPhsCJ1fNNUXBIUrOJ39zel54gDN1Zrg/Rcg27b3DQPa/CI2lhSLKxq
        0PCwwXeWS8E4jZYYpsVLd2hwVp9pDzI=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] task_stack, x86/cea: Force-inline stack helpers
Date:   Thu, 24 Mar 2022 19:36:05 +0100
Message-Id: <20220324183607.31717-2-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220324183607.31717-1-bp@alien8.de>
References: <20220324183607.31717-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Force-inline two stack helpers to fix the following objtool warnings:

  vmlinux.o: warning: objtool: in_task_stack()+0xc: call to task_stack_page() leaves .noinstr.text section
  vmlinux.o: warning: objtool: in_entry_stack()+0x10: call to cpu_entry_stack() leaves .noinstr.text section

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/cpu_entry_area.h | 2 +-
 include/linux/sched/task_stack.h      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
index dd5ea1bdf04c..75efc4c6f076 100644
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -143,7 +143,7 @@ extern void cea_set_pte(void *cea_vaddr, phys_addr_t pa, pgprot_t flags);
 
 extern struct cpu_entry_area *get_cpu_entry_area(int cpu);
 
-static inline struct entry_stack *cpu_entry_stack(int cpu)
+static __always_inline struct entry_stack *cpu_entry_stack(int cpu)
 {
 	return &get_cpu_entry_area(cpu)->entry_stack_page.stack;
 }
diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index d10150587d81..1009b6b5ce40 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -16,7 +16,7 @@
  * try_get_task_stack() instead.  task_stack_page will return a pointer
  * that could get freed out from under you.
  */
-static inline void *task_stack_page(const struct task_struct *task)
+static __always_inline void *task_stack_page(const struct task_struct *task)
 {
 	return task->stack;
 }
-- 
2.35.1

