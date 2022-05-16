Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89098527B39
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 02:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238905AbiEPA4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 20:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbiEPA4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 20:56:11 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEADB26CD
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 17:56:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VDCFs5t_1652662565;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VDCFs5t_1652662565)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 16 May 2022 08:56:05 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        songmuchun@bytedance.com, willy@infradead.org,
        anshuman.khandual@arm.com, christophe.leroy@csgroup.eu,
        baolin.wang@linux.alibaba.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v3 0/2] Implement arm64 specific huge_ptep_get()
Date:   Mon, 16 May 2022 08:55:56 +0800
Message-Id: <cover.1652496622.git.baolin.wang@linux.alibaba.com>
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

Changes from v2:
 - Fix some typos and update the commit message suggested by Anshuman.
 - Improve some coding style issues.
 - Add reviewed tag from Anshuman.

Changes from v1:
 - Rebase on next-20220512.
 - Update commit message suggested by Muchun.
 - Add reviewed tag from Muchun.

Changes from RFC:
 - Implement arm64 specific huge_ptep_get() instead of introducing a new interface.
 - Add a new patch to convert huge_ptep_get() in hugetlbpage.c

Baolin Wang (2):
  arm64/hugetlb: Use ptep_get() to get the pte value of a huge page
  arm64/hugetlb: Implement arm64 specific huge_ptep_get()

 arch/arm64/include/asm/hugetlb.h |  2 ++
 arch/arm64/mm/hugetlbpage.c      | 30 ++++++++++++++++++++++++++----
 2 files changed, 28 insertions(+), 4 deletions(-)

-- 
1.8.3.1

