Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DE25115B1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbiD0LFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbiD0LDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:03:30 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B983EDABC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 03:52:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VBSxH7t_1651056733;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VBSxH7t_1651056733)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Apr 2022 18:52:13 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com
Cc:     almasrymina@google.com, songmuchun@bytedance.com,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Fix cache flush issues considering PMD sharing
Date:   Wed, 27 Apr 2022 18:52:04 +0800
Message-Id: <cover.1651056365.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch set fixes some cache flushing issues if PMD sharing is
possible for hugetlb pages, which were found by code inspection.
Meanwhile Mike found the flush_cache_page() can not cover the whole
size of a hugetlb page on some architectures [1], so I added a new
patch 3 to fix this issue, since I found only try_to_unmap_one()
and try_to_migrate_one() need to fix after some investigation.

Please help to review. Thanks.

[1] https://lore.kernel.org/linux-mm/064da3bb-5b4b-7332-a722-c5a541128705@oracle.com/

Changes from v1:
 - Add reviewed-by tag from Mike.
 - Update some comments suggested by Mike.
 - Add a new patch to fix cache issue for hugetlb page.

Baolin Wang (3):
  mm: hugetlb: Considering PMD sharing when flushing cache/TLBs
  mm: rmap: Move the cache flushing to the correct place for hugetlb PMD
    sharing
  mm: rmap: Use flush_cache_range() to flush cache for hugetlb pages

 mm/hugetlb.c |  17 ++++++++-
 mm/mremap.c  |   2 +-
 mm/rmap.c    | 118 ++++++++++++++++++++++++++++++++---------------------------
 3 files changed, 80 insertions(+), 57 deletions(-)

-- 
1.8.3.1

