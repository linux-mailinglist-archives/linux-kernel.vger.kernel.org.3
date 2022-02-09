Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB994AE629
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 01:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240486AbiBIAlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 19:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbiBIAlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 19:41:09 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FC0C061576;
        Tue,  8 Feb 2022 16:41:08 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id h14-20020a17090a130e00b001b88991a305so3523057pja.3;
        Tue, 08 Feb 2022 16:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pa8AxlM1CGVhFlxgAPHks9xGR/UVYqCAV8jsE4HR0c8=;
        b=WmnBH4aP+hiS3tsbOUMuXayYC75e2ckQtGjf/TAL/S9mLMOX9xmoz1CAXo0FpXgAJ/
         /0zKypXvDa4QhR9pF4nGbWjdTtf/fQFwy4JG9hZBDnRkKQ1s4DKqmVhJy7q8WYRasX4D
         7o9Xi05deTz1Xk8rEPE02UuEqT4vimLaQy9U/FViYqEjBlttQDv81oNdn7S9LQ57NQ/l
         plWT8ndFQFK8uhX9Oc48G7U5boZcJgOQJPPYkTtpjQj4ZFQ/ktshmmAJic8nrkoJZ4i4
         L3OiDmEoQQ/5GcSQyxa5dyZZpdCnqdfDZlQw2Yyi8MnfL4/rTnBKdFt30zoXyCW1XRtH
         A77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pa8AxlM1CGVhFlxgAPHks9xGR/UVYqCAV8jsE4HR0c8=;
        b=eZOKmnqZkNcAwpe0xT8oFrgw0nNC1NiRhm+n8zFsgFEdpEU5LrDxNE5sdGM/y/SgJf
         Yw0kCmw04je7wQUL7bIAI+FSMg94x3u4cvqf67EU21lzqvhshxe5+zYF2pj/l0momPus
         QKtFkjZvT6N5s8c1qWerq8ytTqB3IwoD2INha/1VRxUqe7EW4nKgr25ZUxnrOQaoUbZI
         g8tcFxUc3s+o7qvcZXWHgb9Wzfd81jAiWZNaWfnQKAQazEtWEjWBTaNSyekYrZdMqHO1
         ahSWuYJCeDvw/mp5QhuW81DIngdUXke3E9DUp2Vk66XYJpymB0KYtygP40ImB9ZSkjDx
         7mKw==
X-Gm-Message-State: AOAM531QEbMAltRsrNRGXKi3VnlHU6Laz71c/4tR8jNugJuk7G/tW5/k
        qJrk38H6grOxXHEKPq9sJEc=
X-Google-Smtp-Source: ABdhPJxJlqqg+xMiTZxH/hFHRvCC3tTmddvN/YF4aXV2IcnfmzlGEvnqlAzb8nncV/EaB/nXYFrFSg==
X-Received: by 2002:a17:90a:1987:: with SMTP id 7mr470500pji.215.1644367267990;
        Tue, 08 Feb 2022 16:41:07 -0800 (PST)
Received: from localhost.localdomain (192.243.120.166.16clouds.com. [192.243.120.166])
        by smtp.gmail.com with ESMTPSA id nu7sm4357184pjb.30.2022.02.08.16.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 16:41:07 -0800 (PST)
From:   davidcomponentone@gmail.com
To:     jejb@linux.ibm.com
Cc:     davidcomponentone@gmail.com, martin.petersen@oracle.com,
        bvanassche@acm.org, yang.guang5@zte.com.cn,
        jiapeng.chong@linux.alibaba.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] scsi: csiostor: replace snprintf with sysfs_emit
Date:   Wed,  9 Feb 2022 08:40:55 +0800
Message-Id: <d711ec5a5f416204079155666d2de49d43070897.1644287527.git.yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

coccinelle report:
./drivers/scsi/csiostor/csio_scsi.c:1433:8-16:
WARNING: use scnprintf or sprintf
./drivers/scsi/csiostor/csio_scsi.c:1369:9-17:
WARNING: use scnprintf or sprintf
./drivers/scsi/csiostor/csio_scsi.c:1479:8-16:
WARNING: use scnprintf or sprintf

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
---
 drivers/scsi/csiostor/csio_scsi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/csiostor/csio_scsi.c b/drivers/scsi/csiostor/csio_scsi.c
index 55db02521221..f9b87ae2aa25 100644
--- a/drivers/scsi/csiostor/csio_scsi.c
+++ b/drivers/scsi/csiostor/csio_scsi.c
@@ -1366,9 +1366,9 @@ csio_show_hw_state(struct device *dev,
 	struct csio_hw *hw = csio_lnode_to_hw(ln);
 
 	if (csio_is_hw_ready(hw))
-		return snprintf(buf, PAGE_SIZE, "ready\n");
+		return sysfs_emit(buf, "ready\n");
 	else
-		return snprintf(buf, PAGE_SIZE, "not ready\n");
+		return sysfs_emit(buf, "not ready\n");
 }
 
 /* Device reset */
@@ -1430,7 +1430,7 @@ csio_show_dbg_level(struct device *dev,
 {
 	struct csio_lnode *ln = shost_priv(class_to_shost(dev));
 
-	return snprintf(buf, PAGE_SIZE, "%x\n", ln->params.log_level);
+	return sysfs_emit(buf, "%x\n", ln->params.log_level);
 }
 
 /* Store debug level */
@@ -1476,7 +1476,7 @@ csio_show_num_reg_rnodes(struct device *dev,
 {
 	struct csio_lnode *ln = shost_priv(class_to_shost(dev));
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", ln->num_reg_rnodes);
+	return sysfs_emit(buf, "%d\n", ln->num_reg_rnodes);
 }
 
 static DEVICE_ATTR(num_reg_rnodes, S_IRUGO, csio_show_num_reg_rnodes, NULL);
-- 
2.30.2

