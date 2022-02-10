Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4994B0AA9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239690AbiBJKcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:32:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239586AbiBJKco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:32:44 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED74E250;
        Thu, 10 Feb 2022 02:32:45 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id x4so1457541plb.4;
        Thu, 10 Feb 2022 02:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iCt716I4ZsYeZgcPgpvG3pnbHYTizG7AtfrrJ1x1TOA=;
        b=CFsSFvhjhxVoaibC5X/hwIKPR1L7HhOKYGLkRmUz8ZcPBMqNesWqfb9NwECE6mLAmD
         SphYxEQc9AI0iasLiZ/XOoW2R4wL8+Vm1o0ELkSToFVLcPoM2WMUVpd6zEf66SYyRqKg
         TIR4+Q1qtV2HmjNSIs0aiouCGdoeXMAlG5gJp1i9uDoSne77ZGTxreYR9Wdt03mNJgr/
         w2tO53TcuhddezEDL96JOknQ0mUxgevLIDQVInT/jU92LTcQjBbYu1Vsxyrwgf5k61fa
         jRBWxoL0GYpqd8KbQZMy7g1t6fNjS3KS/2LDG1LCrdQJnUESp7xwkQnhop7hgWzCK+40
         PK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iCt716I4ZsYeZgcPgpvG3pnbHYTizG7AtfrrJ1x1TOA=;
        b=B2H6qb9fvW1uWfXF4g51sY33CH72lQg93h/FvCIuPa53HcWv1YZ1jmhYktmJBNMO7l
         HvkTXmQqjxa3ew3SHI63PGdIUtyqIX7im2jEYZRducd7ddfbL9E/8kbG2FXFCSse+qIM
         1lEfRwA6t1MuNOPHcv05HCbSVVL9hP/3rucz3dD7L6QBWHO5fLVRnrcmcsw81snegFht
         +CbtdIiG+NkVws2iE3VU5Rjw2gpSz1z8dodu7INOA7zmwK+hzlUUPMrLFTDc5iE/QEGZ
         TY3koSy/c3WW6qWmSMRr0X4aT2sVFZTRiiYcCbzO8yKwnNIs5SvtCmhYm5yL/jCmpvzf
         2ySA==
X-Gm-Message-State: AOAM5332y04opIcxOa60a3GUOxUhbQT0karABCrpA3hEK6QuM0hRakIi
        cHMvl9ZZLJ49wLAogbPAO+8=
X-Google-Smtp-Source: ABdhPJxWjbHm/+RgTiVUnCHOj6vTi+8a59SQARtf5Hv0LIP7fzhuIFTUhFk+AiTameQDve1RW5w2dQ==
X-Received: by 2002:a17:902:8a8d:: with SMTP id p13mr6999717plo.80.1644489165477;
        Thu, 10 Feb 2022 02:32:45 -0800 (PST)
Received: from localhost.localdomain (192.243.120.166.16clouds.com. [192.243.120.166])
        by smtp.gmail.com with ESMTPSA id p1sm24663913pfh.98.2022.02.10.02.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 02:32:45 -0800 (PST)
From:   davidcomponentone@gmail.com
To:     jejb@linux.ibm.com
Cc:     davidcomponentone@gmail.com, martin.petersen@oracle.com,
        bvanassche@acm.org, jiapeng.chong@linux.alibaba.com,
        yang.guang5@zte.com.cn, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH v2] scsi: csiostor: replace snprintf with sysfs_emit
Date:   Thu, 10 Feb 2022 18:32:27 +0800
Message-Id: <ce1cb616187bdd9e248008ef60ba07910c647355.1644399526.git.yang.guang5@zte.com.cn>
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
Change from v1-v2:
- Adjust some format

---
 drivers/scsi/csiostor/csio_scsi.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/csiostor/csio_scsi.c b/drivers/scsi/csiostor/csio_scsi.c
index 55db02521221..05f52fc3efb8 100644
--- a/drivers/scsi/csiostor/csio_scsi.c
+++ b/drivers/scsi/csiostor/csio_scsi.c
@@ -1365,10 +1365,7 @@ csio_show_hw_state(struct device *dev,
 	struct csio_lnode *ln = shost_priv(class_to_shost(dev));
 	struct csio_hw *hw = csio_lnode_to_hw(ln);
 
-	if (csio_is_hw_ready(hw))
-		return snprintf(buf, PAGE_SIZE, "ready\n");
-	else
-		return snprintf(buf, PAGE_SIZE, "not ready\n");
+	return sysfs_emit(buf, "%sready\n", csio_is_hw_ready(hw) ? "" : "not ");
 }
 
 /* Device reset */
@@ -1430,7 +1427,7 @@ csio_show_dbg_level(struct device *dev,
 {
 	struct csio_lnode *ln = shost_priv(class_to_shost(dev));
 
-	return snprintf(buf, PAGE_SIZE, "%x\n", ln->params.log_level);
+	return sysfs_emit(buf, "%x\n", ln->params.log_level);
 }
 
 /* Store debug level */
@@ -1476,7 +1473,7 @@ csio_show_num_reg_rnodes(struct device *dev,
 {
 	struct csio_lnode *ln = shost_priv(class_to_shost(dev));
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", ln->num_reg_rnodes);
+	return sysfs_emit(buf, "%u\n", ln->num_reg_rnodes);
 }
 
 static DEVICE_ATTR(num_reg_rnodes, S_IRUGO, csio_show_num_reg_rnodes, NULL);
-- 
2.30.2

