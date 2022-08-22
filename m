Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575F259C1C2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 16:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbiHVOjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbiHVOjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:39:43 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6091132AA4;
        Mon, 22 Aug 2022 07:39:42 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id r14-20020a17090a4dce00b001faa76931beso14211141pjl.1;
        Mon, 22 Aug 2022 07:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=WGucK6A+7SMvvshGIdsAODR7OhhetiQhlNUf0D2nokw=;
        b=U+98d6NZ338KGmIc0NmT90+e2vcuXEQIsK5C2sdR+vEE2o5HwwmveS1M7joPfG5vXu
         iIKnjrJuQaPTuYuYlvgw5VKEo1GhIJjjC6Lo/cAPWB0G9QIJdmXfTmR/RDV+yxMIMDcF
         ukJCKSSMVYvypPNNnoY6F+0cu3G9c2nxbO8nUj0l41uvqahLW0ZFEVAF6zm313TxLaI/
         08n/cH/fK2EO0/pZUmYcY0XDAXwgfhLEQe5i3e9WF3aWnVnUERSypg4XD3RkUFltICFv
         8s4OU5Euhn3oyT98glh9oReO/TS5hCDgS7TqurUL7h1PrezetXd10Ko6GkL7/65Be3Yv
         FDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=WGucK6A+7SMvvshGIdsAODR7OhhetiQhlNUf0D2nokw=;
        b=gYxM81/ijgVY7yYknZpkLNvo4ZrzpNWggC5MJVOhBC2jyVQZLr8FZH2sXo1W0q+AfW
         UzO1BhDQ28vJyCEtJ3KlZv5tM3RyhX09qc59c3nNt29K8+WK/8nraPqOw9PDlgURnLcw
         r5u134S6fprMqhRp3m2Wwt5fVmvLCT+KZPXcfE9GfA0x4Js8yszpvg3O/COQAcpjFugD
         4G8rzs8/avkrIULm8xiSi/L5Ul72LcFaeEpqdDFPLKNLsQzNt8l+zttD+0NMTe4miYHo
         OSpGmEdN60Uzt/TJj0JDjzO4FWlwhPvWH/VGzkBkSWz204RIOrP1xPHlWk6EGk1v0aWz
         uDmA==
X-Gm-Message-State: ACgBeo23xKrfoJcx5yhdhmxxXu4iWmfbEqSh+B0h9LnNF8Vig0V7VdWN
        G5OBBYN18pep8iuBg7ElLdY=
X-Google-Smtp-Source: AA6agR5d9OkigYSIEhWpt/BDewiv5Qw4PGuPH7OQzNhct7q/Oejj7Bg8uH1Wi/9R9mByDA4YYRfelg==
X-Received: by 2002:a17:90b:281:b0:1fb:151b:b5cf with SMTP id az1-20020a17090b028100b001fb151bb5cfmr9346566pjb.166.1661179181980;
        Mon, 22 Aug 2022 07:39:41 -0700 (PDT)
Received: from localhost.localdomain ([182.160.5.243])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902eb8900b001715a939ac5sm1730886plg.295.2022.08.22.07.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 07:39:41 -0700 (PDT)
From:   Tuo Cao <91tuocao@gmail.com>
To:     khalid@gonehiking.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        91tuocao@gmail.com
Subject: [PATCH] scsi: BusLogic: move spin_lock_irqsave to spin_lock in interrupt handler
Date:   Mon, 22 Aug 2022 22:39:19 +0800
Message-Id: <20220822143919.17778-1-91tuocao@gmail.com>
X-Mailer: git-send-email 2.17.1
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

