Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11952517D5A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 08:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiECGeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 02:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiECGeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 02:34:07 -0400
X-Greylist: delayed 452 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 02 May 2022 23:30:35 PDT
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3C1381A3;
        Mon,  2 May 2022 23:30:35 -0700 (PDT)
Received: from coburn.home.jannau.net (p579ad988.dip0.t-ipconnect.de [87.154.217.136])
        by soltyk.jannau.net (Postfix) with ESMTPSA id E76EF26E9B4;
        Tue,  3 May 2022 08:23:02 +0200 (CEST)
From:   Janne Grunau <j@jannau.net>
To:     iommu@lists.linux-foundation.org
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/4] iommu/io-pgtable: Add DART subpage protection support
Date:   Tue,  3 May 2022 08:22:59 +0200
Message-Id: <20220503062301.20872-3-j@jannau.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503062301.20872-1-j@jannau.net>
References: <20220503062301.20872-1-j@jannau.net>
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
---
 drivers/iommu/io-pgtable-arm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 94ff319ae8ac..71570bbc9096 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -10,6 +10,7 @@
 #define pr_fmt(fmt)	"arm-lpae io-pgtable: " fmt
 
 #include <linux/atomic.h>
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/io-pgtable.h>
 #include <linux/kernel.h>
@@ -133,6 +134,9 @@
 #define APPLE_DART_PTE_PROT_NO_WRITE (1<<7)
 #define APPLE_DART_PTE_PROT_NO_READ (1<<8)
 
+#define APPLE_DART_PTE_SUBPAGE_START	GENMASK_ULL(63, 52)
+#define APPLE_DART_PTE_SUBPAGE_END	GENMASK_ULL(51, 40)
+
 /* IOPTE accessors */
 #define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))
 
@@ -273,6 +277,12 @@ static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
 	else
 		pte |= ARM_LPAE_PTE_TYPE_BLOCK;
 
+	if (data->iop.fmt == APPLE_DART) {
+		/* subpage protection: always allow access to the entire page */
+		pte |= FIELD_PREP(APPLE_DART_PTE_SUBPAGE_START, 0);
+		pte |= FIELD_PREP(APPLE_DART_PTE_SUBPAGE_END, 0xfff);
+	}
+
 	for (i = 0; i < num_entries; i++)
 		ptep[i] = pte | paddr_to_iopte(paddr + i * sz, data);
 
-- 
2.35.1

