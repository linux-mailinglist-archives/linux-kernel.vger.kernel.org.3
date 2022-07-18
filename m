Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1061578B0A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236212AbiGRThm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236197AbiGRThU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:37:20 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D116F2E690
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:37:19 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id h132so11502442pgc.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sYv+0w7UbdJfCd/9qiOzPSdo3DPlp98QBnk6mmrNOzw=;
        b=LfD4eNC9SIqr9cYWB25Xbr4WiNNia1nr+3GwzKavBUssVyFOxkqXDhxuEsCKotgHGX
         IWop0WCMjmuoVKLDBbwwaKBQDtdmqkvwVj7sFVhuA7x/GT8cqq96HiJcsEWIREVlkZkC
         XkrXrhlO0AHfhi7Ka0pK/Bk6TGPHIcLO4v6aQWeY6gTl5lS1/EBV6g/dpM3ldLkVpRs4
         P/DRFwB289y/gdLxuvwxWRrdWSS/ANky/BYuh5pHXytyibxUmY1neqRo3cZIvwKFVK6F
         YK0uUoEexTXqrgimYNcJK1bFS70JivrQyx9FnwmH/rpHZPac+0k2ux4Obajgr/ZrEpGI
         ztog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sYv+0w7UbdJfCd/9qiOzPSdo3DPlp98QBnk6mmrNOzw=;
        b=XiukuTmSJtZFfLopEAeh6ZNaUYrI0Q3rRjHZQUZMLGAkjBierDSCkXSZIAS+ODYbfh
         9zoXrvEpEGwib18HlLawyc7Q6emYnX188Gl6wIojMD/fbgavm+VLzyD7vgIckvnU4a6x
         WRHis8RdZDhqW/oiCHPdKoWCo+2yd1h1LKIb9mGDUwhkUb6YMDMfzmOo/9qbjLAkCWnb
         c1IEXbuDibVVK1FEJRI9ucOuC2G5pYqJtiq6KIJb87ez+JnZ0fXxujLnJwacPgkdTiBm
         5mGm8J8X1qMA24ntYfREm0hEk4j8e8mfRu3B4EcI7NvW/xV+pEE/mdOys9JCn5a5E1r0
         4msA==
X-Gm-Message-State: AJIora+O9X00L4KDV8utyrTxTLfHY0s0zCdVXkNBi+xgKzUGTz5eiv3Y
        EnvhpyXKPB/gj5nvDUxGI+g=
X-Google-Smtp-Source: AGRyM1vupv7tu2tOFZ1Su8p2ph2+On2wlRIi/LDIoBmyKSXGXyJd3hN8YQju5I/uoHMU9RGeKryGig==
X-Received: by 2002:a63:2684:0:b0:415:18d8:78dd with SMTP id m126-20020a632684000000b0041518d878ddmr26454387pgm.33.1658173039290;
        Mon, 18 Jul 2022 12:37:19 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b0016bc4a6ce28sm9907887plb.98.2022.07.18.12.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 12:37:18 -0700 (PDT)
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
        Nick Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 11/14] x86/mm: use relaxed TLB flushes when protection is removed
Date:   Mon, 18 Jul 2022 05:02:09 -0700
Message-Id: <20220718120212.3180-12-namit@vmware.com>
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

When checking x86 PTE flags to determine whether a TLB flush is needed,
determine whether a relaxed TLB flush is sufficient. If protection is
added (NX removed or W added), indicate that a relaxed TLB flush would
suffice.

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
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/tlbflush.h | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 230cd1d24fe6..4f98735ab07a 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -271,18 +271,23 @@ static inline enum pte_flush_type pte_flags_flush_type(unsigned long oldflags,
 	 * dirty/access bit if needed without a fault.
 	 */
 	const pteval_t flush_on_clear = _PAGE_DIRTY | _PAGE_PRESENT |
-					_PAGE_ACCESSED;
+					_PAGE_ACCESSED | _PAGE_RW;
+	const pteval_t flush_on_set = _PAGE_NX;
+	const pteval_t flush_on_set_relaxed = _PAGE_RW;
+	const pteval_t flush_on_clear_relaxed = _PAGE_NX;
 	const pteval_t software_flags = _PAGE_SOFTW1 | _PAGE_SOFTW2 |
 					_PAGE_SOFTW3 | _PAGE_SOFTW4;
-	const pteval_t flush_on_change = _PAGE_RW | _PAGE_USER | _PAGE_PWT |
+	const pteval_t flush_on_change = _PAGE_USER | _PAGE_PWT |
 			  _PAGE_PCD | _PAGE_PSE | _PAGE_GLOBAL | _PAGE_PAT |
 			  _PAGE_PAT_LARGE | _PAGE_PKEY_BIT0 | _PAGE_PKEY_BIT1 |
-			  _PAGE_PKEY_BIT2 | _PAGE_PKEY_BIT3 | _PAGE_NX;
+			  _PAGE_PKEY_BIT2 | _PAGE_PKEY_BIT3;
 	unsigned long diff = oldflags ^ newflags;
 
 	BUILD_BUG_ON(flush_on_clear & software_flags);
 	BUILD_BUG_ON(flush_on_clear & flush_on_change);
 	BUILD_BUG_ON(flush_on_change & software_flags);
+	BUILD_BUG_ON(flush_on_change & flush_on_clear_relaxed);
+	BUILD_BUG_ON(flush_on_change & flush_on_set_relaxed);
 
 	/* Ignore software flags */
 	diff &= ~software_flags;
@@ -301,9 +306,16 @@ static inline enum pte_flush_type pte_flags_flush_type(unsigned long oldflags,
 	if (diff & flush_on_change)
 		return PTE_FLUSH_STRICT;
 
+	if (diff & oldflags & flush_on_clear_relaxed)
+		return PTE_FLUSH_RELAXED;
+
+	if (diff & newflags & flush_on_set_relaxed)
+		return PTE_FLUSH_RELAXED;
+
 	/* Ensure there are no flags that were left behind */
 	if (IS_ENABLED(CONFIG_DEBUG_VM) &&
-	    (diff & ~(flush_on_clear | software_flags | flush_on_change))) {
+	    (diff & ~(flush_on_clear | flush_on_set |
+		      software_flags | flush_on_change))) {
 		VM_WARN_ON_ONCE(1);
 		return PTE_FLUSH_STRICT;
 	}
-- 
2.25.1

