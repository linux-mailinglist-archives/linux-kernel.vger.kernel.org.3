Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19FB3491345
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244272AbiARBCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiARBCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:02:00 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3261C061574;
        Mon, 17 Jan 2022 17:01:59 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id b13so72861440edn.0;
        Mon, 17 Jan 2022 17:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=X3rbRq5KfKbeBC7Dkw4uo5NOk4Ukps/dmiHuiNy8NQc=;
        b=Sz/r6tel48hi+gCzCaVmU6ApnbpTRvGnhkCT3ijgn9gjmAj9dLy3C5/KvbN4/ImVlj
         oU4w/JYu7HgFQh6Jjy58QNX537t/7p7mvHF6oTyTHmaLiemuZYlJ/gYrXR7o4q4ShRrl
         1rTxch2FKD1ahFrPNQszh5fMr/6jEHbmRAuJzbv1svQcLVmbYXAzEOp6gGIWX8+PQg+j
         J75U5KP9qculY8DLdCTYnKZRppSrdBEfs2e0iN3a+rky5+JKxE+Yz3EQLFjKEJpRx801
         6EJ1+GNrCgiDLiq5Js61SiXk4YERnRhEzVNbBn7GXXgXV8mcqFLsSvRgVc+KR3g5JsCO
         4i/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X3rbRq5KfKbeBC7Dkw4uo5NOk4Ukps/dmiHuiNy8NQc=;
        b=6H/VCnSQuSZnTqqx1DICpaq0qkTG5tVlJzrd8Oy+1xZckoYjxE6XCkWusqpcg6M56W
         bUlCd2IecAVciB6hBO9Lq9kuz8aTJgkHumLRMAOwF67hE6LhCO3HbMrelaauFzCu7dhE
         DFW509Cnas9+B0P6v0cThL37MFy2KoSFjv6rP58t1s2RIO00msOnl+gVIVJbYHT4spoq
         vjmQmBskCsE84fwOIZcmo6sz8AasoDRBNCD6W9cmChlK7A9nP/2WhMQ2mWV61avcMuWu
         w3uf3w90soDisr1+0z83DIBv/HbTUyNWJkEU1JIuKAtdJQdQqMmM55S5C0f9Phu6zsQf
         OYXA==
X-Gm-Message-State: AOAM532dP1vPxEqnvcoblcS5LFPGdnVJ0fvaFl4z58EtSb1upQqvy6Jp
        7zgsiAk0K74SWiXqOXDwYLc=
X-Google-Smtp-Source: ABdhPJyAzXaFCJe40ztl7YCSxcfx3Fc8bwM/Ywi+aUpQDYUrDNaNxz7GVz+hdQQ4O21xOC/AI1W5rA==
X-Received: by 2002:a17:906:e43:: with SMTP id q3mr12859971eji.92.1642467718082;
        Mon, 17 Jan 2022 17:01:58 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id 24sm4892127ejg.47.2022.01.17.17.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:01:57 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/14] drivers: clk: qcom: gcc-ipq806x: use parent_hws where possible
