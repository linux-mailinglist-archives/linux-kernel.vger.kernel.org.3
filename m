Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F13529DF2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiEQJZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244746AbiEQJZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:25:22 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8694E36E12;
        Tue, 17 May 2022 02:25:21 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n10so33501017ejk.5;
        Tue, 17 May 2022 02:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Me+uKjJZAWDwfBTJxz+jBC9SS3RjTx0pNNUaBKDr068=;
        b=CcMqTDR+yCZbQX0+BOZ14BmdJ6DC3putdvOAXtNqNLfRCIxhuxVqMFz/nrJnUG9N5C
         +nFqEy4Y0b19itGsMX8WE/Ch+VCK24sQV7T/ELAYxH1dFbB89W+qP8fOp+DnojXeVB2g
         n20Cliqrl5K/YuhoRc8SbsvE++a+kfQmhkgzjwREV1T4Tcqkq5H5kOJM2TUvMev5GzyN
         TZIRoOKEUhei2pMDnfF2r9wuLC//HrDd2XqGR+pUjQv2KPRuZCvu8IO0I6+RS5CReoCi
         MuBiGuAymveyQH8ybDNGXx2+JM/MuMMCQZvC+CuXU9+q4s6x4I2dYwOVHgr05/Ew86hs
         PC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Me+uKjJZAWDwfBTJxz+jBC9SS3RjTx0pNNUaBKDr068=;
        b=O0sHuhS3JDEPlEjDCU4yLJEdHVJM9vXVey2DIqXL6kVIeqONDH0sXGmUDZcMxnufSE
         MYFgkhgLIv9dbc630QO4ORQSBKePASK8a2JkB94WLElPtlLg/mSTOccAu2PGmLEg+ReW
         HR26LSNQBsUOhQARXt1RUrbclVHkSqN1Im3t/iCded7NnDBUOgO4RCGY3pSIKpd+WZGY
         x+I0zGTvMlCw09MhcpCuWnVjGL0muyfCZbsbxpA/GrCRSznG/ADHFLEhEFRagtttOF8j
         57Ui8vbczWVHD/xW0DUA5p45mbg4F6ro0VB5K5dRcgIUegb5Na83VoMi2+xGKitqMJvd
         10CA==
X-Gm-Message-State: AOAM531L0my9sNH+5ueNOpoLRCnWa9X4Xm7EGDA6QtBymQfFp++c2SQy
        JGbdkt2gSUnCNnAG2oUGfWw=
X-Google-Smtp-Source: ABdhPJwxRlMB1ICxBqt8qUCJhaUD01PzAS2JaE8J8cRlhr4kBxaPivhnpGynfy/CbhEm4bjB5FquTQ==
X-Received: by 2002:a17:907:3f29:b0:6f4:cb04:a6f5 with SMTP id hq41-20020a1709073f2900b006f4cb04a6f5mr18895645ejc.115.1652779520010;
        Tue, 17 May 2022 02:25:20 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id z4-20020a17090674c400b006f3ef214e14sm814331ejl.122.2022.05.17.02.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 02:25:19 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Saurav Kashyap <skashyap@marvell.com>,
        Javed Hasan <jhasan@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: qedf: remove redundant variable op
Date:   Tue, 17 May 2022 10:25:18 +0100
Message-Id: <20220517092518.93159-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The variable op is assigned a value and is never read. The variable
is not used and is redundant, remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/scsi/qedf/qedf_io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/qedf/qedf_io.c b/drivers/scsi/qedf/qedf_io.c
index 2ec1f710fd1d..e57cc22453d0 100644
--- a/drivers/scsi/qedf/qedf_io.c
+++ b/drivers/scsi/qedf/qedf_io.c
@@ -804,7 +804,6 @@ static void qedf_trace_io(struct qedf_rport *fcport, struct qedf_ioreq *io_req,
 	struct qedf_io_log *io_log;
 	struct scsi_cmnd *sc_cmd = io_req->sc_cmd;
 	unsigned long flags;
-	uint8_t op;
 
 	spin_lock_irqsave(&qedf->io_trace_lock, flags);
 
@@ -813,7 +812,7 @@ static void qedf_trace_io(struct qedf_rport *fcport, struct qedf_ioreq *io_req,
 	io_log->task_id = io_req->xid;
 	io_log->port_id = fcport->rdata->ids.port_id;
 	io_log->lun = sc_cmd->device->lun;
-	io_log->op = op = sc_cmd->cmnd[0];
+	io_log->op = sc_cmd->cmnd[0];
 	io_log->lba[0] = sc_cmd->cmnd[2];
 	io_log->lba[1] = sc_cmd->cmnd[3];
 	io_log->lba[2] = sc_cmd->cmnd[4];
-- 
2.35.1

