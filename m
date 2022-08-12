Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79C45909D3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 03:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbiHLB1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 21:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235268AbiHLB1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 21:27:08 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C5D9BB51
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 18:27:07 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id w11-20020a17090a380b00b001f73f75a1feso7000109pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 18:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=r6pkBLYew73BseP+hLTOhqoRkIsBep/iLPB2yjs5hu4=;
        b=I0mTgVUKEsBOB15afJoGgRDCtfUOYBLEclD96bBTCk6xZwMNtvse4Yg3mFsZKl5ky7
         3R9SCHwbkSjq2N8RaMQVScSXxTr+Fp20m6PaunXeE5hzKvEu/cYysYKAhQAMG5ITBPNO
         iVjhe0vTHnMk234H/RLfdNUVjzkgoqonUlV7T7pLCHCh5j+5UKd27FUtHJOpN2aL8cON
         tuPbypDARlYH31Zanrsvv6fPxUMzVc00AS1i9NL6FsV0J6nFLllCTrBGXfUMGI8LGhMT
         PNM1JTuXXXxuRaEVMzmJLcSi2cnT+Qv3GeWEcZUhmCnt25JH+X6yMdwuRcYWBq3fR8d0
         OO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=r6pkBLYew73BseP+hLTOhqoRkIsBep/iLPB2yjs5hu4=;
        b=1e0QxGQfLgdBYXXRfKbvQ90GqwPEvZAYZ3lKBc7YwHLYSEeTQ+32vKSta31gJaRptM
         //oJzdySTHLQw2qotEnhmDzohSD+WdQCMqAibzeTRjGZ0dHfh3SJvoEPwB8tb2HKROmM
         M0t+ywpFpr5TYgb/umgtCcAYMyh2fr6btpSQ522KeXfc4/f30xZPAEBjOgiXaiCPgxy9
         +t0j0VcLahfi20n9K9lWzj2V5lrOjaHRCi6ev6GbW+hQySoU7NMArpXvBkGKZLt4QMh7
         qmIysWYu+hqdAVISCHm6ckklww+ae0pmw9y8ZIx47s8i4sgV3TecD0xiLzRghHycrbr9
         YZLg==
X-Gm-Message-State: ACgBeo1WuuobvFJGgiEzlfd8cyVsaJ7Pao2SM3cclw1XeonRvYLt2How
        mjmoV2nN49wKszl37tfac84ZvhWo7anW8hdt
X-Google-Smtp-Source: AA6agR4K5xv36FYebO1ewf095xyPwaXieUgWaIsc0nTbqCWmatPVjFUaQabDKVGKhdZQ5wztSWB5+w==
X-Received: by 2002:a17:902:da89:b0:170:a235:5993 with SMTP id j9-20020a170902da8900b00170a2355993mr1720629plx.94.1660267626881;
        Thu, 11 Aug 2022 18:27:06 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id 128-20020a621886000000b0052d200c8040sm322671pfy.211.2022.08.11.18.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 18:27:06 -0700 (PDT)
From:   Zeng Jingxiang <zengjx95@gmail.com>
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zeng Jingxiang <linuszeng@tencent.com>
Subject: [PATCH] mm/damon: remove dead code in damon_lru_sort_enabled_store()
Date:   Fri, 12 Aug 2022 09:24:59 +0800
Message-Id: <20220812012459.481215-1-zengjx95@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zeng Jingxiang <linuszeng@tencent.com>

The variable damon_lru_sort_initialized is always true, causing the
corresponding conditional expression cannot be executed.

Assigning true to damon_lru_sort_initialized here
544         damon_lru_sort_initialized = true;

The value of damon_lru_sort_initialized is always true.
As a result, the following expression cannot be executed.

463         if (!damon_lru_sort_initialized)
464                 return rc;

Fixes: 40e983cca927 ("mm/damon: introduce DAMON-based LRU-lists Sorting")
Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
---
 mm/damon/lru_sort.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index 9de6f00a71c5..e2a656e1b728 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -450,8 +450,6 @@ static void damon_lru_sort_timer_fn(struct work_struct *work)
 }
 static DECLARE_DELAYED_WORK(damon_lru_sort_timer, damon_lru_sort_timer_fn);
 
-static bool damon_lru_sort_initialized;
-
 static int damon_lru_sort_enabled_store(const char *val,
 		const struct kernel_param *kp)
 {
@@ -460,9 +458,6 @@ static int damon_lru_sort_enabled_store(const char *val,
 	if (rc < 0)
 		return rc;
 
-	if (!damon_lru_sort_initialized)
-		return rc;
-
 	schedule_delayed_work(&damon_lru_sort_timer, 0);
 
 	return 0;
@@ -541,7 +536,6 @@ static int __init damon_lru_sort_init(void)
 
 	schedule_delayed_work(&damon_lru_sort_timer, 0);
 
-	damon_lru_sort_initialized = true;
 	return 0;
 }
 
-- 
2.36.1

