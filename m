Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7EF5A98F1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbiIANdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbiIANcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:32:42 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F1A1095
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 06:29:14 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id se27so26948434ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 06:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=CA0Tu1QtRj1CuC30d2aawaIrEzLi0kZytJOI0Gq2tX8=;
        b=bhGYgTnQvyhLVFi0OIyswolIvFUgRdw1839k4Yye7jvNRi9m83S254tvyswacDzXte
         c/7SaCfEXPyVllpvKVenXumkvBeAjQHOVwxKY7/+vE9iFNXgGz9XtrsEnyCPsMaWRnWe
         BF9jEufZX9S7LKidZnhrJC8zQkoF17pE8d4S3VgdpN9j1JOp+KWkb7bEjR8/PKLDC9rH
         vUnGb2o4S5mGu+q6n/cRjLYQTlB25DQi2p72amXT87W6enqJdopkKIbCgWGb8DCTeoLr
         etFsCGSwzuYe0vOMtxJmO2klxCWkDseE5cR5tQrjsEOxccxwl5heCbs1TR/i4+dhUuCy
         UqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=CA0Tu1QtRj1CuC30d2aawaIrEzLi0kZytJOI0Gq2tX8=;
        b=Am1AiAiQCdOILMTVJDqQnneiJqidE0xo0laiUYPi2p+b3MAJcn6Mktel2UloB6MdoS
         o1CifGO3PzK9BWYLK9/Q6ARjI+VdIHVgtbJC+tgpd5e0bb8MDF65AbG69XiEq3otOMHF
         YyV+E8Hi1lMWfbOi25QESsulaJ2uABpCGO/pSGqdyf1p0JlJnBveL/1VJTEfuWmIKdr9
         Y33BjWL1l9BlVsCJAWeupSf9MLEUUY9QspoXSn55n+xrg3q7+sOF5XDe31lMoBiKC9IX
         c7iU2OMYF4WwEt0PPOj+4P/aPPrOVTi5dbS0n7AC0YrjLJdSWY7rxLAX4/TU8TT+KoKf
         z8lA==
X-Gm-Message-State: ACgBeo1zbUilSl1mJo0nNtrhNwn2i5ZiRmBtSvAiwzjauz/yG+OMyceZ
        Oy9h1g1UlReUgGu3d/e/Mlw=
X-Google-Smtp-Source: AA6agR7Jfbj56Zl7x6lrxkSTXRbOfYUL3n86WNDUy2lVZKh5xpDb3/epr0nEPm3L8DzGitMIw75Xdg==
X-Received: by 2002:a17:907:2894:b0:741:4e40:94fe with SMTP id em20-20020a170907289400b007414e4094femr16588744ejc.606.1662038953090;
        Thu, 01 Sep 2022 06:29:13 -0700 (PDT)
Received: from localhost.localdomain (host-87-1-103-238.retail.telecomitalia.it. [87.1.103.238])
        by smtp.gmail.com with ESMTPSA id n2-20020a170906088200b0073d678f50bfsm8460612eje.164.2022.09.01.06.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 06:29:11 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] swiotlb: Replace kmap_atomic() with memcpy_{from,to}_page()
Date:   Thu,  1 Sep 2022 15:29:06 +0200
Message-Id: <20220901132906.14063-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of kmap_atomic() is being deprecated in favor of
kmap_local_page(), which can also be used in atomic context (including
interrupts).

Replace kmap_atomic() with kmap_local_page(). Instead of open coding
mapping, memcpy(), and un-mapping, use the memcpy_{from,to}_page() helper.

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 kernel/dma/swiotlb.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c5a9190b218f..a28ac23ad8db 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -549,9 +549,8 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 	}
 
 	if (PageHighMem(pfn_to_page(pfn))) {
-		/* The buffer does not have a mapping.  Map it in and copy */
 		unsigned int offset = orig_addr & ~PAGE_MASK;
-		char *buffer;
+		struct page *page;
 		unsigned int sz = 0;
 		unsigned long flags;
 
@@ -559,12 +558,11 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 			sz = min_t(size_t, PAGE_SIZE - offset, size);
 
 			local_irq_save(flags);
-			buffer = kmap_atomic(pfn_to_page(pfn));
+			page = pfn_to_page(pfn);
 			if (dir == DMA_TO_DEVICE)
-				memcpy(vaddr, buffer + offset, sz);
+				memcpy_from_page(vaddr, page, offset, sz);
 			else
-				memcpy(buffer + offset, vaddr, sz);
-			kunmap_atomic(buffer);
+				memcpy_to_page(page, offset, vaddr, sz);
 			local_irq_restore(flags);
 
 			size -= sz;
-- 
2.37.2

