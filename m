Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93D84D430C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240597AbiCJJGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 04:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbiCJJGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:06:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AE213774A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 01:05:29 -0800 (PST)
Date:   Thu, 10 Mar 2022 09:05:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646903127;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c3LN9tbjUzKhY8RdE4seLNj3gQk1WEmV55c4SIzaR1k=;
        b=i4O6jjs98gBRt1sPdElKfFMk3Xc0gDwQVMcS22MSBoCbSmZQ3z+Z1mkiY9aOKeZ0/adSpz
        0OfvkrLVG1jpOq4lAUAgNnRQaVIOw2HEPfK3ABO6n9xDBo4n7DcmaQPaUSSU5QkBa5ROLC
        mBuQ+Iei5IjVHR5jJ7342kebVPcVz7jGyIaVIgf18LO4MLcA1NZssYJwGhPKFHxcm9iHqU
        FE7SdNEpItVR1LphueuNjmSYb5lkygLdP2G066KnBcyTKSAhmIGAUWMvyBt4B5H6dlZ6Ds
        4v6Vn0zC+UsuD0VneF8zFStsQdnpku2tqe3Z4rWDkZNIX3rMpa/uACKDS9XEww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646903127;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c3LN9tbjUzKhY8RdE4seLNj3gQk1WEmV55c4SIzaR1k=;
        b=POHiQqKRNwzaan4oOHI3ceHRzRjIiDsQKalpLf/Z/7raDopIqgEx03jjPfaTmkKMVvpvXS
        E273Kp82HE2PIZDg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/apple-aic: Fix cpumask allocation
 for FIQs
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220310050238.4478-1-guozhengkui@vivo.com>
References: <20220310050238.4478-1-guozhengkui@vivo.com>
MIME-Version: 1.0
Message-ID: <164690312459.16921.18336689219451954515.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     dc29812dbc873ae00bf19a4b8661984d7cce7a2e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/dc29812dbc873ae00bf19a4b8661984d7cce7a2e
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 10 Mar 2022 08:34:58 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 10 Mar 2022 08:58:34 

irqchip/apple-aic: Fix cpumask allocation for FIQs

An emparassing typo: allocating a pointer instead of the object
pointed to. No harm done, as the pointer is large enough for
what we are using the object for, but still...

Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220310050238.4478-1-guozhengkui@vivo.com
---
 drivers/irqchip/irq-apple-aic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index b40199c..3f1d2f3 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -810,7 +810,7 @@ static void build_fiq_affinity(struct aic_irq_chip *ic, struct device_node *aff)
 	if (WARN_ON(n < 0))
 		return;
 
-	ic->fiq_aff[fiq] = kzalloc(sizeof(ic->fiq_aff[fiq]), GFP_KERNEL);
+	ic->fiq_aff[fiq] = kzalloc(sizeof(*ic->fiq_aff[fiq]), GFP_KERNEL);
 	if (!ic->fiq_aff[fiq])
 		return;
 
