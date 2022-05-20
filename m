Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C050252E2D9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 05:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345015AbiETDFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 23:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344969AbiETDFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 23:05:17 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BA8B82F8;
        Thu, 19 May 2022 20:05:16 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L4BPz0vfxz1JCQW;
        Fri, 20 May 2022 11:03:51 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 20 May 2022 11:05:14 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 20 May 2022 11:05:14 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <elver@google.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>
CC:     <linux-doc@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 1/2] Documentation/barriers: Add memory barrier dma_mb()
Date:   Fri, 20 May 2022 11:15:47 +0800
Message-ID: <20220520031548.175582-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220520031548.175582-1-wangkefeng.wang@huawei.com>
References: <20220520031548.175582-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory barrier dma_mb() is introduced by commit a76a37777f2c
("iommu/arm-smmu-v3: Ensure queue is read after updating prod pointer"),
which is used to ensure that prior (both reads and writes) accesses to
memory by a CPU are ordered w.r.t. a subsequent MMIO write.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 Documentation/memory-barriers.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index b12df9137e1c..1eabcc0e4eca 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1894,10 +1894,13 @@ There are some more advanced barrier functions:
 
  (*) dma_wmb();
  (*) dma_rmb();
+ (*) dma_mb();
 
      These are for use with consistent memory to guarantee the ordering
      of writes or reads of shared memory accessible to both the CPU and a
-     DMA capable device.
+     DMA capable device, in the case of ensure the prior (both reads and
+     writes) accesses to memory by a CPU are ordered w.r.t. a subsequent
+     MMIO write, dma_mb().
 
      For example, consider a device driver that shares memory with a device
      and uses a descriptor status value to indicate if the descriptor belongs
-- 
2.35.3

