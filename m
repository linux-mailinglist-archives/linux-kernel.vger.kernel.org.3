Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A9646F9A4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 04:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbhLJDmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 22:42:18 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:46103 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231314AbhLJDmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 22:42:17 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V-6vNfC_1639107514;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V-6vNfC_1639107514)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Dec 2021 11:38:40 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] staging: r8188eu: Use memdup_user instead of kmalloc/copy_from_user
Date:   Fri, 10 Dec 2021 11:38:32 +0800
Message-Id: <20211210033832.40428-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following coccicheck warning:

./drivers/staging/r8188eu/os_dep/ioctl_linux.c:4253:8-15: WARNING
opportunity for memdup_user.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 56adfe4087a8..c6a2fbfe8f26 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -4250,17 +4250,12 @@ static int rtw_test(
 	DBG_88E("+%s\n", __func__);
 	len = wrqu->data.length;
 
-	pbuf = kzalloc(len, GFP_KERNEL);
-	if (!pbuf) {
-		DBG_88E("%s: no memory!\n", __func__);
-		return -ENOMEM;
-	}
-
-	if (copy_from_user(pbuf, wrqu->data.pointer, len)) {
-		kfree(pbuf);
+	pbuf = memdup_user(wrqu->data.pointer, len);
+	if (IS_ERR(pbuf)) {
 		DBG_88E("%s: copy from user fail!\n", __func__);
-		return -EFAULT;
+		return PTR_ERR(pbuf);
 	}
+
 	DBG_88E("%s: string =\"%s\"\n", __func__, pbuf);
 
 	ptmp = (char *)pbuf;
-- 
2.34.0

