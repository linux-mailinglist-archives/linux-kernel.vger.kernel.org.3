Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEB2463FD5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 22:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343981AbhK3VYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 16:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343991AbhK3VYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 16:24:18 -0500
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [IPv6:2001:4b7a:2000:18::165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1340C061746
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 13:20:57 -0800 (PST)
Received: from localhost.localdomain (adsl-d210.84-47-0.t-com.sk [84.47.0.210])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 571FA1FA69;
        Tue, 30 Nov 2021 22:20:54 +0100 (CET)
From:   Martin Botka <martin.botka@somainline.org>
To:     martin.botka1@gmail.com
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        konrad.dybcio@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        paul.bouchara@somainline.org,
        Martin Botka <martin.botka@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: qcom: sm6125-gcc: Swap ops of ice and apps on sdcc1
Date:   Tue, 30 Nov 2021 22:20:15 +0100
Message-Id: <20211130212015.25232-1-martin.botka@somainline.org>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this change eMMC runs at overclocked freq.
Swap the ops to not OC the eMMC.

Signed-off-by: Martin Botka <martin.botka@somainline.org>
---
 drivers/clk/qcom/gcc-sm6125.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm6125.c b/drivers/clk/qcom/gcc-sm6125.c
index 543cfab7561f..431b55bb0d2f 100644
--- a/drivers/clk/qcom/gcc-sm6125.c
+++ b/drivers/clk/qcom/gcc-sm6125.c
@@ -1121,7 +1121,7 @@ static struct clk_rcg2 gcc_sdcc1_apps_clk_src = {
 		.name = "gcc_sdcc1_apps_clk_src",
 		.parent_data = gcc_parent_data_1,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_rcg2_floor_ops,
 	},
 };
 
@@ -1143,7 +1143,7 @@ static struct clk_rcg2 gcc_sdcc1_ice_core_clk_src = {
 		.name = "gcc_sdcc1_ice_core_clk_src",
 		.parent_data = gcc_parent_data_0,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-		.ops = &clk_rcg2_floor_ops,
+		.ops = &clk_rcg2_ops,
 	},
 };
 
-- 
2.34.0

