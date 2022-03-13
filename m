Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865764D7795
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 20:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbiCMTGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 15:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbiCMTGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 15:06:17 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128EF4BFD2;
        Sun, 13 Mar 2022 12:05:06 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id kt27so29712064ejb.0;
        Sun, 13 Mar 2022 12:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XhL5PcXPAVYZIaqVjbCyrF3IgCwpUk1BeN4L/hsgGTo=;
        b=D2y43uQNu2B9yDOF3YS3L8VYNVn6768Gl3ngt+1HuCil5SpthBL2RL8oGAbbQ/bjx6
         ak1cP31XU1tdsTT17466uxqN6UdZi/zchiSDQpSxPIwBUJ+XjMDyhmHxT//rSRlYVodq
         1AizAPq3jDiSeE8daDw7zL5ZghbpWO3858OyiAN47TjfKzLEu52MzNCsbw50B6IjyIMp
         wVNYphBWpACAGHJ5oc6wuJnXZROaxTXQSxyFcqBnRoen3tU7qTg9hI6Itth/sK39tb4E
         stlhNwl96F4NN8QNEz4V6EMIEp8O0abMJ22Zi0hrrFvm8dMFVrBC5NNayZr2IURR06C8
         raUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XhL5PcXPAVYZIaqVjbCyrF3IgCwpUk1BeN4L/hsgGTo=;
        b=BETsvQ1XQXYvS3yVZJunptrFMDS2neKy0j9JxlIrK90pKB+F+GMmz0thFKcy4Rfkt9
         KHHd67M3N8pN0/wLNIuhxhRfiGoVbg/BIkWWVNCcom4ZgfLThBxoRtw6fcsDKBxpx60w
         RGb7prBt1QdXdCukpeLIJdEBt+TL3WeLT32+m8Rwj3WVPl0ELT9bgFrf3xROA/w1Ru3C
         1oD19UXe2oYoHH4SoVkAC0sjndQMkb25JmdUctiwngpgOjGEJXzstmhWfARydc1ddbBE
         AYrHlI7z7D23QZvva6CoVjCTxUu5w9I+RWs3o2DM6BK9tXeTqWmCOQ9BT6ZYTK1/Og3c
         9sww==
X-Gm-Message-State: AOAM532cTvz2q2UKntUqoWJnJJjGMqmDVA1YRQeS7j8gWhiiwCHgalF4
        2G3ExgRqpCd6zhf9rmB3OaQ=
X-Google-Smtp-Source: ABdhPJwyjTA7JsQ7NVKZF5OlzDXji+GJxq4tntg0MoUAznuP+aKEgxBAXZAj0YpBe5WB4AdcTdiZGw==
X-Received: by 2002:a17:906:4fc4:b0:6da:b4c6:fadb with SMTP id i4-20020a1709064fc400b006dab4c6fadbmr17160389ejw.282.1647198304451;
        Sun, 13 Mar 2022 12:05:04 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id n13-20020a170906724d00b006cedd6d7e24sm5856697ejk.119.2022.03.13.12.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 12:05:04 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 03/16] clk: qcom: gcc-ipq806x: add PXO_SRC in clk table
Date:   Sun, 13 Mar 2022 20:04:06 +0100
Message-Id: <20220313190419.2207-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220313190419.2207-1-ansuelsmth@gmail.com>
References: <20220313190419.2207-1-ansuelsmth@gmail.com>
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

