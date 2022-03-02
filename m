Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302534CB168
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245328AbiCBVgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245319AbiCBVgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:36:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3285552E53;
        Wed,  2 Mar 2022 13:35:38 -0800 (PST)
Date:   Wed, 02 Mar 2022 21:35:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646256935;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DXsL/G5uXnPDFc9uVI+Aqwd0DVzLE/kN3IO6RMfxO8o=;
        b=3Ydj+1cm67cQGbRhuYHgT2kmAbXoYbyp5IS/upAT4s8N5xJNQDnVHW+0BEvcsgOn2vYiEY
        amhvS+DVbyT9VN6/uzxsmJWhrFJn2VIaHtO4fDA8m0c2TB7LIxFFP2XuKUsVZuWlBRcnSY
        dGN9KRri68t8dfixukURZFNYZmrPMf4MrIC76sWTxc9kEqOPizUTN0v2uqn0LRgfUz+0Ht
        FiFGr9WNUaYursxPwIJDNDE0oRHdXTN8EKegxulCCp2zsvJ4tfiPcrOVrn7nVuSfa5SPSy
        q66TtRm9/dxtuZvY8SStrrWyM8pVdUx8OSxLDt/IWya5GLVU+n2tuJOBMLOlTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646256935;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DXsL/G5uXnPDFc9uVI+Aqwd0DVzLE/kN3IO6RMfxO8o=;
        b=RiBIkiN38VbGQ4UApQDMwxS4YGocltJcyfdVtXr+YDmQ+m0vPWO5ZLtpPhyJ84It6lzG2p
        tmVgGiQfa1BAurBw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] net: usb: lan78xx: Use generic_handle_irq_safe().
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Woojung Huh <woojung.huh@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20220211181500.1856198-7-bigeasy@linutronix.de>
References: <20220211181500.1856198-7-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <164625693477.16921.927635503299605010.tip-bot2@tip-bot2>
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

Commit-ID:     bfe6b967948c251955bcf175cb2d4e8d169102ca
Gitweb:        https://git.kernel.org/tip/bfe6b967948c251955bcf175cb2d4e8d169102ca
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 11 Feb 2022 19:14:59 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Mar 2022 22:28:50 +01:00

net: usb: lan78xx: Use generic_handle_irq_safe().

Instead of manually disabling interrupts before invoking use
generic_handle_irq_safe() which can be invoked with enabled and disabled
interrupts.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Woojung Huh <woojung.huh@microchip.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: UNGLinuxDriver@microchip.com
Link: https://lore.kernel.org/r/20220211181500.1856198-7-bigeasy@linutronix.de

---
 drivers/net/usb/lan78xx.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index b8e20a3..415f166 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1537,11 +1537,8 @@ static void lan78xx_status(struct lan78xx_net *dev, struct urb *urb)
 		netif_dbg(dev, link, dev->net, "PHY INTR: 0x%08x\n", intdata);
 		lan78xx_defer_kevent(dev, EVENT_LINK_RESET);
 
-		if (dev->domain_data.phyirq > 0) {
-			local_irq_disable();
-			generic_handle_irq(dev->domain_data.phyirq);
-			local_irq_enable();
-		}
+		if (dev->domain_data.phyirq > 0)
+			generic_handle_irq_safe(dev->domain_data.phyirq);
 	} else {
 		netdev_warn(dev->net,
 			    "unexpected interrupt: 0x%08x\n", intdata);
