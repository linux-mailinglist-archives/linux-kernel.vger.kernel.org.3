Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C32516DDA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 12:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384496AbiEBKGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 06:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384366AbiEBKG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 06:06:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D8111A04
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 03:02:47 -0700 (PDT)
From:   Viraj Shah <viraj.shah@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651485766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kFbaTBJ6AL/X2QNd2kSlQdvhpj3h8osfwHT7cP5luao=;
        b=ecFdqLEbt2QBAgdMnwZIVO7M+kTY7MbFKwl7xJ3yUbcdGbGorZIyle5SffnfrUD7cgXFAU
        R7b+U/oUhfa3afDtTx6gAzGyeQqULJMQlj3kz6/UgKavTrBIyMBo2BOWqliW7jLGRbiIBS
        zWESVymhNpNJ05klQrkf/F5i+BqVEHYF723hJLi763SjZgQk+dHu4zvHMq0mD1PVKW4tFt
        5iMemher/eZ2IdZFSDUV37NOJr0bONtIjooRQ8Mgy5Qbnr6C6Enq9gObhtfT+zTfig2MCg
        m2C6+0C//Qwq8U/hdO1JedktHKwb9M61FLt66Puin7BsNpqFzDgREvlVuavqSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651485766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kFbaTBJ6AL/X2QNd2kSlQdvhpj3h8osfwHT7cP5luao=;
        b=Zsz0j7wTyu86KZrkCFDG/37bshIgmR0pr0gPWky8FVTaAJhAKSe/9m0OcJXeExTFQRA4nm
        UNziTDS+LijQq+Bw==
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] soc: imx8mm: gpcv2: Power sequence for DISP
Date:   Mon,  2 May 2022 12:02:30 +0200
Message-Id: <20220502100233.6023-2-viraj.shah@linutronix.de>
In-Reply-To: <20220502100233.6023-1-viraj.shah@linutronix.de>
References: <20220502100233.6023-1-viraj.shah@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the imx8mm reference manual, read bit 25(GPC_DISPMIX_
PWRDNACKN) of the power handshake register and wait for ack during
power on/off.

Signed-off-by: Viraj Shah <viraj.shah@linutronix.de>
---
 drivers/soc/imx/gpcv2.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 3cb123016b3e..8ee70c30964f 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -254,11 +254,24 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
 		/*
 		 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
 		 * for PUP_REQ/PDN_REQ bit to be cleared
+		 *
+		 * As per "5.2.9.5 Example Code 5" in i.MX-8MMini-yhsc.pdf
+		 * Display power on section checks for bit 25 of
+		 * Power handshake register to be cleared.
 		 */
-		ret = regmap_read_poll_timeout(domain->regmap,
-					       GPC_PU_PGC_SW_PUP_REQ, reg_val,
-					       !(reg_val & domain->bits.pxx),
-					       0, USEC_PER_MSEC);
+		if (domain->bits.pxx == IMX8MM_DISPMIX_SW_Pxx_REQ) {
+			regmap_update_bits(domain->regmap, GPC_PU_PWRHSK,
+				   BIT(7), BIT(7));
+			ret = regmap_read_poll_timeout(domain->regmap,
+						GPC_PU_PWRHSK, reg_val,
+						!(reg_val & IMX8MM_DISPMIX_HSK_PWRDNACKN),
+						0, USEC_PER_MSEC);
+		} else
+			ret = regmap_read_poll_timeout(domain->regmap,
+						GPC_PU_PGC_SW_PUP_REQ, reg_val,
+						!(reg_val & domain->bits.pxx),
+						0, USEC_PER_MSEC);
+
 		if (ret) {
 			dev_err(domain->dev, "failed to command PGC\n");
 			goto out_clk_disable;
@@ -355,11 +368,24 @@ static int imx_pgc_power_down(struct generic_pm_domain *genpd)
 		/*
 		 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
 		 * for PUP_REQ/PDN_REQ bit to be cleared
+		 *
+		 * As per "5.2.9.5 Example Code 5" in i.MX-8MMini-yhsc.pdf
+		 * Display power on section checks for bit 25 of
+		 * Power handshake register to be set.
 		 */
-		ret = regmap_read_poll_timeout(domain->regmap,
+		if (domain->bits.pxx == IMX8MM_DISPMIX_SW_Pxx_REQ) {
+			regmap_clear_bits(domain->regmap, GPC_PU_PWRHSK,
+				   BIT(7));
+			ret = regmap_read_poll_timeout(domain->regmap,
+						GPC_PU_PWRHSK, reg_val,
+						!(reg_val & IMX8MM_DISPMIX_HSK_PWRDNACKN),
+						0, USEC_PER_MSEC);
+		} else {
+			ret = regmap_read_poll_timeout(domain->regmap,
 					       GPC_PU_PGC_SW_PDN_REQ, reg_val,
 					       !(reg_val & domain->bits.pxx),
 					       0, USEC_PER_MSEC);
+		}
 		if (ret) {
 			dev_err(domain->dev, "failed to command PGC\n");
 			goto out_clk_disable;
-- 
2.20.1

