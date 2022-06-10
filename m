Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B478545D2A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 09:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346673AbiFJHWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 03:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243513AbiFJHVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:21:43 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A0C838D200
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 00:21:36 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 9D1BCBD3;
        Fri, 10 Jun 2022 10:22:24 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 9D1BCBD3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654845745;
        bh=/ATpPn5tsZ4m5LXVjUB+s2xJExFcZUwfGGYs9UuBRm0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=rED/PiOtEGQlT6B72rH4m9mv6LGMvLGiQSaD9co31gQi+glvLXrXBaXaXP25QzUVA
         G7pu13gfID8vrbqTeaacGQhBDKcju+YxwwWx1gcFaT2Gyzdc3SuQIwNdap2xiUTsry
         GZ9XqLzxjNgr1JXIzKaqaQtXmceyPUpPDnqMwASs=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 10:21:32 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Marek Vasut <marek.vasut@gmail.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        <linux-clk@vger.kernel.org>, <linux-mips@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH v4 2/8] clk: vc5: Fix 5P49V6901 outputs disabling when enabling FOD
Date:   Fri, 10 Jun 2022 10:21:18 +0300
Message-ID: <20220610072124.8714-3-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220610072124.8714-1-Sergey.Semin@baikalelectronics.ru>
References: <20220610072124.8714-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have discovered random glitches during the system boot up procedure.
The problem investigation led us to the weird outcomes: when none of the
Renesas 5P49V6901 ports are explicitly enabled by the kernel driver, the
glitches disappeared. It was a mystery since the SoC external clock
domains were fed with different 5P49V6901 outputs. The driver code didn't
seem like bogus either. We almost despaired to find out a root cause when
the solution was found for a more modern revision of the chip. It turned
out the 5P49V6901 clock generator stopped its output for a short period of
time during the VC5_OUT_DIV_CONTROL register writing. The same problem has
was found for the 5P49V6965 revision of the chip and the was successfully
fixed in commit fc336ae622df ("clk: vc5: fix output disabling when
enabling a FOD") by enabling the "bypass_sync" flag hidden inside "Unused
Factory Reserved Register". Even though the 5P49V6901 registers
description and programming guide doesn't provide any intel regarding that
flag, setting it up anyway in the officially unused register completely
eliminated the denoted glitches. Thus let's activate the functionality
submitted in commit fc336ae622df ("clk: vc5: fix output disabling when
enabling a FOD") for the Renesas 5P49V6901 chip too in order to remove
the ports implicit inter-dependency.

Fixes: dbf6b16f5683 ("clk: vc5: Add support for IDT VersaClock 5P49V6901")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v4:
- This is a new patch added on v4 lap of the series.
---
 drivers/clk/clk-versaclock5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
index e7be3e54b9be..03cfef494b49 100644
--- a/drivers/clk/clk-versaclock5.c
+++ b/drivers/clk/clk-versaclock5.c
@@ -1204,7 +1204,7 @@ static const struct vc5_chip_info idt_5p49v6901_info = {
 	.model = IDT_VC6_5P49V6901,
 	.clk_fod_cnt = 4,
 	.clk_out_cnt = 5,
-	.flags = VC5_HAS_PFD_FREQ_DBL,
+	.flags = VC5_HAS_PFD_FREQ_DBL | VC5_HAS_BYPASS_SYNC_BIT,
 };
 
 static const struct vc5_chip_info idt_5p49v6965_info = {
-- 
2.35.1

