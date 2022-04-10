Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CDB4FB029
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 22:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242243AbiDJUg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 16:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbiDJUg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 16:36:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEA136B63;
        Sun, 10 Apr 2022 13:34:45 -0700 (PDT)
Date:   Sun, 10 Apr 2022 20:34:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649622883;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fE3AaMHHUkYLpCGGxU+v1SLmaDbhYiMGg3xpiZFFg3Y=;
        b=mqN4Ow4YLW/TYhVon9R3o5Rn9vjiE0exTZ87Rp+jLvQdP/zzggIo0m6+Ubo2yIDHSRC7f/
        6RIqtiS9M/Ne8LeHX9RhOsopneV+Sn8FMuQQ+N0EFlbvk0LYDtJK/rAfQcDS3JEE4gt9JZ
        zmuEXYnXKMWN6zVwkzXKGzkxd8rCmR4ruB2bIHiLZvEYD1uU7z2Juv8EDHLqnd0bVVgOcY
        IFVEDiPn7AdulbQqzVIxCgOkjhZhGgc++HjHAJfUCqowOwo3azRvSj+YQcIWtNkSqaSXad
        ycVl7HPxmAiKWO3WDoqCIj2znOyrClqPQ5SPo0hdNCrUPiWn085pq1P1u8ZEVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649622883;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fE3AaMHHUkYLpCGGxU+v1SLmaDbhYiMGg3xpiZFFg3Y=;
        b=jLQ+7kMJmKHcbNoL8qaUP8pe+6idDRJYEwYppmZlLtCySlyrZa4Tqgna9AG2m9J8W3Crl8
        lLYaZJmuKuzkLGCg==
From:   "tip-bot2 for Yury Norov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/bmips: Replace cpumask_weight() with cpumask_empty()
Cc:     Yury Norov <yury.norov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20220210224933.379149-21-yury.norov@gmail.com>
References: <20220210224933.379149-21-yury.norov@gmail.com>
MIME-Version: 1.0
Message-ID: <164962288218.4207.15698777919924132121.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     0de61d739c21003201a0adb1f5c403f89a7c2441
Gitweb:        https://git.kernel.org/tip/0de61d739c21003201a0adb1f5c403f89a7c2441
Author:        Yury Norov <yury.norov@gmail.com>
AuthorDate:    Thu, 10 Feb 2022 14:49:04 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 10 Apr 2022 22:28:28 +02:00

irqchip/bmips: Replace cpumask_weight() with cpumask_empty()

bcm6345_l1_of_init() calls cpumask_weight() to check if any bit of a given
cpumask is set.

This can be done more efficiently with cpumask_empty() because
cpumask_empty() stops traversing the cpumask as soon as it finds first set
bit, while cpumask_weight() counts all bits unconditionally.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Link: https://lore.kernel.org/r/20220210224933.379149-21-yury.norov@gmail.com

---
 drivers/irqchip/irq-bcm6345-l1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm6345-l1.c
index fd07921..142a743 100644
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
