Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978415AC4CF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 16:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbiIDOgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 10:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiIDOgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 10:36:41 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CF93341A
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 07:36:41 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id l65so6387173pfl.8
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 07:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=NdfnigtrHEZh15muBd+rCpQfRjPlMeIH5CSvnpjmko0=;
        b=NbGpf4ZNg9AralEfLb26vv9hdj9PXhVHU+vFtLPCVcRVeIeIyVHQhyd6k2O8xiyI5H
         ETt28o/YU15pnx5NXXSPjsCJuzrdc60WGo+kVcUenI/u1cizO9yQTvG/dUw/cNzN2wko
         yiMMphwmfzGvoMhtjLNaCtvPbheWzJziq79zrSQp+9Nn7BZB4SmdFf510tkmMzY7PsRG
         NzpemN2eXZtr4TFXIMjQ3d+oNHbnWoNA7OxdtJWflNIlAa/mnE6Cge+Ba4h7/fzPp/ZZ
         v3OPcENLDUjlO+cdzu73VO2Uw3fIDyt1VKL3UIC3ec/hg+FlEv8lbqQRjEM30KsGj62B
         2Z/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NdfnigtrHEZh15muBd+rCpQfRjPlMeIH5CSvnpjmko0=;
        b=bDo/Kc9U5U+FHHlLlymF/RmqufT+aikgRSG8beMaGSmaLSmfeXVunmFvo0ZhSTShc2
         YWnoLZEB/HMmONG9c6DZ58o7MAHtl3z3m2+Xw8FTIXTYXf8ygTK8orVzqZXOd4Su/Z9e
         Bw/TbHVkNJ/PTTzaCLwBXUMdFQwpROcMlsHbkigWTS6h1w1oAPEFV2xU7r3uAIMQqW4g
         CNdsDTZ9KqJnkrP+QKucnR9RLLJqruRcUqwAhy7bUUNaj2rsSgH/qpVv7tirJXa7pXLl
         q3n6NeNplIGaYn9fxJ2l7TntqOOvx3dfOXqu5fU1HxYQZjxl6qWgAx2XfSUhVrF4PSjn
         nfHg==
X-Gm-Message-State: ACgBeo0l5hRFXecuhpu6MyXhemJLP6LYf5W5FmieGOv59sXszf8lvnKz
        wg5NPxvKro/tXjL4Donu5A==
X-Google-Smtp-Source: AA6agR7bfU9mpvknEdGlX0LhuIj4O4yOLlgGbniqt6rVbT5slINQjvVxN9qKfP6vUWSZUP6kejGy2A==
X-Received: by 2002:a63:205:0:b0:42f:af15:b8d2 with SMTP id 5-20020a630205000000b0042faf15b8d2mr22259669pgc.251.1662302200447;
        Sun, 04 Sep 2022 07:36:40 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id a2-20020aa795a2000000b005360dc9c45csm5742389pfk.43.2022.09.04.07.36.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Sep 2022 07:36:39 -0700 (PDT)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] mm/damon/sysfs: simplify the judgement whether kdamonds are busy
Date:   Sun,  4 Sep 2022 22:36:06 +0800
Message-Id: <1662302166-13216-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

It is unnecessary to get the number of the running kdamond to judge
whether kdamonds are busy. Here we can use the
damon_sysfs_kdamond_running() helper and return -EBUSY directly
when finding a running kdamond. Meanwhile, merging with the judgement
that a kdamond has current sysfs command callback request to make
the code more clear.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 mm/damon/sysfs.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 7488e27c87c3..fe6c6870cf86 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2657,23 +2657,18 @@ static void damon_sysfs_kdamonds_rm_dirs(struct damon_sysfs_kdamonds *kdamonds)
 	kdamonds->kdamonds_arr = NULL;
 }
 
-static int damon_sysfs_nr_running_ctxs(struct damon_sysfs_kdamond **kdamonds,
+static bool damon_sysfs_kdamonds_busy(struct damon_sysfs_kdamond **kdamonds,
 		int nr_kdamonds)
 {
-	int nr_running_ctxs = 0;
 	int i;
 
 	for (i = 0; i < nr_kdamonds; i++) {
-		struct damon_ctx *ctx = kdamonds[i]->damon_ctx;
-
-		if (!ctx)
-			continue;
-		mutex_lock(&ctx->kdamond_lock);
-		if (ctx->kdamond)
-			nr_running_ctxs++;
-		mutex_unlock(&ctx->kdamond_lock);
+		if (damon_sysfs_kdamond_running(kdamonds[i]) ||
+		    damon_sysfs_cmd_request.kdamond == kdamonds[i])
+			return true;
 	}
-	return nr_running_ctxs;
+
+	return false;
 }
 
 static int damon_sysfs_kdamonds_add_dirs(struct damon_sysfs_kdamonds *kdamonds,
@@ -2682,15 +2677,9 @@ static int damon_sysfs_kdamonds_add_dirs(struct damon_sysfs_kdamonds *kdamonds,
 	struct damon_sysfs_kdamond **kdamonds_arr, *kdamond;
 	int err, i;
 
-	if (damon_sysfs_nr_running_ctxs(kdamonds->kdamonds_arr, kdamonds->nr))
+	if (damon_sysfs_kdamonds_busy(kdamonds->kdamonds_arr, kdamonds->nr))
 		return -EBUSY;
 
-	for (i = 0; i < kdamonds->nr; i++) {
-		if (damon_sysfs_cmd_request.kdamond ==
-				kdamonds->kdamonds_arr[i])
-			return -EBUSY;
-	}
-
 	damon_sysfs_kdamonds_rm_dirs(kdamonds);
 	if (!nr_kdamonds)
 		return 0;
-- 
2.27.0

