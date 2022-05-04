Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A8B51A527
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 18:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbiEDQTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 12:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353238AbiEDQSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 12:18:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463A0108
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 09:15:13 -0700 (PDT)
Date:   Wed, 04 May 2022 16:15:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651680911;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PejGroVwC4ueRSj8DbrGKAkPmTAcjqv/5OSkbLs1kDo=;
        b=p/dL/5WEaeh89Ljgwb6Fg7cvVqojH5+szsxHkR/HebSV0zR1GTJO4FCnz0TqdBzznMdv7m
        BSxho1evxhU9dq/Oe/KRY6rwvwiUE+HXjy0rOZUb9lWM3GOnOmdczvHRBUy/f/+8bKdUmM
        pBqhjX39Ft89sP+HlZ3TCOmJ68AHh3Ni1vhplbM4IGJqWEwALvnW9nF3pn73H9wSSjsfD5
        mMRBCdKV8v6MU/lz48MhSD2xWmooO0BEmdML2XnEWw17lKCFu8bvMvulBtr0f+He7FQ/HP
        P2emymRoYuDTwlWu6+1nLrBztMU4Bzo0CyJi7LtCJV9cVJAoNUcucJibVi4lEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651680911;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PejGroVwC4ueRSj8DbrGKAkPmTAcjqv/5OSkbLs1kDo=;
        b=rP5pV6qbrz4CAmVsFG4ATWbERYSUif/rs5+kjRAAcwyDWoc2rPi4FgoUYTM6G8FRZvMcFz
        EfA+GSNqdA7q9ZBA==
From:   "irqchip-bot for Krzysztof Kozlowski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/aspeed-scu-ic: Fix
 irq_of_parse_and_map() return value
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220423094227.33148-2-krzysztof.kozlowski@linaro.org>
References: <20220423094227.33148-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Message-ID: <165168091077.4207.9608550822373424674.tip-bot2@tip-bot2>
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

Commit-ID:     f03a9670d27d23fe734a456f16e2579b21ec02b4
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/f03a9670d27d23fe734a456f16e2579b21ec02b4
Author:        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
AuthorDate:    Sat, 23 Apr 2022 11:42:27 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 04 May 2022 16:37:48 +01:00

irqchip/aspeed-scu-ic: Fix irq_of_parse_and_map() return value

The irq_of_parse_and_map() returns 0 on failure, not a negative ERRNO.

Fixes: 04f605906ff0 ("irqchip: Add Aspeed SCU interrupt controller")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220423094227.33148-2-krzysztof.kozlowski@linaro.org
---
 drivers/irqchip/irq-aspeed-scu-ic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c b/drivers/irqchip/irq-aspeed-scu-ic.c
index 18b77c3..279e92c 100644
--- a/drivers/irqchip/irq-aspeed-scu-ic.c
+++ b/drivers/irqchip/irq-aspeed-scu-ic.c
@@ -157,8 +157,8 @@ static int aspeed_scu_ic_of_init_common(struct aspeed_scu_ic *scu_ic,
 	}
 
 	irq = irq_of_parse_and_map(node, 0);
-	if (irq < 0) {
-		rc = irq;
+	if (!irq) {
+		rc = -EINVAL;
 		goto err;
 	}
 
