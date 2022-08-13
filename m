Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC59591952
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 09:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbiHMHwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 03:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiHMHwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 03:52:31 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A3112772
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 00:52:29 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id z187so2756778pfb.12
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 00:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=BVeFtMFA/+Kv9HpmKKssuQiPaD1FxaNzd0BlFICyHyA=;
        b=isDTFt0C8pDp8R1tIQXeCPdcJca6J5ihyBkbai+4ufxh/7a9tnRVKRnzBV8KSwCgPS
         hq8NT3J+89Zwk7WvjB4BiLj9sFxKvF9POPd+Au4xmgGovAColBNaRLS0aF0HkuaL8VEr
         2HPP1QjwKcAbCbftPb4nbbjO4SKvITlBVLi0fPw82bphUKSKRsX9pgLnU1cg+BpDNLuK
         EwmsbinUa2GgLO9ZD2++H5mkGlj5HWA3mkBPXmnJssVJgL3VnkaTWKQ/tdtWQeG9vxQ0
         hlzC7srEWA6iLWv2HUkmeuwlAK0syU6ZtUwwBPV2fraE6AmP/+kLCq6GdEwZctLQuY2t
         xoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=BVeFtMFA/+Kv9HpmKKssuQiPaD1FxaNzd0BlFICyHyA=;
        b=GP0K8WvEM/F0q5/siJW70j/sNAKQAoiLkLLD160SUpcP6RBq3Eddfn8E7gPLAa/8fZ
         ee/TBedfiYb+BiWzCUWAGjF0VBvNhJg6HxLdUFoybrq6FIjMPMzTHQLHj5BL5TjZjt1R
         Nq6PBKs+W/zBzsB7NikNWjfElCjZbsBQXQi5LiktqNklVNWM38eliGqOYT9k1DUEEG2p
         8EhOrqJbgtGqB73jjp0O2xXKE1JVW+UY8rpXBr4AafvWZ0diGvb69IV9OnnAjxhHjW5D
         e+dzpjx0ypc9KBeThtRvDXb49RaywrXLW3b+OBowGx5eaW6FJZceRBkT1lB37dwWPlv3
         5deQ==
X-Gm-Message-State: ACgBeo0hNcMZnJhnNl7HiDaQAVBOZWoJjpm/E1hjkfjs9DtCIsne1FN8
        /8I0J2/LhKXyVtj1woc40cErPvToXh8=
X-Google-Smtp-Source: AA6agR4gjlHBh540xm1dDJ+cHnCQVHhbwFJsleq48spTWvy9nDF8TcgQRBmsoHOhy99S5IuE2rsuRg==
X-Received: by 2002:a63:c5:0:b0:40d:d290:24ef with SMTP id 188-20020a6300c5000000b0040dd29024efmr6018064pga.141.1660377149105;
        Sat, 13 Aug 2022 00:52:29 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902e98c00b0016bee668a5asm3024553plb.161.2022.08.13.00.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 00:52:28 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     akpm@linux-foundation.org, iamjoonsoo.kim@lge.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        CGEL ZTE <cgel.zte@gmail.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        wangyong <wang.yong12@zte.com.cn>
Subject: [PATCH 2/2] mm/page_io: count submission time as thrashing delay for delayacct
Date:   Sat, 13 Aug 2022 07:52:08 +0000
Message-Id: <20220813075207.58493-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Yang Yang <yang.yang29@zte.com.cn>

Once upon a time, we only support accounting thrashing of page cache.
Then Joonsoo introduced workingset detection for anonymous pages and
we gained the ability to account thrashing of them[1].

Likes PSI, we count submission time because When the device is congested,
or the submitting cgroup IO-throttled, submission can be a significant
part of overall IO time.

This patch is based on "delayacct: support re-entrance detection of
thrashing accounting".

[1] commit aae466b0052e ("mm/swap: implement workingset detection for anonymous LRU")

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Reviewed-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Reviewed-by: wangyong <wang.yong12@zte.com.cn>
---
 mm/page_io.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 68318134dc92..d2f5e0527af6 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -453,18 +453,21 @@ int swap_readpage(struct page *page, bool synchronous,
 	struct swap_info_struct *sis = page_swap_info(page);
 	bool workingset = PageWorkingset(page);
 	unsigned long pflags;
+	unsigned long dflags;
 
 	VM_BUG_ON_PAGE(!PageSwapCache(page) && !synchronous, page);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(PageUptodate(page), page);
 
 	/*
-	 * Count submission time as memory stall. When the device is congested,
-	 * or the submitting cgroup IO-throttled, submission can be a
-	 * significant part of overall IO time.
+	 * Count submission time as memory stall and delay. When the device
+	 * is congested, or the submitting cgroup IO-throttled, submission
+	 * can be a significant part of overall IO time.
 	 */
-	if (workingset)
+	if (workingset) {
+		delayacct_thrashing_start(&dflags);
 		psi_memstall_enter(&pflags);
+	}
 	delayacct_swapin_start();
 
 	if (frontswap_load(page) == 0) {
@@ -513,8 +516,10 @@ int swap_readpage(struct page *page, bool synchronous,
 	bio_put(bio);
 
 out:
-	if (workingset)
+	if (workingset) {
+		delayacct_thrashing_end(&dflags);
 		psi_memstall_leave(&pflags);
+	}
 	delayacct_swapin_end();
 	return ret;
 }
-- 
2.25.1

