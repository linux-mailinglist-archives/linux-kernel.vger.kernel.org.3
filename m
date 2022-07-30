Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B52585A75
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 14:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbiG3Mhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 08:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiG3Mhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 08:37:40 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6B71838B;
        Sat, 30 Jul 2022 05:37:39 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q30so4380425wra.11;
        Sat, 30 Jul 2022 05:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+zqXY6rkbMPJMqxkU+rtqDlpsqxUz8kijBJqA4TT6I4=;
        b=PCp0FluRL4dEiyBs8kpRXdqgSajxSjtKCXBHRf2VvWn9bE3NiUAnD0Dx8F3h51txtp
         55mhTmys1bW2yLccVjfz6IEiyiiDvU9EX0fuZ/jvaOMQjSj7jVO10g4JkNQn1z/tjfUm
         dpW0zrZuLe0zfVxKwC7EQu60GVhOqIlLmJBjbWnUljx5o4b+JLzVk4iheGtEkoQVxF1m
         TiH73P4kUlGX81QnelYCbdN6FgInYKCMVJTGbdXCQa4M/HqXXBJaa8S4Vf/txUzTbLFM
         +svdZwCj2C8koI4+64OG+1zkQW4kNrdyqMWVZCdzt4C0/C4fG0k67Zuu6F5hbBBjBamv
         FNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+zqXY6rkbMPJMqxkU+rtqDlpsqxUz8kijBJqA4TT6I4=;
        b=Pd5WEqyUr9QmIeaAYnjP6bUZ9bPvvdaejMmJXG/zebiBaDKPnE3V4oAlLWfhJGAnX3
         WGKchynkqMv5/sCNKaGgY8ltqm0tM4bTfzBX4SjCD1YEQi40NI2Hp5jGRA6FnicYsy8I
         WuaN1pf8jmZpl3JswurgphCOasxmaZfPmTx/2B9GLF0vH0xhtpwIe40iE1bNUeccJeA9
         ZejCFVJKw6o6zHwum1tNo/41MWaOyEZwsc5SWYl21JPNxN9JauXkyfcf/DA75YTekxnv
         xMUa2PxsNsJEB/YRjSLPqVyI0uBHHxrA8G4mRRbbrB22Cu2cGMX7dbyTJhkCDe88zres
         cvDA==
X-Gm-Message-State: ACgBeo3wepz9dBCUtAwBvt6PurdJ8e/tUP987Dyn3M8LBNsMupje3iyO
        flm9r7jvmOPFgmqMckyBVV0=
X-Google-Smtp-Source: AA6agR5CGhKjD+l7VNDqxKiZ32jGvTOkrvgweH4tLy+324ya1sYXoh3+IFN6ZXOPpfYiPZq3BAtS+A==
X-Received: by 2002:adf:f287:0:b0:220:5a73:e6df with SMTP id k7-20020adff287000000b002205a73e6dfmr940406wro.541.1659184657501;
        Sat, 30 Jul 2022 05:37:37 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id l18-20020a7bc452000000b003a2e655f2e6sm7977080wmi.21.2022.07.30.05.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 05:37:37 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Khalid Aziz <khalid@gonehiking.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: FlashPoint: remove redundant variable bm_int_st
Date:   Sat, 30 Jul 2022 13:37:36 +0100
Message-Id: <20220730123736.147758-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable bm_int_st is assigned a value but it is never read. The
variable and the assignment are redundant and can be removed.

Cleans up clang scan build warning:
drivers/scsi/FlashPoint.c:1726:7: warning: Although the value stored
to 'bm_int_st' is used in the enclosing expression, the value is never
actually read from 'bm_int_st' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/scsi/FlashPoint.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/FlashPoint.c b/drivers/scsi/FlashPoint.c
index 90253208a72f..3d9c56ac8224 100644
--- a/drivers/scsi/FlashPoint.c
+++ b/drivers/scsi/FlashPoint.c
@@ -1712,7 +1712,7 @@ static unsigned char FlashPoint_InterruptPending(void *pCurrCard)
 static int FlashPoint_HandleInterrupt(void *pcard)
 {
 	struct sccb *currSCCB;
-	unsigned char thisCard, result, bm_status, bm_int_st;
+	unsigned char thisCard, result, bm_status;
 	unsigned short hp_int;
 	unsigned char i, target;
 	struct sccb_card *pCurrCard = pcard;
@@ -1723,7 +1723,7 @@ static int FlashPoint_HandleInterrupt(void *pcard)
 
 	MDISABLE_INT(ioport);
 
-	if ((bm_int_st = RD_HARPOON(ioport + hp_int_status)) & EXT_STATUS_ON)
+	if (RD_HARPOON(ioport + hp_int_status) & EXT_STATUS_ON)
 		bm_status = RD_HARPOON(ioport + hp_ext_status) &
 					(unsigned char)BAD_EXT_STATUS;
 	else
-- 
2.35.3

