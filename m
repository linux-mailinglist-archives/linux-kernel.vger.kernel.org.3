Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BF75A8A18
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 02:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiIAA4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 20:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiIAA4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 20:56:04 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9291F7EFD6;
        Wed, 31 Aug 2022 17:56:02 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d12so15658629plr.6;
        Wed, 31 Aug 2022 17:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=yMzz1umAxMQ2stZ48UvACqRJNFBhww/PsqlmKyKiAZ4=;
        b=HunG3LjnCcWHMsupfD5Lgaeb1mZoWbGg9t8p+a0IsNln0hO0dugF7yYMikQmZXTm6A
         8geokvxSR2ZPEt9CHEoxB5p1d5OhNdVN1zL47+/l6jaIB/A6zSXI2AX4QH3yQMMnzJ9f
         INRg9WHwg0/0IeIqvlmIfPu05F2eLVstuw6aoeni+PcTdcjJfNauoWCNqUwoxvDk/lgt
         K2UjCSihqaX0qNP8x87Xx7gL95a/R9zIDNaRAKzdEyPOUk1pYAH0mfzUuH6EuNe3sqn7
         /jyawY6SMJmb8pU0ElS5TnkSr6EalbDx37oL47j8IhbtRr0K3nVtEV3yJI8ectrjNIg+
         hkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=yMzz1umAxMQ2stZ48UvACqRJNFBhww/PsqlmKyKiAZ4=;
        b=hWi9MVqWU+lltU/tsw//VzbaGi4koutCKkfFkwzxRyiwKJP73B1Nn8talWp4vGswyy
         c67Cgy1IgTTELzo9xUJF+dGNkg6U77z8DfwKRSk7u1zp3SFrrr+UGYeqgYpPSn/gGFMw
         UicaYRy2qE0kNo//DRWyz10ndITtm3uEba2lDq15m6ETpue2OxLuawC5+hLDITnUX379
         aZkxrk3M+/sVhcmkoin3ona2aS1lBsTtZseJYuLbl447Dss4sXLTX7x9obIr8Aafbb0o
         Pu8wwU3nu0JvogxynDmt9VmW9V06W9Vru9NupqvaaTI48duO0H3Mx4Oj1+2+tX4I7i8g
         HzhA==
X-Gm-Message-State: ACgBeo2FA3lKkH6zde6c2sIhQm5z9Ns58EO/tmg7dBRId2Ooa3gvbXLe
        Cw+sNGVcprJYt7qOFZENatc=
X-Google-Smtp-Source: AA6agR5sUewNkFuKs0kGGACrcDiZRim1JmGeHJnQTRBqTrGHDkNhZG97U9X3X7YgamirQWMbGDW3Aw==
X-Received: by 2002:a17:90a:bd02:b0:1fd:d9b5:c6ce with SMTP id y2-20020a17090abd0200b001fdd9b5c6cemr5780349pjr.219.1661993762121;
        Wed, 31 Aug 2022 17:56:02 -0700 (PDT)
Received: from carlis-virtual-machine.localdomain ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id 198-20020a6216cf000000b0052b84ca900csm11939019pfw.62.2022.08.31.17.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 17:56:01 -0700 (PDT)
From:   Xuezhi Zhang <zhangxuezhi3@gmail.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com, bvanassche@acm.org,
        johannes.thumshirn@wdc.com, himanshu.madhani@oracle.com,
        zhangxuezhi1@coolpad.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangxuezhi3@gmail.com
Subject: [PATCH v2] scsi: csiostor: convert sysfs snprintf to sysfs_emit
Date:   Thu,  1 Sep 2022 08:55:54 +0800
Message-Id: <20220901005554.417043-1-zhangxuezhi3@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xuezhi Zhang <zhangxuezhi1@coolpad.com>

Fix up all sysfs show entries to use sysfs_emit

Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
---
v2: delete 'else' and extra space.
---
 arch/arm64/configs/defconfig      |  2 ++
 drivers/scsi/csiostor/csio_scsi.c | 10 +++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 91e58cf59c99..6a0af8a5a8b2 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1328,3 +1328,5 @@ CONFIG_DEBUG_FS=y
 # CONFIG_DEBUG_PREEMPT is not set
 # CONFIG_FTRACE is not set
 CONFIG_MEMTEST=y
+CONFIG_SCSI_CHELSIO_FCOE=y
+CONFIG_MEGARAID_MAILBOX=y
diff --git a/drivers/scsi/csiostor/csio_scsi.c b/drivers/scsi/csiostor/csio_scsi.c
index 9aafe0002ab1..05e1a63e00c3 100644
--- a/drivers/scsi/csiostor/csio_scsi.c
+++ b/drivers/scsi/csiostor/csio_scsi.c
@@ -1366,9 +1366,9 @@ csio_show_hw_state(struct device *dev,
 	struct csio_hw *hw = csio_lnode_to_hw(ln);
 
 	if (csio_is_hw_ready(hw))
-		return snprintf(buf, PAGE_SIZE, "ready\n");
-	else
-		return snprintf(buf, PAGE_SIZE, "not ready\n");
+		return sysfs_emit(buf, "ready\n");
+
+	return sysfs_emit(buf, "not ready\n");
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
2.25.1

