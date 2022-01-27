Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA55049D681
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 01:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiA0ABS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 19:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbiA0ABP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 19:01:15 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FD7C061757;
        Wed, 26 Jan 2022 16:01:14 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id u130so1123441pfc.2;
        Wed, 26 Jan 2022 16:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lJg34UXavo+BCA7CJbZaK2UMuPsocHL4tImngrho0Cw=;
        b=DzOwhAFAqsmZE8JYLDDnJes5OALer0ARpR6/Wl08rkeNbGjzAqxvWZn/0QKeQiUAi3
         c6q1lc87oouSG94PVNTPEMQJnY6O0jk79naLBftevX+KYl5BBR4SAbtqd2Nl1W+IIgrm
         Y4Exjv7B+9rzqzIQeNxcpiai63RP0oLLN/rmgCqa9pFiilNyu9tqLs3cveVReQY2TXB3
         eCBw2DJXqNJ6Zc/ezeDYGSLOPO9BCPAS8AD2rZC57ZpeXM+c8Yxb9eTPgMb1Haue7A14
         /wRf2yJgiHw/Z0UULaKSpJPP9x2Rykwjmw5XjXsw1lLgm16xnPl65d6DAyjuFhghEW5B
         SPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lJg34UXavo+BCA7CJbZaK2UMuPsocHL4tImngrho0Cw=;
        b=G4OjPbwfqOlBljfyVruh5/wT+SXSjsZbbOJl0aH/X/14AsKwMC0aDYlFmGrB4cYWIv
         qUlxU9VVyeaqMFdVGr8WS8yupl74pgJB3anhriMd1BQfbP/EFKLXhYw0yC0sDDNYJVfq
         wHQUD/6EO2PeGfsAc9X6T9wODUehdL27E67tYwtFYvJWrwibOHaH/zrjqQHq0Ai99Zz3
         N/NUTfDo8UUcEej6sHkShOvWPM/1hRvDmqBpQTYZcIQNeyuOgdgtijL7is1CXH9Q9UOB
         FVC0xvZCweQmicG5pbV8kG/2OBXcp3cY7IanYyNwpJt6b6Azt+gPe/25e76iDnFnbEtr
         DJHQ==
X-Gm-Message-State: AOAM5327csxCH5Bw/adGoYWrAmbmzmRlAZg1FSpVIm2uX6EgEAiLWYps
        yj8wrjN7INT8IR2JSgC/Kbs=
X-Google-Smtp-Source: ABdhPJx6XxFGHOcuTGOvCwpS9bcS4x7uyZ8hAU0+dQS1s0A9vw/uNd/pBD9T2FB6J+jgs/6JqCqLIA==
X-Received: by 2002:a05:6a00:984:: with SMTP id u4mr822601pfg.67.1643241673776;
        Wed, 26 Jan 2022 16:01:13 -0800 (PST)
Received: from localhost.localdomain (192.243.120.23.16clouds.com. [192.243.120.23])
        by smtp.gmail.com with ESMTPSA id g5sm306510pjj.36.2022.01.26.16.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 16:01:13 -0800 (PST)
From:   davidcomponentone@gmail.com
To:     jejb@linux.ibm.com
Cc:     davidcomponentone@gmail.com, martin.petersen@oracle.com,
        yang.guang5@zte.com.cn, yuyufen@huawei.com,
        thunder.leizhen@huawei.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] scsi: mvsas: replace snprintf with sysfs_emit
Date:   Thu, 27 Jan 2022 08:00:59 +0800
Message-Id: <c1711f7cf251730a8ceb5bdfc313bf85662b3395.1643182948.git.yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

coccinelle report:
./drivers/scsi/mvsas/mv_init.c:699:8-16:
WARNING: use scnprintf or sprintf
./drivers/scsi/mvsas/mv_init.c:747:8-16:
WARNING: use scnprintf or sprintf

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
---
 drivers/scsi/mvsas/mv_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index dcae2d4464f9..44df7c03aab8 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -696,7 +696,7 @@ static struct pci_driver mvs_pci_driver = {
 static ssize_t driver_version_show(struct device *cdev,
 				   struct device_attribute *attr, char *buffer)
 {
-	return snprintf(buffer, PAGE_SIZE, "%s\n", DRV_VERSION);
+	return sysfs_emit(buffer, "%s\n", DRV_VERSION);
 }
 
 static DEVICE_ATTR_RO(driver_version);
@@ -744,7 +744,7 @@ static ssize_t interrupt_coalescing_store(struct device *cdev,
 static ssize_t interrupt_coalescing_show(struct device *cdev,
 					 struct device_attribute *attr, char *buffer)
 {
-	return snprintf(buffer, PAGE_SIZE, "%d\n", interrupt_coalescing);
+	return sysfs_emit(buffer, "%d\n", interrupt_coalescing);
 }
 
 static DEVICE_ATTR_RW(interrupt_coalescing);
-- 
2.30.2

