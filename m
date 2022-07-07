Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E517A569D5B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbiGGISo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbiGGIRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:17:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57988564CA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:16:04 -0700 (PDT)
Date:   Thu, 07 Jul 2022 08:15:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657181756;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DD+NDpqm5I36QU55M3gfvR6ksTUNVcDNJp9Awm7EMaY=;
        b=D2SfCCrMGUV310c6hy5yZr61+cEWLhR24lIQJeXJQ1cJWk+kA1O9guw7iSJjfpzWQcl7H/
        KJXh61L0q1lVfY2w8URxlf/x666JQvAZZnfBImN67z7GVDA3D7e8k/a00NwKxwAoNmyRwu
        ZFtDSQtj3w7z1YVN7EgokWnwAmbGwdZXUl7fDZa2AqJ9RGN44a8Qdq/dcdsWyiCKgSDiqO
        7307bb4oonY7i/yvxOqc4eTZqWLPo5SdritlFi02WPN2x2X/q+rII6aHuds5cx17x6zaI4
        xiCP3C+du2yCu+bBLzc9aVO5+ZxBQo7HoAzGWNWu6dDEMUKltKVHpllJ1R7sQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657181756;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DD+NDpqm5I36QU55M3gfvR6ksTUNVcDNJp9Awm7EMaY=;
        b=w66UehvxuH3OkeyEeDlLtMyWUlyDhqve3D4Om2GS23PBS1loQVdn+2GOFBRJbk2bUmggA2
        ufwNXrGcXJRfGuCA==
From:   "irqchip-bot for Antonio Borneo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] genirq: Don't return error on missing
 optional irq_request_resources()
Cc:     Antonio Borneo <antonio.borneo@foss.st.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220512160544.13561-1-antonio.borneo@foss.st.com>
References: <20220512160544.13561-1-antonio.borneo@foss.st.com>
MIME-Version: 1.0
Message-ID: <165718175501.15455.15982341933411923765.tip-bot2@tip-bot2>
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

Commit-ID:     95001b756467ecc9f5973eb5e74e97699d9bbdf1
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/95001b756467ecc9f5973eb5e74e97699d9bbdf1
Author:        Antonio Borneo <antonio.borneo@foss.st.com>
AuthorDate:    Thu, 12 May 2022 18:05:44 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 07 Jul 2022 09:04:13 +01:00

genirq: Don't return error on missing optional irq_request_resources()

Function irq_chip::irq_request_resources() is reported as optional
in the declaration of struct irq_chip.
If the parent irq_chip does not implement it, we should ignore it
and return.

Don't return error if the functions is missing.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220512160544.13561-1-antonio.borneo@foss.st.com
---
 kernel/irq/chip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 886789d..c190405 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1516,7 +1516,8 @@ int irq_chip_request_resources_parent(struct irq_data *data)
 	if (data->chip->irq_request_resources)
 		return data->chip->irq_request_resources(data);
 
-	return -ENOSYS;
+	/* no error on missing optional irq_chip::irq_request_resources */
+	return 0;
 }
 EXPORT_SYMBOL_GPL(irq_chip_request_resources_parent);
 
