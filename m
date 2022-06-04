Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E091053D4A6
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 03:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348500AbiFDBct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 21:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiFDBco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 21:32:44 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0DA13CDC
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 18:32:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VFHNL2w_1654306357;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VFHNL2w_1654306357)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 04 Jun 2022 09:32:38 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] Add PUD and kernel PTE level pagetable account
Date:   Sat,  4 Jun 2022 09:32:28 +0800
Message-Id: <cover.1654271618.git.baolin.wang@linux.alibaba.com>
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
and cleanup in future. Please help to review. Thanks.

Baolin Wang (3):
  mm: Factor out the pagetable pages account into new helper function
  mm: Add PUD level pagetable account
  mm: Add kernel PTE level pagetable pages account

 arch/arm64/include/asm/tlb.h    |  5 ++++-
 arch/csky/include/asm/pgalloc.h |  2 +-
 arch/microblaze/mm/pgtable.c    |  2 +-
 arch/mips/include/asm/pgalloc.h | 11 ++++++++---
 arch/openrisc/mm/ioremap.c      |  2 +-
 arch/s390/include/asm/tlb.h     |  1 +
 arch/x86/mm/pgtable.c           |  3 +++
 include/asm-generic/pgalloc.h   | 18 ++++++++++++++++--
 include/linux/mm.h              | 24 ++++++++++++++++--------
 9 files changed, 51 insertions(+), 17 deletions(-)

-- 
1.8.3.1

