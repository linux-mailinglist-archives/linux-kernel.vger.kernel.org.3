Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C290475104
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 03:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239221AbhLOCjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 21:39:04 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:40253 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229492AbhLOCjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 21:39:03 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V-g8tNf_1639535941;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V-g8tNf_1639535941)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 15 Dec 2021 10:39:01 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     jaegeuk@kernel.org
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] f2fs: Simplify bool conversion
Date:   Wed, 15 Dec 2021 10:38:58 +0800
Message-Id: <20211215023858.33303-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:
./fs/f2fs/sysfs.c:491:41-46: WARNING: conversion to bool not needed here

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/f2fs/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 9e1cf44642ae..530c36b89bf1 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -488,7 +488,7 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 
 	if (!strcmp(a->attr.name, "gc_urgent_high_remaining")) {
 		spin_lock(&sbi->gc_urgent_high_lock);
-		sbi->gc_urgent_high_limited = t == 0 ? false : true;
+		sbi->gc_urgent_high_limited = t != 0;
 		sbi->gc_urgent_high_remaining = t;
 		spin_unlock(&sbi->gc_urgent_high_lock);
 
-- 
2.20.1.7.g153144c

