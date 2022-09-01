Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3035A8B10
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 03:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbiIABvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 21:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiIABvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 21:51:42 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A21E86B0;
        Wed, 31 Aug 2022 18:51:41 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id x80so11462156pgx.0;
        Wed, 31 Aug 2022 18:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=g9xmQmtF0N14mRd5cXkvjRikZ0ObEaOiMPNkgYQh2P4=;
        b=m5PQQDNa64bJioaDOQeRL6c8iWPMVINFFPvPKeyrcdTYAfHWQKtS+xsrR3ups+8RXd
         MB8oPFncvILQIZku+NB6qD6ttvb+4Bq4FiTF75J5Q6jb2ptJGLdUeETTNRxci3JTSe5I
         GO100sTTEq0kQs4EEzvtV2qWjRZOTEjUD3qHHWfMijByLGV2geTOiMVPWlZzONPgcKZs
         2+VMA+IRK8JYS7wlkyOG38zCAa9WD21ppyucMyFFSxAet/VLt+epjfLtZ77IGBDMmZm4
         ZDbnqSVR4ahnMl7AI/QQ1rVJa32tyQM96hZBeYgCOYf5N11Ap8g9Ujlzwf1fMlYl6z0x
         wSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=g9xmQmtF0N14mRd5cXkvjRikZ0ObEaOiMPNkgYQh2P4=;
        b=pAL/FfCjkCIm30/4GstBB2JWpVnasSHndu6GeCnSH7dVbtv8HybhN+NtG4uyGL9phO
         +RYEB66bgheTxWQLR53YJloF13EAVDBlZi8prturvKcFXMizuQvAvc6MXWXcghSQaSlF
         sSkM1f5v4ek0CNtn6LXMTZyQ6JVhd8ea/DowKDn7MortoRESqEwcdVknUK7PumoBBAjV
         u28WVS4zR71J/lFarz7SWIUto/zr9HZKT27EFgfbmoCHP12QIx/uRGAyhq3uXlXvPgiX
         fFTxTdPq3koOsiDuq7AZ5zIBDGUG3C6/5aIMZqsgLb9mVglpGUKq4naOV6yc/4VRlsNl
         efFA==
X-Gm-Message-State: ACgBeo3FOhxz6Y8pNwjqWFNIoEbHWodhFk8mp5EfuLZBJ7ACeZARFPCW
        rQMlRkvIQEshp+W0Mas6tzQ=
X-Google-Smtp-Source: AA6agR6G6V/F9razGL9k3shbk/J/lPolCi0fv5LOcUxL0qO7xVVVugIW7vv7llvEfeEi21r2OciGwQ==
X-Received: by 2002:a63:6d8f:0:b0:42c:7046:1e9e with SMTP id i137-20020a636d8f000000b0042c70461e9emr10835269pgc.603.1661997101601;
        Wed, 31 Aug 2022 18:51:41 -0700 (PDT)
Received: from carlis-virtual-machine.localdomain ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id z12-20020a170903018c00b001754e086eb3sm1520145plg.302.2022.08.31.18.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 18:51:40 -0700 (PDT)
From:   Xuezhi Zhang <zhangxuezhi3@gmail.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com, bvanassche@acm.org,
        johannes.thumshirn@wdc.com, himanshu.madhani@oracle.com,
        zhangxuezhi1@coolpad.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangxuezhi3@gmail.com
Subject: [PATCH v3] scsi: csiostor: convert sysfs snprintf to sysfs_emit
Date:   Thu,  1 Sep 2022 09:51:30 +0800
Message-Id: <20220901015130.419307-1-zhangxuezhi3@gmail.com>
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

Follow the advice of the Documentation/filesystems/sysfs.rst
and show() should only use sysfs_emit() or sysfs_emit_at()
when formatting the value to be returned to user space.

Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
---
v2: delete 'else' and extra space.
v3: delete extra configs in patch v2
    and use a new changelog.
---
 drivers/scsi/csiostor/csio_scsi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

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

