Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654EE4DDDE2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238571AbiCRQKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238185AbiCRQJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:09:52 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA85F4FC46;
        Fri, 18 Mar 2022 09:08:33 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id pv16so18033034ejb.0;
        Fri, 18 Mar 2022 09:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XhL5PcXPAVYZIaqVjbCyrF3IgCwpUk1BeN4L/hsgGTo=;
        b=qzZNmheckii7QD5B6iClmT8S/PvmDeu/o1DSZKpegT9SOmdJLN03FPiDEE4+dI1i6L
         y8OEsCn5zq6gWGNu44Td39d3oEfyRIRAdQuW2hFtACB4ey1XRBtMUIXCEDzQsP91rb5T
         ysXx3/vrsXll9Ja/ynKboUT64F8mrewZ02PeX9qIu5Oa1E+KJBde83iiBDTYQzlv6nXr
         quSsnwauwp+x1Kv3IX2u2o9RjCRT4SsSLtIWTrqz67KD4x0hmRyh832KW83anEEiNZSo
         6qbNSmg62K6h216Gc94cierMEbIxhRiFHBpiQYGfe5NVrSbyXmgYKy0+zwx7mqvX3UtU
         oITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XhL5PcXPAVYZIaqVjbCyrF3IgCwpUk1BeN4L/hsgGTo=;
        b=QZiLDem4o5pTgrcTxjhh1AN0r1ooJvZU3xbTpYAnGBzYZI9tyWGVVTjjwLF34SHWMM
         smzLklySoF3q0cBkc7HY40tLKThXdXaNJrpAwO1S1MgGEm40mJaF0CEaxQoqu2zm9shP
         njLLlzpxtEhKiVS9NtqOgmBIZoZfstH6QNqCJM36qiPKXSfcYFfyX/Dh/WdKb2Lpt8A7
         uIU8MK8KiwvH7F9Rz8xbL8OPJWoaK7XtmSoeEVnOrYJCBqpzMEIVNcNaneud7I4BD1tF
         +OZy1/H1T+ydZvuqOB1oPbJNY/S3mWNBKOGgFv/q20KvKYeHyhJAyO9Cpi6HxLGCa7R5
         irLQ==
X-Gm-Message-State: AOAM530ivcPCWY1hZKBI/SRbA+L8fPHXP69VKPlvP03lKKghzBmk7h6j
        0nr8r5KV+xVSWyBQDvHZ3cY=
X-Google-Smtp-Source: ABdhPJzz7S9OaQ0+IgohlMwoZ4xu/sUe6wt2Q7iMdSBrrmc9PPLUjlxOJZ5cITsoF1KKXdkSLJBRpQ==
X-Received: by 2002:a17:906:1f11:b0:685:d50e:3bf9 with SMTP id w17-20020a1709061f1100b00685d50e3bf9mr9829780ejj.275.1647619712207;
        Fri, 18 Mar 2022 09:08:32 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id e9-20020a170906c00900b006d4a45869basm3754118ejz.199.2022.03.18.09.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 09:08:31 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v2 03/16] clk: qcom: gcc-ipq806x: add PXO_SRC in clk table
Date:   Fri, 18 Mar 2022 17:08:14 +0100
Message-Id: <20220318160827.8860-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220318160827.8860-1-ansuelsmth@gmail.com>
References: <20220318160827.8860-1-ansuelsmth@gmail.com>
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

