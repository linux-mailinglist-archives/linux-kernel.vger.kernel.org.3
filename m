Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFC74706C0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244397AbhLJRQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhLJRQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:16:39 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1D5C061746;
        Fri, 10 Dec 2021 09:13:04 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id r138so8568891pgr.13;
        Fri, 10 Dec 2021 09:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=AFS6TxWHilPzoarcvHvazXfKaWUjST4kWlEN/2wq70Y=;
        b=kxtGM2elbPa4ecF7Zc9+WHOQ3XaExGlAd14O/gSfSVlWgszkNAvNANitSVfBUCHfoq
         kd2NpjonuaKqXnrzPqnmQsrezfEGQYzL5alnTbye8L7gpytQUk7iwnAcnGl+rFrooCEE
         1L2ve+FCUvKPac+sjvxgzLsQnL40C7TGvVpVt6wNXCMYy6oyrR7K3a29XR72MxZ8+sDn
         asreJSrL9YNksy3/mdUAGYsHh6NxA8bQtuqu9NwTyB1hcC0ujutn/wfnLYm5BlLSYMks
         hYUF5xu7CPTScEbVloe0QAFXkqJ3AkVTmCKjtcVTi9vANCoi7JZewAJKJddSelArwVW7
         2sWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AFS6TxWHilPzoarcvHvazXfKaWUjST4kWlEN/2wq70Y=;
        b=Kga0S2ajmeyo/Kr0mik/adKxbxe9zDerLf4KpuuEkJf6iYmXCw/YO1ZsWoJTyvPn8C
         ElMFK7NnXaFNSqKb2aGrmWAz3K2rUh+UxwShI/wMAiartSKTUKuNmectCNCcbLNiq1vZ
         DdLC3hHeUY3jG3b0o8gEVZlz4Y0RfvZBV9S3CBQDfGL1NbLsH4iUwiGhrFwHS4QaL6f5
         n2Kght/hN0RQlnEdn0OoLSLMwzwN+PBnjm4puvFlXjqz8frpCNK17XOgBV6EAuON+kcF
         QYaAJ19PYBZpyxZbcSvNNYZ6bA/g64LBcfMa/7bCFHYFQZhsW0kaPsf2fsWH3pcj6dl7
         RE7w==
X-Gm-Message-State: AOAM5336ybOeNk2wJ4yZ+lBqpmFd+3rgTMX3VXIaKdy9BiHcLy1AVuOK
        8wi5BZtH1BaAdOfU9jPx8DI=
X-Google-Smtp-Source: ABdhPJxXFqayeCbH9o/vZ3cVTI/xA04jkeFhemOQTzE1P2Is5B/Q8vody4wUfqfMNGVFWcC4xFguRw==
X-Received: by 2002:a63:4a4b:: with SMTP id j11mr40534020pgl.580.1639156384050;
        Fri, 10 Dec 2021 09:13:04 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id qe12sm13926813pjb.29.2021.12.10.09.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 09:13:03 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     Christoph Hellwig <hch@lst.de>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1] of: unittest: fix warning on PowerPC frame size warning
Date:   Fri, 10 Dec 2021 12:12:58 -0500
Message-Id: <20211210171258.41138-1-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
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
 drivers/of/unittest.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 481ba8682ebf..945cda299a63 100644
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

base-commit: c741e49150dbb0c0aebe234389f4aa8b47958fa8
-- 
2.17.1

