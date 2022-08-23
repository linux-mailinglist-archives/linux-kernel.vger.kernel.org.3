Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B5659D2AB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241316AbiHWHvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241279AbiHWHuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:50:21 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8F56554E
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:50:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VN0xkM-_1661241012;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VN0xkM-_1661241012)
          by smtp.aliyun-inc.com;
          Tue, 23 Aug 2022 15:50:13 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com
Cc:     baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Fix some issues when looking up hugetlb page
Date:   Tue, 23 Aug 2022 15:50:00 +0800
Message-Id: <cover.1661240170.git.baolin.wang@linux.alibaba.com>
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

On ARM64 architecture, it can support CONT-PTE/PMD size hugetlb. When
looking up hugetlb page by follow_page(), we will hold the incorrect
pte/pmd lock for the CONT-PTE/PMD size hugetlb page, which will make
the pte/pmd entry unstable even under the lock and cause some potential
race issues. So considering the CONT-PTE/PMD size hugetlb, this patch set
changes to use the correct function to get the correct pte/pmd entry lock
to make the pte/pmd entry stable.

Changes from v1:
 - Introduce a new helper to handle the CONT-PTE page.
 - Use finer grained locks for CONT-PTE/PMD entries.
 - Update some commit message.

Baolin Wang (5):
  mm/hugetlb: fix races when looking up a CONT-PTE size hugetlb page
  mm/hugetlb: use PTE page lock to protect CONT-PTE entries
  mm/hugetlb: fix races when looking up a CONT-PMD size hugetlb page
  mm/hugetlb: use PMD page lock to protect CONT-PTE entries
  mm/hugetlb: add FOLL_MIGRATION validation before waiting for a
    migration entry

 include/linux/hugetlb.h | 38 ++++++++++++++++++++++++---
 mm/gup.c                | 13 ++++++++-
 mm/hugetlb.c            | 70 ++++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 113 insertions(+), 8 deletions(-)

-- 
1.8.3.1

