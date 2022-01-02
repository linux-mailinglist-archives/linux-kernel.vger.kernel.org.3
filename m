Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A36F4828FD
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 04:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiABDbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 22:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiABDbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 22:31:48 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C90C061574
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jan 2022 19:31:48 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id i8so18896051pgt.13
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jan 2022 19:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6mGMDwMYzsbtIAV8Ge2UR4U7kb+kupKdQiyzOY6W9VM=;
        b=bteVmKTz4doQHMEkurGnEVIsTfSON/5wwzIWctdq7DwpMLDx5ZcahQRoT7iu6dHViF
         D3PYMLI1ycKTLX/kMAf/S+0uohdXXHOP0E6A+sHswhSjbugeZU4TlTBPiMaQ0LH0z2aw
         RAJSkGDnU6S+oILWhi4apYgEyWmiMxX7h2NnIfOTimYDXuI8HFam7RHMv6vnkFNqkqza
         4TEYVSTvOHscozRlBRWeWAnR7konv44dht2mXooULiCpLwN/eSzOs+aFdY71JnqMgzZj
         45jAYm7PD509mBv2dCaIs+WtXFgnEYn3P8r7ORCsGvrJjncSlWk7S5ItZKlXV2LNGS6G
         X59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6mGMDwMYzsbtIAV8Ge2UR4U7kb+kupKdQiyzOY6W9VM=;
        b=1Uu/ssznV5DWEObSA0tXiYCFvPc2EaMv+a32nGpvDcHtm4g3Ma0ivf8QP7ixCFQcAr
         ruC8yPfU3kD2/BVRAk3KcXMYsMSV3l9NST/voGHQ+X6tT+/ZshjgT1sE/xDo5tzmd1KI
         9Sj9iv85LnJ2sjQxm+bQSrWkqOwYYqvdUSsRuLnQ+KDFKnJYjnhrb+rroUUISuXp2c32
         ntgj0m1lC5Y/megQjnhYPrW0GHeJiBtmzLhE2sbDkwU7PTzx013dXWMkFDWqHGinvB9z
         EfUwMEvMM9Pm1dIcxHw0WZJe8frcktr934cAvFRWJqTKLgnQclTIln8S/ljehLpiJFho
         bTMQ==
X-Gm-Message-State: AOAM531Z5g0wKksIJFGTRo14AGq7yNiA2oAs1cGA61mcgFIYf8Uz5szk
        Vb5rwqbYDDjis1zhQKXXBPk=
X-Google-Smtp-Source: ABdhPJyL+Q9QfRnHES8SFspujjLe+fFcxRcTX4lc27QSYJvb5TJLzIJglnh0Q3HW6/TOTE+uJUnANA==
X-Received: by 2002:a63:804a:: with SMTP id j71mr36099020pgd.72.1641094307633;
        Sat, 01 Jan 2022 19:31:47 -0800 (PST)
Received: from localhost.localdomain ([211.193.61.222])
        by smtp.gmail.com with ESMTPSA id on2sm37348649pjb.19.2022.01.01.19.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jan 2022 19:31:47 -0800 (PST)
From:   skseofh@gmail.com
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Daero Lee <skseofh@gmail.com>
Subject: [PATCH] mm/vmscan.c: no need to double-check if free pages are under high-watermark
Date:   Sun,  2 Jan 2022 12:31:29 +0900
Message-Id: <20220102033129.12913-1-skseofh@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daero Lee <skseofh@gmail.com>

In kswapd_try_to_sleep function, to check whether kswapd can sleep,
the prepare_kswapd_sleep function is called twice.

If free pages are below high-watermark in the first call,
the @remaining variable is not updated at 0 and the
prepare_kswapd_sleep function is called for the second time.

I think it is necessary to set the initial value of the
@remaining to a non-zero value to prevent consecutive calls
to the same function.

Signed-off-by: Daero Lee <skseofh@gmail.com>
---
 mm/vmscan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 700434db5735..1217ecec5bbb 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4331,7 +4331,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 	/*
 	 * Return the order kswapd stopped reclaiming at as
 	 * prepare_kswapd_sleep() takes it into account. If another caller
-	 * entered the allocator slow path while kswapd was awake, order will
+	 * entered the allqocator slow path while kswapd was awake, order will
 	 * remain at the higher level.
 	 */
 	return sc.order;
@@ -4355,7 +4355,7 @@ static enum zone_type kswapd_highest_zoneidx(pg_data_t *pgdat,
 static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_order,
 				unsigned int highest_zoneidx)
 {
-	long remaining = 0;
+	long remaining = ~0;
 	DEFINE_WAIT(wait);
 
 	if (freezing(current) || kthread_should_stop())
-- 
2.25.1

