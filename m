Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCE44D27CC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229474AbiCIEKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 23:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiCIEKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 23:10:52 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236BD12D91B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 20:09:55 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id o8so908962pgf.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 20:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kfr5m2PRqnND1bCrQVSYfXTF8HBTyqcn2+yeFt5oR7M=;
        b=OTwW3d49hx7PReFEjXfxIs2X8WMnlL+pxohujjDzVggLSnjMshhSQ/QsrcJQRUeDxh
         oVx/rQ6nNJFVbFGv0dyK8T8Yz6BMptDlAKEM0nYXB2dgrk3daFdobewXvRYPp11Id2Gh
         Kbk4b7yjSgP5v/91Fa6hBeeE5W7glIUtJuUpdlCt61mujhnGppmT1MrSjBb/04B50jem
         Bp5uHs3sKVaGRm8DETQjStaPbbG7No0QyS5nTLN9Yn6Hzas7fswFuuisc+fKkqiEtfzx
         FjU/y2KCt18GQ6G3IVTK96KfV+BtgN/DIr8RgdpG0LUCedSTMk5qRXvW5rouL0flzuwZ
         oivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kfr5m2PRqnND1bCrQVSYfXTF8HBTyqcn2+yeFt5oR7M=;
        b=cIRTSHPt+hxVEQvvpvm22vLkIcFyZa8f4klidaqtznQn1ke15X/+JFeZS+oa1EcGqu
         FvIxQn0SwyzCBjyPQi0Vbbx9+P3xx0/K7XnPAN2tdTb1OdyGSLEoEos1G7A3H16uw/3u
         yB48homDZxIv5/K9NK3aNZ3SU+z2CfUii28ViFNXzY9Dye56qvMDuRRfyHTt/xBpbZ18
         P8DfFACKkWN6J6pPe5rtAiu1sNwqk45ZaLuPcaX5c49veITfGfLugluG/rYZYzmnxsRL
         kAIE3l2xYO2HLkqtS8lEtBv9+yYrMukMwE8BIjPGM1Q3BNOtluHialgLJCMxIYwb0LDY
         Ospg==
X-Gm-Message-State: AOAM532ggmm3KGevUfrnQgp3QIW7QZhX6HP7yBcI70zJJknz2bG6xzzR
        E91Xp8UZdfkWeRoEoegURKc=
X-Google-Smtp-Source: ABdhPJyqsd9QoxJNxes8scCRZ0Z54fuC+h0Jh3Dc4ivlMWdu6Je3/jtzA7eH43h5l4nOv/+PlamJOQ==
X-Received: by 2002:a05:6a00:1516:b0:4f6:fad6:f0a7 with SMTP id q22-20020a056a00151600b004f6fad6f0a7mr14762628pfu.21.1646798994088;
        Tue, 08 Mar 2022 20:09:54 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id g5-20020a655805000000b003643e405b56sm604343pgr.24.2022.03.08.20.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 20:09:53 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>, Andi Kleen <ak@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: [PATCH v3 0/5] mm/mprotect: avoid unnecessary TLB flushes
Date:   Tue,  8 Mar 2022 20:10:38 -0800
Message-Id: <20220309041043.302261-1-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
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

This patch-set is intended to remove unnecessary TLB flushes during
mprotect() syscalls. Once this patch-set make it through, similar
and further optimizations for MADV_COLD and userfaultfd would be
possible.

Sorry for the time between it took me to get to v3.

Basically, there are 3 optimizations in this patch-set:
1. Use TLB batching infrastructure to batch flushes across VMAs and
   do better/fewer flushes. This would also be handy for later
   userfaultfd enhancements.
2. Avoid TLB flushes on permission demotion. This optimization is
   the one that provides most of the performance benefits. Note that
   the previous batching infrastructure changes are needed for that to
   happen.
3. Avoiding TLB flushes on change_huge_pmd() that are only needed to
   prevent the A/D bits from changing.

Andrew asked for some benchmark numbers. I do not have an easy
determinate macrobenchmark in which it is easy to show benefit. I therre
ran a microbenchmark: a loop that does the following on anonymous
memory, just as a sanity check to see that time is saved by avoiding TLB
flushes. The loop goes:

	mprotect(p, PAGE_SIZE, PROT_READ)
	mprotect(p, PAGE_SIZE, PROT_READ|PROT_WRITE)
	*p = 0; // make the page writable

The test was run in KVM guest with 1 or 2 threads (the second thread
was busy-looping). I measured the time (cycles) of each operation:

		1 thread		2 threads
		mmots	+patch		mmots	+patch
PROT_READ	3494	2725 (-22%)	8630	7788 (-10%)
PROT_READ|WRITE	3952	2724 (-31%)	9075	2865 (-68%)

[ mmots = v5.17-rc6-mmots-2022-03-06-20-38 ]

The exact numbers are really meaningless, but the benefit is clear.
There are 2 interesting results though. 

(1) PROT_READ is cheaper, while one can expect it not to be affected.
This is presumably due to TLB miss that is saved

(2) Without memory access (*p = 0), the speedup of the patch is even
greater. In that scenario mprotect(PROT_READ) also avoids the TLB flush.
As a result both operations on the patched kernel take roughly ~1500
cycles (with either 1 or 2 threads), whereas on mmotm their cost is as
high as presented in the table.


Cc: Andi Kleen <ak@linux.intel.com>
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

--

v2 -> v3:
* Fix orders of patches (order could lead to breakage)
* Better comments
* Clearer KNL detection [Dave]
* Assertion on PF error-code [Dave]
* Comments, code, function names improvements [PeterZ]
* Flush on access-bit clearing on PMD changes to follow the way
  flushing on x86 is done today in the kernel.

v1 -> v2:
* Wrong detection of permission demotion [Andrea]
* Better comments [Andrea]
* Handle THP [Andrea]
* Batching across VMAs [Peter Xu]
* Avoid open-coding PTE analysis
* Fix wrong use of the mmu_gather()

Nadav Amit (5):
  x86: Detection of Knights Landing A/D leak
  x86/mm: check exec permissions on fault
  mm/mprotect: use mmu_gather
  mm/mprotect: do not flush on permission promotion
  mm: avoid unnecessary flush on change_huge_pmd()

 arch/x86/include/asm/cpufeatures.h   |  1 +
 arch/x86/include/asm/pgtable.h       |  5 ++
 arch/x86/include/asm/pgtable_types.h |  2 +
 arch/x86/include/asm/tlbflush.h      | 82 ++++++++++++++++++++++++
 arch/x86/kernel/cpu/intel.c          |  5 ++
 arch/x86/mm/fault.c                  | 22 ++++++-
 arch/x86/mm/pgtable.c                | 10 +++
 fs/exec.c                            |  6 +-
 include/asm-generic/tlb.h            | 14 +++++
 include/linux/huge_mm.h              |  5 +-
 include/linux/mm.h                   |  5 +-
 include/linux/pgtable.h              | 20 ++++++
 mm/huge_memory.c                     | 19 ++++--
 mm/mprotect.c                        | 94 +++++++++++++++-------------
 mm/pgtable-generic.c                 |  8 +++
 mm/userfaultfd.c                     |  6 +-
 16 files changed, 248 insertions(+), 56 deletions(-)

-- 
2.25.1

