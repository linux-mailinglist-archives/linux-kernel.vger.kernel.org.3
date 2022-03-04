Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205284CD53E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 14:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238833AbiCDNfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 08:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236713AbiCDNfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 08:35:45 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646131B762C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 05:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646400897; x=1677936897;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3OTySUvfj9YLZ+NLvxOpjOu3QfEnAa4NzFTMBjne5gU=;
  b=zSqzA8CY3L/eaXjGGcClWLiUgwNlRkzksNmxa2nWKh/UqjlROQonIpjm
   tPX4W3SaVKkk0WoZ+qIF7YvGo/Os2o0OQOGporbMmSf9GJZ/YBBhwdldj
   w/exZSTAwomeO9NtDp2vfdIssm8nIl4qM2Zg4t+/dZX4WUkdQ9x8WDfQU
   M/O8DB8MMDtViuuRHEFFtk4JzlzqbL6sOQE8qimyYSDpfhT4SXJihJJa+
   T7cwPMS783faC5zB7lvyCYd4V5HUvQbgDoGqidHb50QEu8VhbOptpMY6P
   TqydkPrhC8EYNk7HoVI0Bq72TtYFce/w/A1JTftm5sYRoMINBBi8bAHQb
   g==;
X-IronPort-AV: E=Sophos;i="5.90,155,1643698800"; 
   d="scan'208";a="148098681"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 06:34:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 06:34:56 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 4 Mar 2022 06:34:55 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 2/6] clocksource/drivers/timer-microchip-pit64b: use notrace
Date:   Fri, 4 Mar 2022 15:35:57 +0200
Message-ID: <20220304133601.2404086-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220304133601.2404086-1-claudiu.beznea@microchip.com>
References: <20220304133601.2404086-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,TVD_SPACE_RATIO,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use notrace for mchp_pit64b_sched_read_clk() to avoid recursive call of
prepare_ftrace_return() when issuing:
echo function_graph > /sys/kernel/debug/tracing/current_tracer

Fixes: 625022a5f160 ("clocksource/drivers/timer-microchip-pit64b: Add Microchip PIT64B support")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clocksource/timer-microchip-pit64b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-microchip-pit64b.c b/drivers/clocksource/timer-microchip-pit64b.c
index cfa4ec7ef396..790d2c9b42a7 100644
--- a/drivers/clocksource/timer-microchip-pit64b.c
+++ b/drivers/clocksource/timer-microchip-pit64b.c
@@ -165,7 +165,7 @@ static u64 mchp_pit64b_clksrc_read(struct clocksource *cs)
 	return mchp_pit64b_cnt_read(mchp_pit64b_cs_base);
 }
 
-static u64 mchp_pit64b_sched_read_clk(void)
+static u64 notrace mchp_pit64b_sched_read_clk(void)
 {
 	return mchp_pit64b_cnt_read(mchp_pit64b_cs_base);
 }
-- 
2.32.0

