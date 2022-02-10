Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56534B1998
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 00:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345744AbiBJXgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 18:36:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345734AbiBJXgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 18:36:01 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609875F6B;
        Thu, 10 Feb 2022 15:36:01 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id o10so5711977ilh.0;
        Thu, 10 Feb 2022 15:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+6fGWOvKupFRHqASATl4H7ePp2/LogONFRX5QE2erMk=;
        b=c5TKy1a65HE0+KDrrZ0l/0nyjG2KwQMjf+LTDiNfbSE5RPViIvGC8K2sHtLqVEcATl
         s9UJ/l/F0Gz6sTG4Um9A9x+I5/IKHSGqrabca7G/pE0GFSn3XrH1YGeZFwiQrdeYQ2OO
         wRYGq1zhoyCG6jEZqlxFK4gKdjeLjsn3FyH/9KWUGJa5YZSktM3YXMRDDCVu/rR+AA2Z
         oA78RSF7auCtcAT5js4nUbb4fLc9eIrWmHdj2Xyew4TFqMHZNPCFuVgHQyJVH43uWM+x
         hbbn18w+pjBpT7F/P3oXQdsqSOIcktcYds/lAjybQxjTdeU0egJ1F0ul5vz3eBMhF1Qg
         zMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+6fGWOvKupFRHqASATl4H7ePp2/LogONFRX5QE2erMk=;
        b=Je0WUv8LTZFb/06BB0tyffvW5e+Oc7MqqdghD3pFwzPq1WhT6yfLFUhxLkl1RsCcEg
         7JW8ssOV6hUweOq6Uu9htKUk/oOQnFkssshDDPwt9IHjp5tf4bFY9UItTtBQP3zYcV9Y
         7Z0qVWVMj8rhz+q/CLVYPg2FiRvKIgt3+/tLSLQQdMUq/nt9W6Mqwo9I06WiBY+1AlMa
         l51BhzCu6EdHkDLQoh1LXDLNZtV8ipEtkU0xbfsF610BC3V2ckhaHu+/FXRTXCzZW851
         a5WtVzooDXFuD+i+SEYrm2sY56MHrYjwVQ2TokMOjJr++ZAVHSkPQh/IHPmo7/Z23r35
         feCA==
X-Gm-Message-State: AOAM533CM9eYh7FtzcLm2Q2NI++rCkX4i/+hfMwl246sK+2oi6h9Ih+D
        FLCa1+cN5WdOmhPe120HajE=
X-Google-Smtp-Source: ABdhPJxIyAONwSqovY5ap0uN+hIkP7cYxn35rT83uobFJrTicWBOWExdY8XujcVELZYNJmB7R5CauA==
X-Received: by 2002:a92:db0e:: with SMTP id b14mr5408913iln.153.1644536160698;
        Thu, 10 Feb 2022 15:36:00 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id a10sm12126701ilv.44.2022.02.10.15.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 15:36:00 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org
Subject: [PATCH 20/49] irq: mips: replace cpumask_weight with cpumask_empty where appropriate
Date:   Thu, 10 Feb 2022 14:49:04 -0800
Message-Id: <20220210224933.379149-21-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220210224933.379149-1-yury.norov@gmail.com>
References: <20220210224933.379149-1-yury.norov@gmail.com>
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

bcm6345_l1_of_init() calls cpumask_weight() to check if any bit of a given
cpumask is set. We can do it more efficiently with cpumask_empty() because
cpumask_empty() stops traversing the cpumask as soon as it finds first set
bit, while cpumask_weight() counts all bits unconditionally.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/irqchip/irq-bcm6345-l1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm6345-l1.c
index fd079215c17f..142a7431745f 100644
--- a/drivers/irqchip/irq-bcm6345-l1.c
+++ b/drivers/irqchip/irq-bcm6345-l1.c
@@ -315,7 +315,7 @@ static int __init bcm6345_l1_of_init(struct device_node *dn,
 			cpumask_set_cpu(idx, &intc->cpumask);
 	}
 
-	if (!cpumask_weight(&intc->cpumask)) {
+	if (cpumask_empty(&intc->cpumask)) {
 		ret = -ENODEV;
 		goto out_free;
 	}
-- 
2.32.0

