Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1766C49FE1F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350095AbiA1Qf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:35:58 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37996 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350067AbiA1Qf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:35:57 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id C990F1F46300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643387755;
        bh=S4Z9IVyEDWl5NFUhRrfhKWpv39Y/h9ZoEjs/1KHozrI=;
        h=From:To:Cc:Subject:Date:From;
        b=akyfuuwp7yF5ZmP+FMZrRp8amwzILjjcWdkGPxvtVaKcXNQkFn0p9W9xtg+JcOLLy
         nYpd6Pv7Il5ewKvnsxEY4jdo/CxchOZ0RGtSL0DKSKHneAwyKdqGIHybQAMk+9qK4K
         bptyaGaQcGhB3j2/eD5Upv7o8HJA40ik7zd3fAe164EhYcwqdsi6qRrLUel9+i69uR
         M7KF17DfyAIVAgNGpBIEcv/PO2MFpiFso+ttLqXrUOEUwHGle4tjBp4CQhzbIOb+oL
         mATjdnOtTn0riKxVWnZOwggBqifwk1APp+Eh3nJ/vMgkqj/uaU81QOqU9fqDoesFZD
         VUOaizw9THSXA==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, kernel-janitors@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: visconti: Remove dead code
Date:   Fri, 28 Jan 2022 21:35:27 +0500
Message-Id: <20220128163527.1587325-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rs_id is of unsigned type, u8. The condition rs_id >= 0 will always be
true. Remove the if-else condition and the dead code.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 drivers/clk/visconti/clkc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/visconti/clkc.c b/drivers/clk/visconti/clkc.c
index 56a8a4ffebca8..5ccf771d05985 100644
--- a/drivers/clk/visconti/clkc.c
+++ b/drivers/clk/visconti/clkc.c
@@ -147,13 +147,9 @@ int visconti_clk_register_gates(struct visconti_clk_provider *ctx,
 		if (!dev_name)
 			return -ENOMEM;
 
-		if (clks[i].rs_id >= 0) {
-			rson_offset = reset[clks[i].rs_id].rson_offset;
-			rsoff_offset = reset[clks[i].rs_id].rsoff_offset;
-			rs_idx = reset[clks[i].rs_id].rs_idx;
-		} else {
-			rson_offset = rsoff_offset = rs_idx = -1;
-		}
+		rson_offset = reset[clks[i].rs_id].rson_offset;
+		rsoff_offset = reset[clks[i].rs_id].rsoff_offset;
+		rs_idx = reset[clks[i].rs_id].rs_idx;
 
 		div_clk = devm_clk_hw_register_fixed_factor(dev,
 							    dev_name,
-- 
2.30.2

