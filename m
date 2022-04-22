Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AFC50BE3B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 19:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358046AbiDVROd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 13:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241817AbiDVRMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:12:33 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3365D91579;
        Fri, 22 Apr 2022 10:09:36 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 01FF41F4682E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650647375;
        bh=tTOCToDJjcLzI14JLadsZVSZ4cSn/2Or8RPivrlFg50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nRp37PUl9g3sm7SH8QHjqumjOWGGKySd3yzOHLHBV+nA3BANrQOEtF1yocoezTbtb
         BdFmZ3mfNyleoMjixrmdThLcDlzewu0sZ1sHllb9zi9rC5kXI6DpCh5Cua/ea+CxOJ
         0g5F3zi4GA8xGPKEj0nrGI//atb9/XyPMupHBlfKMS4odQEWqCaPR8/XVnOEn6610O
         +1u23HS5ZQPUOddDLl2XnpTgpFbkYtb/3iItd7Q43dLC68I7DY73y78fIOA9x1AVhA
         9lZKK81IHvxhO/Z7HyTd65ZrbjkOKu2yR/8GiEJrP2ezdJIPpA0Xu0CiPa1PeLx5Ke
         K859EnBRcajJw==
Received: by jupiter.universe (Postfix, from userid 1000)
        id C42014807E1; Fri, 22 Apr 2022 19:09:32 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        Elaine Zhang <zhangqing@rock-chips.com>, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 02/19] clk: rockchip: add register offset of the cores select parent
Date:   Fri, 22 Apr 2022 19:09:03 +0200
Message-Id: <20220422170920.401914-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422170920.401914-1-sebastian.reichel@collabora.com>
References: <20220422170920.401914-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elaine Zhang <zhangqing@rock-chips.com>

The cores select parent register is special on RK3588.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/clk/rockchip/clk-cpu.c | 28 ++++++++++++++++++++--------
 drivers/clk/rockchip/clk.h     |  3 +++
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/rockchip/clk-cpu.c b/drivers/clk/rockchip/clk-cpu.c
index 47288197c9d7..11aa2259b532 100644
--- a/drivers/clk/rockchip/clk-cpu.c
+++ b/drivers/clk/rockchip/clk-cpu.c
@@ -166,10 +166,16 @@ static int rockchip_cpuclk_pre_rate_change(struct rockchip_cpuclk *cpuclk,
 		}
 	}
 	/* select alternate parent */
-	writel(HIWORD_UPDATE(reg_data->mux_core_alt,
-			     reg_data->mux_core_mask,
-			     reg_data->mux_core_shift),
-	       cpuclk->reg_base + reg_data->core_reg[0]);
+	if (reg_data->mux_core_reg)
+		writel(HIWORD_UPDATE(reg_data->mux_core_alt,
+				     reg_data->mux_core_mask,
+				     reg_data->mux_core_shift),
+		       cpuclk->reg_base + reg_data->mux_core_reg);
+	else
+		writel(HIWORD_UPDATE(reg_data->mux_core_alt,
+				     reg_data->mux_core_mask,
+				     reg_data->mux_core_shift),
+		       cpuclk->reg_base + reg_data->core_reg[0]);
 
 	spin_unlock_irqrestore(cpuclk->lock, flags);
 	return 0;
@@ -202,10 +208,16 @@ static int rockchip_cpuclk_post_rate_change(struct rockchip_cpuclk *cpuclk,
 	 * primary parent by the extra dividers that were needed for the alt.
 	 */
 
-	writel(HIWORD_UPDATE(reg_data->mux_core_main,
-			     reg_data->mux_core_mask,
-			     reg_data->mux_core_shift),
-	       cpuclk->reg_base + reg_data->core_reg[0]);
+	if (reg_data->mux_core_reg)
+		writel(HIWORD_UPDATE(reg_data->mux_core_main,
+				     reg_data->mux_core_mask,
+				     reg_data->mux_core_shift),
+		       cpuclk->reg_base + reg_data->mux_core_reg);
+	else
+		writel(HIWORD_UPDATE(reg_data->mux_core_main,
+				     reg_data->mux_core_mask,
+				     reg_data->mux_core_shift),
+		       cpuclk->reg_base + reg_data->core_reg[0]);
 
 	/* remove dividers */
 	for (i = 0; i < reg_data->num_cores; i++) {
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index 7aa45cc70287..6aece7f07a7d 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -370,6 +370,8 @@ struct rockchip_cpuclk_rate_table {
  * @div_core_shift[]:	cores divider offset used to divide the pll value
  * @div_core_mask[]:	cores divider mask
  * @num_cores:	number of cpu cores
+ * @mux_core_reg:       register offset of the cores select parent
+ * @mux_core_alt:       mux value to select alternate parent
  * @mux_core_main:	mux value to select main parent of core
  * @mux_core_shift:	offset of the core multiplexer
  * @mux_core_mask:	core multiplexer mask
@@ -379,6 +381,7 @@ struct rockchip_cpuclk_reg_data {
 	u8	div_core_shift[ROCKCHIP_CPUCLK_MAX_CORES];
 	u32	div_core_mask[ROCKCHIP_CPUCLK_MAX_CORES];
 	int	num_cores;
+	int	mux_core_reg;
 	u8	mux_core_alt;
 	u8	mux_core_main;
 	u8	mux_core_shift;
-- 
2.35.1

