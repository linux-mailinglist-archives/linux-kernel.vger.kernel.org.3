Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8D45A5A14
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 05:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiH3Dd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 23:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiH3Ddg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 23:33:36 -0400
Received: from m12-17.163.com (m12-17.163.com [220.181.12.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C194F6AA13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 20:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=QP8HW
        uzvK/XpdKlS+HMadL+ojObm+N5qHMzgCFkYqug=; b=fQyuKO2G6niXW3NBOsFUs
        3HfQWjBSNhizPcMFPocsWBNRXKTZ04tJGUJEOaP3ozIURak+JuU47pPyHSm0BmK1
        /bq8nVhWTpBbvunBpGkFupC3on60PNSywBiFJEUylWQnqQspPkPq/0x2S8ouvZ9u
        Gmb86V7wcsRu5XLCtFFlYg=
Received: from DESKTOP-B1R4FVG.localdomain (unknown [218.201.129.20])
        by smtp13 (Coremail) with SMTP id EcCowACHfpHqhA1jauj7YQ--.16609S2;
        Tue, 30 Aug 2022 11:33:01 +0800 (CST)
From:   qianfanguijin@163.com
To:     linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Evgeny Boger <boger@wirenboard.com>,
        Andre Przywara <andre.przywara@arm.com>,
        qianfan Zhao <qianfanguijin@163.com>
Subject: [PATCH] net: allwinner: emac: Fix double spinlock in emac_timeout
Date:   Tue, 30 Aug 2022 11:32:58 +0800
Message-Id: <20220830033258.8105-1-qianfanguijin@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowACHfpHqhA1jauj7YQ--.16609S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCw15tr4xAF48JryfXFW7XFb_yoWrAF43pr
        yjya4rCw4xX3Wqvw4xtrWvqFWjq3Z2y34xCrs7Aw4fuFn3G34rXFy8tFy2kFWYyrZrAay7
        KF1qyrWSkF4kXaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piU73kUUUUU=
X-Originating-IP: [218.201.129.20]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/xtbB2Alt7WBHLzAuEgAAsV
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: qianfan Zhao <qianfanguijin@163.com>

The system will dead due to double lock if sometings trigger
emac_timeout, next is the kernel logs:

WARNING: CPU: 2 PID: 0 at net/sched/sch_generic.c:478
dev_watchdog+0x2e4/0x2e8
NETDEV WATCHDOG: FE0 (sun4i-emac): transmit queue 0 timed out
Modules linked in:
CPU: 2 PID: 0 Comm: swapper/2 Tainted: G W 5.15.0-00047-g0848e4aeb313
Hardware name: Wisdom T3 based CCT Family
[<c010f740>] (unwind_backtrace) from [<c010b744>] (show_stack+0x10/0x14)
[<c010b744>] (show_stack) from [<c0a4d978>] (dump_stack_lvl+0x40/0x4c)
[<c0a4d978>] (dump_stack_lvl) from [<c0120734>] (__warn+0x104/0x108)
[<c0120734>] (__warn) from [<c01207b0>] (warn_slowpath_fmt+0x78/0xbc)
[<c01207b0>] (warn_slowpath_fmt) from [<c0898a54>]
(dev_watchdog+0x2e4/0x2e8)
[<c0898a54>] (dev_watchdog) from [<c019a888>] (call_timer_fn+0x3c/0x178)
[<c019a888>] (call_timer_fn) from [<c019bddc>]
(run_timer_softirq+0x540/0x624)
[<c019bddc>] (run_timer_softirq) from [<c0101298>]
(__do_softirq+0x130/0x3bc)
[<c0101298>] (__do_softirq) from [<c0127ea0>] (irq_exit+0xbc/0x100)
[<c0127ea0>] (irq_exit) from [<c017e514>] (handle_domain_irq+0x60/0x78)
[<c017e514>] (handle_domain_irq) from [<c05a6130>]
(gic_handle_irq+0x7c/0x90)
[<c05a6130>] (gic_handle_irq) from [<c0100afc>] (__irq_svc+0x5c/0x78)
Exception stack(0xc14f3f70 to 0xc14f3fb8)
3f60:                                     0003475c 00000000 00000001
c01188a0
3f80: c107b200 c0f06b4c c0f06b90 00000004 c1079ff8 c0c62774 00000000
00000000
3fa0: c10b2198 c14f3fc0 c0107fcc c0107fd0 60030013 ffffffff
[<c0100afc>] (__irq_svc) from [<c0107fd0>] (arch_cpu_idle+0x38/0x3c)
[<c0107fd0>] (arch_cpu_idle) from [<c0a57f38>]
(default_idle_call+0x3c/0xcc)
[<c0a57f38>] (default_idle_call) from [<c0157258>] (do_idle+0xdc/0x13c)
[<c0157258>] (do_idle) from [<c01575a4>] (cpu_startup_entry+0x18/0x1c)
[<c01575a4>] (cpu_startup_entry) from [<401015d0>] (0x401015d0)
---[ end trace a70942a1265338f1 ]---
rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
rcu: \x092-...0: (1 GPs behind) idle=75d/0/0x1 softirq=8288/8289 fqs=931
\x09(detected by 0, t=2102 jiffies, g=13485, q=1635)
Sending NMI from CPU 0 to CPUs 2:
spi_master spi2: spi2.1: timeout transferring 4 bytes@100000Hz for
110(100)ms
spidev spi2.1: SPI transfer failed: -110

Fix it.

Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
---
 drivers/net/ethernet/allwinner/sun4i-emac.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/allwinner/sun4i-emac.c b/drivers/net/ethernet/allwinner/sun4i-emac.c
index 49759deeed8e..d49c2c18f39d 100644
--- a/drivers/net/ethernet/allwinner/sun4i-emac.c
+++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
@@ -378,14 +378,11 @@ static int emac_set_mac_address(struct net_device *dev, void *p)
 }
 
 /* Initialize emac board */
-static void emac_init_device(struct net_device *dev)
+static void emac_init_device_without_lock(struct net_device *dev)
 {
 	struct emac_board_info *db = netdev_priv(dev);
-	unsigned long flags;
 	unsigned int reg_val;
 
-	spin_lock_irqsave(&db->lock, flags);
-
 	emac_update_speed(dev);
 	emac_update_duplex(dev);
 
@@ -398,7 +395,15 @@ static void emac_init_device(struct net_device *dev)
 	reg_val = readl(db->membase + EMAC_INT_CTL_REG);
 	reg_val |= (0xf << 0) | (0x01 << 8);
 	writel(reg_val, db->membase + EMAC_INT_CTL_REG);
+}
+
+static void emac_init_device(struct net_device *dev)
+{
+	struct emac_board_info *db = netdev_priv(dev);
+	unsigned long flags;
 
+	spin_lock_irqsave(&db->lock, flags);
+	emac_init_device_without_lock(dev);
 	spin_unlock_irqrestore(&db->lock, flags);
 }
 
@@ -416,7 +421,7 @@ static void emac_timeout(struct net_device *dev, unsigned int txqueue)
 
 	netif_stop_queue(dev);
 	emac_reset(db);
-	emac_init_device(dev);
+	emac_init_device_without_lock(dev);
 	/* We can accept TX packets again */
 	netif_trans_update(dev);
 	netif_wake_queue(dev);
-- 
2.25.1

