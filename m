Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0CF50B49A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446382AbiDVKFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347178AbiDVKF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:05:27 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27DE53B4E;
        Fri, 22 Apr 2022 03:02:34 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c12so9780132plr.6;
        Fri, 22 Apr 2022 03:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k7VCUGihacP2DQRoahc3UEPX5aPnZ4E+0PZqjtlRjj0=;
        b=Jv2SI7b+1Lt4+Z3ZcqH/yUxUz1pSrQnSS77c1Uf6XWzLH/Zq2vWCeng9hc3pL4m5Yw
         JLi0QV0pejgpG1jdIi1rMnlVLk7CzO8pM7qEBdE/OvlWBojfC7nK2rK37hF1vPvBpRWL
         rfZjcD/jTDfHTTX/9XmuanVQ9TUJkGe6K4taTUXk4BTcVLArkehW4aZpmRZELSYFvEoS
         gefv8baNyUrKiN4ban4qm6oT9MOEcniIWhA/ciinb6XPILCBMoskdya8kGASShbHXSTd
         kmh8medKcFICKI6ZBV/u28JVS7ZWuAjcYMkBqgmd3dN/lx3viv96eqy55fgsjlYtDLhK
         fW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k7VCUGihacP2DQRoahc3UEPX5aPnZ4E+0PZqjtlRjj0=;
        b=sasaxRr2+fr66LBAYsBv2WXSFp6h4UGT7b47gXPN2RSspKpVaqP0OaFoDr94ur84ol
         wMcpkUiagCUT3xGbEktAKi9qaqp31S8i9VaPFomz69y/5zjjEv2e3k+GV/x41f+FlitJ
         sqrKke9vhxvw3qA6VW+QA6M1MYaYYFft06FUHuW/qxt2TOfehWn7aEBGKFMKBAfOAlK+
         Enez/oDDGy0MFPo0OiSgaw3yyHCsLbf48xbGOGLTbMMG74mcThty+rALn34NNHsYaDWB
         Cz2lvY8XNm3BY4kkYE1e7Rs0DEaELuJhQFNsH0mdVKlRn70sTSyRwB8XK3eubLyY/mmK
         Buow==
X-Gm-Message-State: AOAM531dlV6ENL9ud88dPuge8SiTTKjG/aWFmmDYNPHZeWZolR0GR+d5
        4UdT5cotE7Noq4WWOqytDLnOqrjd4g==
X-Google-Smtp-Source: ABdhPJwcsbD3BHRmBJpOJXbTLn+oBQHoShGt9MWGRKRYwIsmlp9ff2m14LQrBJ4XE7HDEm7iPNJw7A==
X-Received: by 2002:a17:90b:4a8b:b0:1d2:9346:6432 with SMTP id lp11-20020a17090b4a8b00b001d293466432mr4434108pjb.183.1650621753722;
        Fri, 22 Apr 2022 03:02:33 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id w187-20020a6230c4000000b00505cde77826sm1953914pfw.159.2022.04.22.03.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 03:02:31 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-s390@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCHv2] s390/irq: utilize RCU instead of irq_lock_sparse() in show_msi_interrupt()
Date:   Fri, 22 Apr 2022 18:02:12 +0800
Message-Id: <20220422100212.22666-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220420140521.45361-5-kernelfans@gmail.com>
References: <20220420140521.45361-5-kernelfans@gmail.com>
MIME-Version: 1.0
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

As demonstrated by commit 74bdf7815dfb ("genirq: Speedup show_interrupts()"),
irq_desc can be accessed safely in RCU read section.

Hence here resorting to rcu read lock to get rid of irq_lock_sparse().

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org
To: linux-s390@vger.kernel.org

---
 arch/s390/kernel/irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index 3033f616e256..45393919fe61 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -205,7 +205,7 @@ static void show_msi_interrupt(struct seq_file *p, int irq)
 	unsigned long flags;
 	int cpu;
 
-	irq_lock_sparse();
+	rcu_read_lock();
 	desc = irq_to_desc(irq);
 	if (!desc)
 		goto out;
@@ -224,7 +224,7 @@ static void show_msi_interrupt(struct seq_file *p, int irq)
 	seq_putc(p, '\n');
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 out:
-	irq_unlock_sparse();
+	rcu_read_unlock();
 }
 
 /*
-- 
2.31.1

