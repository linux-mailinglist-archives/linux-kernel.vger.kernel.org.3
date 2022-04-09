Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB18D4FA8BE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242256AbiDINvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbiDINvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:51:51 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D32FB89;
        Sat,  9 Apr 2022 06:49:42 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q36-20020a17090a17a700b001cb57a8da1cso2138668pja.0;
        Sat, 09 Apr 2022 06:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eQxR8LoSXw+Q4PAtREmzhoLUOa2AwuVcoHE/IZiDWwo=;
        b=IuMzyrwpKYrswpduJZP0e2v1e2zKNVxsEMo7zglDLrCW5PVCTv97+MFqE9iyDzECza
         cZxFReHSImiGf8FJoF9/9BzZprLuhkd1bEA77Di3qatxal974webxUPlND+x/j0gLcGC
         5NLAsWyODgqonR15Al3w6PBlaY73c1ISCLByRCzn9Ym7jw3C32JxYsS9N9mR7hdFVVUG
         6/9qlMVGmjozwidXrq+wkjmxQ3zsXvKGomEG3Se1KJ9K9ef+bj0OJUPQxO1r3qJ5zQ3h
         jK8QIpFY7H0Y7Zk0dTg/bZjCIEXjnFGRW1HQ5URr4XDPVDl2i7vXCxk6ooIgnPs7DvUG
         6xPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eQxR8LoSXw+Q4PAtREmzhoLUOa2AwuVcoHE/IZiDWwo=;
        b=tnE01Fv50uMasQWz2HhTXzOnTSGavIpUOlgSOPp1BXPCyyT00Tyz9/Vf2kZNYlXWJV
         hqr/lCpbYz7rUVfPU1PclKaeSkIN5v7LGJbxZy2pPPBhohJl3YFb+/VNexfuH5LXnQ+B
         XNHipTRH70mv8S6VA9cDsAqQ+RfxXmFlt8pgRCUr6l+qz+UyWMT/Eidruwyqzu02c2gq
         re0cq/hIB3kxGCmrGaPELh4GiymUOYuiKywVl7XcxDRU5ONe+1I7op3Tilu3BadPAbsl
         eSxo7Fdmyz55MavAF7ZK0hTQidV2WhIv/RGP5n3A3bZGuNH7ww0sjV7LQ4nd1FrsU9OX
         vIRA==
X-Gm-Message-State: AOAM530Gza2I6y2RxX3tYT7WZkKwjiyiU58RAwaxXd03HJZsrNQotITF
        AW3rLk4sGfUkT/iMLGX8hw==
X-Google-Smtp-Source: ABdhPJz3LRFoU6I5tmoscaIXDLI100a23EaVeRZc3gx7tWVOTXHiclTR+f3kdmiIopdpzaX1QQUlmQ==
X-Received: by 2002:a17:90a:c792:b0:1ca:4d2f:3f1b with SMTP id gn18-20020a17090ac79200b001ca4d2f3f1bmr26762255pjb.86.1649512182026;
        Sat, 09 Apr 2022 06:49:42 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id q18-20020aa78432000000b004fb0a5aa2c7sm30964774pfn.183.2022.04.09.06.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 06:49:41 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     sathya.prakash@broadcom.com, kashyap.desai@broadcom.com,
        sumit.saxena@broadcom.com, sreekanth.reddy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] scsi: mpi3mr: Fix an error code when probing the driver
Date:   Sat,  9 Apr 2022 21:49:26 +0800
Message-Id: <20220409134926.331728-1-zheyuma97@gmail.com>
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

During the process of driver probing, probe function should return < 0
for failure, otherwise kernel will treat value >= 0 as success.

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/scsi/mpi3mr/mpi3mr_os.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index f7cd70a15ea6..240bfdf9788b 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -4222,9 +4222,10 @@ mpi3mr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct Scsi_Host *shost = NULL;
 	int retval = 0, i;
 
-	if (osintfc_mrioc_security_status(pdev)) {
+	retval = osintfc_mrioc_security_status(pdev);
+	if (retval) {
 		warn_non_secure_ctlr = 1;
-		return 1; /* For Invalid and Tampered device */
+		return retval; /* For Invalid and Tampered device */
 	}
 
 	shost = scsi_host_alloc(&mpi3mr_driver_template,
-- 
2.25.1

