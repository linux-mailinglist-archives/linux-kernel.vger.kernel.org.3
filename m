Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BDE4E34D3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbiCUXrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbiCUXqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:46:45 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57BA6E4C5;
        Mon, 21 Mar 2022 16:45:16 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r10so22793245wrp.3;
        Mon, 21 Mar 2022 16:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XhL5PcXPAVYZIaqVjbCyrF3IgCwpUk1BeN4L/hsgGTo=;
        b=VtKokik8jZoQyV3SXrJav2zsYascZDoAoeYdKhrVPhTBywjJOCILD+HBgks3+onIT1
         zCCcMYlFIoSUiBK29Lpxhu2GpxBMCDnOmhbPeB0lYbYf06jpkkhKZwXM8kwz6oV6uiFx
         MAc+flCgvYR5hhxADs/2RgSYLxIr7a5HFnNkEwgSPzwAFvNSj8gtKotLB1gwPuFzTWut
         XxJ1TD58yW8yDoNA5WnqeRYT1Xodqcw+lVyfLg7ZK6GvVlMauyAzkF7qqu2ObKfxqbIR
         9+FdZ+qTcQI6TuhU9V2TBuT74lAP5mswSJW0ikVXdMQqt+qTt+EPNTQ9ujHobVLpj5wa
         Aa1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XhL5PcXPAVYZIaqVjbCyrF3IgCwpUk1BeN4L/hsgGTo=;
        b=p3L+TtVXn+is4YB3hboLLYOwEx1F/5e/ZoChcXuwg65Qs9vzLYg65irIaKtNGdMYAU
         R2Vd7atlz94wEblEjmBQ93+GzDOT0QVnrqQDBOmNbwFITb87rpKTb4MnUGrf7IyPpcP2
         FSQ7WWJ7e6JjP7iJ4Ge8oxU6feWAyHYsKY8wqFRl9thmMEUHB8iKdhxBtiPx8iRGujN1
         BsTSWc9kWtddNZioRQuZiE8blBGrS4P/UUaP280Q+S9PSm1HCuoGkApnOxHkPUCQ4t8a
         3WS9VFBC0Cd8U3LwZGPfRGUXYaiibcKAvKHl/xCWOZznl0Lr4PUsOp/p7x1ke5n47dCk
         3iMQ==
X-Gm-Message-State: AOAM531cZYYKp+YsJlIVw1gqxnij3HYHrOIGiKRFyBO0G5SIAi/Kawf/
        /44GlQY1PgtM41yy0uJOEyo=
X-Google-Smtp-Source: ABdhPJxTJFdJL1hfeET4DhPZVqmLCzIdHZguEiqvmbEyux3rIVGb5NsscxI0HS2N71uidvVTJspR+A==
X-Received: by 2002:a5d:584a:0:b0:203:97f6:5975 with SMTP id i10-20020a5d584a000000b0020397f65975mr19790174wrf.612.1647906315315;
        Mon, 21 Mar 2022 16:45:15 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id n10-20020a5d588a000000b002052e4aaf89sm105497wrf.80.2022.03.21.16.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 16:45:14 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v6 03/18] clk: qcom: gcc-ipq806x: add PXO_SRC in clk table
Date:   Tue, 22 Mar 2022 00:15:33 +0100
Message-Id: <20220321231548.14276-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321231548.14276-1-ansuelsmth@gmail.com>
References: <20220321231548.14276-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PXO_SRC is currently defined in the gcc include and referenced in the
ipq8064 DTSI. Correctly provide a clk after gcc probe to fix kernel
panic if a driver starts to actually use it.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index 27f6d7626abb..7271d3afdc89 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -26,6 +26,8 @@
 #include "clk-hfpll.h"
 #include "reset.h"
 
+static struct clk_regmap pxo = { };
+
 static struct clk_pll pll0 = {
 	.l_reg = 0x30c4,
 	.m_reg = 0x30c8,
@@ -2754,6 +2756,7 @@ static struct clk_dyn_rcg ubi32_core2_src_clk = {
 };
 
 static struct clk_regmap *gcc_ipq806x_clks[] = {
+	[PXO_SRC] = NULL,
 	[PLL0] = &pll0.clkr,
 	[PLL0_VOTE] = &pll0_vote,
 	[PLL3] = &pll3.clkr,
@@ -3083,6 +3086,10 @@ static int gcc_ipq806x_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	clk = clk_get(dev, "pxo");
+	pxo.hw = *__clk_get_hw(clk);
+	gcc_ipq806x_clks[PXO_SRC] = &pxo;
+
 	regmap = dev_get_regmap(dev, NULL);
 	if (!regmap)
 		return -ENODEV;
-- 
2.34.1

