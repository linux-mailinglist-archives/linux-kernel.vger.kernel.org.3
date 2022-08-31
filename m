Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB91D5A7F96
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbiHaOLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiHaOKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:10:54 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08ED7C0B74;
        Wed, 31 Aug 2022 07:10:54 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id x23so14241656pll.7;
        Wed, 31 Aug 2022 07:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=kboID+a4oCZLB90RjGESjjpmeonElRrw7Xrg2AJLT0Q=;
        b=G237vnn6SJPjJ/Q2dKvBRQk+gEKFtEXFBcgFhk7UCauh/Q6Bh3gr0YgobdrGeeFCvN
         HzqjWgnakoRCTG1GonGgfjwW2+PkpmcpoaQGFTRZtuDgXEl1vANbvHhoDE0PDXmzB0k2
         l2tQqsdjIjU8Fff2Y5/60BRc04dxbIwgFRIsr25IDSR64pdEE6ArjnAT4sQI8heOjpyD
         LktZ/Vq5/K4ARgqBSdLtvIGFtyuMlMnTsTPsFulFuC1RHvFROIDNov+0Bft1cAW9tgi2
         LXnQtsX5NytByx3bCqnWHVDxr0tThWeE3+kxpGzouRVmOvPT41IZ9Y0FKW39swNAqYxy
         mv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=kboID+a4oCZLB90RjGESjjpmeonElRrw7Xrg2AJLT0Q=;
        b=0n3SA1Ms5yFjzk8Gwlg6DqqfRogPfcR7fhgUu9R4+Nq8XCugLxCxeQ7GYMvAFfTRGT
         lcQ+IcWnYrW4fOYOjf6txLSmm3YJwcYd9H9NwQI3jRx4EJDbhjFepc9r5gEcQh/7+KUX
         Hli4spmcJ/pB5+V/T4Q1NmnNx38n9ylzgAKRGmt+XTblfYglDnfPdqbCoIUafoGDSTxf
         dbMECB6jAA1gJiJ4oeet5BHlhiZdaBawlflPdqyN1UkzUUD2AXxRaRrmUHK4xr5qW1U0
         DvHnVF+MEICXE11Rl5Qv/gGJocgELmDyfBxRjhIo2XoyflqIXC3mg3vWh32bwJMmOJgw
         ZDnw==
X-Gm-Message-State: ACgBeo0I8SslGmscE1LIiVqetKqQXefD6F8GcnrJnatu8XNnvY/xsEXO
        hybbPtoJcbHHO2wTCN7YIG4=
X-Google-Smtp-Source: AA6agR6zZs1DfYBUFLrRGp/kxkTVOOhcBnsJx3jUKapVRMAnhDXzGKMdfxYktw39QZ994YkoKW7+lQ==
X-Received: by 2002:a17:903:4ce:b0:171:2cbb:ba27 with SMTP id jm14-20020a17090304ce00b001712cbbba27mr25703420plb.72.1661955053245;
        Wed, 31 Aug 2022 07:10:53 -0700 (PDT)
Received: from carlis-virtual-machine.localdomain ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id h16-20020aa796d0000000b0053ae018a91esm365011pfq.173.2022.08.31.07.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 07:10:52 -0700 (PDT)
From:   Xuezhi Zhang <zhangxuezhi3@gmail.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com, bvanassche@acm.org,
        johannes.thumshirn@wdc.com, himanshu.madhani@oracle.com,
        zhangxuezhi1@coolpad.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangxuezhi3@gmail.com
Subject: [PATCH] scsi: csiostor: convert sysfs snprintf to sysfs_emit
Date:   Wed, 31 Aug 2022 22:10:46 +0800
Message-Id: <20220831141046.406837-1-zhangxuezhi3@gmail.com>
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
 drivers/scsi/csiostor/csio_scsi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/csiostor/csio_scsi.c b/drivers/scsi/csiostor/csio_scsi.c
index 9aafe0002ab1..39e8c3c26a19 100644
--- a/drivers/scsi/csiostor/csio_scsi.c
+++ b/drivers/scsi/csiostor/csio_scsi.c
@@ -1366,9 +1366,9 @@ csio_show_hw_state(struct device *dev,
 	struct csio_hw *hw = csio_lnode_to_hw(ln);
 
 	if (csio_is_hw_ready(hw))
-		return snprintf(buf, PAGE_SIZE, "ready\n");
+		return sysfs_emit(buf, "ready\n");
 	else
-		return snprintf(buf, PAGE_SIZE, "not ready\n");
+		return sysfs_emit(buf,  "not ready\n");
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

