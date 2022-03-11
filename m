Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A281B4D68EC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 20:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351050AbiCKTIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 14:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351036AbiCKTIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 14:08:10 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623B51AE66C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 11:07:06 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id rm8-20020a17090b3ec800b001c55791fdb1so1199763pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 11:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2SJwDWdiGMEZCVwB+/7uYYAov/bAs7rI8E5dgDcHCHE=;
        b=RNQvCIeNkI4a6kLZuTON6FllInIPnYqg62rwO8uY4lqXnydg7/VigusyjdDFurCpyA
         aZXwXDaW7rxdtHW2kXSbfdOGvqMuG0VR3uYmnR5C6fefO6pRdmPrLDeAcGksiwudrbPJ
         +uS23aBaNlyW0XX7OGc85OfYadCVJY7t8QkH11lz1wPwpTu7NxXw8LIsKfNXGjEdDh+d
         LdeTShgIANY79GqZTPLLMZeOjHeXEtMEeyXY/slpMh9JNQn9q2wrgVKViNoLw7GUcJmV
         xAw8FyP6gSJJoLj3ROIh4jy5cZhvnzwyl03cKtvmVJzRqjbXUTvg55K/2sLgZQ1OfwL7
         Ir6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2SJwDWdiGMEZCVwB+/7uYYAov/bAs7rI8E5dgDcHCHE=;
        b=ZMTjfrlQnsF1jW1DbzzeeKi8/RxwPN3hZQyUuykeggH3w7FgmFjx/0W0+Lc93DAp8x
         8JcQo9pAkYrIvJOAxDCigfkwRRIxjxBDQmjPZ/oNyXAWNHtjGbUr4HuDrGv2qdwJlIGZ
         N9LdLmg/e6+nUeXlLKaieTVg8GAAFfFc8/SpbxuDTiWMNxeV8StTOvrZ0NBTLhGraqZ7
         RwAuC+iVJoUVzPQibfbn1X91qhM9TMAmrwtESDRjRkXIg4IGefm11ZHHypKu4MLZikBa
         TI/aucISactRIsMMrhPxRzHHeMlPHMfnPloZxkFqmBlI19dLBkG1G5MOHNgzrlAmGohp
         PWIw==
X-Gm-Message-State: AOAM531/m2xzfUGqSr5yqqUrqhIsGpX+DYd3sqFyjEexmJeSnyFE7YTK
        9JPyt3HQaEzvJt9FpTKdLsY=
X-Google-Smtp-Source: ABdhPJzL9/Di0EFA1D/q8bRtKkBUbBPgCgrnm9WVIMobs4Hsr0B+nA08KlWZ2rvqyD+IC3SeAeAwHA==
X-Received: by 2002:a17:902:a9cb:b0:151:f21c:2432 with SMTP id b11-20020a170902a9cb00b00151f21c2432mr12252500plr.158.1647025625493;
        Fri, 11 Mar 2022 11:07:05 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id a5-20020a621a05000000b004f79f8f795fsm857329pfa.0.2022.03.11.11.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 11:07:05 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: [RESEND PATCH v3 2/5] x86/mm: check exec permissions on fault
Date:   Fri, 11 Mar 2022 11:07:46 -0800
Message-Id: <20220311190749.338281-3-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220311190749.338281-1-namit@vmware.com>
References: <20220311190749.338281-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index d0074c6ed31a..ad0ef0a6087a 100644
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

