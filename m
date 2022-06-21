Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D54D552BE0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346768AbiFUHZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346265AbiFUHZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:25:30 -0400
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9294F22B00
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:25:29 -0700 (PDT)
Received: from coburn.home.jannau.net (p579ad988.dip0.t-ipconnect.de [87.154.217.136])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 7E63126ED18;
        Tue, 21 Jun 2022 09:18:50 +0200 (CEST)
From:   Janne Grunau <j@jannau.net>
To:     iommu@lists.linux-foundation.org
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        asahi@lists.linux.dev, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] iommu/io-pgtable: Add DART subpage protection support
Date:   Tue, 21 Jun 2022 09:18:46 +0200
Message-Id: <20220621071848.14834-4-j@jannau.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621071848.14834-1-j@jannau.net>
References: <20220621071848.14834-1-j@jannau.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Peter <sven@svenpeter.dev>

DART allows to only expose a subpage to the device. While this is an
optional feature on the M1 DARTs the new ones present on the Pro/Max
models require this field in every PTE.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
Signed-off-by: Janne Grunau <j@jannau.net>

---

Changes in v3:
- apply change to io-pgtable-dart.c

 drivers/iommu/io-pgtable-dart.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/io-pgtable-dart.c b/drivers/iommu/io-pgtable-dart.c
index 0c5222942c65..fa8025c03bb5 100644
--- a/drivers/iommu/io-pgtable-dart.c
+++ b/drivers/iommu/io-pgtable-dart.c
@@ -14,6 +14,7 @@
 #define pr_fmt(fmt)	"dart io-pgtable: " fmt
 
 #include <linux/atomic.h>
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/io-pgtable.h>
 #include <linux/kernel.h>
@@ -63,6 +64,9 @@
 /* Calculate the block/page mapping size at level l for pagetable in d. */
 #define DART_BLOCK_SIZE(l, d)	(1ULL << DART_LVL_SHIFT(l, d))
 
+#define APPLE_DART_PTE_SUBPAGE_START   GENMASK_ULL(63, 52)
+#define APPLE_DART_PTE_SUBPAGE_END     GENMASK_ULL(51, 40)
+
 #define APPLE_DART1_PADDR_MASK	GENMASK_ULL(35, 12)
 
 /* Apple DART1 protection bits */
@@ -140,6 +144,10 @@ static void __dart_init_pte(struct dart_io_pgtable *data,
 
 	pte |= APPLE_DART_PTE_VALID;
 
+	/* subpage protection: always allow access to the entire page */
+	pte |= FIELD_PREP(APPLE_DART_PTE_SUBPAGE_START, 0);
+	pte |= FIELD_PREP(APPLE_DART_PTE_SUBPAGE_END, 0xfff);
+
 	for (i = 0; i < num_entries; i++)
 		ptep[i] = pte | paddr_to_iopte(paddr + i * sz, data);
 }
-- 
2.35.1

