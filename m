Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BA64DDDF5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238718AbiCRQKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238465AbiCRQJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:09:59 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EA58CCEA;
        Fri, 18 Mar 2022 09:08:39 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id m12so10780185edc.12;
        Fri, 18 Mar 2022 09:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YuacHx0JsXxYcT0I9GUMkZ9rOmfUJZlRqGllxjL2g6w=;
        b=XhwB16XBlFYR8i8uRZ2p0xv9ToluLeqLrUH/Sf23WGPBxvy86iklrE24C4rqAauxh7
         qB4erOLysq6QpZrBN/Kj+WvKxTjyRLrQaBB5vDhrmhEOhXPsoq0yfc12jxXppDO65FVC
         7JapF5Ym84aAoAICmzzB4IpKJN0w48kApmFPzmvfisjHlLFAzkBO8YKlIt++fc4tKxSm
         b7LVCR+bKSwWEpXbsi3V0G9LnsiMUL9a4Ha2zCIYFhQ6Tb9LerRFiSjuGZGXxOAz77Ht
         XXKdnad7DAVvsmgYqo2t/XKJ4x+VaUweIM7oq6c6IoggzpOtHq08BUrOrKzQnfxusUG/
         91iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YuacHx0JsXxYcT0I9GUMkZ9rOmfUJZlRqGllxjL2g6w=;
        b=1G+wi+1MHGOMwh7FpPFsqHYkNIzjbefXuI9Fkyvl2WtZ1kxZnhEqZ3PrtntSiXmomE
         gmUauF26UgYSUnWCmirqlqIrQ+OJTQcbRX0PFFiivaYFdzdynyRmD2qOeY0hNag/XyKk
         hpBxl0ZtO07SqUkklGxyUF9Ii2etnWmr94EHTtVxi1tHYsUlPQx5mGY4K0G9feouFBwr
         hg+sjaeNScBgAUj/qncFP+FdxrCrvyjfLjn9g2KN0gpi8gnu9QI0oaK/Tkjeo5B5JAEl
         JUqzgapNv9vXPcTeXBgyz0f9f1Aqm08c17KmGgNVwCGaloKGrLccjn6T/erCZyRTZm2R
         y8tw==
X-Gm-Message-State: AOAM533CAcntDUbQDjPb7CbdABVqGq95fKWa5Ag13bnVDxVciiNHAqR4
        KcmexEHVA85IrQuIR6FhClU=
X-Google-Smtp-Source: ABdhPJwLMjhJdMS0qcG/cpgjR8P8esIh5TwDqXt13nNr2t7CyVGc966nokwZiY1/fBPNXzXC5OJhKg==
X-Received: by 2002:a05:6402:27d1:b0:419:1b02:4a04 with SMTP id c17-20020a05640227d100b004191b024a04mr660958ede.218.1647619718337;
        Fri, 18 Mar 2022 09:08:38 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id e9-20020a170906c00900b006d4a45869basm3754118ejz.199.2022.03.18.09.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 09:08:38 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v2 09/16] clk: qcom: krait-cc: drop pr_info and register qsb only if needed
Date:   Fri, 18 Mar 2022 17:08:20 +0100
Message-Id: <20220318160827.8860-10-ansuelsmth@gmail.com>
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

