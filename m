Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F000516F55
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 14:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384913AbiEBMOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 08:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384622AbiEBMOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 08:14:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158F3BFA;
        Mon,  2 May 2022 05:11:04 -0700 (PDT)
Date:   Mon, 02 May 2022 12:11:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651493462;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DqLyU6eqOYm5mbsrgaYZRI+vMRTFZkpfrcGpvit8sCs=;
        b=lfASwGypYDAxvZnjOsBm4ApDvAjAkjdu/FCKFjVtUiheCv+RHaBRPU0gndgZEpxnN9OEod
        NCspsyMQEBIMdHG3CG0Jr3nemhpSHBvrDTDtanay/gDRhm+00c3UycX4GX2Tvkts2kf+an
        q6qVwVKgsBUKHlyZWhN4uY8a2Gf3tL+ghNHaSFeUhVYetrt9yHOxA5UGZcgeFj7PcJskS9
        aeePq6XOysgwj8tJsCh4SKwQ1qS9MFHAZESg1cMLmaIkNmeu47sDcuZq4Vt/wLMzTZQDk6
        Ohph7tvNE6u3f/3+rQU2Hmyre8HfipgUhLwy/dGUwLYEtYPRTsX4MJnDdEZLng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651493462;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DqLyU6eqOYm5mbsrgaYZRI+vMRTFZkpfrcGpvit8sCs=;
        b=JcWQUm6Z51InkI7cK1DYUOhX1XFMuQ/ShJFozA3/cG5yHC5kBruHWnpslSV6NypSpCNpv/
        NMLLHVkjZ/5kDUDQ==
From:   "tip-bot2 for Minghao Chi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Use pm_runtime_resume_and_get() instead of
 pm_runtime_get_sync()
Cc:     Zeal Robot <zealci@zte.com.cn>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20220418110716.2559453-1-chi.minghao@zte.com.cn>
References: <20220418110716.2559453-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Message-ID: <165149346127.4207.7891496748759999918.tip-bot2@tip-bot2>
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

Commit-ID:     ce4818957fdc5bca57fc2c92b0dfe109d26bcc47
Gitweb:        https://git.kernel.org/tip/ce4818957fdc5bca57fc2c92b0dfe109d26bcc47
Author:        Minghao Chi <chi.minghao@zte.com.cn>
AuthorDate:    Mon, 18 Apr 2022 11:07:16 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 02 May 2022 14:08:08 +02:00

genirq: Use pm_runtime_resume_and_get() instead of pm_runtime_get_sync()

pm_runtime_resume_and_get() achieves the same and simplifies the code.

[ tglx: Simplify it further by presetting retval ]

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20220418110716.2559453-1-chi.minghao@zte.com.cn
---
 kernel/irq/chip.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 54af0de..e6b8e56 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1573,17 +1573,12 @@ static struct device *irq_get_parent_device(struct irq_data *data)
 int irq_chip_pm_get(struct irq_data *data)
 {
 	struct device *dev = irq_get_parent_device(data);
-	int retval;
+	int retval = 0;
 
-	if (IS_ENABLED(CONFIG_PM) && dev) {
-		retval = pm_runtime_get_sync(dev);
-		if (retval < 0) {
-			pm_runtime_put_noidle(dev);
-			return retval;
-		}
-	}
+	if (IS_ENABLED(CONFIG_PM) && dev)
+		retval = pm_runtime_resume_and_get(dev);
 
-	return 0;
+	return retval;
 }
 
 /**
