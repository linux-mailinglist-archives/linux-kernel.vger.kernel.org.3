Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87DC4628D2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 01:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhK3AIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 19:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbhK3AIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 19:08:39 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6010DC061574;
        Mon, 29 Nov 2021 16:05:21 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id j5-20020a17090a318500b001a6c749e697so12691844pjb.1;
        Mon, 29 Nov 2021 16:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wkjZyN1c2Y9GQc80h4xdKR14ovJk4gf09rJILRmjtTU=;
        b=Ub/o3b66eoqONKeNJPi0CUuJknTbGXftG779TZbCg9Nki8v/P9X5jP9FvdbrtAKqXs
         Ih+9NneVY5oZST2rk3xDbqkeUlc4IyqQLDaslvJlOMkYtvuxXHuA4GKrKoXCxu1MD3xc
         fTB1VpxvkMet8h8Yq28v4+jSeFaBpqUkc9kdSLbMLS78wBauj4exbIXMv/1yv7g9WKWX
         YMi0ZagFfBRVQOwFvxKvkPTBUkqS9YubHBPU8zoJLf5asQM3C1qX0XgWCSBVNWs5BRky
         3I54oyTnUVM0hQBmVjedzAFFjsE76KVSQX7FNRSLsGU9iBeOIAOw4u2hyO9c3avloh4v
         av1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wkjZyN1c2Y9GQc80h4xdKR14ovJk4gf09rJILRmjtTU=;
        b=dEn2t72T+OXnHkaCeQQNmicrvwKfg9BmYninzREQjF6aPdV6GW5SOb3X4+7c9nha2k
         pnoUN2NGQzzsejola9+/Ek7VNYJ6DmVFylFW+LWq1Cuk1+mqh67oYMwfQL28zPQXefgx
         9/mVti4MRacYkOm9QguhNQsYDxThSlekyW8XOnt2MtE4HtxkC1BmAHMGao5k7kAH49Ua
         5FOekSReHPPPsTeUX+2W1q5CQK0kF90Rt7qcTQn9lyCcFL/Maj5+6BVoPiSOYfkgZMUL
         +T9Nhg/nDEtk8nOIE/ztCqPOrH9TYmwdTx5GPXWRD/kOwtseg9FqRz0C9+6eRrdiKXAH
         vu8g==
X-Gm-Message-State: AOAM531/zzbY8UA/I70n50+F2+FysmN06Yit8/M8WzovufYA4NkGS2ZT
        LGCVoGeH9qSV8+9BlscTsKU=
X-Google-Smtp-Source: ABdhPJwbgQDyoddUomQxlAnMDmC3A6cZb4Y//MC0zyw0PYbnZNXnkemRJbearZQHIbRmSYRk+IoUrA==
X-Received: by 2002:a17:90a:ba13:: with SMTP id s19mr1687317pjr.62.1638230720938;
        Mon, 29 Nov 2021 16:05:20 -0800 (PST)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id k1sm19543223pfu.31.2021.11.29.16.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 16:05:20 -0800 (PST)
From:   davidcomponentone@gmail.com
X-Google-Original-From: yang.guang5@zte.com.cn
To:     ducheng2@gmail.com
Cc:     davidcomponentone@gmail.com, tzimmermann@suse.de,
        penguin-kernel@I-love.SAKURA.ne.jp, gregkh@linuxfoundation.org,
        cssk@net-c.es, yang.guang5@zte.com.cn,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] fbdev: replace snprintf in show functions with sysfs_emit
Date:   Tue, 30 Nov 2021 08:05:08 +0800
Message-Id: <0cb7ca73d9cd7162988a22a24cd18bbcd3d8bb27.1638156341.git.yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

coccinelle report:
./drivers/video/fbdev/core/fbcon.c:2680:8-16:
WARNING: use scnprintf or sprintf
./drivers/video/fbdev/core/fbcon.c:2655:8-16:
WARNING: use scnprintf or sprintf

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 drivers/video/fbdev/core/fbcon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 99ecd9a6d844..b4234ec2f047 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2652,7 +2652,7 @@ static ssize_t show_rotate(struct device *device,
 	rotate = fbcon_get_rotate(info);
 err:
 	console_unlock();
-	return snprintf(buf, PAGE_SIZE, "%d\n", rotate);
+	return sysfs_emit(buf, "%d\n", rotate);
 }
 
 static ssize_t show_cursor_blink(struct device *device,
@@ -2677,7 +2677,7 @@ static ssize_t show_cursor_blink(struct device *device,
 	blink = (ops->flags & FBCON_FLAGS_CURSOR_TIMER) ? 1 : 0;
 err:
 	console_unlock();
-	return snprintf(buf, PAGE_SIZE, "%d\n", blink);
+	return sysfs_emit(buf, "%d\n", blink);
 }
 
 static ssize_t store_cursor_blink(struct device *device,
-- 
2.30.2

