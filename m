Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF17487041
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 03:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345345AbiAGCSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 21:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344454AbiAGCR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 21:17:59 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E641C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 18:17:59 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id f138so4575801qke.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 18:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SBYBagvggg03DwKt9otfHsLIPVT6M43LhOwukGYuXUk=;
        b=Sy/9Uasu+Otq8grGnBaWjIKNca9j5Ulw4E54DZSJU9tQxqJbyIS5Yl3TBt9aVyQl03
         SDmI2d6L3aWhErx9yzu5HQQnt+iaCDrGeg9dTsu1Znq7rqGwH8896Jikcw94pVX9T/w/
         47Zvim1y1dNmKoWFwRJ80R+iy2vTtNwZAnKSOzh/xvo4PnAe2LR78mqK011pcjHK8fcd
         8bLW1o6f0yP916KYwL3/V58Wk8dFEZeGHVF9wxnQas8g5Rhxi5elgFF9AL0ySncce+0h
         rEIuIhqrJziFyDvqSM9n7XjCliE+t2nBz0WCe01w3c5BNLwCBdU3IVrEE8mkiJY/Vw3S
         pDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SBYBagvggg03DwKt9otfHsLIPVT6M43LhOwukGYuXUk=;
        b=yN46oCJi19YXAGZQ/rpHFBR1ou0PXVZ0NfPV//5yPnYuvUPoUrs31AnqzmcZGqjZQi
         H3EfQpDb6jkJReqGUUjdyC7sB1dtmvJpH0M30+RwFvjLwqVPbVHaUCVaBHMV55tThery
         IWsERoshnhxvbXrUE8CcM4Ere624kH1TaN5E1EU5QJQl6u/EywBoNSui5gF/y+DPy7IJ
         /FnRIxR52+8yn0+XwDsNuQF7ZyDPl8z74bqdoZeA5VcRMxUjPTXeom0zteW5S+mJa9U/
         dKXdMnXcafsa0W1ZLVcIs+JKSPh4JORNOm486JJBtSVGc5YBRkL4wfc/hJeMEgis0nJk
         umpg==
X-Gm-Message-State: AOAM533qgjxZTYblrJOS4p3e9UMseJi5bN0ghLxe+YXsNWpUMcydnZWZ
        HEHAQSO+3AAbmd/iX778z00=
X-Google-Smtp-Source: ABdhPJzCmUe2aahWL31EXQn8osBohaFXJD+vj9UD1cu/3qosviYk4/6kjmfOCgNCUI1pwKR0p59aaw==
X-Received: by 2002:a05:620a:2208:: with SMTP id m8mr40526762qkh.126.1641521878342;
        Thu, 06 Jan 2022 18:17:58 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id t11sm1092323qkm.96.2022.01.06.18.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 18:17:57 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] mm/page_alloc.c: Use div64_ul instead of do_div
Date:   Fri,  7 Jan 2022 02:17:51 +0000
Message-Id: <20220107021751.621522-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

do_div() does a 64-by-32 division. Here the divisor is an unsigned long
which on some platforms is 64 bit wide. So use div64_ul instead of do_div
to avoid a possible truncation.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 mm/page_alloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8dd6399bafb5..60469b616ac1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8431,7 +8431,7 @@ static void __setup_per_zone_wmarks(void)
 
 		spin_lock_irqsave(&zone->lock, flags);
 		tmp = (u64)pages_min * zone_managed_pages(zone);
-		do_div(tmp, lowmem_pages);
+		tmp = div64_ul(tmp, lowmem_pages);
 		if (is_highmem(zone)) {
 			/*
 			 * __GFP_HIGH and PF_MEMALLOC allocations usually don't
@@ -8804,7 +8804,7 @@ void *__init alloc_large_system_hash(const char *tablename,
 	/* limit allocation size to 1/16 total memory by default */
 	if (max == 0) {
 		max = ((unsigned long long)nr_all_pages << PAGE_SHIFT) >> 4;
-		do_div(max, bucketsize);
+		max = div64_ul(max, bucketsize);
 	}
 	max = min(max, 0x80000000ULL);
 
-- 
2.25.1

