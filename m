Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAE3591EC3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 08:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240345AbiHNGpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 02:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240303AbiHNGom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 02:44:42 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A415867C88;
        Sat, 13 Aug 2022 23:44:37 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id c24so4149911pgg.11;
        Sat, 13 Aug 2022 23:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=bpHflVqpWFCurIS5n6prF8RqBgNPSiD5kv/4SFiqdqI=;
        b=mwcYny7oCPSQKZ1FC4syu8SOhDeD6KdzzNLzmXR55TGnD+AC779AdiOiwpaPIQPwkG
         M4MBYsM+6nWzNnDrj0CC/aJ6c2YOkkvalKCokgYXywjUVdeJDsql0G+ZMolJ0uataFrU
         Q1GEDxrzHDtq6q3uA/83Xm2ra4+VAUuIZmu69rIAyG10reFTOwwL4ijlBWlRIfhD4CUK
         6oNhWE5ypXpLoCn0ePC/VvhXcbhTl7DoiqZ2f/uMCWPP6QLeW5puL4/EQaSpzYPZBcv6
         vJJw2/KKJcbOqtMEm193MVfruhcz8X1Uo/tXGvNg2MYuB7X7aXuxObwsdAnnY2Gcn6UG
         RoOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=bpHflVqpWFCurIS5n6prF8RqBgNPSiD5kv/4SFiqdqI=;
        b=HHfIk9udEgTBA28k96xU4aQIDA7Rnjq1HZqhqOzkTiLQsD9dWbeBKt6Ffme09pv8B6
         IC6beH7VQRxOB1vvkbUJXRp0W3iQNl5A9YdrfD4VdhJ/qQ0SoPiUR4dEY8w6tYiAaTFT
         AViCsWwRGy7nByskFgj2HFzYgr3Yk7NI3DLPWzyfPlx02qlVSt7TIN6IvIz02We/7LCj
         cja3dq9zoffxFJB5Iw2czU/YkKRzF8+BG2nGJvjRxZKkw4VN5BxpFblxLQu80fLgTHVl
         mV9TBsQTXNW+cvzJ1JOhxlYxCsmr9155WKuXkkgo5dEDhvd3gRF5ih4T+t/WGaCMygJ6
         1Yug==
X-Gm-Message-State: ACgBeo3XEOxKA0KCI3txfCYhWl8ikri0qNlzwFSVNnHnO/UeUS4GN0D7
        16TVJS707jtpTYB/Texxn0g=
X-Google-Smtp-Source: AA6agR6aN+cNBziv2g6L/nCULTB4wP2gc5R52kExDTjPOXl6Zbz72M+uhW7Dn+6q5vAtL80GD0+Brw==
X-Received: by 2002:a05:6a00:1948:b0:525:45e3:2eb7 with SMTP id s8-20020a056a00194800b0052545e32eb7mr11258981pfk.77.1660459477252;
        Sat, 13 Aug 2022 23:44:37 -0700 (PDT)
Received: from localhost.localdomain ([182.160.5.243])
        by smtp.gmail.com with ESMTPSA id o27-20020aa7979b000000b0052d481032a7sm4593778pfp.26.2022.08.13.23.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 23:44:36 -0700 (PDT)
From:   Tuo Cao <91tuocao@gmail.com>
To:     James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
        khalid@gonehiking.org, willy@infradead.org, hare@suse.com
Cc:     anil.gurumurthy@qlogic.com, sudarsana.kalluru@qlogic.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        91tuocao@gmail.com
Subject: [PATCH 7/9] scsi: aha1542: move spin_lock_irqsave to spin_lock in interrupt handler
Date:   Sun, 14 Aug 2022 14:43:35 +0800
Message-Id: <20220814064337.32621-8-91tuocao@gmail.com>
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
 drivers/scsi/aha1542.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/aha1542.c b/drivers/scsi/aha1542.c
index 552ca95157da..b49082bc5b54 100644
--- a/drivers/scsi/aha1542.c
+++ b/drivers/scsi/aha1542.c
@@ -281,7 +281,6 @@ static irqreturn_t aha1542_interrupt(int irq, void *dev_id)
 	struct aha1542_hostdata *aha1542 = shost_priv(sh);
 	int errstatus, mbi, mbo, mbistatus;
 	int number_serviced;
-	unsigned long flags;
 	struct scsi_cmnd *tmp_cmd;
 	int flag;
 	struct mailbox *mb = aha1542->mb;
@@ -306,7 +305,7 @@ static irqreturn_t aha1542_interrupt(int irq, void *dev_id)
 #endif
 	number_serviced = 0;
 
-	spin_lock_irqsave(sh->host_lock, flags);
+	spin_lock(sh->host_lock);
 	while (1) {
 		flag = inb(INTRFLAGS(sh->io_port));
 
@@ -339,7 +338,7 @@ static irqreturn_t aha1542_interrupt(int irq, void *dev_id)
 		} while (mbi != aha1542->aha1542_last_mbi_used);
 
 		if (mb[mbi].status == 0) {
-			spin_unlock_irqrestore(sh->host_lock, flags);
+			spin_unlock(sh->host_lock);
 			/* Hmm, no mail.  Must have read it the last time around */
 			if (!number_serviced)
 				shost_printk(KERN_WARNING, sh, "interrupt received, but no mail.\n");
@@ -367,7 +366,7 @@ static irqreturn_t aha1542_interrupt(int irq, void *dev_id)
 		tmp_cmd = aha1542->int_cmds[mbo];
 
 		if (!tmp_cmd) {
-			spin_unlock_irqrestore(sh->host_lock, flags);
+			spin_unlock(sh->host_lock);
 			shost_printk(KERN_WARNING, sh, "Unexpected interrupt\n");
 			shost_printk(KERN_WARNING, sh, "tarstat=%x, hastat=%x idlun=%x ccb#=%d\n", ccb[mbo].tarstat,
 			       ccb[mbo].hastat, ccb[mbo].idlun, mbo);
-- 
2.17.1