Date:   Tue, 18 Jan 2022 01:44:26 +0100
Message-Id: <20220118004434.17095-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220118004434.17095-1-ansuelsmth@gmail.com>
References: <20220118004434.17095-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use parent_hws instead of generic parent_data when parents all the
parent are defined in the ipq806x gcc driver.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 156 ++++++++++++++++-----------------
 1 file changed, 78 insertions(+), 78 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index 383494280e3e..ce5654d3e937 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -48,8 +48,8 @@ static struct clk_regmap pll0_vote = {
 	.enable_mask = BIT(0),
 	.hw.init = &(struct clk_init_data){
 		.name = "pll0_vote",
-		.parent_data = &(const struct clk_parent_data){
-			.hw = &pll0.clkr.hw,
+		.parent_hws = (const struct clk_hw*[]){
+			&pll0.clkr.hw,
 		},
 		.num_parents = 1,
 		.ops = &clk_pll_vote_ops,
@@ -108,8 +108,8 @@ static struct clk_regmap pll8_vote = {
 	.enable_mask = BIT(8),
 	.hw.init = &(struct clk_init_data){
 		.name = "pll8_vote",
-		.parent_data = &(const struct clk_parent_data){
-			.hw = &pll8.clkr.hw,
+		.parent_hws = (const struct clk_hw*[]){
+			&pll8.clkr.hw,
 		},
 		.num_parents = 1,
 		.ops = &clk_pll_vote_ops,
@@ -223,8 +223,8 @@ static struct clk_regmap pll14_vote = {
 	.enable_mask = BIT(14),
 	.hw.init = &(struct clk_init_data){
 		.name = "pll14_vote",
-		.parent_data = &(const struct clk_parent_data){
-			.hw = &pll14.clkr.hw,
+		.parent_hws = (const struct clk_hw*[]){
+			&pll14.clkr.hw,
 		},
 		.num_parents = 1,
 		.ops = &clk_pll_vote_ops,
@@ -400,8 +400,8 @@ static struct clk_branch gsbi1_uart_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi1_uart_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &gsbi1_uart_src.clkr.hw,
+			.parent_hws = (const struct clk_hw*[]){
+				&gsbi1_uart_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -451,8 +451,8 @@ static struct clk_branch gsbi2_uart_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi2_uart_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &gsbi2_uart_src.clkr.hw,
+			.parent_hws = (const struct clk_hw*[]){
+				&gsbi2_uart_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -502,8 +502,8 @@ static struct clk_branch gsbi4_uart_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi4_uart_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &gsbi4_uart_src.clkr.hw,
+			.parent_hws = (const struct clk_hw*[]){
+				&gsbi4_uart_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -553,8 +553,8 @@ static struct clk_branch gsbi5_uart_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi5_uart_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &gsbi5_uart_src.clkr.hw,
+			.parent_hws = (const struct clk_hw*[]){
+				&gsbi5_uart_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -604,8 +604,8 @@ static struct clk_branch gsbi6_uart_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi6_uart_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &gsbi6_uart_src.clkr.hw,
+			.parent_hws = (const struct clk_hw*[]){
+				&gsbi6_uart_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -655,8 +655,8 @@ static struct clk_branch gsbi7_uart_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi7_uart_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &gsbi7_uart_src.clkr.hw,
+			.parent_hws = (const struct clk_hw*[]){
+				&gsbi7_uart_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -719,8 +719,8 @@ static struct clk_branch gsbi1_qup_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi1_qup_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &gsbi1_qup_src.clkr.hw,
+			.parent_hws = (const struct clk_hw*[]){
+				&gsbi1_qup_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -770,8 +770,8 @@ static struct clk_branch gsbi2_qup_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi2_qup_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &gsbi2_qup_src.clkr.hw,
+			.parent_hws = (const struct clk_hw*[]){
+				&gsbi2_qup_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -821,8 +821,8 @@ static struct clk_branch gsbi4_qup_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi4_qup_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &gsbi4_qup_src.clkr.hw,
+			.parent_hws = (const struct clk_hw*[]){
+				&gsbi4_qup_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -872,8 +872,8 @@ static struct clk_branch gsbi5_qup_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi5_qup_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &gsbi5_qup_src.clkr.hw,
+			.parent_hws = (const struct clk_hw*[]){
+				&gsbi5_qup_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -923,8 +923,8 @@ static struct clk_branch gsbi6_qup_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi6_qup_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &gsbi6_qup_src.clkr.hw,
+			.parent_hws = (const struct clk_hw*[]){
+				&gsbi6_qup_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -974,8 +974,8 @@ static struct clk_branch gsbi7_qup_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi7_qup_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &gsbi7_qup_src.clkr.hw,
+			.parent_hws = (const struct clk_hw*[]){
+				&gsbi7_qup_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -1126,8 +1126,8 @@ static struct clk_branch gp0_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "gp0_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &gp0_src.clkr.hw,
+			.parent_hws = (const struct clk_hw*[]){
+				&gp0_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -1177,8 +1177,8 @@ static struct clk_branch gp1_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "gp1_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &gp1_src.clkr.hw,
+			.parent_hws = (const struct clk_hw*[]){
+				&gp1_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -1228,8 +1228,8 @@ static struct clk_branch gp2_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "gp2_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &gp2_src.clkr.hw,
+			.parent_hws = (const struct clk_hw*[]){
+				&gp2_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -1284,8 +1284,8 @@ static struct clk_branch prng_clk = {
 		.enable_mask = BIT(10),
 		.hw.init = &(struct clk_init_data){
 			.name = "prng_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &prng_src.clkr.hw,
+			.parent_hws = (const struct clk_hw*[]){
+				&prng_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -1347,8 +1347,8 @@ static struct clk_branch sdc1_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "sdc1_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &sdc1_src.clkr.hw,
+			.parent_hws = (const struct clk_hw*[]){
+				&sdc1_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -1397,8 +1397,8 @@ static struct clk_branch sdc3_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "sdc3_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &sdc3_src.clkr.hw,
+			.parent_hws = (const struct clk_hw*[]){
+				&sdc3_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -1482,8 +1482,8 @@ static struct clk_branch tsif_ref_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "tsif_ref_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &tsif_ref_src.clkr.hw,
+			.parent_hws = (const struct clk_hw*[]){
+				&tsif_ref_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -1647,8 +1647,8 @@ static struct clk_branch pcie_ref_src_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "pcie_ref_src_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &pcie_ref_src.clkr.hw,
+			.parent_hws = (const struct clk_hw*[]){
+				&pcie_ref_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -1741,8 +1741,8 @@ static struct clk_branch pcie1_ref_src_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "pcie1_ref_src_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &pcie1_ref_src.clkr.hw,
+			.parent_hws = (const struct clk_hw*[]){
+				&pcie1_ref_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -1835,8 +1835,8 @@ static struct clk_branch pcie2_ref_src_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "pcie2_ref_src_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &pcie2_ref_src.clkr.hw,
+			.parent_hws = (const struct clk_hw*[]){
+				&pcie2_ref_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -1934,8 +1934,8 @@ static struct clk_branch sata_rxoob_clk = {
 		.enable_mask = BIT(4),
 		.hw.init = &(struct clk_init_data){
 			.name = "sata_rxoob_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &sata_ref_src.clkr.hw,
+			.parent_hws = (const struct clk_hw*[]){
+				&sata_ref_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -1952,8 +1952,8 @@ static struct clk_branch sata_pmalive_clk = {
 		.enable_mask = BIT(4),
 		.hw.init = &(struct clk_init_data){
 			.name = "sata_pmalive_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &sata_ref_src.clkr.hw,
+			.parent_hws = (const struct clk_hw*[]){
+				&sata_ref_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -2077,8 +2077,8 @@ static struct clk_branch usb30_0_branch_clk = {
 		.enable_mask = BIT(4),
 		.hw.init = &(struct clk_init_data){
 			.name = "usb30_0_branch_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &usb30_master_clk_src.clkr.hw,
+			.parent_hws = (const struct clk_hw*[]){
+				&usb30_master_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -2095,8 +2095,8 @@ static struct clk_branch usb30_1_branch_clk = {
 		.enable_mask = BIT(4),
 		.hw.init = &(struct clk_init_data){
 			.name = "usb30_1_branch_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &usb30_master_clk_src.clkr.hw,
+			.parent_hws = (const struct clk_hw*[]){
+				&usb30_master_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -2151,8 +2151,8 @@ static struct clk_branch usb30_0_utmi_clk_ctl = {
 		.enable_mask = BIT(4),
 		.hw.init = &(struct clk_init_data){
 			.name = "usb30_0_utmi_clk_ctl",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &usb30_utmi_clk.clkr.hw,
+			.parent_hws = (const struct clk_hw*[]){
+				&usb30_utmi_clk.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -2169,8 +2169,8 @@ static struct clk_branch usb30_1_utmi_clk_ctl = {
 		.enable_mask = BIT(4),
 		.hw.init = &(struct clk_init_data){
 			.name = "usb30_1_utmi_clk_ctl",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &usb30_utmi_clk.clkr.hw,
+			.parent_hws = (const struct clk_hw*[]){
+				&usb30_utmi_clk.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -2225,8 +2225,8 @@ static struct clk_branch usb_hs1_xcvr_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "usb_hs1_xcvr_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &usb_hs1_xcvr_clk_src.clkr.hw,
+			.parent_hws = (const struct clk_hw*[]){
+				&usb_hs1_xcvr_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -2291,8 +2291,8 @@ static struct clk_branch usb_fs1_xcvr_clk = {
 		.enable_mask = BIT(9),
 		.hw.init = &(struct clk_init_data){
 			.name = "usb_fs1_xcvr_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &usb_fs1_xcvr_clk_src.clkr.hw,
+			.parent_hws = (const struct clk_hw*[]){
+				&usb_fs1_xcvr_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -2309,8 +2309,8 @@ static struct clk_branch usb_fs1_sys_clk = {
 		.enable_mask = BIT(4),
 		.hw.init = &(struct clk_init_data){
 			.name = "usb_fs1_sys_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &usb_fs1_xcvr_clk_src.clkr.hw,
+			.parent_hws = (const struct clk_hw*[]){
+				&usb_fs1_xcvr_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -2428,8 +2428,8 @@ static struct clk_branch gmac_core1_clk = {
 		.enable_mask = BIT(4),
 		.hw.init = &(struct clk_init_data){
 			.name = "gmac_core1_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &gmac_core1_src.clkr.hw,
+			.parent_hws = (const struct clk_hw*[]){
+				&gmac_core1_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -2500,8 +2500,8 @@ static struct clk_branch gmac_core2_clk = {
 		.enable_mask = BIT(4),
 		.hw.init = &(struct clk_init_data){
 			.name = "gmac_core2_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &gmac_core2_src.clkr.hw,
+			.parent_hws = (const struct clk_hw*[]){
+				&gmac_core2_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -2572,8 +2572,8 @@ static struct clk_branch gmac_core3_clk = {
 		.enable_mask = BIT(4),
 		.hw.init = &(struct clk_init_data){
 			.name = "gmac_core3_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &gmac_core3_src.clkr.hw,
+			.parent_hws = (const struct clk_hw*[]){
+				&gmac_core3_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -2644,8 +2644,8 @@ static struct clk_branch gmac_core4_clk = {
 		.enable_mask = BIT(4),
 		.hw.init = &(struct clk_init_data){
 			.name = "gmac_core4_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &gmac_core4_src.clkr.hw,
+			.parent_hws = (const struct clk_hw*[]){
+				&gmac_core4_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
@@ -2702,8 +2702,8 @@ static struct clk_branch nss_tcm_clk = {
 		.enable_mask = BIT(6) | BIT(4),
 		.hw.init = &(struct clk_init_data){
 			.name = "nss_tcm_clk",
-			.parent_data = &(const struct clk_parent_data){
-				.hw = &nss_tcm_src.clkr.hw,
+			.parent_hws = (const struct clk_hw*[]){
+				&nss_tcm_src.clkr.hw,
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
-- 
2.33.1

