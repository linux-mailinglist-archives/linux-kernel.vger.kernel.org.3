Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C89749DD22
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238108AbiA0JAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:00:22 -0500
Received: from smtpbg703.qq.com ([203.205.195.89]:36716 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238104AbiA0JAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:00:21 -0500
X-QQ-mid: bizesmtp43t1643274007t8sa334g
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 27 Jan 2022 17:00:01 +0800 (CST)
X-QQ-SSF: 0140000000200090E000C00A0000000
X-QQ-FEAT: nnjWNCC3Pd2Gry3AWSm/mVxwssU5xdxnJ6Cjs2RQO2G+C3WtpV0Qqw+SNMq6Z
        QqNpR1oggIOktD1eMsqTTnZL5c20GpnnhuFGCFe3xoXK/HOWo5N4g+O/ujWSqfG2+NX/AcY
        mMih7+jygtydz/MIWHkCHWIBf14OSibTBUG7XAv4qTPJ8fSkej5TOGMAdf1utKQr1BxH4/6
        i/eOG+pVU7uGGOT921rNPNmdnQZqbejjB4NXQ0y6BMzu8VBmtPHdGMlZ99beKonIebh12lt
        wEe6QR9dMUjKFigKuU/ymL3kyzutMypM+YNvU3mlQmRCm4E+1om5xTCSiWy1v1LkbKN9rF9
        00IgxAMjJ0nl8RdWofxotvfViRvNnke0a9jfK9sGYN82PjxlkI=
X-QQ-GoodBg: 2
From:   tangmeng <tangmeng@uniontech.com>
To:     axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tangmeng <tangmeng@uniontech.com>
Subject: [PATCH] scsi: sr: Improve the judgment statement
Date:   Thu, 27 Jan 2022 17:00:00 +0800
Message-Id: <20220127090000.5289-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous code has a less-than-perfect usage of judgment syntax.

When the med->media_event_code value is equal to 2 or 3, the same
value is returned, so it would be better to combine the implementation
statements when the med->media_event_code value is equal to 2 or 3.

Moreover, when a variable is equal to multiple values, it is better
to use a switch judgment statement.

mechanical switch on the Drive) to eject the specified slot or media.

Signed-off-by: tangmeng <tangmeng@uniontech.com>
---
 drivers/scsi/sr.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index f925b1f1f9ad..610baa630067 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -222,12 +222,16 @@ static unsigned int sr_get_events(struct scsi_device *sdev)
 	if (eh->nea || eh->notification_class != 0x4)
 		return 0;
 
-	if (med->media_event_code == 1)
+	switch (med->media_event_code) {
+	case 1:
 		return DISK_EVENT_EJECT_REQUEST;
-	else if (med->media_event_code == 2)
-		return DISK_EVENT_MEDIA_CHANGE;
-	else if (med->media_event_code == 3)
+	case 2:
+	case 3:
 		return DISK_EVENT_MEDIA_CHANGE;
+	default:
+		break;
+	}
+
 	return 0;
 }
 
-- 
2.20.1



