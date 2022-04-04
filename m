Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372514F20FB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiDECqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiDECqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:46:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8ABB385F04;
        Mon,  4 Apr 2022 18:51:52 -0700 (PDT)
Date:   Mon, 04 Apr 2022 23:57:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649116660;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PwZ76pi+E1pphrWaO+JmzsmgfjzaPFORwHErcJhS/Zg=;
        b=QrXbGUeSZ9tGnmphT8TVTod8Sqjxw3V58/+JVTiLk13f6s1wfOXsVmhLHXnCf/C/XLChI4
        LEbyvkizoyR0OyEUhkZKbqZTYs4FmLacKYi4MoyuJ6RTmhuN/+Wt9coa8N+2LFDNKouYnL
        VmfvfPpJFRkNF+qLNBohrSfDo3S097QY0M/IGnzqdmsZNHWlWo/GuDa8xKA1A7nGSejiNQ
        wMuyo5MSC83tLnrPxM20urOX4YvrYiCiXwzqWd64i8yKYdbJiuvvBnz4iIUpySEQyR+oIB
        lcJH/UP7CWF4quGMG7SBmTNujzv7neOt2zZ0phuIqAUXXV1u5JXynaNaBTTECQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649116660;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PwZ76pi+E1pphrWaO+JmzsmgfjzaPFORwHErcJhS/Zg=;
        b=pOt0TEUAEEyXcTRvW6fkt+VJcvDDSV1Irqcmvzd8lD9nnCf34QCK+EqxzP5yG4FVoftznR
        7/dBbdMaP0F6faAw==
From:   "tip-bot2 for Ira Weiny" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/pkeys: Remove __arch_set_user_pkey_access()
 declaration
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220331180655.2946086-1-ira.weiny@intel.com>
References: <20220331180655.2946086-1-ira.weiny@intel.com>
MIME-Version: 1.0
Message-ID: <164911665956.389.14418304758202721398.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     5a0893088a20252cc268cbeabb25e883c2b6f94f
Gitweb:        https://git.kernel.org/tip/5a0893088a20252cc268cbeabb25e883c2b6f94f
Author:        Ira Weiny <ira.weiny@intel.com>
AuthorDate:    Thu, 31 Mar 2022 11:06:55 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 04 Apr 2022 15:58:24 -07:00

x86/pkeys: Remove __arch_set_user_pkey_access() declaration

In the x86 code __arch_set_user_pkey_access() is not used and is not
defined.

Remove the dead declaration.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20220331180655.2946086-1-ira.weiny@intel.com
---
 arch/x86/include/asm/pkeys.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index 9c53053..2e6c04d 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -41,9 +41,6 @@ static inline int arch_override_mprotect_pkey(struct vm_area_struct *vma,
 	return __arch_override_mprotect_pkey(vma, prot, pkey);
 }
 
-extern int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
-		unsigned long init_val);
-
 #define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | VM_PKEY_BIT3)
 
 #define mm_pkey_allocation_map(mm)	(mm->context.pkey_allocation_map)
@@ -118,9 +115,6 @@ int mm_pkey_free(struct mm_struct *mm, int pkey)
 	return 0;
 }
 
-extern int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
-		unsigned long init_val);
-
 static inline int vma_pkey(struct vm_area_struct *vma)
 {
 	unsigned long vma_pkey_mask = VM_PKEY_BIT0 | VM_PKEY_BIT1 |
