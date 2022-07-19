Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7738F579793
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 12:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbiGSKX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 06:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGSKX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 06:23:27 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933941114C;
        Tue, 19 Jul 2022 03:23:26 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPS id C47D140737D5;
        Tue, 19 Jul 2022 10:23:24 +0000 (UTC)
From:   Andrey Strachuk <strochuk@ispras.ru>
To:     Tero Kristo <kristo@kernel.org>
Cc:     Andrey Strachuk <strochuk@ispras.ru>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Colin Ian King <colin.i.king@googlemail.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] clk/ti/adpll: remove useless comparison in ti_adpll_free_resources()
Date:   Tue, 19 Jul 2022 13:23:19 +0300
Message-Id: <20220719102319.5912-1-strochuk@ispras.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Local variable 'ac' is initialized by an address
of field of ti_adpll_data, so it does not make
sense to compare 'ac' with NULL.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Andrey Strachuk <strochuk@ispras.ru>
Fixes: 21330497f303 ("clk: ti: Add support for dm814x ADPLL")
---
 drivers/clk/ti/adpll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ti/adpll.c b/drivers/clk/ti/adpll.c
index 962502ca7ff0..7207915f9440 100644
--- a/drivers/clk/ti/adpll.c
+++ b/drivers/clk/ti/adpll.c
@@ -772,7 +772,7 @@ static void ti_adpll_free_resources(struct ti_adpll_data *d)
 	for (i = TI_ADPLL_M3; i >= 0; i--) {
 		struct ti_adpll_clock *ac = &d->clocks[i];
 
-		if (!ac || IS_ERR_OR_NULL(ac->clk))
+		if (IS_ERR_OR_NULL(ac->clk))
 			continue;
 		if (ac->cl)
 			clkdev_drop(ac->cl);
-- 
2.25.1

