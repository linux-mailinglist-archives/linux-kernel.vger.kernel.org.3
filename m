Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD4D578B04
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbiGRThL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236147AbiGRThG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:37:06 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB15E00D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:37:06 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id bh13so11528720pgb.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IufP9Zf+LxI7/ja1tm+EfHoZ34yAqbNH4YNdr2fLKzg=;
        b=qG3NzQadQYCy4rNcC/00/m1k00Rdnq8ihunEXn9ko/dtWH2HiC/JLZcB0XE3Fmrnme
         4uHW7JOvxcluNfpQxgbQVqeUgNSwGxPrf47yeAbr1vPKr2M8T3ojhSwKcIotbVOpuGpC
         03vIgXyGqL1xqLnoRk6HZYGbEsfTuBQb3UTilxepLrrh6di54zWWHrvnUwafOcNixDvI
         mAiMqZJOgnaD3MYRYn1evGphPH12+idguFStTv1WGAkRhN95WV3+4haBwVkVtpdhUTwQ
         dAycGnGYVMeeHc5jfDHQcsMcyMaz2Yv5VlzLzbDlj5bMe2rXOZ12FUP7+Pdwyzf05Qjg
         mXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IufP9Zf+LxI7/ja1tm+EfHoZ34yAqbNH4YNdr2fLKzg=;
        b=Sx9D+ZvR5pwK654JVRdbB36EzIVM6722qUAAoNfk59ypgWGOzSk3+7SX3Q3k0cL3JI
         EMWsv0L9tNN/Aoin9i/6i9r6yJlGf0tksrYW4Zmab6Ti9o+appr+4KEykGDMhOI1jzFG
         +/6+HEGi8upQIuLqptlAI9OmhyYLr2AvAr85M8Hy1KReptu51pguEec4//UrnPQuyu5v
         gNkINVzMLskN0kYUKFyU7ARypqLGk0+OgvKxD3vmLcl6Gg/nIJamOvG+MjeD9+5dMq6t
         FChh5OipG1Z02xJqU79dClL/E0kv1r14+QDPMqc7tFr1GD3ljByGGBwdaO0wGtEVvog8
         SGeQ==
X-Gm-Message-State: AJIora9kjgNshVgvCmBYjunY/YTiSw2lWLCqk4nr89qjMY549MQcs4XM
        I6DAKSUUDWWfYcLpLLHZ9lC1+d3pnkMDvw==
X-Google-Smtp-Source: AGRyM1s4dUG7omvru0Q+c8qc7tyPUfIKb/kzYGzarbIemngP+tEUPjt2ISjbd7jZhK5SI6J3kDZqpg==
X-Received: by 2002:a63:504c:0:b0:419:d02e:f42a with SMTP id q12-20020a63504c000000b00419d02ef42amr17915418pgl.566.1658173025597;
        Mon, 18 Jul 2022 12:37:05 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b0016bc4a6ce28sm9907887plb.98.2022.07.18.12.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 12:37:05 -0700 (PDT)
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
Subject: [RFC PATCH 02/14] userfaultfd: try to map write-unprotected pages
Date:   Mon, 18 Jul 2022 05:02:00 -0700
Message-Id: <20220718120212.3180-3-namit@vmware.com>
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

When using userfaultfd write-(un)protect ioctl, try to change the PTE to
be writable. This would save a page-fault afterwards.

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
 mm/userfaultfd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index e0492f5f06a0..6013b217e9f3 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -799,6 +799,8 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 	cp_flags = enable_wp ? MM_CP_UFFD_WP : MM_CP_UFFD_WP_RESOLVE;
 	if (uffd_flags & (UFFD_FLAGS_ACCESS_LIKELY|UFFD_FLAGS_WRITE_LIKELY))
 		cp_flags |= MM_CP_WILL_NEED;
+	if (!enable_wp && (uffd_flags & UFFD_FLAGS_WRITE_LIKELY))
+		cp_flags |= MM_CP_TRY_CHANGE_WRITABLE;
 
 	tlb_gather_mmu(&tlb, dst_mm);
 	change_protection(&tlb, dst_vma, start, start + len, newprot, cp_flags);
-- 
2.25.1

