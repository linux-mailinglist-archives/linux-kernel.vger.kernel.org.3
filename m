Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A355C591EC6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 08:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240364AbiHNGpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 02:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240315AbiHNGpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 02:45:00 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED2461B12;
        Sat, 13 Aug 2022 23:44:40 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id k14so4386566pfh.0;
        Sat, 13 Aug 2022 23:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=J0IgRCNJ5zc066qO2+BSqn97K/QHn49DvsVSGMTObUo=;
        b=Bc7HOD4dYzcxi5LkgcO2VwQV46IzFaUbg7GPwCGjiQtQwY+twq0EajtCWrz2xIqZtm
         syih3CkT9aVKtjbROpryD+OR3Ip55O+SLf1AgX3neLe9DP2/kmq1xVsE1yIct9NxAQPJ
         NgTDMIG5Wyamx/EVSDSBsimrnU5ZrwK3qF6U+1nBJ5ELNgx560OHNrUcT3H3dkjUgnXP
         +3FSztjYdmKRrqiGNVii5yZhaedi5r8/i9okpw4PjO6/ljLhQn/7NDMroXLONUnOwh6o
         Mubdn8+ULwPafsyqVRCTOlS0P3ielWHBfuZfg/oW9OU8CPl8J/+fnUjcVyYvUsUOEvWC
         QKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=J0IgRCNJ5zc066qO2+BSqn97K/QHn49DvsVSGMTObUo=;
        b=XhbTuG9VRCiQNqqazf7ojFzpwx0vlk0+aA99j36FlQFdUDxJlmDkiCqVgz4gRzcfLx
         hDNjVF85+dkgPqkO4j4jRQoJTJp98SvVfEtTFslRskgP8uFSJGXcXOXufMaAl6FlASJ3
         h2gh1xdTtYsj/XbUtqRvFQZj1Hr++BipIxbKHxKAgqpnD7Y2lAvH3YSXGEpwPFi9x991
         aXEeN/3fuqk0qyDiFx27edSZrrjy0bFKr/hx2CUUzprXSb5f0sdPuCoGzH4ktWKl7XsI
         DWayXU6OY1H3m9rzuD2TtVBsYFSRXNQSi/hDgLoYbR2adHm9KE1RLQG5nWRFRbIKCKAT
         k7Jw==
X-Gm-Message-State: ACgBeo1EkMSbVbgkWw1sC8gkGUV8B6PkAhii3jZtTB2ryWLrCYSppE4p
        6qy299gXZmepebUfJJBsw5s=
X-Google-Smtp-Source: AA6agR4Bv8K5j45NR9cWF3WsYfymXfcq2W3VZ3dL3yaosEb4mZ2TxerWrMunao1wdCzzebZY8vu5Hg==
X-Received: by 2002:a63:4f5a:0:b0:41d:10ae:6203 with SMTP id p26-20020a634f5a000000b0041d10ae6203mr9459572pgl.258.1660459479522;
        Sat, 13 Aug 2022 23:44:39 -0700 (PDT)
Received: from localhost.localdomain ([182.160.5.243])
        by smtp.gmail.com with ESMTPSA id o27-20020aa7979b000000b0052d481032a7sm4593778pfp.26.2022.08.13.23.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 23:44:39 -0700 (PDT)
From:   Tuo Cao <91tuocao@gmail.com>
To:     James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
        khalid@gonehiking.org, willy@infradead.org, hare@suse.com
Cc:     anil.gurumurthy@qlogic.com, sudarsana.kalluru@qlogic.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        91tuocao@gmail.com
Subject: [PATCH 8/9] scsi: aha1740: move spin_lock_irqsave to spin_lock in interrupt handler
Date:   Sun, 14 Aug 2022 14:43:36 +0800
Message-Id: <20220814064337.32621-9-91tuocao@gmail.com>
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
 drivers/scsi/aha1740.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/aha1740.c b/drivers/scsi/aha1740.c
index 134255751819..c4f46ab927d1 100644
--- a/drivers/scsi/aha1740.c
+++ b/drivers/scsi/aha1740.c
@@ -218,14 +218,13 @@ static irqreturn_t aha1740_intr_handle(int irq, void *dev_id)
 	struct ecb *ecbptr;
 	struct scsi_cmnd *SCtmp;
 	unsigned int base;
-	unsigned long flags;
 	int handled = 0;
 	struct aha1740_sg *sgptr;
 	struct eisa_device *edev;
 	
 	if (!host)
 		panic("aha1740.c: Irq from unknown host!\n");
-	spin_lock_irqsave(host->host_lock, flags);
+	spin_lock(host->host_lock);
 	base = host->io_port;
 	number_serviced = 0;
 	edev = HOSTDATA(host)->edev;
@@ -315,7 +314,7 @@ static irqreturn_t aha1740_intr_handle(int irq, void *dev_id)
 		number_serviced++;
 	}
 
-	spin_unlock_irqrestore(host->host_lock, flags);
+	spin_unlock(host->host_lock);
 	return IRQ_RETVAL(handled);
 }
 
-- 
2.17.1

