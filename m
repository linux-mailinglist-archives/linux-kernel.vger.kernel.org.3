Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D5451E3C9
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 05:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445430AbiEGD3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 23:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442292AbiEGD3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 23:29:14 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0603B1DB
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 20:25:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VCUhL69_1651893913;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VCUhL69_1651893913)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 07 May 2022 11:25:24 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     sj@kernel.org
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] mm/damon/reclaim: Use resource_size function on resource object
Date:   Sat,  7 May 2022 11:25:12 +0800
Message-Id: <20220507032512.129598-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

./mm/damon/reclaim.c:241:30-33: WARNING: Suspicious code. resource_size
is maybe missing with res.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 mm/damon/reclaim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index f37c5d4b27fa..8efbfb24f3a1 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -238,7 +238,7 @@ static int walk_system_ram(struct resource *res, void *arg)
 {
 	struct damon_reclaim_ram_walk_arg *a = arg;
 
-	if (a->end - a->start < res->end - res->start) {
+	if (a->end - a->start < resource_size(res)) {
 		a->start = res->start;
 		a->end = res->end;
 	}
-- 
2.20.1.7.g153144c

