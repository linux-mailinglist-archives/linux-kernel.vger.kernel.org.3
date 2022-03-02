Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00D74CB169
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245339AbiCBVg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbiCBVgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:36:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB60C6210;
        Wed,  2 Mar 2022 13:35:38 -0800 (PST)
Date:   Wed, 02 Mar 2022 21:35:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646256937;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L9tZ9052UBqC9zDBXZ17D7LaAh9HUKJFi3/Eib8nuRI=;
        b=rZXTdqQU08qZVXU3G4Lw9kcC2ayOelvdUsHgS9dWK9WCrqw7traOR3bezISVdisQLn8z0x
        6pOjocUOU1mLnsiqSCsYja0vv1D/sxNYbH2f+E7542oDQaj7yYgiXLEcutHCK/E+sq3Uwb
        cwn8wi6qz4ODq5jgDgHxME1Zi3qq1rsyD2rG/BcpeVDEPgK+Hee/BxCO71ZUI76C3QMqK2
        l9I/g45kYKL8t5d/dS8GYmluHIMQ6PGGA3UfM4dVVUENVVpBLtb5ipc++fzFIqZ4cPC3xD
        ZXhzjygRv2zxgUYE7R+Admc+PkM5fa1e8lnLpPx6Mazc5nKXxT2AkklDJIT2ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646256937;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L9tZ9052UBqC9zDBXZ17D7LaAh9HUKJFi3/Eib8nuRI=;
        b=B3umpFmmhuw4psIvdhZywVt6PTl4KVOcmMCQojz6yygxBGlgri9mbW7KcPGZ/GOhcP7zmE
        IWfPi5zdQtSTBaCA==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] mfd: ezx-pcap: Use generic_handle_irq_safe().
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lee Jones <lee.jones@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20220211181500.1856198-6-bigeasy@linutronix.de>
References: <20220211181500.1856198-6-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <164625693589.16921.18156701901423741475.tip-bot2@tip-bot2>
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

Commit-ID:     83d9b7e3955d32d3e4e3321029f655716cb21c99
Gitweb:        https://git.kernel.org/tip/83d9b7e3955d32d3e4e3321029f655716cb21c99
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 11 Feb 2022 19:14:58 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Mar 2022 22:28:50 +01:00

mfd: ezx-pcap: Use generic_handle_irq_safe().

Instead of manually disabling interrupts before invoking use
generic_handle_irq_safe() which can be invoked with enabled and disabled
interrupts.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Lee Jones <lee.jones@linaro.org>
Link: https://lore.kernel.org/r/20220211181500.1856198-6-bigeasy@linutronix.de

---
 drivers/mfd/ezx-pcap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mfd/ezx-pcap.c b/drivers/mfd/ezx-pcap.c
index 70fa18b..b14d3f9 100644
--- a/drivers/mfd/ezx-pcap.c
+++ b/drivers/mfd/ezx-pcap.c
@@ -193,13 +193,11 @@ static void pcap_isr_work(struct work_struct *work)
 		ezx_pcap_write(pcap, PCAP_REG_MSR, isr | msr);
 		ezx_pcap_write(pcap, PCAP_REG_ISR, isr);
 
-		local_irq_disable();
 		service = isr & ~msr;
 		for (irq = pcap->irq_base; service; service >>= 1, irq++) {
 			if (service & 1)
-				generic_handle_irq(irq);
+				generic_handle_irq_safe(irq);
 		}
-		local_irq_enable();
 		ezx_pcap_write(pcap, PCAP_REG_MSR, pcap->msr);
 	} while (gpio_get_value(pdata->gpio));
 }
