Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C689F50D267
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 16:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239445AbiDXOx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 10:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239441AbiDXOx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 10:53:27 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4782FFCF
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 07:50:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VB2JqrI_1650811822;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VB2JqrI_1650811822)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 24 Apr 2022 22:50:22 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com
Cc:     almasrymina@google.com, songmuchun@bytedance.com,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Fix cache flush issues considering PMD sharing
Date:   Sun, 24 Apr 2022 22:50:12 +0800
Message-Id: <cover.1650810915.git.baolin.wang@linux.alibaba.com>
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
Please help to review. Thanks.


Baolin Wang (2):
  mm: hugetlb: Considering PMD sharing when flushing cache/TLBs
  mm: rmap: Move the cache flushing to the correct place for hugetlb PMD
    sharing

 mm/hugetlb.c | 17 +++++++++++++++--
 mm/mremap.c  |  2 +-
 mm/rmap.c    | 40 ++++++++++++++++++++++------------------
 3 files changed, 38 insertions(+), 21 deletions(-)

-- 
1.8.3.1

