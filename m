Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1F6569D45
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbiGGISh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbiGGIRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:17:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5662E4F1B0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:16:04 -0700 (PDT)
Date:   Thu, 07 Jul 2022 08:15:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657181755;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IT72UPHhR3fY7DZf7dpCh/dwUfT13aTxm8sSRC/oTqE=;
        b=bn/kLTCVLcQtwyAXD+HN7kilrzy62fOK1nSpKs9Ruis04u+i0WAKjPiwQhqkd4X0dQvgi6
        cezIvLZCqLjxVsMvRXS800NFC4vxKE3YBsWJJl8KbEcCbHmvEXM1KMTly5M1Ffnqs0UPBq
        uEcwzYBcrx3ck3N6fPrISdbUpMvnTpSbS3L5yYe6jkPfsrGVZFe93mwHgRaqo8GK69uw0G
        9a7/vEsLUPYLgqAPntd0dfFsMDcJVlFAppdKGcPSBD1n+m7myG8M2gG5Z+2NK2vWSB8KPW
        rioGjws7WYneuqk3SdCCcOoXYSuwvTkmPHZmvPqazbiwwY6Kki6uMUGIv+J4dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657181755;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IT72UPHhR3fY7DZf7dpCh/dwUfT13aTxm8sSRC/oTqE=;
        b=3nSiICx9AYrcKwVW8f5eO3GCCjEZPKYMcfjfBhfVdobrQrWHSMSHfL+szSG4Dsffc00bv2
        9rwy9ARMLBsvTqBw==
From:   "irqchip-bot for Ludovic Barre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/stm32-exti: Fix irq_set_affinity
 return value
Cc:     Ludovic Barre <ludovic.barre@foss.st.com>,
        Antonio Borneo <antonio.borneo@foss.st.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220606162757.415354-2-antonio.borneo@foss.st.com>
References: <20220606162757.415354-2-antonio.borneo@foss.st.com>
MIME-Version: 1.0
Message-ID: <165718175409.15455.10614451386631543139.tip-bot2@tip-bot2>
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

Commit-ID:     3e17683ff4a870ed99e989425bc976a944978711
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/3e17683ff4a870ed99e989425bc976a944978711
Author:        Ludovic Barre <ludovic.barre@foss.st.com>
AuthorDate:    Mon, 06 Jun 2022 18:27:52 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 07 Jul 2022 09:07:44 +01:00

irqchip/stm32-exti: Fix irq_set_affinity return value

When there is no parent, there is no specific action to do in
stm32-exti irqchip. In such case, it's incorrect returning an
error.

Let irq_set_affinity to return IRQ_SET_MASK_OK_DONE when there is
no parent.

Signed-off-by: Ludovic Barre <ludovic.barre@foss.st.com>
Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220606162757.415354-2-antonio.borneo@foss.st.com
---
 drivers/irqchip/irq-stm32-exti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 9d18f47..10c9c74 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -614,7 +614,7 @@ static int stm32_exti_h_set_affinity(struct irq_data *d,
 	if (d->parent_data->chip)
 		return irq_chip_set_affinity_parent(d, dest, force);
 
-	return -EINVAL;
+	return IRQ_SET_MASK_OK_DONE;
 }
 
 static int __maybe_unused stm32_exti_h_suspend(void)
