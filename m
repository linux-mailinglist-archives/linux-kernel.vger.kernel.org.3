Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43956470941
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245552AbhLJSuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245544AbhLJSuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:50:18 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55927C061746;
        Fri, 10 Dec 2021 10:46:43 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id n26so9244250pff.3;
        Fri, 10 Dec 2021 10:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=08X8xmhfWg+7yMJFfsUm7qWwhAIHbNlPzGyyf5Wh3CY=;
        b=YybsEZ0Fg9aCk2Epw/G1jArcwPDq0QDjSjNjSXSOV6HojR+gH9ZOPmUY9mjJg0+/7Q
         uJEYNsJKPkPQpVeGHaKkjqYJAsM25/yO3mMs+msOhf7M7gJ1nXvQa7TrlVslYR3iJwgM
         D/MLShgb1+8p5J0WjHkTuu2104tHsgMBHiI47q8hGWPM2f0WG0tBjG/Y+JXDAJPKfcgf
         HIf3+DJx85s/VKMryuL7/5s+7w2yFQtxhKGFxb0JcwazNbvI0/JQ1eM+QBbXjImkvsCI
         9Fkj3oo9IediIB+cV+5s8khR9RjsrLa3MAD3opv2CmzVYj1i34CUJHvdKbFrnbpRzHk3
         /QcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=08X8xmhfWg+7yMJFfsUm7qWwhAIHbNlPzGyyf5Wh3CY=;
        b=thGibkdUWavurJDo2xvHqVIKFioN+5/ePXQSITupqd/wlv99uTPjpQneXdgjrXm1oa
         173WiIi61XZY6lHMbj6Tc7y9jOESt2vTxfa04BR5bjBdwN3/qjQ1t3sQA8wNFHX/1Lc0
         ljEhaucRKQsukkMAaAGDBh2ki7xo/ODjYOdUkUs6G2CXkiQSf1of8cGoO6OaZU6pDb5l
         +5XVNy2En/vbO0KHM3YYPqJumEVNAG/2dZdV8FobKHeJeV/ciPMt9p5KCpfaGX8NTREY
         tbPhOS8MUDQRRmVqBqUxWtkBJQl5BEOxGbVYfjSohqyXfRbfoolo0IAHUC226XSzH+Uo
         jB+Q==
X-Gm-Message-State: AOAM533oNUjllVwRpW6don2wA/aaixBeVHb72V0wGdlA4txetgRWlSNg
        PGQ7PwK3MX3NRjSh2vRcovM=
X-Google-Smtp-Source: ABdhPJyJnJU0QvSPetd3ZdZtqkbM2EwGty9WKttw4Li4qX/edNmXbFca4sAQSDltzF41gOcbqtTXYQ==
X-Received: by 2002:aa7:9a1a:0:b0:4b0:9ff9:9f69 with SMTP id w26-20020aa79a1a000000b004b09ff99f69mr9653764pfj.26.1639162002763;
        Fri, 10 Dec 2021 10:46:42 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id w6sm4320334pfu.172.2021.12.10.10.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 10:46:42 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     Christoph Hellwig <hch@lst.de>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/1] of: unittest: fix warning on PowerPC frame size warning
Date:   Fri, 10 Dec 2021 13:46:35 -0500
Message-Id: <20211210184636.7273-2-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211210184636.7273-1-jim2101024@gmail.com>
References: <20211210184636.7273-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct device variable "dev_bogus" was triggering this warning
on a PowerPC build:

    drivers/of/unittest.c: In function 'of_unittest_dma_ranges_one.constprop':
    [...] >> The frame size of 1424 bytes is larger than 1024 bytes
             [-Wframe-larger-than=]

This variable is now dynamically allocated.

Fixes: e0d072782c734 ("dma-mapping: introduce DMA range map, supplanting dma_pfn_offset")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/of/unittest.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 481ba8682ebf..02c5cd06ad19 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -911,11 +911,18 @@ static void __init of_unittest_dma_ranges_one(const char *path,
 	if (!rc) {
 		phys_addr_t	paddr;
 		dma_addr_t	dma_addr;
-		struct device	dev_bogus;
+		struct device	*dev_bogus;
 
-		dev_bogus.dma_range_map = map;
-		paddr = dma_to_phys(&dev_bogus, expect_dma_addr);
-		dma_addr = phys_to_dma(&dev_bogus, expect_paddr);
+		dev_bogus = kzalloc(sizeof(struct device), GFP_KERNEL);
+		if (!dev_bogus) {
+			unittest(0, "kzalloc() failed\n");
+			kfree(map);
+			return;
+		}
+
+		dev_bogus->dma_range_map = map;
+		paddr = dma_to_phys(dev_bogus, expect_dma_addr);
+		dma_addr = phys_to_dma(dev_bogus, expect_paddr);
 
 		unittest(paddr == expect_paddr,
 			 "of_dma_get_range: wrong phys addr %pap (expecting %llx) on node %pOF\n",
@@ -925,6 +932,7 @@ static void __init of_unittest_dma_ranges_one(const char *path,
 			 &dma_addr, expect_dma_addr, np);
 
 		kfree(map);
+		kfree(dev_bogus);
 	}
 	of_node_put(np);
 #endif
-- 
2.17.1

