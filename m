Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6630578B06
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbiGRTh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236184AbiGRThQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:37:16 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074C92CDED
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:37:14 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id g126so11565451pfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ii9tnumcH6f4uVFiJaNvbNbCHj/eOFwFpwV99AWDIWY=;
        b=gF1O4Ap8c6u3Wl7EJAnk5cpari+SSbCrCwIHnkKi2iGutzFYOra9oMYtovijltSliX
         f9n+3+zOazFlTlGbgoP7cASWhUOA3yRUCNf36n4asDLBRZ2n5F6V77g8Ih0ng07spWdH
         HCMUUeGMN6x1yYhcSmRTYhGUaieuitiLXWFPOh9CH2CMEqYcyByqPimLVW+wP36dQPZe
         1RJE9T2eaZawBkz5E8JuXZAG/5xKtgo8+wNL/iuOrcsSXLKNEDQJjqpz/5Yuv3v3GVFQ
         DvCcYoxTnP9tWp+lBd1uyqN2PAo5ihDVfdOn4Uj1GiSnYTj0YlvWIZ5h14BKB8GCHPjA
         0gFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ii9tnumcH6f4uVFiJaNvbNbCHj/eOFwFpwV99AWDIWY=;
        b=zNosqQGRRV4CaRWURanoiewy4STvLM3KxyKHHT8F6Hsf8HCScyF+cQ3A2t8VEiOceI
         QZY5H10tGPVIEX5UdpZX+XKlTNm0SWt7bxaxipLM8I0hHhLNNRSc7CIa/hpYw2MGJU2e
         6SVIIyNp4KmNg0Ufmsk7oeyXD4mazPfbNcYEitOVeB50srGE2EiUU4Dp9LT3x2hJWnav
         ds960yZ/NKDnjROufVOZQyn43lPtj1xn+XpVJ3fL0bDB+88WPkAe3/a+y1PXckyBPHoT
         wnCKML5fdoWdWhCnS2yhK9Za3NHtjidRuGRNspCldqha8ypXQP5LWBlN4+bqau1YVeLg
         SHyw==
X-Gm-Message-State: AJIora966Nwt47D7+YDU9q5ZbBx+WjFQz39REMn4yP0wquFAmJTBQ4g0
        bxkHX9pc2LSshNWIDL+YlOg=
X-Google-Smtp-Source: AGRyM1tECueM0uV0ckJl2HFWgTNipKEQZcrDzMSchFkRcqY0hBmCA7xorYY92YcZXwgaVycH49hQXg==
X-Received: by 2002:a05:6a00:3388:b0:52a:c018:6cdf with SMTP id cm8-20020a056a00338800b0052ac0186cdfmr29910792pfb.55.1658173033302;
        Mon, 18 Jul 2022 12:37:13 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b0016bc4a6ce28sm9907887plb.98.2022.07.18.12.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 12:37:12 -0700 (PDT)
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
Subject: [RFC PATCH 07/14] mm: do fix spurious page-faults for instruction faults
Date:   Mon, 18 Jul 2022 05:02:05 -0700
Message-Id: <20220718120212.3180-8-namit@vmware.com>
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

The next patches might cause spurious instruction faults on x86. To
prevent them from occurring too much, call
flush_tlb_fix_spurious_fault() for page-faults on code fetching as well.
The callee is expected to do a full flush, or whatever is necessary to
avoid further TLB flushes.

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
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 31ec3f0071a2..152a47876c36 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4924,7 +4924,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		 * This still avoids useless tlb flushes for .text page faults
 		 * with threads.
 		 */
-		if (vmf->flags & FAULT_FLAG_WRITE)
+		if (vmf->flags & (FAULT_FLAG_WRITE|FAULT_FLAG_INSTRUCTION))
 			flush_tlb_fix_spurious_fault(vmf->vma, vmf->address);
 	}
 unlock:
-- 
2.25.1

