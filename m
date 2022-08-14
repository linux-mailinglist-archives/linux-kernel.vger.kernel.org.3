Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BED591EC7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 08:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240332AbiHNGpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 02:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiHNGpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 02:45:07 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5508E61D47;
        Sat, 13 Aug 2022 23:44:42 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 202so4152590pgc.8;
        Sat, 13 Aug 2022 23:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=eRP0R2EaBtwSq8WtYYvJ1VIiqvdFfbDzoNH6Xz9adF4=;
        b=gJTq4+2G2E8UjOzN05cmXZvN90i7memh0g8Vie6zK1iCWo1/89Fb7eFgNla5CnP1AL
         TSJg0M4C+eex55+sagcNQ7UmrYFhK60eqLXlbsj3wM67eSbYNUXman2xHu4efTVHmqNB
         ZIVDJKemz0mkuaADoV8/nbdi9R0EqfNH82RFylPSy81uY47Ad4MSczhqQlICoXsvSnPr
         OxlXRyyEl2RmTux7Z/rKk0kpgpyQsewtHF7Jky/WdQCjo7WfyXTMmwFH8vJCpzunJqGK
         XqnhbNj95dj3Xw5Agj3i1vkHX8UdhO9Y4d8602pA3lIjuvIhKQjsUB3mn4SYqoTeU/td
         47ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=eRP0R2EaBtwSq8WtYYvJ1VIiqvdFfbDzoNH6Xz9adF4=;
        b=vaHZtSkQvIBUFJv1v5fCkKE0FVIP1T4/H3IRCPzNgWIVNIW9OaumSG4FZKPGEh9ZOc
         9ThZMeoXbDqweVJhB0nRqKhk7UUvP48pAq3t8JZa79lzoIuADynAX7o/u2hp6M8hG+7m
         zT5sVwEy0N2qfcXwanuzPLeEL0DGB9YlIlDjQNLMFjAePfY/wtPPV3UJIZHI7lM70Czn
         jpmyZ0jp7zCnsUanzCi6e0wrqsXROX1wEVblbVWJ7jm4fQDsaKDYI9JE/x4dBSG4GtZz
         0gsYBbTR5z7aCxznDkbMMbyHx/t8sJiB58UKq+nGG+wz7T+BowGyLMESUOEoV+DVmfmQ
         tZjg==
X-Gm-Message-State: ACgBeo0DAd4FiCksYo08MmQmj+TzyN/EcT/EuQI5hYqvmBtL3SA3Lo+v
        yOoDVp5wSBTh1ESP04kFFjA=
X-Google-Smtp-Source: AA6agR40kM1yEhA2lQH3A99ngi9U6RGioao6KJCMRA3Y6JtaX4ryHMT+pLNna9uSvmu7RS9+ThBuuA==
X-Received: by 2002:aa7:88c4:0:b0:52f:755c:a354 with SMTP id k4-20020aa788c4000000b0052f755ca354mr10785397pff.81.1660459481710;
        Sat, 13 Aug 2022 23:44:41 -0700 (PDT)
Received: from localhost.localdomain ([182.160.5.243])
        by smtp.gmail.com with ESMTPSA id o27-20020aa7979b000000b0052d481032a7sm4593778pfp.26.2022.08.13.23.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 23:44:41 -0700 (PDT)
From:   Tuo Cao <91tuocao@gmail.com>
To:     James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
        khalid@gonehiking.org, willy@infradead.org, hare@suse.com
Cc:     anil.gurumurthy@qlogic.com, sudarsana.kalluru@qlogic.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        91tuocao@gmail.com
Subject: [PATCH 9/9] scsi: bfad: move spin_lock_irqsave to spin_lock in interrupt handler
Date:   Sun, 14 Aug 2022 14:43:37 +0800
Message-Id: <20220814064337.32621-10-91tuocao@gmail.com>
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
 drivers/scsi/bfa/bfad.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/bfa/bfad.c b/drivers/scsi/bfa/bfad.c
index e5aa982ffedc..3191377d543b 100644
--- a/drivers/scsi/bfa/bfad.c
+++ b/drivers/scsi/bfa/bfad.c
@@ -1086,25 +1086,24 @@ bfad_intx(int irq, void *dev_id)
 {
 	struct bfad_s	*bfad = dev_id;
 	struct list_head	doneq;
-	unsigned long	flags;
 	bfa_boolean_t rc;
 
-	spin_lock_irqsave(&bfad->bfad_lock, flags);
+	spin_lock(&bfad->bfad_lock);
 	rc = bfa_intx(&bfad->bfa);
 	if (!rc) {
-		spin_unlock_irqrestore(&bfad->bfad_lock, flags);
+		spin_unlock(&bfad->bfad_lock);
 		return IRQ_NONE;
 	}
 
 	bfa_comp_deq(&bfad->bfa, &doneq);
-	spin_unlock_irqrestore(&bfad->bfad_lock, flags);
+	spin_unlock(&bfad->bfad_lock);
 
 	if (!list_empty(&doneq)) {
 		bfa_comp_process(&bfad->bfa, &doneq);
 
-		spin_lock_irqsave(&bfad->bfad_lock, flags);
+		spin_lock(&bfad->bfad_lock);
 		bfa_comp_free(&bfad->bfa, &doneq);
-		spin_unlock_irqrestore(&bfad->bfad_lock, flags);
+		spin_unlock(&bfad->bfad_lock);
 	}
 
 	return IRQ_HANDLED;
@@ -1117,20 +1116,19 @@ bfad_msix(int irq, void *dev_id)
 	struct bfad_msix_s *vec = dev_id;
 	struct bfad_s *bfad = vec->bfad;
 	struct list_head doneq;
-	unsigned long   flags;
 
-	spin_lock_irqsave(&bfad->bfad_lock, flags);
+	spin_lock(&bfad->bfad_lock);
 
 	bfa_msix(&bfad->bfa, vec->msix.entry);
 	bfa_comp_deq(&bfad->bfa, &doneq);
-	spin_unlock_irqrestore(&bfad->bfad_lock, flags);
+	spin_unlock(&bfad->bfad_lock);
 
 	if (!list_empty(&doneq)) {
 		bfa_comp_process(&bfad->bfa, &doneq);
 
-		spin_lock_irqsave(&bfad->bfad_lock, flags);
+		spin_lock(&bfad->bfad_lock);
 		bfa_comp_free(&bfad->bfa, &doneq);
-		spin_unlock_irqrestore(&bfad->bfad_lock, flags);
+		spin_unlock(&bfad->bfad_lock);
 	}
 
 	return IRQ_HANDLED;
-- 
2.17.1

