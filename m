Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DCC4AB673
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 09:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236644AbiBGISB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243699AbiBGIP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:15:29 -0500
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F283AC043185;
        Mon,  7 Feb 2022 00:15:27 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V3nfmXb_1644221724;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V3nfmXb_1644221724)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Feb 2022 16:15:24 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     damien.lemoal@opensource.wdc.com, jejb@linux.ibm.com
Cc:     jinpu.wang@cloud.ionos.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next v2] scsi: pm8001: clean up some inconsistent indenting
Date:   Mon,  7 Feb 2022 16:15:22 +0800
Message-Id: <20220207081522.12111-1-yang.lee@linux.alibaba.com>
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

  Changes in v2:
--According to Damien's suggestion
  1) Start multi-line comments with a line that has only "/*".
  2) Align the conditions together to make this code more readable.
  3) Using a local variable for value which is calculated too many times.

 drivers/scsi/pm8001/pm8001_ctl.c | 61 ++++++++++++++++----------------
 1 file changed, 31 insertions(+), 30 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_ctl.c b/drivers/scsi/pm8001/pm8001_ctl.c
index 41a63c9b719b..0d9533ba8d27 100644
--- a/drivers/scsi/pm8001/pm8001_ctl.c
+++ b/drivers/scsi/pm8001/pm8001_ctl.c
@@ -727,6 +727,8 @@ static int pm8001_update_flash(struct pm8001_hba_info *pm8001_ha)
 	u32		sizeRead = 0;
 	u32		ret = 0;
 	u32		length = 1024 * 16 + sizeof(*payload) - 1;
+	u32		fc_len = 0;
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
+			fc_len = (partitionSize + HEADER_LEN) % IOCTL_BUF_SIZE;
+			read_buf  = (u8 *)pm8001_ha->fw_image->data + sizeRead;
+
+			if (((loopcount-loopNumber) == 1) && fc_len) {
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

