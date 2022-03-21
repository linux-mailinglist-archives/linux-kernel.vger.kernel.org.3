Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E744E2D6F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350812AbiCUQK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350705AbiCUQJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:09:52 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DD026545;
        Mon, 21 Mar 2022 09:08:26 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id h189so88218wmh.3;
        Mon, 21 Mar 2022 09:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YuacHx0JsXxYcT0I9GUMkZ9rOmfUJZlRqGllxjL2g6w=;
        b=K2a4KR0EWlyhrfSg3vSGs0tS19vAAzxdd7DQjTVLcdaJyT/36aF7MDWcVV4cBY8KJc
         CG2I16S/Juf6qG5/WuISMSJNH6OiKIS0PZFL2GkLW8jCcAohTmwTZcQyBlNnpNl29z5t
         DYQpafKj31zGuL9XAXLpaS0ZY2GJy4KfkxfsIK+7qpjQkcjkiUoHICSiMjvWHe03tMbT
         ZxKLivHGki29kubdkySe9ObKEhlrgNTPi+niyvTEoQ4iJEA7LZ0Yu78xLlBdTUnt9BgP
         GyxbLI8zN2NmOP3w7nTsgqUi5Xnyd1dp+uUay3/NnlaGJPRz8Rc2+yMVrdRxeJtfUPBr
         axOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YuacHx0JsXxYcT0I9GUMkZ9rOmfUJZlRqGllxjL2g6w=;
        b=Lx6zlVzNVbh+g5sMOHeAC9t1CF8a7y76EDHS9GcyVBBxekX7mXelDtuARHw3uF7Ggt
         AV/dDp00uEEcN5Uu7Q6MUcwCBkM0aQ1d3xX3X0DXn2McrIwc1DyoUuJKHxG4bciWTkQW
         KXFxZk0vTM8KlIxrVeLHAayhY1KL7OyZQ/wfajBStJz2IL77fRPEb9UvLfVQlLb68jRj
         BfK1dOb6X3F1HJ8WBvLC2cBVwzbTx/X8+1+c+UsDtkKITvA+LwLvOWx20fnkCYrq28Ft
         KecyIb8NUV/KpCp4VcbSagSwPeC4i6r7A2HS2XJLIdI4u6rw7wWzdQ+RLiLbamUTZEPB
         IWlA==
X-Gm-Message-State: AOAM530uAXCV2nB+9h69D1Tt9FjIl1j2XZEZQetCpoLFJdFsHoBJgpXd
        0HfO3T6PYTVXAo0jF/i2M18=
X-Google-Smtp-Source: ABdhPJzNRpHV4qx9Oy1IcManqjclMoUpVZv8zvdj5SKts8/rPTEm9/fKQ1VwqLSqmW9SNEkf6JRUBw==
X-Received: by 2002:a7b:c955:0:b0:38c:aafb:2991 with SMTP id i21-20020a7bc955000000b0038caafb2991mr3418589wml.114.1647878904859;
        Mon, 21 Mar 2022 09:08:24 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id az19-20020a05600c601300b0038cadf3aa69sm2603864wmb.36.2022.03.21.09.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 09:08:24 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v5 09/18] clk: qcom: krait-cc: drop pr_info and register qsb only if needed
Date:   Mon, 21 Mar 2022 16:38:46 +0100
Message-Id: <20220321153855.12082-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321153855.12082-1-ansuelsmth@gmail.com>
References: <20220321153855.12082-1-ansuelsmth@gmail.com>
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

