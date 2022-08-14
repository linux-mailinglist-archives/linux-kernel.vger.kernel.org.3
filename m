Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D93591EBF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 08:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240307AbiHNGo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 02:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240244AbiHNGoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 02:44:34 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEF961112;
        Sat, 13 Aug 2022 23:44:33 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id ch17-20020a17090af41100b001fa74771f61so266742pjb.0;
        Sat, 13 Aug 2022 23:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=WGucK6A+7SMvvshGIdsAODR7OhhetiQhlNUf0D2nokw=;
        b=Jrul6cFXqZzr7sMQmOdzdAKmja4nShj+64SNWr0CzTx452D9lOyUH0xbFXaH/x5IxS
         KzerY8GKSdBnVWB9Q/3PSzrL2SPXfhLIldeY0WFe6z1eSrH/4I2LHqsfgsWNiyKqYBM2
         8YZEz8Gld+uuU3fQbHs28v3XedKNVGfyNYQbO2p+FJuJwzaxnzv/+urUohK1hCL+YwcQ
         O22QwEmlecohN3Bc+vbg0zJKlkHaoNDih7dIxqOeb4SWlOX5KJTwJPEWNNYyVnIy8R10
         FSOUWj+AZZ8gHd6lkXAMkGxsSYXAyr7oOzHu/p3tSX5GOyelp3GcQQkc81sVeJ8Qzk7P
         9vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=WGucK6A+7SMvvshGIdsAODR7OhhetiQhlNUf0D2nokw=;
        b=EOFCfgSZ7IRKiEvIWrRPHSdiAnJXmHzCvC2teAeDfYauIRYWd7HVmPYekf0lPfQzNv
         sd0IHy8mOh6XW0xbsWkX5quZ3hiq9is1QnWN9LI+ShEBKXyKINbmwUHPyQX87nHFOD4U
         1abPIsFwIzthqs3SOkjt7WvivyGYXy0X4tRDhe8mbIibvUWpXMCTq7te0s1OygE/3txe
         DG0NgzAadKt1wUJjleOMtjrUaA6HuwtFsQmq7JlSMG7YZF5nOzk2UccFfL+nHrJcsPrp
         xa1eQFVKzYVEUgEEFLeKZfq88c9TjnPsJaJF5/vuD962ftFMxFKLLC80NSq5gSU/bt9D
         xZ5A==
X-Gm-Message-State: ACgBeo2ERPaSWZmzPEWRUUqMGNNopY2062cQEFlr9Yl2RVcmftStZErN
        SXhRsumaHF2XD4Mc97FLHDk=
X-Google-Smtp-Source: AA6agR5foPcXHj0G32XHenSQ/1289LiOmyjMgiNs4la+kMONVXSfBsLI+REueuiYdjX9Of4bCw15dw==
X-Received: by 2002:a17:90b:38cd:b0:1fa:5566:9214 with SMTP id nn13-20020a17090b38cd00b001fa55669214mr9272289pjb.35.1660459472806;
        Sat, 13 Aug 2022 23:44:32 -0700 (PDT)
Received: from localhost.localdomain ([182.160.5.243])
        by smtp.gmail.com with ESMTPSA id o27-20020aa7979b000000b0052d481032a7sm4593778pfp.26.2022.08.13.23.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 23:44:32 -0700 (PDT)
From:   Tuo Cao <91tuocao@gmail.com>
To:     James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
        khalid@gonehiking.org, willy@infradead.org, hare@suse.com
Cc:     anil.gurumurthy@qlogic.com, sudarsana.kalluru@qlogic.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        91tuocao@gmail.com
Subject: [PATCH 5/9] scsi: BusLogic: move spin_lock_irqsave to spin_lock in interrupt handler
Date:   Sun, 14 Aug 2022 14:43:33 +0800
Message-Id: <20220814064337.32621-6-91tuocao@gmail.com>
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
 drivers/scsi/BusLogic.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
index f2abffce2659..e2eb020966cd 100644
--- a/drivers/scsi/BusLogic.c
+++ b/drivers/scsi/BusLogic.c
@@ -2739,11 +2739,10 @@ static void blogic_process_ccbs(struct blogic_adapter *adapter)
 static irqreturn_t blogic_inthandler(int irq_ch, void *devid)
 {
 	struct blogic_adapter *adapter = (struct blogic_adapter *) devid;
-	unsigned long processor_flag;
 	/*
 	   Acquire exclusive access to Host Adapter.
 	 */
-	spin_lock_irqsave(adapter->scsi_host->host_lock, processor_flag);
+	spin_lock(adapter->scsi_host->host_lock);
 	/*
 	   Handle Interrupts appropriately for each Host Adapter type.
 	 */
@@ -2811,7 +2810,7 @@ static irqreturn_t blogic_inthandler(int irq_ch, void *devid)
 	/*
 	   Release exclusive access to Host Adapter.
 	 */
-	spin_unlock_irqrestore(adapter->scsi_host->host_lock, processor_flag);
+	spin_unlock(adapter->scsi_host->host_lock);
 	return IRQ_HANDLED;
 }
 
-- 
2.17.1

