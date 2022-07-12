Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DD55719A4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbiGLMPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbiGLMPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:15:15 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A66764D158;
        Tue, 12 Jul 2022 05:15:11 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id F245ABC7;
        Tue, 12 Jul 2022 15:17:02 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com F245ABC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1657628222;
        bh=Xn98MR7V1F/LIQ3Yu3hI7bvvVoawgSacfNBPSyIHRWs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=fgTFw1Cgfah7QswYLsPBh/Z4ZMUW+U/7FsccVPX3LQahvnIETJMuKWX4aV81Luuu4
         Vd9IPz/ZRPWfOLm0Y01G64ZxoaROyUA0dhFzGNXjT+rT4g4kaXmTCujuODGyDWgnEE
         oeUEsm/A8U/jtthsbHAShA/jqAvdrcy3kNVamo94=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 12 Jul 2022 15:15:08 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        <linux-clk@vger.kernel.org>, <linux-mips@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 2/7] clk: baikal-t1: Fix invalid xGMAC PTP clock divider
Date:   Tue, 12 Jul 2022 15:15:00 +0300
Message-ID: <20220712121505.5671-3-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220712121505.5671-1-Sergey.Semin@baikalelectronics.ru>
References: <20220712121505.5671-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most likely due to copy-paste mistake the divider has been set to 10 while
according to the SoC reference manual it's supposed to be 8 thus having
PTP clock frequency of 156.25 MHz.

Fixes: 353afa3a8d2e ("clk: Add Baikal-T1 CCU Dividers driver")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/clk/baikal-t1/clk-ccu-div.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/baikal-t1/clk-ccu-div.c b/drivers/clk/baikal-t1/clk-ccu-div.c
index f141fda12b09..ea77eec40ddd 100644
--- a/drivers/clk/baikal-t1/clk-ccu-div.c
+++ b/drivers/clk/baikal-t1/clk-ccu-div.c
@@ -207,7 +207,7 @@ static const struct ccu_div_info sys_info[] = {
 	CCU_DIV_GATE_INFO(CCU_SYS_XGMAC_REF_CLK, "sys_xgmac_ref_clk",
 			  "eth_clk", CCU_SYS_XGMAC_BASE, 8),
 	CCU_DIV_FIXED_INFO(CCU_SYS_XGMAC_PTP_CLK, "sys_xgmac_ptp_clk",
-			   "eth_clk", 10),
+			   "eth_clk", 8),
 	CCU_DIV_GATE_INFO(CCU_SYS_USB_CLK, "sys_usb_clk",
 			  "eth_clk", CCU_SYS_USB_BASE, 10),
 	CCU_DIV_VAR_INFO(CCU_SYS_PVT_CLK, "sys_pvt_clk",
-- 
2.35.1

