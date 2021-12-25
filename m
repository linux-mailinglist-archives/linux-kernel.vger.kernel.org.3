Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C7347F3F6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 18:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbhLYREp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 12:04:45 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:42133 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229914AbhLYREo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 12:04:44 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V.j7Uhg_1640451878;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V.j7Uhg_1640451878)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 26 Dec 2021 01:04:41 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH v4] staging: r8188eu: Use strndup_user instead of kmalloc/copy_from_user
Date:   Sun, 26 Dec 2021 01:04:36 +0800
Message-Id: <20211225170436.111000-1-jiapeng.chong@linux.alibaba.com>
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
Changes in v2:
  -This function does nothing, so it should just be deleted entirely.

 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 38 --------------------
 1 file changed, 38 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index e7f35143dfe1..518625730883 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -4229,43 +4229,6 @@ static int rtw_tdls_get(struct net_device *dev,
 	return 0;
 }
 
-static int rtw_test(
-	struct net_device *dev,
-	struct iw_request_info *info,
-	union iwreq_data *wrqu, char *extra)
-{
-	u32 len;
-	u8 *pbuf, *pch;
-	char *ptmp;
-	u8 *delim = ",";
-
-	DBG_88E("+%s\n", __func__);
-	len = wrqu->data.length;
-
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
-	DBG_88E("%s: string =\"%s\"\n", __func__, pbuf);
-
-	ptmp = (char *)pbuf;
-	pch = strsep(&ptmp, delim);
-	if (!pch || strlen(pch) == 0) {
-		kfree(pbuf);
-		DBG_88E("%s: parameter error(level 1)!\n", __func__);
-		return -EFAULT;
-	}
-	kfree(pbuf);
-	return 0;
-}
-
 static iw_handler rtw_handlers[] = {
 	IW_HANDLER(SIOCGIWNAME, rtw_wx_get_name),
 	IW_HANDLER(SIOCGIWFREQ, rtw_wx_get_freq),
@@ -4431,7 +4394,6 @@ NULL,					/* 0x03 */
 	NULL,				/* 0x1A */
 	NULL,				/* 0x1B */
 	NULL,				/*  0x1C is reserved for hostapd */
-	rtw_test,			/*  0x1D */
 };
 
 static struct iw_statistics *rtw_get_wireless_stats(struct net_device *dev)
-- 
2.20.1.7.g153144c

