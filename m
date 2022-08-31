Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C329C5A7485
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 05:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbiHaDfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 23:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiHaDfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 23:35:46 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6432473324;
        Tue, 30 Aug 2022 20:35:38 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id b196so2728483pga.7;
        Tue, 30 Aug 2022 20:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=SIkOhpnSgF12O0JnM4QFh38Ot/jDR9kAJ4qYsNIujk4=;
        b=eIygtkBWAQmAnn7mDNLw0of/85QWNnSdr415QP9X5+//LjjnDzLKCpsBBmv0yOooFh
         LnowY3AunE6UFHvA4cX/K83phl4F/5Ehf7zkkgkWqjyHHWuBK9GUGO5eWOiPxe7TnUgx
         Dtpzwh6izT6zykxRx5FDpTX3AGnrqaY00QB4hy1OgmJGuGThmeurDjMNCjl446YbXTNh
         FHITG4J+RkHsODf459Cunkt1omY/wdntktgydSvtr5eltdnybivHRr+qCK9KqaI7faV7
         mk4goy1bfGUsT6O5iUN0aFHc9EXecgkTSrdxc/zYSfHgu6ZGdZ1fUzgaeh4yT1Yp4RsY
         MtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=SIkOhpnSgF12O0JnM4QFh38Ot/jDR9kAJ4qYsNIujk4=;
        b=WP5i9CpnpGnTYJFJOtFkDNXS6hsmv/QRTwL3ZGof7lWFreUukD/fzDOhCV6WVT5mL4
         fw6H/Lkd8rr71qPUmM0LbQt8JumILCTOcDdTsDep63JSJ8vq0EIKH/w3y0B28lYBK4gL
         2pSvEW0VY8yubeolTT+4fkZp3Q1dLe40Sz7AI88kmlDOxhP98MBGhnfac7tyIkkPuH+M
         i1ytayETPM7hT924o85Bsh+Ce44Ev/W7yw+DcpjbhEYt8zDSAKuu4jdh5h4/WfzkNy4E
         B9Z8fsC4ANe0rLg1OVsZbi72bl6LjzrHzM7SY3u1bIphSZJeO0xpXRphefSkR06Lt0q5
         3P0Q==
X-Gm-Message-State: ACgBeo0rorrxzxXCQydXPVnjdsimhTK0iAa8x6T+CgBnjA7mGXuHtISX
        oEz58RfrOsk6ZaZwkdck88ZxPLkzft0=
X-Google-Smtp-Source: AA6agR4WW6HckWjcodwy/+crBhah3Qqe7gNkOeyuE5I782puZwmdrUpF3vNcys71GOj17Uh+r9ImSw==
X-Received: by 2002:a63:4a47:0:b0:42b:e4a4:3aec with SMTP id j7-20020a634a47000000b0042be4a43aecmr12585562pgl.512.1661916937608;
        Tue, 30 Aug 2022 20:35:37 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id z29-20020a630a5d000000b0042b291a89bfsm2307733pgk.11.2022.08.30.20.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 20:35:37 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     jejb@linux.ibm.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] scsi: scsi_error.c: Remove the unneeded result variable
Date:   Wed, 31 Aug 2022 03:35:28 +0000
Message-Id: <20220831033528.302249-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value scsi_device_online() directly instead of storing it in
another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/scsi/scsi_error.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 448748e3fba5..6840bb4ab55f 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -377,13 +377,9 @@ enum blk_eh_timer_return scsi_timeout(struct request *req)
  */
 int scsi_block_when_processing_errors(struct scsi_device *sdev)
 {
-	int online;
-
 	wait_event(sdev->host->host_wait, !scsi_host_in_recovery(sdev->host));
 
-	online = scsi_device_online(sdev);
-
-	return online;
+	return scsi_device_online(sdev);
 }
 EXPORT_SYMBOL(scsi_block_when_processing_errors);
 
-- 
2.25.1
