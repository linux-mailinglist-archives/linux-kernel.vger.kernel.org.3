Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F17F4C8BB4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 13:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbiCAMe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 07:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbiCAMem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 07:34:42 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6ECA97BB7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 04:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646138040; x=1677674040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YvuB2Ay0dLnc800oXNRcutbEZNg7vLBu/3a/pjG1aOE=;
  b=izTfY8YgQUGuzaw636wp/15i7p/ByI4S1ca1YF5Vxib+4DoN91YVRott
   baF10rvuwkI17htv4v9Dl587QqO31Rr5Lieb2HJ29eSNGTdM5TXvOG+jK
   fljMcvebFc7bp9rR3ZQNLgCDIMwgSycPAkmqQtcYb+fl40jqVqfh4MfNT
   cEVLLpfvpsN95Il1v6CpelBgtrbqaun8USibUpt0VM8tSGaHG8h10kYjA
   Pb4FCKaUdXT8C4hRELIcPzUeRIuut5oolgMggem9ay4yEexgzErKlkSDF
   7waUj4n/k3iq0trhfU5XqRCS7w4h99BTwODA5u3+tgEoOO6PhMgSKdWfi
   g==;
X-IronPort-AV: E=Sophos;i="5.90,146,1643698800"; 
   d="scan'208";a="155253494"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Mar 2022 05:34:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 1 Mar 2022 05:33:59 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 1 Mar 2022 05:33:58 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 7/7] clocksource/drivers/timer-microchip-pit64b: fix compilation warnings
Date:   Tue, 1 Mar 2022 14:34:49 +0200
Message-ID: <20220301123449.2816625-8-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220301123449.2816625-1-claudiu.beznea@microchip.com>
References: <20220301123449.2816625-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following compilation warnings:
timer-microchip-pit64b.c:68: warning: cannot understand function prototype: 'struct mchp_pit64b_clkevt '
timer-microchip-pit64b.c:82: warning: cannot understand function prototype: 'struct mchp_pit64b_clksrc '
timer-microchip-pit64b.c:283: warning: Function parameter or member 'timer' not described in 'mchp_pit64b_init_mode'
timer-microchip-pit64b.c:283: warning: Function parameter or member 'max_rate' not described in 'mchp_pit64b_init_mode'

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clocksource/timer-microchip-pit64b.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-microchip-pit64b.c b/drivers/clocksource/timer-microchip-pit64b.c
index f50705698283..5ce206723700 100644
--- a/drivers/clocksource/timer-microchip-pit64b.c
+++ b/drivers/clocksource/timer-microchip-pit64b.c
@@ -46,7 +46,7 @@
 
 #define MCHP_PIT64B_NAME		"pit64b"
 
-/**
+/*
  * struct mchp_pit64b_timer - PIT64B timer data structure
  * @base: base address of PIT64B hardware block
  * @pclk: PIT64B's peripheral clock
@@ -60,7 +60,7 @@ struct mchp_pit64b_timer {
 	u32		mode;
 };
 
-/**
+/*
  * mchp_pit64b_clkevt - PIT64B clockevent data structure
  * @timer: PIT64B timer
  * @clkevt: clockevent
@@ -74,7 +74,7 @@ struct mchp_pit64b_clkevt {
 	((struct mchp_pit64b_timer *)container_of(x,\
 		struct mchp_pit64b_clkevt, clkevt))
 
-/**
+/*
  * mchp_pit64b_clksrc - PIT64B clocksource data structure
  * @timer: PIT64B timer
  * @clksrc: clocksource
@@ -244,7 +244,7 @@ static void __init mchp_pit64b_pres_compute(u32 *pres, u32 clk_rate,
 		*pres = MCHP_PIT64B_PRES_MAX - 1;
 }
 
-/**
+/*
  * mchp_pit64b_init_mode - prepare PIT64B mode register value to be used at
  *			   runtime; this includes prescaler and SGCLK bit
  *
-- 
2.32.0

