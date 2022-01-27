Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84F349DD72
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238315AbiA0JMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:12:49 -0500
Received: from smtpbguseast1.qq.com ([54.204.34.129]:47276 "EHLO
        smtpbguseast1.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238299AbiA0JMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:12:39 -0500
X-QQ-mid: bizesmtp54t1643274737tnh7xl4d
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 27 Jan 2022 17:12:11 +0800 (CST)
X-QQ-SSF: 0140000000200090E000C00A0000000
X-QQ-FEAT: F3yR32iATbjWw3acDtsfp2HLqnilxm49/4xuiIAVnD3g9W5QKpqaUyV3Lkk6W
        GRHy/Z/TKb4rTYjEmDW/4bTNTdYtPjiVTdxpR3fJkmD5jxHf55vczWMU1TKeLG+bS2qg34p
        oXrvYyWnob/at2T9ngNQV+dHympfswqSoQLwtmOwDlZ4N58gZh+A+1FBUpfJSk2aQX9AFAq
        6BcI1OWr/5nv8fuVRU4bSdtYiTlwYBIbH7YnbjB/Sh7m4ZXbdKG9HZhd4kcFD7Miact+6gP
        beikY47ZSxYMJ9tMuVcAIrZxqhYSln7ymbG4ntqkxzPwI/+Z1At6Kd/GL23LxJIzVkcRZnk
        oLYqJ4J/hEIwOLDpaM/Q91vzWiAvM5Z9Us9A37dR66jYSdju+I=
X-QQ-GoodBg: 2
From:   tangmeng <tangmeng@uniontech.com>
To:     axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tangmeng <tangmeng@uniontech.com>
Subject: [PATCH v2] scsi: sr: Improve the judgment statement
Date:   Thu, 27 Jan 2022 17:11:36 +0800
Message-Id: <20220127091136.9658-1-tangmeng@uniontech.com>
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



