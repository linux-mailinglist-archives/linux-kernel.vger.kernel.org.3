Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FF54CB9AE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 09:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiCCI7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 03:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiCCI7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:59:13 -0500
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A281637C4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 00:58:23 -0800 (PST)
X-QQ-mid: bizesmtp88t1646297875tvknoqfu
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 03 Mar 2022 16:57:24 +0800 (CST)
X-QQ-SSF: 01400000002000C0G000000A0000000
X-QQ-FEAT: F3yR32iATbj+CDy6glGXK7CfKwYA2ck11zfxblzjk7VPDD0ZwURNsb75Ores6
        6rmZ71mSIHAdegatBujGhJxy0iFB926mAyQ2lmoA14jrRIrn3iUD9iXdTxetPHrc9d5JD3L
        z6ZojemhQP4AqkBacJgVKZuUQgUiST4zz1wnOyVdx9Wv0ipWFVSLSxlbh1lkp2T1abkEg3N
        SKKJT2CKXEyUz+R3UXm4TkYEHjAZzVKOXUzRBorA8tJ4U4zTxhb193hrQR9DrbYt7hDzDOb
        WlhGh7c+X8Uraz3hSKcLsDSDDsbwCStum9U2IJ4g1eurIUU9wmTBrtlZFcBej6C1FfAm7OS
        vSe7mxK+HNbC0r+k9F4j6FWlMi91Lh+AstpyJHnIagKrEkkvdM=
X-QQ-GoodBg: 1
From:   Meng Tang <tangmeng@uniontech.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH] scsi: sr: Simplify ptr_min_max_vals adjustment
Date:   Thu,  3 Mar 2022 16:57:22 +0800
Message-Id: <20220303085722.2400-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the med->media_event_code value is equal to 2 or 3, the
same value is returned, so it would be better to combine the
implementation statements when the med->media_event_code value
is equal to 2 or 3.

Moreover, when a variable is equal to multiple values, it is
better to use a switch judgment statement.

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
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



