Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5A1465C1A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 03:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354659AbhLBCZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 21:25:37 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:60467 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231411AbhLBCZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 21:25:32 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Uz7EqZm_1638411728;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Uz7EqZm_1638411728)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Dec 2021 10:22:09 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     djrscally@gmail.com
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] media: i2c: Simplify bool conversion
Date:   Thu,  2 Dec 2021 10:22:03 +0800
Message-Id: <1638411723-24179-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:
./drivers/media/i2c/ov5693.c:989:46-51: WARNING: conversion to bool not
needed here
./drivers/media/i2c/ov5693.c:991:46-51: WARNING: conversion to bool not
needed here

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/media/i2c/ov5693.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov5693.c b/drivers/media/i2c/ov5693.c
index 2784fcf..4a5aa6e0 100644
--- a/drivers/media/i2c/ov5693.c
+++ b/drivers/media/i2c/ov5693.c
@@ -986,9 +986,9 @@ static int ov5693_set_fmt(struct v4l2_subdev *sd,
 
 	mutex_lock(&ov5693->lock);
 
-	ov5693->mode.binning_x = hratio > 1 ? true : false;
+	ov5693->mode.binning_x = hratio > 1;
 	ov5693->mode.inc_x_odd = hratio > 1 ? 3 : 1;
-	ov5693->mode.binning_y = vratio > 1 ? true : false;
+	ov5693->mode.binning_y = vratio > 1;
 	ov5693->mode.inc_y_odd = vratio > 1 ? 3 : 1;
 
 	ov5693->mode.vts = __ov5693_calc_vts(fmt->height);
-- 
1.8.3.1

