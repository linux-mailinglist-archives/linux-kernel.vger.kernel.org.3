Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314F34E1CB3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 17:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245531AbiCTQ3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 12:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245468AbiCTQ3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 12:29:38 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C64F344DC;
        Sun, 20 Mar 2022 09:28:15 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r190-20020a1c2bc7000000b0038a1013241dso7237256wmr.1;
        Sun, 20 Mar 2022 09:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XhL5PcXPAVYZIaqVjbCyrF3IgCwpUk1BeN4L/hsgGTo=;
        b=lvVwhd3NFXJB1ApopmbOb4WGqxnI5aZIi/oFdTKyxa3QGvWs1vq+wc5nCJvXSoFl2a
         Z4PSWz7wFVt8r+ZyC+bPngeGL0ylzuB6AyokuE3XePfet6eHsNUMwicaV849FC/ONAzf
         gUcNNubL0r8iH21j8tPgUo1H/9XCVqS3kXCbE+kYbnG2VqpvKRfH7odqRpV1Ml6yL7dU
         Z2TgCYtbDbCSCQyEXE+z5E8t1RbtE7uw0c7TRnm+IK0DW++XGdJRVxCZyUtjVz4dVN6H
         seIdVDNlTjrgUD5Y8dmH/lZEeghG8H719NgaN27wnhNfC5HYclzxRb6PYX+TcVT0iw2O
         5hgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XhL5PcXPAVYZIaqVjbCyrF3IgCwpUk1BeN4L/hsgGTo=;
        b=3bhU2mIqSHx6rNFqk25kLZspst7ERapvgvVGzRDk0tWgfwNGeKznw1I3Vmu+EUGx34
         G+PTWsMDa3CeeHSurdiBTKsByGaasDaaxgIKw7ADTfAcLXRXP4c/ttZE5oFflpRkKU1V
         osrYo65ZTMU/jYwDxFFT7xIPHV5g5UOCkHjWcvFcWw4XhCxKgIGoHA0svPV8QxBaV90i
         DqjQ2u9d+Hjk7X2upgvcP0u60cE1rZobs5v3Zi5T+Rrf1CYo9A717rh1+WZuio3LITF4
         zvIQMYTyo7VTC6Wd+ZCRcPqBHeEAAsYyzI0ohaGEVtwImwFcBLyQvE2jrnnHGLFOIWiS
         1ufg==
X-Gm-Message-State: AOAM53101NvWUXmHVpo2Q6nQFLYCBq5sMYqhSONWQSvmQ4tqFBkwG5AJ
        pF3SH70BfuH//+KLP36zOeL/H/mlPHo=
X-Google-Smtp-Source: ABdhPJxKzWiavPeOkd3SpgHfRfE4hVaqD6LqknQUXwhrlb2Pg4Sr0Gzivp4d7/v+NX+Q9+ApYn68Ag==
X-Received: by 2002:a05:600c:4e55:b0:38c:a453:d99a with SMTP id e21-20020a05600c4e5500b0038ca453d99amr1925787wmq.184.1647793694073;
        Sun, 20 Mar 2022 09:28:14 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id y6-20020a05600015c600b00203fa70b4ebsm6760085wry.53.2022.03.20.09.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 09:28:13 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 03/18] clk: qcom: gcc-ipq806x: add PXO_SRC in clk table
Date:   Sun, 20 Mar 2022 12:34:15 +0100
Message-Id: <20220320113430.26076-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220320113430.26076-1-ansuelsmth@gmail.com>
References: <20220320113430.26076-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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

