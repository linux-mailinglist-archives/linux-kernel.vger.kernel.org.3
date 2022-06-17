Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A0C54F858
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382038AbiFQNdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236792AbiFQNdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:33:33 -0400
Received: from m15112.mail.126.com (m15112.mail.126.com [220.181.15.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01F7EB483
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 06:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=7u6qK
        ltsp5jSRpjg0OvbbT6LXIqaBGbVUZXXet7le4E=; b=i2NSrUiWLcHvbVI1dRkFw
        oy11kkjprzeWXsw5lr7qxd9AnvzIt8NIY1Yo8JwqkvpYN++yVqhgQ5rJdKcz/V+e
        W7owMLW5Y1ERhKylMHygsC8cFkO30pcJ3yYlm9ZW/b90kUu2Ebnxjf97eDeBIRtN
        6nyU54yjzmrowf2drNtN64=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp2 (Coremail) with SMTP id DMmowACnrgJZgqxim2kiDg--.21116S2;
        Fri, 17 Jun 2022 21:32:10 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, windhl@126.com
Subject: [PATCH] clocksource: Fix refcount leak bug in time-ti-dm-systimer
Date:   Fri, 17 Jun 2022 21:32:09 +0800
Message-Id: <20220617133209.4049325-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMmowACnrgJZgqxim2kiDg--.21116S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFyxAF1xZw17GFyrKF4fuFg_yoWkWwc_Ww
        s7XF9rJrW3urn7G39rCw13Z39xKrnavr48Z3WIqr9xJ3WxZw15ArnrZrn7ua48uay3tFyD
        C3y7JrW7Zr17GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRtgAwDUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi2hAjF1uwMOVH-gABs4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dmtimer_percpu_quirk_init(), of_find_compatible_node() will return
a node pointer with refcount incremented. We should use of_node_put()
in fail path or when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 drivers/clocksource/timer-ti-dm-systimer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-ti-dm-systimer.c b/drivers/clocksource/timer-ti-dm-systimer.c
index 2737407ff069..f414cb553649 100644
--- a/drivers/clocksource/timer-ti-dm-systimer.c
+++ b/drivers/clocksource/timer-ti-dm-systimer.c
@@ -690,10 +690,11 @@ static int __init dmtimer_percpu_quirk_init(struct device_node *np, u32 pa)
 
 	arm_timer = of_find_compatible_node(NULL, NULL, "arm,armv7-timer");
 	if (of_device_is_available(arm_timer)) {
+		of_node_put(arm_timer);
 		pr_warn_once("ARM architected timer wrap issue i940 detected\n");
 		return 0;
 	}
-
+	of_node_put(arm_timer);
 	if (pa == 0x4882c000)           /* dra7 dmtimer15 */
 		return dmtimer_percpu_timer_init(np, 0);
 	else if (pa == 0x4882e000)      /* dra7 dmtimer16 */
-- 
2.25.1

