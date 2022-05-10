Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EFE521353
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240721AbiEJLRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240661AbiEJLRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:17:07 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C618E21A94B
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 04:13:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VCqxQ84_1652181184;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VCqxQ84_1652181184)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 10 May 2022 19:13:05 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     catalin.marinas@arm.com, will@kernel.org, mike.kravetz@oracle.com,
        akpm@linux-foundation.org
Cc:     songmuchun@bytedance.com, willy@infradead.org,
        anshuman.khandual@arm.com, christophe.leroy@csgroup.eu,
        baolin.wang@linux.alibaba.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 0/2] Implement arm64 specific huge_ptep_get()
Date:   Tue, 10 May 2022 19:12:51 +0800
Message-Id: <cover.1652180088.git.baolin.wang@linux.alibaba.com>
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

As Mike pointed out [1], the huge_ptep_get() will only return one specific
pte value for the CONT-PTE or CONT-PMD size hugetlb on ARM64 system, which
will not take into account the subpages' dirty or young bits of a CONT-PTE/PMD
size hugetlb page. That will make us miss dirty or young flags of a CONT-PTE/PMD
size hugetlb page for those functions that want to check the dirty or
young flags of a hugetlb page. For example, the gather_hugetlb_stats() will
get inaccurate dirty hugetlb page statistics, and the DAMON for hugetlb monitoring
will also get inaccurate access statistics.

To fix this issue, this patch set introduces an ARM64 specific huge_ptep_get()
implementation, which will take into account any subpages' dirty or young bits.

[1] https://lore.kernel.org/linux-mm/85bd80b4-b4fd-0d3f-a2e5-149559f2f387@oracle.com/

Changes from RFC:
 - Implement arm64 specific huge_ptep_get() instead of introducing a new interface.
 - Add a new patch to convert huge_ptep_get() in hugetlbpage.c

Baolin Wang (2):
  arm64/hugetlb: Use ptep_get() to get the pte value of a huge page
  arm64/hugetlb: Implement arm64 specific huge_ptep_get()

 arch/arm64/include/asm/hugetlb.h |  2 ++
 arch/arm64/mm/hugetlbpage.c      | 32 ++++++++++++++++++++++++++++----
 2 files changed, 30 insertions(+), 4 deletions(-)

-- 
1.8.3.1

