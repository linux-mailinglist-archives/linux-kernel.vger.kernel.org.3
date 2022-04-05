Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BA74F5011
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1452746AbiDFBJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457390AbiDEQDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:03:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653585FD2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:40:04 -0700 (PDT)
Date:   Tue, 05 Apr 2022 15:40:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649173203;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/bDtmQYgBvJGgUnqDZdoylzTygcxGVQDC5VhemXrey8=;
        b=lHdM+kZ9Ue0f9rsKoPhHy/toqky3/GBj7xPzCcUTrSSp+Dgsn9Q73ZoZPZmkJKNZAO906G
        BmsDFd+Y7uCWZ8rync15CwDna7MWPzYjLF3h3Nc/uu5+tPaDfcXeyyTsFrACs89jXUZflW
        hXft24QR5bXF/CwU/jtFpDix2QLPtn7zB4+jKAdIPvsLp7z/RdRen969a+a6LniafxBL54
        TsEyEsN7/JdVwGJfBAiABGCHLf/ju/C4mh8TtvYvTLYSCwxS47vB0VNteitRd9QzgAZyUi
        jGdiktJAEdT0JVgPCvFZwD7bAEU0STUFBzvvc4XvOpmdnJXzBqD64D2GG9FW9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649173203;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/bDtmQYgBvJGgUnqDZdoylzTygcxGVQDC5VhemXrey8=;
        b=f5o6m9L1HSYlncLfXFk1Eo8ER7GlgBObZEWKl06LJKtwcfFiV/L364wIXDzwzj1mHY6kT8
        dg9VH6e7wockenBA==
From:   "irqchip-bot for YueHaibing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irq/qcom-mpm: Fix build error without MAILBOX
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220317131956.30004-1-yuehaibing@huawei.com>
References: <20220317131956.30004-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Message-ID: <164917320203.389.10470324625310778188.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     fa4dcc880390fbedf4118e9f88a6b13363e0a7a1
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/fa4dcc880390fbedf4118e9f88a6b13363e0a7a1
Author:        YueHaibing <yuehaibing@huawei.com>
AuthorDate:    Thu, 17 Mar 2022 21:19:56 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 05 Apr 2022 16:33:13 +01:00

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
