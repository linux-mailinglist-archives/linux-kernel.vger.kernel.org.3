Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2821A4F5BD9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348468AbiDFK7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 06:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236568AbiDFK6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 06:58:31 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 362004F512D;
        Wed,  6 Apr 2022 00:24:26 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.90,239,1643641200"; 
   d="scan'208";a="116907861"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 Apr 2022 16:24:25 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id E4C9241D1F25;
        Wed,  6 Apr 2022 16:24:23 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] clocksource/drivers/renesas-ostm: Add support for RZ/V2L SoC
Date:   Wed,  6 Apr 2022 08:24:17 +0100
Message-Id: <20220406072417.14185-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OSTM block is identical on Renesas RZ/G2L and RZ/V2L SoC's, so instead
of adding dependency for each SoC's add dependency on ARCH_RZG2L. The
ARCH_RZG2L config option is already selected by ARCH_R9A07G044 and
ARCH_R9A07G054.

With the above change OSTM will be enabled on RZ/V2L SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clocksource/renesas-ostm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/renesas-ostm.c b/drivers/clocksource/renesas-ostm.c
index 21d1392637b8..8da972dc1713 100644
--- a/drivers/clocksource/renesas-ostm.c
+++ b/drivers/clocksource/renesas-ostm.c
@@ -224,7 +224,7 @@ static int __init ostm_init(struct device_node *np)
 
 TIMER_OF_DECLARE(ostm, "renesas,ostm", ostm_init);
 
-#ifdef CONFIG_ARCH_R9A07G044
+#ifdef CONFIG_ARCH_RZG2L
 static int __init ostm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-- 
2.17.1

