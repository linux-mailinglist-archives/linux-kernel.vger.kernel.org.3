Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790095A76C0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 08:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiHaGi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 02:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiHaGiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:38:23 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD33BD75A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 23:38:22 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-33ef3e5faeeso190998247b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 23:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=It3y/STunI05Ydz1QHfujdG313dUyBru08R+qGI7HoM=;
        b=bA2Qx/GQl3M3N9A8PUFo9hekqjnouCvqIFiijACBUirMx/DolZPyJR/G96OVlAoZkj
         taUpfJ8birvC5nERsAybS7mclQxIjcWwrUWZOj+hJyyCZ6fGo8Yo43RCreFN7/wWBxIM
         kOUrZJLrLLNG27GYus10Nrns978dPi93yD801SyYNRSqnoamewGNGufUej0g/mqncUrR
         PkcAAmyK9RUfYVjqPOFankeGldXgjIbxLQpFy9Fk8BRAHLZeDVbG+oUnOX1Za0yM2elK
         XoeNhV6Ui6e1NIg1hvb/WA7uTXfxmfZnl2z7uyKEi+AItM2ctv5piL6UBvhcbQNfaj6A
         43kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=It3y/STunI05Ydz1QHfujdG313dUyBru08R+qGI7HoM=;
        b=te7I2UOJsGDYIXNydG8j5BjsLJq0MTfenwfcCaVW6Wp0Agy8uU2GB7aGmIG4yzMXSV
         9DOuCEBZUS898IXdUHj+bI2uTGf7E6cLbXnjsH2W5WdiEPPzTsGpjEEVBDtbm7VEQUzc
         ZIW2FxZmBqAlaKpxVfXbZP6wXB89D3I0ZRdI4LbibYAvN+hxG0uwZdXIR0GmdnkuTRix
         hAtopPb33//F7Y2OQs2pZxSR9V9Uan5eGDeFUabrPGt/Oi7cYCSQsVnPPCFBx7+UM9ek
         7zdBUfcuYmNrrJqI9f0hihBy4lDX3hwTFT6VPfAyvs9x61OoxzdZoTlqj8SY/oEIkBFS
         kFBQ==
X-Gm-Message-State: ACgBeo15clX50cHe80dVuYXgxe3sX6apLrTfZhZLmkPqILqftx0ocCnw
        mQMqBKc4qfg61Bxt3h+1L6eQwjz5uxA=
X-Google-Smtp-Source: AA6agR4BQf9ZFM65KZ1OjONT0vPQ2tZZiq9X3I+KHd0i3Y++KKDlpOhXPDjfwUav9YJIu2iR/eJPWprCakw=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:103:daa9:a72c:751a])
 (user=yuzhao job=sendgmr) by 2002:a5b:3ce:0:b0:66f:4692:27a2 with SMTP id
 t14-20020a5b03ce000000b0066f469227a2mr14479161ybp.167.1661927901645; Tue, 30
 Aug 2022 23:38:21 -0700 (PDT)
Date:   Wed, 31 Aug 2022 00:38:18 -0600
In-Reply-To: <20220829232934.3277747-1-yuzhao@google.com>
Message-Id: <20220831063818.3902572-1-yuzhao@google.com>
Mime-Version: 1.0
References: <20220829232934.3277747-1-yuzhao@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v2] Revert "swiotlb: panic if nslabs is too small"
From:   Yu Zhao <yuzhao@google.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Dongli Zhang <dongli.zhang@oracle.com>
Cc:     iommu@lists.linux.dev, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 0bf28fc40d89b1a3e00d1b79473bad4e9ca20ad1.

Reasons:
  1. new panic()s shouldn't be added [1].
  2. It does no "cleanup" but breaks MIPS [2].

v2: properly solved the conflict [3] with
commit 20347fca71a38 ("swiotlb: split up the global swiotlb lock")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

[1] https://lore.kernel.org/r/CAHk-=wit-DmhMfQErY29JSPjFgebx_Ld+pnerc4J2Ag990WwAA@mail.gmail.com/
[2] https://lore.kernel.org/r/20220820012031.1285979-1-yuzhao@google.com/
[3] https://lore.kernel.org/r/202208310701.LKr1WDCh-lkp@intel.com/

Fixes: 0bf28fc40d89b ("swiotlb: panic if nslabs is too small")
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 kernel/dma/swiotlb.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index c5a9190b218f..dd8863987e0c 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -326,9 +326,6 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 		swiotlb_adjust_nareas(num_possible_cpus());
 
 	nslabs = default_nslabs;
-	if (nslabs < IO_TLB_MIN_SLABS)
-		panic("%s: nslabs = %lu too small\n", __func__, nslabs);
-
 	/*
 	 * By default allocate the bounce buffer memory from low memory, but
 	 * allow to pick a location everywhere for hypervisors with guest
@@ -341,8 +338,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 	else
 		tlb = memblock_alloc_low(bytes, PAGE_SIZE);
 	if (!tlb) {
-		pr_warn("%s: Failed to allocate %zu bytes tlb structure\n",
-			__func__, bytes);
+		pr_warn("%s: failed to allocate tlb structure\n", __func__);
 		return;
 	}
 

base-commit: dcf8e5633e2e69ad60b730ab5905608b756a032f
-- 
2.37.2.672.g94769d06f0-goog

