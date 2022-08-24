Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46EB59F486
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 09:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbiHXHuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 03:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235133AbiHXHuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 03:50:23 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892034AD6A;
        Wed, 24 Aug 2022 00:50:22 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 83so10019848pfw.6;
        Wed, 24 Aug 2022 00:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Pa1j7+cEMv+Jr0WvV2/oEDE5lx0kvRfB1vxY0gDsATo=;
        b=T/vPWPgh004DEeQugLUaAVLyShLUdMTVDaN9o0Jzd8TiY8oW9Yk4KOJl9qAzpMi+co
         KtuW8D0TfY4BpiH3YfifdR8mlz788VtpVXS/koQ0mXwKi2RJBwvE6UftA9yAnUaBv8Md
         l2Cv13xnseBwthH70WHnMwJs9vNINCZdCI7OFGV5WRpASeuWRhV166pg6+6bYVkC2ZE4
         4sbojilGYeeq415SXvnEF+HRJwVWjz7WZ0JLWrikAlFcmUwXF66pB7x6VcOsWyzmnN6/
         d0q+bVEdDlEH8r5ekUud8z7zhVwrQ3dvbH+ombPgJGru7y9qxiUbvS7z7ulVaZ7NstVt
         8B7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Pa1j7+cEMv+Jr0WvV2/oEDE5lx0kvRfB1vxY0gDsATo=;
        b=3vQR6N063FwWEdevTJtBPUu45aOZX4Xf0d3h4ontZShKGrsqE6OqhZ+6yy9Efjk/Dq
         1UqgYoOA/3AuqDPMt5sIf076zl5nSvmUwZwtMaeJXa4w/OByGHc3Id7y3ToOwTUh96FJ
         XYGM2szSTj79i5j+I0a2COpf4g57B7eru/wKSxFbYN9JyJEo7XJTwxbxcWQretfVxVVI
         HuEdoQyTVnt3CH/Q3O/F/CVh6b3KLUBjNr42SummiFiQGf7Vt9bR4YxZJj6eM8ETAXk+
         rxpr0og26GlXTnaq+dYw4xfDdoPQfau3gVqgzWI0B+yPRvOrHOwo2g3V27QwvKcM7svM
         lnOQ==
X-Gm-Message-State: ACgBeo35KCVjOSGApES2FX2N62d9qFI8askEF+YN5MzEGSfhn5/NL5kW
        wxHozAjpbURZ1EqdP9kagBM=
X-Google-Smtp-Source: AA6agR4c4JUVjv4yb50or8GMkZlXUXuqbZWEsDJ1fd6ClGtEWPBAgW3DSspogpTr/iI6z4yY6h+zHg==
X-Received: by 2002:a63:e241:0:b0:41b:b374:caf8 with SMTP id y1-20020a63e241000000b0041bb374caf8mr24114497pgj.310.1661327422028;
        Wed, 24 Aug 2022 00:50:22 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i19-20020a63e913000000b0041a6638b357sm10512593pgh.72.2022.08.24.00.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 00:50:21 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     martin.petersen@oracle.com
Cc:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] scsi: lpfc: Remove the unneeded result variable
Date:   Wed, 24 Aug 2022 07:50:17 +0000
Message-Id: <20220824075017.221244-1-ye.xingchen@zte.com.cn>
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

Return the value from lpfc_sli4_issue_wqe() directly instead of storing it
 in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/scsi/lpfc/lpfc_sli.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 608016725db9..1298cea81396 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -10322,12 +10322,10 @@ static int
 __lpfc_sli_issue_fcp_io_s4(struct lpfc_hba *phba, uint32_t ring_number,
 			   struct lpfc_iocbq *piocb, uint32_t flag)
 {
-	int rc;
 	struct lpfc_io_buf *lpfc_cmd = piocb->io_buf;
 
 	lpfc_prep_embed_io(phba, lpfc_cmd);
-	rc = lpfc_sli4_issue_wqe(phba, lpfc_cmd->hdwq, piocb);
-	return rc;
+	return lpfc_sli4_issue_wqe(phba, lpfc_cmd->hdwq, piocb);
 }
 
 void
-- 
2.25.1
