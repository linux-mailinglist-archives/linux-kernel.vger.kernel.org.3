Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5A94723C5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 10:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbhLMJ0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 04:26:16 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:46330 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229576AbhLMJ0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:26:15 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V-UrgcD_1639387564;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V-UrgcD_1639387564)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 13 Dec 2021 17:26:12 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH v3] staging: r8188eu: Use strndup_user instead of kmalloc/copy_from_user
Date:   Mon, 13 Dec 2021 17:25:58 +0800
Message-Id: <20211213092558.77624-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code assumes that the user is going to give us a NUL terminated
string which is not necessarily true.

Fix following coccicheck warning:

./drivers/staging/r8188eu/os_dep/ioctl_linux.c:4253:8-15: WARNING
opportunity for memdup_user.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: 2b42bd58b321 ("staging: r8188eu: introduce new os_dep dir for RTL8188eu driver")
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v3:
  -Delete useless printk, modified the commit message and fixes tag.

 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 77728ba78d76..d8c28f279aa0 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -4247,18 +4247,10 @@ static int rtw_test(
 
 	DBG_88E("+%s\n", __func__);
 	len = wrqu->data.length;
+	pbuf = strndup_user(wrqu->data.pointer, len);
+	if (IS_ERR(pbuf))
+		return PTR_ERR(pbuf);
 
-	pbuf = kzalloc(len, GFP_KERNEL);
-	if (!pbuf) {
-		DBG_88E("%s: no memory!\n", __func__);
-		return -ENOMEM;
-	}
-
-	if (copy_from_user(pbuf, wrqu->data.pointer, len)) {
-		kfree(pbuf);
-		DBG_88E("%s: copy from user fail!\n", __func__);
-		return -EFAULT;
-	}
 	DBG_88E("%s: string =\"%s\"\n", __func__, pbuf);
 
 	ptmp = (char *)pbuf;
-- 
2.20.1.7.g153144c

