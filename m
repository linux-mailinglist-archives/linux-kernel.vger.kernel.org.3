Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FD24CF2D7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 08:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235911AbiCGHq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 02:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235909AbiCGHqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 02:46:23 -0500
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB4A5A0BD
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 23:45:28 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V6SREaW_1646639116;
Received: from localhost.localdomain(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0V6SREaW_1646639116)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Mar 2022 15:45:25 +0800
From:   Tianchen Ding <dtcccc@linux.alibaba.com>
To:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] provide the flexibility to enable KFENCE
Date:   Mon,  7 Mar 2022 15:45:14 +0800
Message-Id: <20220307074516.6920-1-dtcccc@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v3 for (re-)enabling KFENCE.

If CONFIG_CONTIG_ALLOC is not supported, we fallback to try
alloc_pages_exact(). Allocating pages in this way has limits about
MAX_ORDER (default 11). So we will not support allocating kfence pool
after system startup with a large KFENCE_NUM_OBJECTS.

When handling failures in kfence_init_pool_late(), we pair
free_pages_exact() to alloc_pages_exact() for compatibility
consideration, though it actually does the same as free_contig_range().

v3:
Use alloc_pages_exact() instead of alloc_contig_pages()
if CONFIG_CONTIG_ALLOC is not defined.

v2: https://lore.kernel.org/all/20220305144858.17040-1-dtcccc@linux.alibaba.com/
Take KFENCE_WARN_ON() into account. Do not allow re-enabling KFENCE
if it once disabled by warn.
Modify func names and comments.

RFC/v1: https://lore.kernel.org/all/20220303031505.28495-1-dtcccc@linux.alibaba.com/

Tianchen Ding (2):
  kfence: Allow re-enabling KFENCE after system startup
  kfence: Alloc kfence_pool after system startup

 mm/kfence/core.c | 126 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 105 insertions(+), 21 deletions(-)

-- 
2.27.0

