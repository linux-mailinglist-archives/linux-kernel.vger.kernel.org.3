Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0AE570758
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbiGKPoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiGKPox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:44:53 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F4912AC5C;
        Mon, 11 Jul 2022 08:44:49 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id BDE5216AC;
        Mon, 11 Jul 2022 18:46:39 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com BDE5216AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1657554399;
        bh=BveNLPY/YG4fFAd5N/AaPUO76c/YnxfM372ERsi7TmM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=RlIlhDFfXWOkpu1kI//ka6ng9WG2tyf9gWii03fuBSB/GJPxq0sNls2Z5z6PZNneQ
         PjD+BvqUgZoBn8Pq0riIhtRPZlJY+2JBA+4SoTdfNk2tAop3cfhDEUFJWeQYyLhFL1
         Qn4dCzKYzMCj03VBvdn/8BwGjF6TOX89rpqQL3Rk=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 11 Jul 2022 18:44:46 +0300
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
Subject: [PATCH v7 1/7] clk: vc5: Fix 5P49V6901 outputs disabling when enabling FOD
Date:   Mon, 11 Jul 2022 18:44:27 +0300
Message-ID: <20220711154433.15415-2-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220711154433.15415-1-Sergey.Semin@baikalelectronics.ru>
References: <20220711154433.15415-1-Sergey.Semin@baikalelectronics.ru>
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

We have discovered random glitches during the system boot up procedure.
The problem investigation led us to the weird outcomes: when none of the
Renesas 5P49V6901 ports are explicitly enabled by the kernel driver, the
glitches disappeared. It was a mystery since the SoC external clock
domains were fed with different 5P49V6901 outputs. The driver code didn't
seem like bogus either. We almost despaired to find out a root cause when
the solution has been found for a more modern revision of the chip. It
turned out the 5P49V6901 clock generator stopped its output for a short
period of time during the VC5_OUT_DIV_CONTROL register writing. The same
problem was found for the 5P49V6965 revision of the chip and was
successfully fixed in commit fc336ae622df ("clk: vc5: fix output disabling
when enabling a FOD") by enabling the "bypass_sync" flag hidden inside
"Unused Factory Reserved Register". Even though the 5P49V6901 registers
description and programming guide doesn't provide any intel regarding that
flag, setting it up anyway in the officially unused register completely
eliminated the denoted glitches. Thus let's activate the functionality
submitted in commit fc336ae622df ("clk: vc5: fix output disabling when
enabling a FOD") for the Renesas 5P49V6901 chip too in order to remove the
ports implicit inter-dependency.

Fixes: dbf6b16f5683 ("clk: vc5: Add support for IDT VersaClock 5P49V6901")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Luca Ceresoli <luca@lucaceresoli.net>

---

Changelog v4:
- This is a new patch added on v4 lap of the series.

Changelog v5:
- Fix some grammar mistakes in the commit log. (@Sergey Shtylyov)
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

