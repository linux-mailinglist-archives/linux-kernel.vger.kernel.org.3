Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465CE5618CF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 13:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbiF3LLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 07:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiF3LL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 07:11:29 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2367645052
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 04:11:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VHrqafz_1656587484;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VHrqafz_1656587484)
          by smtp.aliyun-inc.com;
          Thu, 30 Jun 2022 19:11:24 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     rppt@linux.ibm.com, willy@infradead.org,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 0/3] Add PUD and kernel PTE level pagetable account
Date:   Thu, 30 Jun 2022 19:11:13 +0800
Message-Id: <cover.1656586863.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Now we will miss to account the PUD level pagetable and kernel PTE level
pagetable, as well as missing to set the PG_table flags for these pagetable
pages, which will get an inaccurate pagetable accounting, and miss
PageTable() validation in some cases. So this patch set introduces 2 new
helpers to help to account PUD and kernel PTE pagetable pages.

Note there are still some architectures specific pagetable allocation
that need to account the pagetable pages, which need more investigation
and cleanup in future. Now I only send patches to mm mailist, and if no
objections from mm people, then I will send to the related arch's maillist
to get more review. Thanks.

Changes from RFC v2:
 - Convert to use mod_lruvec_page_state() for non-order-0 case.
 - Rename the helpers.
 - Update some commit messages.
 - Remove unnecessary __GFP_HIGHMEM clear.

Note: I still keep using alloc_pages() to allocate page in this version,
which follows pmd_alloc_one() and saves unnecessary conversion pointed
out by Matthew.

Changes from RFC v1:
 - Update some commit message.
 - Add missing pgtable_clear_and_dec() on X86 arch.
 - Use __free_page() to free pagetable which can avoid duplicated virt_to_page().

Baolin Wang (3):
  mm: Factor out the pagetable pages account into new helper function
  mm: Add PUD level pagetable account
  mm: Add kernel PTE level pagetable pages account

 arch/arm64/include/asm/tlb.h         |  5 ++++-
 arch/csky/include/asm/pgalloc.h      |  2 +-
 arch/loongarch/include/asm/pgalloc.h | 11 ++++++++---
 arch/microblaze/mm/pgtable.c         |  2 +-
 arch/mips/include/asm/pgalloc.h      | 11 ++++++++---
 arch/openrisc/mm/ioremap.c           |  2 +-
 arch/s390/include/asm/tlb.h          |  1 +
 arch/x86/mm/pgtable.c                | 10 ++++++++--
 include/asm-generic/pgalloc.h        | 26 ++++++++++++++++++++++----
 include/linux/mm.h                   | 24 ++++++++++++++++--------
 10 files changed, 70 insertions(+), 24 deletions(-)

-- 
1.8.3.1

