Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F00851A384
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352134AbiEDPTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352074AbiEDPTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:19:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA6519C0E
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 08:15:40 -0700 (PDT)
Date:   Wed, 04 May 2022 15:15:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651677338;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZdcVioVoPZuet/ZuOdrNf/nX7+CTAjFcvE5C68TmTYM=;
        b=ao2gkoSKAk0LVg0Oc7cn2HlyM1gIfSBeZ4HNlW/hR/cJN5aSkE6cozPgoQrgSoIutR4pw0
        vYveNrNnI4Y5l79d39zifCva72UdeUFtBU5JiqLkWtsu0unae5VhhDUUHj1dHx8IohSpio
        9lUwZ52l2hwKcwGqca7Cd+yWHL0OjsCd/+tU+0jCg0QnyIwSnsM5m7fsFnzT1fpuYL3plr
        foYCMj1h5gGYLYCv3D4uGY8d1Hg421h6jG7DKjSxEuKuTx9XL9Cgul/T+oJ5q+phaeFbj0
        wKKp3tBd3XasJFKrTRnjSdVhx+BxRcRTncuSHOw8eMG56wxt99OoGzaVFL9q1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651677338;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZdcVioVoPZuet/ZuOdrNf/nX7+CTAjFcvE5C68TmTYM=;
        b=uMUxIzXITpdowSA4j2DNAh75gBRVLBM6f8qpEJmjXTMekMzaiQvvr66lYyW1efFo/KtecL
        25nWuFnAkAnCQ2Ag==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic-v3: Exposes bit values for
 GICR_CTLR.{IR, CES}
Cc:     Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@google.com>,
        tglx@linutronix.de
In-Reply-To: <20220405182327.205520-2-maz@kernel.org>
References: <20220405182327.205520-2-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <165167733717.4207.7066710452462948960.tip-bot2@tip-bot2>
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

Commit-ID:     34453c2e9f799d02f5f379519495208bbd96a935
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/34453c2e9f799d02f5f379519495208bbd96a935
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 05 Apr 2022 19:23:24 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 04 May 2022 14:09:52 +01:00

irqchip/gic-v3: Exposes bit values for GICR_CTLR.{IR, CES}

As we're about to expose GICR_CTLR.{IR,CES} to guests, populate
the include file with the architectural values.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Oliver Upton <oupton@google.com>
Link: https://lore.kernel.org/r/20220405182327.205520-2-maz@kernel.org
---
 include/linux/irqchip/arm-gic-v3.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 12d91f0..7286913 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -127,6 +127,8 @@
 #define GICR_PIDR2			GICD_PIDR2
 
 #define GICR_CTLR_ENABLE_LPIS		(1UL << 0)
+#define GICR_CTLR_CES			(1UL << 1)
+#define GICR_CTLR_IR			(1UL << 2)
 #define GICR_CTLR_RWP			(1UL << 3)
 
 #define GICR_TYPER_CPU_NUMBER(r)	(((r) >> 8) & 0xffff)
