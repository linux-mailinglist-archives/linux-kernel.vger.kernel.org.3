Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F5F4DCA10
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbiCQPfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235896AbiCQPfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:35:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D391788FE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 08:34:01 -0700 (PDT)
Date:   Thu, 17 Mar 2022 15:33:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647531240;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A5rA4NpV/C5UbKlXxvEuQEaV4gZ2/9ZhOEdJ4HSELdg=;
        b=OUYNAGtRuvjHbHVJ+j05xUy/Xkwk/WOTcoebcIiZ+NrGm+FTnNugywUscULY6NotDBDqqs
        /pA07YqALzbU4rrGvb6djkIDAKe3v6KGkiVYY576Zrt1b1JkmpZkAzhKKxwRM6wvlJdP8N
        xZy9k3ImGsdk4u32DdYNWGam4oiQ1LAOgKLyLrPWoX2W9/f2eOjdCqEfXw1AnNuD4Zbkzw
        HLGLgVg5vS9EilS1KxY8yq5F7q9yg7RAyRKQfBJPo7Pl8sLROTyfut/UGpjwR+NCpbn/Rv
        m/QMJC1UtuAbV9S/9fkAnu+sdWEa9w5qXjBEdBo8RNTeKPgurd8leNqZpvZevQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647531240;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A5rA4NpV/C5UbKlXxvEuQEaV4gZ2/9ZhOEdJ4HSELdg=;
        b=CRhGoTFfUe8WMR7RR86vZFiBX8zDCeGV3biSXICN9tLAAzy2/A8ggTmc5VcE6SnKB4mX0a
        H56PjfzBWk1B2JDg==
From:   "irqchip-bot for YueHaibing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irq/qcom-mpm: Fix build error without MAILBOX
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220317131956.30004-1-yuehaibing@huawei.com>
References: <20220317131956.30004-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Message-ID: <164753123915.389.14752318574592261606.tip-bot2@tip-bot2>
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

Commit-ID:     8f887b78961c935a54bb2b5d4dc2c25f869c3723
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/8f887b78961c935a54bb2b5d4dc2c25f869c3723
Author:        YueHaibing <yuehaibing@huawei.com>
AuthorDate:    Thu, 17 Mar 2022 21:19:56 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 17 Mar 2022 15:29:04 

irq/qcom-mpm: Fix build error without MAILBOX

If MAILBOX is n, building fails:

drivers/irqchip/irq-qcom-mpm.o: In function `mpm_pd_power_off':
irq-qcom-mpm.c:(.text+0x174): undefined reference to `mbox_send_message'
irq-qcom-mpm.c:(.text+0x174): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `mbox_send_message'

Make QCOM_MPM depends on MAILBOX to fix this.

Fixes: a6199bb514d8 ("irqchip: Add Qualcomm MPM controller driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220317131956.30004-1-yuehaibing@huawei.com
---
 drivers/irqchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 680d2fc..15edb9a 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -433,6 +433,7 @@ config QCOM_PDC
 config QCOM_MPM
 	tristate "QCOM MPM"
 	depends on ARCH_QCOM
+	depends on MAILBOX
 	select IRQ_DOMAIN_HIERARCHY
 	help
 	  MSM Power Manager driver to manage and configure wakeup
