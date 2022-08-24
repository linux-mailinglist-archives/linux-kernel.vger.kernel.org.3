Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0232F59F48B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 09:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbiHXHvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 03:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234678AbiHXHvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 03:51:36 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B767F11D;
        Wed, 24 Aug 2022 00:51:34 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r22so14346426pgm.5;
        Wed, 24 Aug 2022 00:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=DAl6yWbW9rDoDO0yFmApA23sTUMNeEKhwoyVh9Q/pUc=;
        b=LN6+pGAo8jgApNZ+G1V3U0yZrjHxONbw/a7n/Ws4sLQYmR95WEU5ZuANcS5NCGYm8v
         CoGF4TQcN3SnZLYWtb8uYSCjlwTYtoW8C2vF24bz08II+3oJS86sacfidOshxpE6HfEY
         XgbCQyqDGOluxEgPg3JSc8SCv6sVTo6VXmWzubC0Z+nFxsPBz/OJP+g2evqt1IUzMa71
         wwzmaHnypCYaDPGVRdToJPfly5npeYX3auUG4nX9oksuNUrHKz0SoJwGYNIKlqql4VUS
         THzxWwkjXoSm8u69fLlyHx06muEgQHcZaZA0fe+AEI9u0pc83Bk+5wJuDV2hkit2Nr2b
         Bb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=DAl6yWbW9rDoDO0yFmApA23sTUMNeEKhwoyVh9Q/pUc=;
        b=021c7wR5RLPTOjPir7xlanL6J8WA1Q+aHAbCWx37O2A87zNTSlRY2eKZMmfaqhVyQC
         mBZmyLwGvxuxahhP7ErZY853KRnhZNU3yJZOBuwqE0Hztv6xm9cX2IaOsJJpFtQUdlIB
         9NZOfuEFkQT2LpRnIJIvxuoaXe1nC6xXhHMDAMh9VArDAMOK0r2IuYNkNXMdvOnAzCJ2
         8Ltn4/zfocC2BNwkmdwYIXgSug9KI83zRJa7NlUNfSQ4DcKa4FbUfrEsx9yxufMYROgm
         WlP1hVIM9+NpcpY5JS4Q/6dwpIbvOLhksYKD8MyGdoIAC0XWuuR+Qk4AtPj9So9BF4SS
         JXgQ==
X-Gm-Message-State: ACgBeo2M/m3IGndByremxS3BFa09KWYV5Ej2RCWylqTtgF2Ute2/X8aN
        RknQzFq2g25utq1wH6lIA0M=
X-Google-Smtp-Source: AA6agR4lYvZpgIXIFmeYgFLyvYbhC6G9VG/42zKKahEhLHpCtHGmA095FgZrsttJiHaAjmfb/j4k+A==
X-Received: by 2002:a63:d0:0:b0:411:f92b:8e6c with SMTP id 199-20020a6300d0000000b00411f92b8e6cmr22901680pga.108.1661327494374;
        Wed, 24 Aug 2022 00:51:34 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d6-20020a631d46000000b0042aaaf6e2d9sm5498989pgm.49.2022.08.24.00.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 00:51:34 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     martin.petersen@oracle.com
Cc:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] scsi: lpfc: Remove unneeded result variable
Date:   Wed, 24 Aug 2022 07:51:23 +0000
Message-Id: <20220824075123.221316-1-ye.xingchen@zte.com.cn>
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

Return the value from lpfc_issue_reg_vfi() directly instead of storing it
 in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/scsi/lpfc/lpfc_bsg.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
index 9be3bb01a8ec..ac0c7ccf2eae 100644
--- a/drivers/scsi/lpfc/lpfc_bsg.c
+++ b/drivers/scsi/lpfc/lpfc_bsg.c
@@ -1977,8 +1977,6 @@ lpfc_sli4_bsg_set_loopback_mode(struct lpfc_hba *phba, int mode,
 static int
 lpfc_sli4_diag_fcport_reg_setup(struct lpfc_hba *phba)
 {
-	int rc;
-
 	if (phba->pport->fc_flag & FC_VFI_REGISTERED) {
 		lpfc_printf_log(phba, KERN_WARNING, LOG_LIBDFC,
 				"3136 Port still had vfi registered: "
@@ -1988,8 +1986,7 @@ lpfc_sli4_diag_fcport_reg_setup(struct lpfc_hba *phba)
 				phba->vpi_ids[phba->pport->vpi]);
 		return -EINVAL;
 	}
-	rc = lpfc_issue_reg_vfi(phba->pport);
-	return rc;
+	return lpfc_issue_reg_vfi(phba->pport);
 }
 
 /**
-- 
2.25.1
