Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3534ACF41
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 03:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346262AbiBHCzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 21:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346250AbiBHCzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 21:55:11 -0500
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCCDC0401DC;
        Mon,  7 Feb 2022 18:55:08 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V3tqOcC_1644288902;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V3tqOcC_1644288902)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Feb 2022 10:55:02 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     damien.lemoal@opensource.wdc.com, jejb@linux.ibm.com
Cc:     jinpu.wang@cloud.ionos.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next v3] scsi: pm8001: clean up some inconsistent indentin
Date:   Tue,  8 Feb 2022 10:55:00 +0800
Message-Id: <20220208025500.29511-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow smatch warning:
drivers/scsi/pm8001/pm8001_ctl.c:760 pm8001_update_flash() warn:
inconsistent indenting

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---

  Changes in v3:
--According to Damien's suggestion
  1) "u32 fc_len = 0;" -> "u32 fc_len;".
  2) Add spaces around the "-" and remove the unnecessary parenthesis.
  3) Move "fc_len = (partitionSize + HEADER_LEN) % IOCTL_BUF_SIZE;"down,
     right above the "if" where the variable is used.

 drivers/scsi/pm8001/pm8001_ctl.c | 61 ++++++++++++++++----------------
 1 file changed, 31 insertions(+), 30 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_ctl.c b/drivers/scsi/pm8001/pm8001_ctl.c
index 41a63c9b719b..66307783c73c 100644
--- a/drivers/scsi/pm8001/pm8001_ctl.c
+++ b/drivers/scsi/pm8001/pm8001_ctl.c
@@ -727,6 +727,8 @@ static int pm8001_update_flash(struct pm8001_hba_info *pm8001_ha)
 	u32		sizeRead = 0;
 	u32		ret = 0;
 	u32		length = 1024 * 16 + sizeof(*payload) - 1;
+	u32		fc_len;
+	u8		*read_buf;
 
 	if (pm8001_ha->fw_image->size < 28) {
 		pm8001_ha->fw_status = FAIL_FILE_SIZE;
@@ -755,36 +757,35 @@ static int pm8001_update_flash(struct pm8001_hba_info *pm8001_ha)
 			fwControl->retcode = 0;/* OUT */
 			fwControl->offset = loopNumber * IOCTL_BUF_SIZE;/*OUT */
 
-		/* for the last chunk of data in case file size is not even with
-		4k, load only the rest*/
-		if (((loopcount-loopNumber) == 1) &&
-			((partitionSize + HEADER_LEN) % IOCTL_BUF_SIZE)) {
-			fwControl->len =
-				(partitionSize + HEADER_LEN) % IOCTL_BUF_SIZE;
-			memcpy((u8 *)fwControl->buffer,
-				(u8 *)pm8001_ha->fw_image->data + sizeRead,
-				(partitionSize + HEADER_LEN) % IOCTL_BUF_SIZE);
-			sizeRead +=
-				(partitionSize + HEADER_LEN) % IOCTL_BUF_SIZE;
-		} else {
-			memcpy((u8 *)fwControl->buffer,
-				(u8 *)pm8001_ha->fw_image->data + sizeRead,
-				IOCTL_BUF_SIZE);
-			sizeRead += IOCTL_BUF_SIZE;
-		}
-
-		pm8001_ha->nvmd_completion = &completion;
-		ret = PM8001_CHIP_DISP->fw_flash_update_req(pm8001_ha, payload);
-		if (ret) {
-			pm8001_ha->fw_status = FAIL_OUT_MEMORY;
-			goto out;
-		}
-		wait_for_completion(&completion);
-		if (fwControl->retcode > FLASH_UPDATE_IN_PROGRESS) {
-			pm8001_ha->fw_status = fwControl->retcode;
-			ret = -EFAULT;
-			goto out;
-		}
+			/*
+			 * for the last chunk of data in case file size is
+			 * not even with 4k, load only the rest
+			 */
+
+			read_buf  = (u8 *)pm8001_ha->fw_image->data + sizeRead;
+			fc_len = (partitionSize + HEADER_LEN) % IOCTL_BUF_SIZE;
+
+			if (loopcount - loopNumber == 1 && fc_len) {
+				fwControl->len = fc_len;
+				memcpy((u8 *)fwControl->buffer, read_buf, fc_len);
+				sizeRead += fc_len;
+			} else {
+				memcpy((u8 *)fwControl->buffer, read_buf, IOCTL_BUF_SIZE);
+				sizeRead += IOCTL_BUF_SIZE;
+			}
+
+			pm8001_ha->nvmd_completion = &completion;
+			ret = PM8001_CHIP_DISP->fw_flash_update_req(pm8001_ha, payload);
+			if (ret) {
+				pm8001_ha->fw_status = FAIL_OUT_MEMORY;
+				goto out;
+			}
+			wait_for_completion(&completion);
+			if (fwControl->retcode > FLASH_UPDATE_IN_PROGRESS) {
+				pm8001_ha->fw_status = fwControl->retcode;
+				ret = -EFAULT;
+				goto out;
+			}
 		}
 	}
 out:
-- 
2.20.1.7.g153144c

