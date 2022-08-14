Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1317F591EC1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 08:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240323AbiHNGpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 02:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240247AbiHNGom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 02:44:42 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEB5647EC;
        Sat, 13 Aug 2022 23:44:35 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 202so4152465pgc.8;
        Sat, 13 Aug 2022 23:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=WTcptoHTlt8t0Uw787rjRlrJSUTtZQTxGFKI+vfMRbw=;
        b=CCpZ+mtrX0u+mFtsRgAUlwUh51Uh4RETylKQaMvxGZH1XGhg0GmYVp43DRDrYyqE/a
         fN3OWenfZXgHmfl1dYPTi+Bs10e6LZbZ6AXHUilToisYLTFPLP9FeB5YJdoylKID1ikh
         YF67ky/vS5Ov927cuuCn/mfCRnja5N2qSty5WefVCEr9Nk3oa0RVavCyF6PQbW9KRF1m
         +qG6EXX0r4EScOfYqxbm0CIaEtx3i5/TbtL02OsLbYMdsipJpC5cM75YziuqXzspBtjK
         qN1X+iPF6C3zjhfZ9J22Y1t+Q4RrEeC71oJ9mnoAIZOqfW1og4RnXyGRYBDEHndIAURK
         GB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=WTcptoHTlt8t0Uw787rjRlrJSUTtZQTxGFKI+vfMRbw=;
        b=ky9U8MjXlR/jfX61LF/JQpVBdwzNK50o90LaUD5kfkhR5yjBg8Ctx2PnqvLSLvspHY
         dXRBiZUdEV6YsJrrlcysBTqOGkGXXr1A/UI38iC4TEd8eF29LxlwjgOLcReUeYdIpAGm
         t3fbYCob0Fep7m183CTCD7adt2iDSCvPfXq/sAR/69eWXwxc0fwlaztsNMUFqU4TV0jY
         Wz2R3FDpW1hMtZ9EILk1lpmsXdVaxrCxc9YS9RbptW0urgseyeEdTVGVXNmDuLMc1XpQ
         lZJVeEP4GOEQwXWun4u9HrRyR+q+PHK9Ls3cAFwdJA6By0+t9jRzTrrwcnK44aGW6tai
         tlQw==
X-Gm-Message-State: ACgBeo18op7sb0b4fND+SC3/moOlVVID4qI1+A4M4VaNM1O/+VLAIbYe
        cgHhMvuySEY4SnRRD8YvR3E=
X-Google-Smtp-Source: AA6agR7ZpmWGP7r5GU11jppfRo+BTncutxWo903b/yOtV40cQgGzdD5ADIO+XppvV9DWPArII8Ay5A==
X-Received: by 2002:a63:5c4a:0:b0:41d:bd7d:6084 with SMTP id n10-20020a635c4a000000b0041dbd7d6084mr9309641pgm.411.1660459475059;
        Sat, 13 Aug 2022 23:44:35 -0700 (PDT)
Received: from localhost.localdomain ([182.160.5.243])
        by smtp.gmail.com with ESMTPSA id o27-20020aa7979b000000b0052d481032a7sm4593778pfp.26.2022.08.13.23.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 23:44:34 -0700 (PDT)
From:   Tuo Cao <91tuocao@gmail.com>
To:     James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
        khalid@gonehiking.org, willy@infradead.org, hare@suse.com
Cc:     anil.gurumurthy@qlogic.com, sudarsana.kalluru@qlogic.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        91tuocao@gmail.com
Subject: [PATCH 6/9] scsi: advansys: move spin_lock_irqsave to spin_lock in interrupt handler
Date:   Sun, 14 Aug 2022 14:43:34 +0800
Message-Id: <20220814064337.32621-7-91tuocao@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220814064337.32621-1-91tuocao@gmail.com>
References: <20220814064337.32621-1-91tuocao@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

it is unnecessary to call spin_lock_irqsave in a interrupt handler.

Signed-off-by: Tuo Cao <91tuocao@gmail.com>
---
 drivers/scsi/advansys.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/advansys.c b/drivers/scsi/advansys.c
index f301aec044bb..2f402f73ae4e 100644
--- a/drivers/scsi/advansys.c
+++ b/drivers/scsi/advansys.c
@@ -7137,10 +7137,9 @@ static irqreturn_t advansys_interrupt(int irq, void *dev_id)
 	struct Scsi_Host *shost = dev_id;
 	struct asc_board *boardp = shost_priv(shost);
 	irqreturn_t result = IRQ_NONE;
-	unsigned long flags;
 
 	ASC_DBG(2, "boardp 0x%p\n", boardp);
-	spin_lock_irqsave(shost->host_lock, flags);
+	spin_lock(shost->host_lock);
 	if (ASC_NARROW_BOARD(boardp)) {
 		if (AscIsIntPending(shost->io_port)) {
 			result = IRQ_HANDLED;
@@ -7155,7 +7154,7 @@ static irqreturn_t advansys_interrupt(int irq, void *dev_id)
 			ASC_STATS(shost, interrupt);
 		}
 	}
-	spin_unlock_irqrestore(shost->host_lock, flags);
+	spin_unlock(shost->host_lock);
 
 	ASC_DBG(1, "end\n");
 	return result;
-- 
2.17.1

