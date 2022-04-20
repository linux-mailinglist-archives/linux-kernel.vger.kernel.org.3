Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D25508A08
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379330AbiDTOI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379319AbiDTOIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:08:49 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F19433A9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:06:03 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id s14-20020a17090a880e00b001caaf6d3dd1so5049077pjn.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2BbdN1kr5sGoIGX1dtNP33lYM00rauT2fciX5GfBZWk=;
        b=qPaGt8W1SqBUdOv9jbIxxS6ZyJAG8y3H45tHU2B/Rku9YW/MdoizmUnnz/k3hzJuFL
         PwKCyUmQuU00oINndtdwHZGGA9NeIIp4Ja7sCeCsbVIxJx/6vqgyB2Wm5sUvQsUWqYur
         5XrzKb6MyXbu3tr/UpAj6JhAP06wKMWV63FSUCkG9AMYgMGPXfTHQ5PHuZqReyCIoQCa
         eqlk9W1RBcZV6naDaBUkwHO/hpuNEy2xvG02iPOa9acTWBJb1tned1CLlL2IYSmTyaej
         2CPr3alR9H1u8xODMebyeOSV5SuwemSA5rHLqGmq1RboRqULztcVquB/DVby9RpXMCBU
         Vl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2BbdN1kr5sGoIGX1dtNP33lYM00rauT2fciX5GfBZWk=;
        b=mGs3wqf1/TKQl5EC7hNRTj7GnsB8PfRrkko54boblKRZEZAYGkuFj3ia0Nf2dlr5N1
         AUm+N4MAq2AGPaSBMt9xPpWD7eUWkKvdkCAfGML5v76PJzG0ktFCkvEzHeYTUAaENuhh
         I889ZZpi4V9d/E1K/pDY/Q0Ow9PtB9vFbPLnzAIkpuUzE1arPiSiS/tPfWocjKIsgHyU
         YTkKlemDnUyGya4WEU5rigFtT3DMO6g8kaCCSQkeKH5YlwLdunlvfw8VQULWCpa3cxGh
         LCf+jz0fT+2b1aw6sXJ8MRiu8O0sN8EASb4P56Neap9b6Mh3pbk4cV5cFgpvMOy2TQXq
         GHwg==
X-Gm-Message-State: AOAM533pIHv3KxjOyLink1ii9JLEj0F8QOmfsAhnbo0xB0arJlRvZ7ot
        y1LEMA7IqNLxfDP33+sG9zlkjb3PfQ==
X-Google-Smtp-Source: ABdhPJy93n7MJeCi0rQR1oa0d4fp/Wo2Zw8s/BAo8O+6HmRdt6k0l6D5iy/e9DK4uqrR9bVmfGDL/Q==
X-Received: by 2002:a17:90b:350e:b0:1d2:b6e2:1000 with SMTP id ls14-20020a17090b350e00b001d2b6e21000mr4702893pjb.199.1650463562517;
        Wed, 20 Apr 2022 07:06:02 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id br10-20020a056a00440a00b0050a777cd10csm10959178pfb.91.2022.04.20.07.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 07:06:02 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 6/9] pm/irq: make for_each_irq_desc() safe of irq_desc release
Date:   Wed, 20 Apr 2022 22:05:18 +0800
Message-Id: <20220420140521.45361-7-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220420140521.45361-1-kernelfans@gmail.com>
References: <20220420140521.45361-1-kernelfans@gmail.com>
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

The invloved context is no a RCU read section. Furthermore there may be
more than one task at this point. Hence it demands a measure to prevent
irq_desc from freeing. Use irq_lock_sparse to serve the protection
purpose.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
To: linux-kernel@vger.kernel.org
---
 kernel/irq/pm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
index ca71123a6130..4b67a4c7de3c 100644
--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -133,6 +133,7 @@ void suspend_device_irqs(void)
 	struct irq_desc *desc;
 	int irq;
 
+	irq_lock_sparse();
 	for_each_irq_desc(irq, desc) {
 		unsigned long flags;
 		bool sync;
@@ -146,6 +147,7 @@ void suspend_device_irqs(void)
 		if (sync)
 			synchronize_irq(irq);
 	}
+	irq_unlock_sparse();
 }
 EXPORT_SYMBOL_GPL(suspend_device_irqs);
 
@@ -186,6 +188,7 @@ static void resume_irqs(bool want_early)
 	struct irq_desc *desc;
 	int irq;
 
+	/* The early resume stage is free of irq_desc release */
 	for_each_irq_desc(irq, desc) {
 		unsigned long flags;
 		bool is_early = desc->action &&
-- 
2.31.1

