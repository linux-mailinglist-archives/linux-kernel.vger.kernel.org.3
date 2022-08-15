Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5903592F9E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242894AbiHONQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiHONQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:16:50 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98BEA6301;
        Mon, 15 Aug 2022 06:16:49 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 2CD7E80FB;
        Mon, 15 Aug 2022 13:09:57 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel test robot <lkp@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 1/1] clocksource/drivers/timer-ti-dm: Fix compile test warning
Date:   Mon, 15 Aug 2022 16:16:41 +0300
Message-Id: <20220815131642.35116-1-tony@atomide.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can get a warning with COMPILE_TEST enabled for omap_timer_match
for 'omap_timer_match' defined but not used.

Fixes: ab0bbef3ae0f ("clocksource/drivers/timer-ti-dm: Make timer selectable for ARCH_K3")
Reported-by: kernel test robot <lkp@intel.com>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Tony Lindgren <tony@atomide.com>

---

Changes since v1:

- Remove of_match_ptr() instead of adding __maybe_unused as suggested by Arnd

---
 drivers/clocksource/timer-ti-dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -1081,7 +1081,7 @@ static struct platform_driver omap_dm_timer_driver = {
 	.remove = omap_dm_timer_remove,
 	.driver = {
 		.name   = "omap_timer",
-		.of_match_table = of_match_ptr(omap_timer_match),
+		.of_match_table = omap_timer_match,
 		.pm = &omap_dm_timer_pm_ops,
 	},
 };
-- 
2.37.1
