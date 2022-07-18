Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D68B578B05
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236204AbiGRThV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236171AbiGRThQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:37:16 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF682D1E2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:37:11 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 72so11548760pge.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ztsUe2wZg/YICD33iqkzWz48lO96HPpWHQuuJ7tssIY=;
        b=L6+6rmWmlW74N35sQK1UeLXbLRgio2fsQS6mHJKVKzCTV61e8UW1ZZTN3koJ/ZKhAc
         Fuvodma7l4HTg6DZYvRj45/tMb7kCvzZw5K3JToemZFvQ1c5i9J+9IHlZylJfJHA8nmc
         uoiAVOLKXgLbMrTehDka9krReSTVnxLoS+Pghk2tFsInE1OztwnvEOqn4jNqft/Etn2w
         jjh/vGyNDH6Vj+uXcHOgy8ww40jB0eIPjLweUE55/vH6SgXA/XVlD1I8fHOnP35ZIRdB
         XkPCLZoHaJrwMPAIT4pU6iMAvGGNwFLN6atUCLJsOAvQHbVbxWALAXD8mmcQKOHMfINI
         qscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ztsUe2wZg/YICD33iqkzWz48lO96HPpWHQuuJ7tssIY=;
        b=EkAAfLru/MUM3TA+6tS7NUftUc7WP27afLom4G2Fy9UurxeblN9dLq+a2NebV8C0/N
         WkMgnbmrj9vD422w+bVoXs8ua3dR4fAX/RTNEy2XmQ3goL07ok55Eir4l+9B2MLcAYuI
         ghju2KigT1LNAh3cms0zkPwVaxHFIFqkzyWLIkI495Lj+MMo7ND4kZ6zn0ieIKWud0bp
         xxIbnsUn2VCFL3LkLmk3PXiXwYszrbNEg1Oj/K7ypObyf0WLMXzMFTOvVK/G3on146yB
         RN/ulOen5vG5i5trcb//5LPZ3Z6iVAd3xkde1WHczAWpRLSNvHPNQ3+FpAnkOr4Q3etk
         PBrQ==
X-Gm-Message-State: AJIora/cV60WNmnQNUza9qiv5+zUIs6jqvob+dFBiZB7MKo4twCZQfxo
        qCNMcY7bjbK5GTqQteIMvgs=
X-Google-Smtp-Source: AGRyM1ta8bb059Mp7zmutlWdMZ80ywE9XEnxT7RsTULurbViUhAfTouO49B+QsXkfMAuN7Zpzky0+Q==
X-Received: by 2002:a05:6a00:889:b0:510:91e6:6463 with SMTP id q9-20020a056a00088900b0051091e66463mr29798403pfj.58.1658173030299;
        Mon, 18 Jul 2022 12:37:10 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b0016bc4a6ce28sm9907887plb.98.2022.07.18.12.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 12:37:09 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: [RFC PATCH 05/14] x86/mm: check exec permissions on fault
Date:   Mon, 18 Jul 2022 05:02:03 -0700
Message-Id: <20220718120212.3180-6-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220718120212.3180-1-namit@vmware.com>
References: <20220718120212.3180-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

access_error() currently does not check for execution permission
violation. As a result, spurious page-faults due to execution permission
violation cause SIGSEGV.

It appears not to be an issue so far, but the next patches avoid TLB
flushes on permission promotion, which can lead to this scenario. nodejs
for instance crashes when TLB flush is avoided on permission promotion.

Add a check to prevent access_error() from returning mistakenly that
spurious page-faults due to instruction fetch are a reason for an access
error.

It is assumed that error code bits of "instruction fetch" and "write" in
the hardware error code are mutual exclusive, and the change assumes so.
However, to be on the safe side, especially if hypervisors misbehave,
assert this is the case and warn otherwise.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: x86@kernel.org
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/mm/fault.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index fe10c6d76bac..00013c1fac3f 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1107,10 +1107,28 @@ access_error(unsigned long error_code, struct vm_area_struct *vma)
 				       (error_code & X86_PF_INSTR), foreign))
 		return 1;
 
-	if (error_code & X86_PF_WRITE) {
+	if (error_code & (X86_PF_WRITE | X86_PF_INSTR)) {
+		/*
+		 * CPUs are not expected to set the two error code bits
+		 * together, but to ensure that hypervisors do not misbehave,
+		 * run an additional sanity check.
+		 */
+		if ((error_code & (X86_PF_WRITE|X86_PF_INSTR)) ==
+					(X86_PF_WRITE|X86_PF_INSTR)) {
+			WARN_ON_ONCE(1);
+			return 1;
+		}
+
 		/* write, present and write, not present: */
-		if (unlikely(!(vma->vm_flags & VM_WRITE)))
+		if ((error_code & X86_PF_WRITE) &&
+		    unlikely(!(vma->vm_flags & VM_WRITE)))
+			return 1;
+
+		/* exec, present and exec, not present: */
+		if ((error_code & X86_PF_INSTR) &&
+		    unlikely(!(vma->vm_flags & VM_EXEC)))
 			return 1;
+
 		return 0;
 	}
 
-- 
2.25.1

