Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33DB4C3E97
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 07:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237933AbiBYGs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 01:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237027AbiBYGs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 01:48:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2213718C794;
        Thu, 24 Feb 2022 22:48:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD646B82B2D;
        Fri, 25 Feb 2022 06:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6ADAC340E7;
        Fri, 25 Feb 2022 06:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645771703;
        bh=4K1giYj+12R2Kkj5i0ab94fJZmq/YtPl2GIZQ2+Qasg=;
        h=From:To:Cc:Subject:Date:From;
        b=aUK0CzG7NxKCUcI/2x7fYYZvO53D/IAyGrnExUV/vj9O1nVxs04eGkTlmANqnTENI
         I5FQgVCJn0yUENmgtdAqRKKudHSx2LCXtLyFzpVrFN3lzUpEza5oP372D8ZjUoHaLf
         yuJ5oraug0bm8f4Fz8xHNSQNOAILKECLQLUouYgf/i6VaZcxkKOwA2AZtVpMFvCsen
         LEB1Vz9uO5eIZNmmeNXxrbKLJU2DicwbmiBczjHmq+qGmJ/+VZNg964szy3qZM/AQf
         y80v3+mD0WIuW4e8/GmDcptAcbmx+ctknTHUHCNXKhCofq2pKQhdU5ui04OfG7km/p
         mHOl1FtcbHhwQ==
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Strudel <tstrudel@google.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] PM: domains: Fix sleep-in-atomic bug caused by genpd_debug_remove()
Date:   Fri, 25 Feb 2022 14:48:15 +0800
Message-Id: <20220225064815.444571-1-shawnguo@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shawn Guo <shawn.guo@linaro.org>

When a genpd with GENPD_FLAG_IRQ_SAFE gets removed, the following
sleep-in-atomic bug will be seen, as genpd_debug_remove() will be called
with a spinlock being held.

[    0.029183] BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1460
[    0.029204] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 1, name: swapper/0
[    0.029219] preempt_count: 1, expected: 0
[    0.029230] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.17.0-rc4+ #489
[    0.029245] Hardware name: Thundercomm TurboX CM2290 (DT)
[    0.029256] Call trace:
[    0.029265]  dump_backtrace.part.0+0xbc/0xd0
[    0.029285]  show_stack+0x3c/0xa0
[    0.029298]  dump_stack_lvl+0x7c/0xa0
[    0.029311]  dump_stack+0x18/0x34
[    0.029323]  __might_resched+0x10c/0x13c
[    0.029338]  __might_sleep+0x4c/0x80
[    0.029351]  down_read+0x24/0xd0
[    0.029363]  lookup_one_len_unlocked+0x9c/0xcc
[    0.029379]  lookup_positive_unlocked+0x10/0x50
[    0.029392]  debugfs_lookup+0x68/0xac
[    0.029406]  genpd_remove.part.0+0x12c/0x1b4
[    0.029419]  of_genpd_remove_last+0xa8/0xd4
[    0.029434]  psci_cpuidle_domain_probe+0x174/0x53c
[    0.029449]  platform_probe+0x68/0xe0
[    0.029462]  really_probe+0x190/0x430
[    0.029473]  __driver_probe_device+0x90/0x18c
[    0.029485]  driver_probe_device+0x40/0xe0
[    0.029497]  __driver_attach+0xf4/0x1d0
[    0.029508]  bus_for_each_dev+0x70/0xd0
[    0.029523]  driver_attach+0x24/0x30
[    0.029534]  bus_add_driver+0x164/0x22c
[    0.029545]  driver_register+0x78/0x130
[    0.029556]  __platform_driver_register+0x28/0x34
[    0.029569]  psci_idle_init_domains+0x1c/0x28
[    0.029583]  do_one_initcall+0x50/0x1b0
[    0.029595]  kernel_init_freeable+0x214/0x280
[    0.029609]  kernel_init+0x2c/0x13c
[    0.029622]  ret_from_fork+0x10/0x20

It doesn't seem necessary to call genpd_debug_remove() with the lock, so
move it out from locking to fix the problem.

Fixes: 718072ceb211 ("PM: domains: create debugfs nodes when adding power domains")
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/base/power/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 5db704f02e71..7e8039d1884c 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2058,9 +2058,9 @@ static int genpd_remove(struct generic_pm_domain *genpd)
 		kfree(link);
 	}
 
-	genpd_debug_remove(genpd);
 	list_del(&genpd->gpd_list_node);
 	genpd_unlock(genpd);
+	genpd_debug_remove(genpd);
 	cancel_work_sync(&genpd->power_off_work);
 	if (genpd_is_cpu_domain(genpd))
 		free_cpumask_var(genpd->cpus);
-- 
2.25.1

