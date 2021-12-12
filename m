Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A2F471BA7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 17:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhLLQyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 11:54:36 -0500
Received: from out162-62-57-64.mail.qq.com ([162.62.57.64]:58639 "EHLO
        out162-62-57-64.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231694AbhLLQye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 11:54:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1639328069;
        bh=1pXiJm/XdfCHGUHrUq3aIQM1q83tiYf3WoWjaGkPR20=;
        h=From:To:Cc:Subject:Date;
        b=VCysTCz5oM+EDCktqOoMjEoUnNRFp9p2+BAGS5ar/zhOxy9mFuCD7ru/x+mfj7ZvF
         jHHVpla7z0S778ivX2NyBxNw2JyYeGyewbP/kiVckpVkbSaDSHtGq4uGwnGZ7ezO0q
         3/HwmazrMUj3MqRJty/YXAS3i6v2qmvrHPtIIo80=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrsza5.qq.com (NewEsmtp) with SMTP
        id D500BEED; Mon, 13 Dec 2021 00:53:16 +0800
X-QQ-mid: xmsmtpt1639327996t8l0poumn
Message-ID: <tencent_1AB342AE1B4723454E78A4D2FD3F33C81306@qq.com>
X-QQ-XMAILINFO: NzOHSugmTg7X+KikSiSMQqPXolIHXnD6UhGF0Lj1ITOJuupesg8GxhhWDYxv0M
         VzbNY9riooFSKOUJn1iPElqHO5ciPeBY+xHylF2GjFnPHwBd3ZzuokbPkaT+qPbgLDQTSRr+8cua
         5pibFX52nTMWAR+ly7B4B5Upx1EAhEDOpsDtucNw45n9KI/RbYX8iAIikbd027F/nYSGmJADjaXh
         1QvVEDqZZX8Ygfxpj9oQZyBuxt69g049XwYdzz/bhDPD73JvHSODf7wT0DPs0/bLzc2SzEqDcJ77
         U5AGeoxmtRqO1QFvcC/jlOiCOBzFgcJeFuZdnQBAeIT0uq9+LXx1xyBDVtQaXnUyhy3wu5stajab
         tmFKW+4LNfLNxIVQFuuzjxgWe8t2eAGmblXw6GGRxfaVpSdDzLzxBc0XsALUn7cK4ObbDZT8aF52
         04tgL0Qta1n4EswuE3pGcPY88zFIRfzgWOEd8bSROZ+1US4UBvKvYitkgyGfbcfCMeRSNtp1mD3g
         jSN6F/jWhdUn1ULeLVlzD9hZgoru/1uL/kFJuvb0t+YU0I+JZQjz9iu7bCdRsWltxEKaU/zhVQeK
         RtaVa4YqiCssCwuFfG/+MqY72sSik8OVCX7URllTOWedzIipm9p3jqFfWk62reM9naMWmO9l8EYh
         xoMsdoYE9SchG4Ly3FiS2bTVA3ddT4xpUmp0N68ZtuTXfS24hdJTIGF4gGBe5Kshf+JFQXCeyuTm
         k0PO76sSEuD7gpbjUSn+5++rrQeoNDdYCe0eQb6JLsG1zcdIeojbCJ5VDOF8KL5NwctugKQY/1RV
         Ovnp4cfMrrLej0F2tNrLG6hMUEo0ucCKym6IbTjIxBW67GYPyeteCYt1w6wrE7U9pGWsLlKIUdqJ
         cPszAn3Jkq
From:   xkernel <xkernel.wang@foxmail.com>
To:     andreas.noever@gmail.com, michael.jamet@intel.com,
        mika.westerberg@linux.intel.com, YehezkelShB@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        xkernel <xkernel.wang@foxmail.com>
Subject: [PATCH] thunderbolt: check the return value of kmemdup()
Date:   Mon, 13 Dec 2021 00:51:33 +0800
X-OQ-MSGID: <20211212165133.2754-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup() return NULL when some internal memory errors happen, it is
better to check the return value of it. Otherwise, some memory errors
will not be catched in time and may further result in wrong memory
access.

Signed-off-by: xkernel <xkernel.wang@foxmail.com>
---
 drivers/thunderbolt/icm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 6255f1e..fff0c74 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -1741,8 +1741,13 @@ static void icm_handle_event(struct tb *tb, enum tb_cfg_pkg_type type,
 	if (!n)
 		return;
 
-	INIT_WORK(&n->work, icm_handle_notification);
 	n->pkg = kmemdup(buf, size, GFP_KERNEL);
+	if (!n->pkg) {
+		kfree(n);
+		return;
+	}
+
+	INIT_WORK(&n->work, icm_handle_notification);
 	n->tb = tb;
 
 	queue_work(tb->wq, &n->work);
-- 
