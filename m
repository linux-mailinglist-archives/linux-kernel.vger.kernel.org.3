Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FC94D68E9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 20:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351034AbiCKTIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 14:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351027AbiCKTII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 14:08:08 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673701AEEC1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 11:07:03 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id z3so8417508plg.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 11:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XW7DMcnwk1D85iVl8OKvTHZ55GYo9rx6/0j7AsIh0HQ=;
        b=e47/s6ZBl4wIUGL5c01pNpGqkL5r6JZQLVE6zMWFkZY0l+FwUINd/znyYKiGbpZ+oe
         i9GeHQ9AYKGtzUHOKvYOwS0igdHMwtCFUfzhdTjtlBir9fkng/T986ta5EQU4GqCeK2/
         d0bt4Pyp9nn8jeL99jDgwYLNPc8FYeC3BN83OwsOyhc0nzBhFsokE+NNLx9c1LyZaSEo
         dIMaxL7BAClSzsw+ZO/oqhmUen17ycSl+wo+iOmz26h6kitOiJu7mcF8Gi0z5bphzjdP
         Z++wHrNhvD5RmEGuhTPRxRkuJB4UIXy2aAfl2tC3ttnG2VDw6SqvzMLYIwMiciBYw3B6
         8IrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XW7DMcnwk1D85iVl8OKvTHZ55GYo9rx6/0j7AsIh0HQ=;
        b=Qcpca898jul7icKmeN7CzQhVs8pk2rvZGeOvaqOs96GsmrEaMpB11Bqu265gmkgspE
         b7Mt6kKV2cGOeffhcLOkDGuWOfAkIAbOJaWQqV/D0QrxUFEV/wUs4+W76Lq3at/F16uR
         +HOIlRIuGi9klXyfKs1F7RaPjvOV3jIRTGC2rrZH2lJ6YuDTx+pLy5RRayFWIhEJu/N+
         irwwxbzEcAqNFyWJf57T+ISvIv0AcunnhvPnvn1Y8kHJq/KNzLY71Scu/Os5FD5xXSMj
         D3kf5pEzNQg3t/C/0Zib/2WexMCO4XyubIWRad96RArZ29rRVxcTXrBr+pubah4KOF7u
         WGxQ==
X-Gm-Message-State: AOAM5320w5nsJwlFqWCN8yApXaszVquJO+e7U/ULb+DQwZgB8H5wlh2i
        OUTLwJ+UXFrNknQAAu8C4F+EwuALOuc=
X-Google-Smtp-Source: ABdhPJxqrFhajsmYg+GWFFnHM9DyifPtdDuQJ2e2Dir9Apy8YRuyREqw+9Qpa5wx1sy4qbFcF4rw+w==
X-Received: by 2002:a17:902:ba8f:b0:153:237c:a77f with SMTP id k15-20020a170902ba8f00b00153237ca77fmr9063928pls.1.1647025622607;
        Fri, 11 Mar 2022 11:07:02 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id a5-20020a621a05000000b004f79f8f795fsm857329pfa.0.2022.03.11.11.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 11:07:02 -0800 (PST)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>
Subject: [RESEND PATCH v3 0/5] mm/mprotect: avoid unnecessary TLB flushes
Date:   Fri, 11 Mar 2022 11:07:44 -0800
Message-Id: <20220311190749.338281-1-namit@vmware.com>
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


*** BLURB HERE ***

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

