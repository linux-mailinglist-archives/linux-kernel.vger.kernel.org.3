Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463654E1CD0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 17:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245590AbiCTQaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 12:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245495AbiCTQ3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 12:29:46 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DEE34656;
        Sun, 20 Mar 2022 09:28:22 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o30-20020a05600c511e00b0038c9cfb79cbso459518wms.1;
        Sun, 20 Mar 2022 09:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YuacHx0JsXxYcT0I9GUMkZ9rOmfUJZlRqGllxjL2g6w=;
        b=eWFE4ObkZaO8EEYJkVeLQHWVjCylfQT5ul3qDz+SJnRyKID+ak07AnKQXwR29HXJpz
         iFKD5BOSpQJ1ifEwCzMTxLdR2GhDho0iKVT1Ty6Ct4JhTqWw0E5QMDG5Zg6dSvPJmjxN
         ppO0MEwBQcByrxK+d5mHL96rIlC3JfXDSaT7pOpR2R6ksxzdk6tshfoayATordUmvrEa
         +7UPxZlROnDeXml30WbXag37WVTRn9PHYKlxSgcqxx4mP4Z1uH/Sw8O959j4iwZACAuF
         qa4NOhiXFhj6/BX2BoyG2FAv9+2BAOK+hakK226Me2YehgPO8jFs1ZQdvBwVhYDIVOwT
         dbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YuacHx0JsXxYcT0I9GUMkZ9rOmfUJZlRqGllxjL2g6w=;
        b=zuLcTuualRcKU+bGtvuL61OdEEHmRTpjgdH00KeXGLXKv1D64DalLqjQRcFb/R2vI5
         CI/AqQXdeShckh45P28jU3AWoNIvpFjPC83M4VmcRDUE0DMQPc/CSBtt3ID4LbngoUxA
         jwLqSxOECOIWd4nAi9gtu4RQG8pQKX4XObBfpD1J8eJmRPrZDub3JRnZ5q5ryFrt3yK4
         qvttqFoNxtJ3gdBy3Yk7GbXwahWUT3TXvtMgSilztprpO1UDS1oOnAZi11XKr536f866
         4zrzENKTQyyUK26xHB9RHN3Gxapb7ffLJo2kv14QOCupZTk+p1rhcT8J4Q4HnLXmyr8z
         9wng==
X-Gm-Message-State: AOAM532HwSWm47itO5e4XmAJ04AxnuiaiCcxTr6b2zY3GJL4DEpAUleo
        4uFzgPeSwb04Y6qajvOJX4w=
X-Google-Smtp-Source: ABdhPJwFNPxi31n7RiMY9yAhJ48j3uVzfhH3/crsYKX+EvU4Jbw4q2xUcH1qhFrrgmy805KX4rONsg==
X-Received: by 2002:a05:600c:3556:b0:389:d214:baac with SMTP id i22-20020a05600c355600b00389d214baacmr23958541wmq.92.1647793701108;
        Sun, 20 Mar 2022 09:28:21 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id y6-20020a05600015c600b00203fa70b4ebsm6760085wry.53.2022.03.20.09.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 09:28:20 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 09/18] clk: qcom: krait-cc: drop pr_info and register qsb only if needed
Date:   Sun, 20 Mar 2022 12:34:21 +0100
Message-Id: <20220320113430.26076-10-ansuelsmth@gmail.com>
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

Replace pr_info() with dev_info() to provide better diagnostics.
Register qsb fixed clk only if it's not declared in DTS.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/krait-cc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/qcom/krait-cc.c b/drivers/clk/qcom/krait-cc.c
index 645ad9e8dd73..e9508e3104ea 100644
--- a/drivers/clk/qcom/krait-cc.c
+++ b/drivers/clk/qcom/krait-cc.c
@@ -308,7 +308,9 @@ static int krait_cc_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	/* Rate is 1 because 0 causes problems for __clk_mux_determine_rate */
-	clk = clk_register_fixed_rate(dev, "qsb", NULL, 0, 1);
+	if (IS_ERR(clk_get(dev, "qsb")))
+		clk = clk_register_fixed_rate(dev, "qsb", NULL, 0, 1);
+
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
@@ -363,25 +365,25 @@ static int krait_cc_probe(struct platform_device *pdev)
 	cur_rate = clk_get_rate(l2_pri_mux_clk);
 	aux_rate = 384000000;
 	if (cur_rate == 1) {
-		pr_info("L2 @ QSB rate. Forcing new rate.\n");
+		dev_info(dev, "L2 @ QSB rate. Forcing new rate.\n");
 		cur_rate = aux_rate;
 	}
 	clk_set_rate(l2_pri_mux_clk, aux_rate);
 	clk_set_rate(l2_pri_mux_clk, 2);
 	clk_set_rate(l2_pri_mux_clk, cur_rate);
-	pr_info("L2 @ %lu KHz\n", clk_get_rate(l2_pri_mux_clk) / 1000);
+	dev_info(dev, "L2 @ %lu KHz\n", clk_get_rate(l2_pri_mux_clk) / 1000);
 	for_each_possible_cpu(cpu) {
 		clk = clks[cpu];
 		cur_rate = clk_get_rate(clk);
 		if (cur_rate == 1) {
-			pr_info("CPU%d @ QSB rate. Forcing new rate.\n", cpu);
+			dev_info(dev, "CPU%d @ QSB rate. Forcing new rate.\n", cpu);
 			cur_rate = aux_rate;
 		}
 
 		clk_set_rate(clk, aux_rate);
 		clk_set_rate(clk, 2);
 		clk_set_rate(clk, cur_rate);
-		pr_info("CPU%d @ %lu KHz\n", cpu, clk_get_rate(clk) / 1000);
+		dev_info(dev, "CPU%d @ %lu KHz\n", cpu, clk_get_rate(clk) / 1000);
 	}
 
 	of_clk_add_provider(dev->of_node, krait_of_get, clks);
-- 
2.34.1

