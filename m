Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A202C586AF6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbiHAMi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234571AbiHAMiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:38:22 -0400
Received: from out199-1.us.a.mail.aliyun.com (out199-1.us.a.mail.aliyun.com [47.90.199.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBAE9EC71
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 05:17:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VL6DdII_1659356249;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VL6DdII_1659356249)
          by smtp.aliyun-inc.com;
          Mon, 01 Aug 2022 20:17:31 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     willy@infradead.org
Cc:     akpm@linux-foundation.org, adobriyan@gmail.com,
        keescook@chromium.org, xhao@linux.alibaba.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [RFC PATCH V4 0/1] mm: add last level page table numa info to /proc/pid/numa_pgtable
Date:   Mon,  1 Aug 2022 20:17:26 +0800
Message-Id: <20220801121727.76186-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In many data center servers, the shared memory architectures is
Non-Uniform Memory Access (NUMA), remote numa node data access
often brings a high latency problem, but what we are easy to ignore
is that the page table remote numa access, It can also leads to a
performance degradation.

So there add a new interface in /proc, This will help developers to
get more info about performance issues if they are caused by cross-NUMA.

V4 -> V3
1, Add some detects and spinlock when operating PMD page as Baolin Wang advised.

V2 -> V3
1, Fix compile warning bug.

V1 -> V2
1, As Matthew Wilcox advise, Simplify the code.
2, Do some codes format fix.

V3: https://lore.kernel.org/linux-mm/20220801032704.64356-1-xhao@linux.alibaba.com/
V2: https://lore.kernel.org/linux-mm/20220731155223.60238-1-xhao@linux.alibaba.com/
V1: https://lore.kernel.org/linux-mm/YuVqdcY8Ibib2LJa@casper.infradead.org/T/


Xin Hao (1):
  mm: add last level page table numa info to /proc/pid/numa_pgtable

 fs/proc/base.c     |  2 ++
 fs/proc/internal.h |  1 +
 fs/proc/task_mmu.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+)

--
2.31.0
