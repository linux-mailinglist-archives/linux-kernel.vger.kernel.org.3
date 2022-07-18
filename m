Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9404F578B03
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbiGRThR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236113AbiGRThI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:37:08 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE7DE00D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:37:07 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g4-20020a17090a290400b001f1f2b7379dso356929pjd.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Q49j7ZnjpJbe7tnNHIQw9SAVjFrSuB+lmoi9+DDawg=;
        b=bmUPVvdzZ44bZXvMXaJebmRi8Em4oQjsNDUw0UeAiKmw4D56qcZbcTGB0JlqUCsblt
         OEV1P1bs52wmG0gm8jY3wqSSUBITQIxayVYMmqk0JsmL+4pXoNVZ2FH1OsJW8kiZmEr5
         o7V/37GKM2yOHpp0l6kahMySGW2vJQoZxf4VUu7MLfRdvtcC2k5ObYDHuP/XNyCSsW5v
         F/svHC9579Af/qJy3HoEVjxdNA4i/N87zD/iGJjAednCkdcRy5LqlQH1N6K6bzUuXkKo
         O+nHVRq37bCF+vMHywbE4q/ySw3g4zg984mjk3Zd66z+yPz9kQc8fmRVgs/2ZAhpyHge
         Nzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Q49j7ZnjpJbe7tnNHIQw9SAVjFrSuB+lmoi9+DDawg=;
        b=QTzDvcuX8FBkQsx5DxhJzvZ1Pcfl2KYNFjNOAasgtF2GcqiTrLlW4NyRWY7a2h2kaf
         YHoYnRi8/Fr0kKRwN+eYly7QUa7yUM2drCXEA8/DodWdow8GuN4Tf2Z5/VmUdFatPoQ8
         fsSbufeLN40oFaEXbpXjKLL7xbvVHjVVmKQ1XGysMJ8I2+c1RkgHWRgElZzoT7eB1hAz
         2jC6bVtS4O8ZbzCNUvwWuZnzvXZFCTE3RGbJ3avGlOmgIxCmjQuH6WQfSSfqbHjW2G7p
         URaRwA3PHFYqE2WU6uql22Y4a5+3P6wVgAitVuP50CpPp2lx1R5uM3GQPmqx6FfpEnwi
         zlew==
X-Gm-Message-State: AJIora+tPWip9msXutFJW5q+hdHM/RQ73ScCDj8dL0/MhGSo6gN11w0Z
        +LgiAkRoXxNJZkf5Rd4CL64=
X-Google-Smtp-Source: AGRyM1tTWf0SQi53/iAko8YuS1u16C/ViaTRcBXow+cR8M+MN0AQg8swqeSra7RTo6Z8gZakiBjToQ==
X-Received: by 2002:a17:90a:d195:b0:1ef:8eb2:4f4d with SMTP id fu21-20020a17090ad19500b001ef8eb24f4dmr39367516pjb.104.1658173027111;
        Mon, 18 Jul 2022 12:37:07 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b0016bc4a6ce28sm9907887plb.98.2022.07.18.12.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 12:37:06 -0700 (PDT)
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
Subject: [RFC PATCH 03/14] mm/mprotect: allow exclusive anon pages to be writable
Date:   Mon, 18 Jul 2022 05:02:01 -0700
Message-Id: <20220718120212.3180-4-namit@vmware.com>
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

Anonymous pages might have the dirty bit clear, but this should not
prevent mprotect from making them writable if they are exclusive.
Therefore, skip the test whether the page is dirty in this case.

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
 mm/mprotect.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 34c2dfb68c42..da5b9bf8204f 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -45,7 +45,7 @@ static inline bool can_change_pte_writable(struct vm_area_struct *vma,
 
 	VM_BUG_ON(!(vma->vm_flags & VM_WRITE) || pte_write(pte));
 
-	if (pte_protnone(pte) || !pte_dirty(pte))
+	if (pte_protnone(pte))
 		return false;
 
 	/* Do we need write faults for softdirty tracking? */
@@ -66,7 +66,8 @@ static inline bool can_change_pte_writable(struct vm_area_struct *vma,
 		page = vm_normal_page(vma, addr, pte);
 		if (!page || !PageAnon(page) || !PageAnonExclusive(page))
 			return false;
-	}
+	} else if (!pte_dirty(pte))
+		return false;
 
 	return true;
 }
-- 
2.25.1

