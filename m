Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2754D27E2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiCIELD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 23:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiCIEKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 23:10:55 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1BC12E169
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 20:09:57 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id w4so872005ply.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 20:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2SJwDWdiGMEZCVwB+/7uYYAov/bAs7rI8E5dgDcHCHE=;
        b=ATVTz40hJi2tmeDX85+96Z/GuBi2dfLoScIagjwpTYztYkuWr9vE5ghlLwx5hJOr5f
         PO9KAStO8HI2xQWYX1PW6CrIfi1/OANTsATHA3jYRMhGAxpaFd6HWUpTEazUMro04a3d
         Bcn0qpj0Fx8BFfYvgXR+3/NbOToYqNe3fX8YDBJowKHlp/tIGy/Ez1vkfqwV43+ey/IN
         E37twpo7wWLDkx/9rUbh1ssGjU1o7i2Qn76Ct0RmhWhA05O7CektW1nKBcDCty6Bbanv
         YRvzX6s1L6Yka/lD5dXl75Nyq0hvxqoNeunS+wOV5DQICLE/pYH9+fFiADyfy57o/Q2u
         S5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2SJwDWdiGMEZCVwB+/7uYYAov/bAs7rI8E5dgDcHCHE=;
        b=jrZn+Cqjy8ziSi7KUT5Bv3RlVBzn5I+DuppHImuSyjtsSD1C3j2OZj0qP84WO+2MbG
         z36fgUdIYoUBm9UxfiVOreHMQsHZ6bmWO1CRieUbxkIYittdZC5Ny0RsDhJL/CFUZ2NM
         FiVWu83H8wrV6YqUEHtZsXGn4UVHaqvw72nmsah2bvAy0AXles0WaUUgoCImzNWBXYOU
         MrKeMyHJiy15Ma5NQk4fbMGEkq6L/dfFG9P1tmQlzx9P+AS/TJ4H7auFbmlC6OJDAyHs
         mj9wTXqbAZ8uFHPdZXcc8FVa1oQ9YbfyersRA1HQrcc+H4AiHHzhDgc/9MGVI7aEW76s
         4/yw==
X-Gm-Message-State: AOAM532ywvQTU0vMPLRin8DK/Wl47S9LkI+ETlosrkQs1nRv7qY2Ruww
        ZG06OXof9W+QhG4o2ALtTsI=
X-Google-Smtp-Source: ABdhPJzoRyh9dUlZqdCM+iui5NsBCu4xoyMPa/RF2114leOcWaPd45FxGNhhrskQuzehdlyE6kWOuQ==
X-Received: by 2002:a17:90b:1d8a:b0:1be:f9b0:1fca with SMTP id pf10-20020a17090b1d8a00b001bef9b01fcamr8344653pjb.137.1646798997095;
        Tue, 08 Mar 2022 20:09:57 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id g5-20020a655805000000b003643e405b56sm604343pgr.24.2022.03.08.20.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 20:09:56 -0800 (PST)
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
Subject: [PATCH v3 2/5] x86/mm: check exec permissions on fault
Date:   Tue,  8 Mar 2022 20:10:40 -0800
Message-Id: <20220309041043.302261-3-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220309041043.302261-1-namit@vmware.com>
References: <20220309041043.302261-1-namit@vmware.com>
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

