Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05FD578B0C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236173AbiGRThu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236216AbiGRThX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:37:23 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0585D30F75
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:37:22 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id z1so9967428plb.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U3bHH+VCApNk0EgSMkQpPIu/hogjL02kkGQOh371JqE=;
        b=cgVgCcOubWJlYQh87ciup80RfrTt14z9y9XheMGRDWpUOcN7tz83N1/LeVdqY4FC8x
         NjZ299ZmT5ayN+y3qeWtB4AiGGlLv0bTeoa41zMsLcKw7Yvbr8j3tdxbVbn/BCQj5UnM
         N+DKf8yCPT06zTRIR4vx6LrfvTTsQMm6mDcaVmmqoslMBPkuYDGQM8LAXE49wLZerlr4
         O2XHyJrKy3OzAIEITCEW9D6Zdl1GZeNoRYmVFo5+eof3svAuQ9oW9pdkFfi1jwDp+2Kd
         cmWr6cYwHWT0ai9wmSNVyZ4nkkJV4zU269t4/tA7BL3pdN3OppGjcXUqwL5ga4yr3+rK
         lK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U3bHH+VCApNk0EgSMkQpPIu/hogjL02kkGQOh371JqE=;
        b=DUF3PtX4kOW5U/7yPOpKXEYLS9Q/RZ50yl6Bxn9H+AA2Ng215CxmHBcUop+9mbQHmB
         SoEFOwlH+EYCdWvsBcjj7QCAjA/fDqqrOYmU4w0i0dje47kD6U//HuYOMBG8+FXkhRBi
         5EwJo8DQpOREMIYst2DIR5aGdcuAvviQAnLNeywMVEaTnXSzm9TyOC/e1VqSh0lTxnka
         thzC7UxKX3RUKYZVYAClSoFEkKAK/75XY2dKj3wj2ldIf5u1IG24tP4akIF5HPXLBHHC
         MlRHQlebSXQhOafP68ZjwVPGKhPHXj76pPhSwVQTyPXKYI26bf4+oAq5SkZTSm6gRdK4
         pZ0Q==
X-Gm-Message-State: AJIora/yOYpL3bO6okyZkjIURP+NnopbhtwLHMNuWDtiy+arZiDhi8YT
        jnMkyC3Eq0sp1ZyBolEp0sA=
X-Google-Smtp-Source: AGRyM1t9fp3tA/qUiJLR5rxiQilje7wUJ0XNs2hdR5hLaXg/+Pz/WHXJKpxZoMJbK3OuMmRL/9fyZw==
X-Received: by 2002:a17:90a:f114:b0:1ef:991f:12e7 with SMTP id cc20-20020a17090af11400b001ef991f12e7mr41584874pjb.199.1658173040943;
        Mon, 18 Jul 2022 12:37:20 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b0016bc4a6ce28sm9907887plb.98.2022.07.18.12.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 12:37:20 -0700 (PDT)
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
Subject: [RFC PATCH 12/14] x86/tlb: no flush on PTE change from RW->RO when PTE is clean
Date:   Mon, 18 Jul 2022 05:02:10 -0700
Message-Id: <20220718120212.3180-13-namit@vmware.com>
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

On x86 it is possible to skip a TLB flush when a RW entry become RO and
the PTE is clean. Add logic to detect this case and skip the flush.

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
 arch/x86/include/asm/tlbflush.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 4f98735ab07a..58c95e36b098 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -271,8 +271,9 @@ static inline enum pte_flush_type pte_flags_flush_type(unsigned long oldflags,
 	 * dirty/access bit if needed without a fault.
 	 */
 	const pteval_t flush_on_clear = _PAGE_DIRTY | _PAGE_PRESENT |
-					_PAGE_ACCESSED | _PAGE_RW;
+					_PAGE_ACCESSED;
 	const pteval_t flush_on_set = _PAGE_NX;
+	const pteval_t flush_on_special = _PAGE_RW;
 	const pteval_t flush_on_set_relaxed = _PAGE_RW;
 	const pteval_t flush_on_clear_relaxed = _PAGE_NX;
 	const pteval_t software_flags = _PAGE_SOFTW1 | _PAGE_SOFTW2 |
@@ -302,6 +303,17 @@ static inline enum pte_flush_type pte_flags_flush_type(unsigned long oldflags,
 	if (diff & oldflags & flush_on_clear)
 		return PTE_FLUSH_STRICT;
 
+	/*
+	 * Did any of the 'flush_on_set' flags was set between 'oldflags' and
+	 * 'newflags'?
+	 */
+	if (diff & newflags & flush_on_set)
+		return PTE_FLUSH_STRICT;
+
+	/* On RW->RO, a flush is needed if the old entry is dirty */
+	if ((diff & oldflags & _PAGE_RW) && (oldflags & _PAGE_DIRTY))
+		return PTE_FLUSH_STRICT;
+
 	/* Flush on modified flags. */
 	if (diff & flush_on_change)
 		return PTE_FLUSH_STRICT;
@@ -314,7 +326,7 @@ static inline enum pte_flush_type pte_flags_flush_type(unsigned long oldflags,
 
 	/* Ensure there are no flags that were left behind */
 	if (IS_ENABLED(CONFIG_DEBUG_VM) &&
-	    (diff & ~(flush_on_clear | flush_on_set |
+	    (diff & ~(flush_on_clear | flush_on_set | flush_on_special |
 		      software_flags | flush_on_change))) {
 		VM_WARN_ON_ONCE(1);
 		return PTE_FLUSH_STRICT;
-- 
2.25.1

