Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFAC50333A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiDPDNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 23:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiDPDNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 23:13:18 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E628111BE73
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 20:10:46 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id md20-20020a17090b23d400b001cb70ef790dso13044698pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 20:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ifMOAfHLNN7DfaZZqh9MgNejy76ce9ngnv0s3Ahi1Mg=;
        b=ggfdvgfSjlld23cULp92DrBodIrBWoYraPLq+y0nf51pyOxV23MK6HA7k5KLqVjHAP
         1gzmHtMPYeMczmgRqby0gDpH5lF3PAz8JPHRsoomma1Ky3zqd9eZPikkyfAr2nTarEg9
         nc1/8HoiQ4pjnGisNsqivEqysPJ9wsW1KpUa1cbS+q2LM47CAaODl2A7NIQIobEhO/vt
         eBXhr67bSojdbdKfwVwKfTWS4g9la8y3nvex8LJ1VGVZXjXCRzl4Jh0ZoVUpkYoUQbE9
         LJP9hfLwdADTNt+gqBb6ovzSJuLRxX/tsKh44dVugIRf89D9jNrYTygA2GqcUc9whaN0
         97Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ifMOAfHLNN7DfaZZqh9MgNejy76ce9ngnv0s3Ahi1Mg=;
        b=WOM0wRbK6ueaqm+ECU/3Kci1tS/0hd7fwJTAmTzyJ163932sd9NDC0pXezJtXNYYGA
         KNygVB6CBGUooSZ1vLUgJhgef4HCJApnvRANPxHWG4pXD/vPSihJLtSbZr5XGNmqy7EE
         sqmwO42keGMhK16n7E64CjsdeX02flDiSG7yyefW/pJOZ9gZ04jb5g049Gk9/poQhJQS
         jskR+LLIYtfYKPzNS24NijheL6PY686GoGsqPxbzoSQhfVft96tuy2gBF35mqe3IuByw
         nZr8yuGs5OYQdVrcXP4yTNuaznzah0blawpeQTdC4A+Sr0d05AP2saRipZLiBbvcaTft
         5N+w==
X-Gm-Message-State: AOAM5328s42CQAl1fDmYui9v7fhLJJ5x4yG/x5QEFXMlnAXLYNE+Fk8w
        oRqr3aJmzOKjThbx2btJHyNybg==
X-Google-Smtp-Source: ABdhPJzNYBTinusU0OgY+Velu6hlMRdEzPZKTz9Hw5w+nSmt9+1pZS1W+li8ZfZzaqFPQxNZwKU8cQ==
X-Received: by 2002:a17:902:8347:b0:158:9224:1a80 with SMTP id z7-20020a170902834700b0015892241a80mr1919291pln.23.1650078646345;
        Fri, 15 Apr 2022 20:10:46 -0700 (PDT)
Received: from localhost.localdomain ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id f33-20020a631021000000b0039dbae3fce0sm5719120pgl.43.2022.04.15.20.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 20:10:45 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 2/2] interconnect: qcom: icc-rpm: Cache every clock rate
Date:   Sat, 16 Apr 2022 11:10:29 +0800
Message-Id: <20220416031029.693211-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220416031029.693211-1-leo.yan@linaro.org>
References: <20220416031029.693211-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cached clock rate is used for all bus clocks, thus it has the
assumption that all interconnect clock rates are always same, this
causes trouble if we want to set different clock rates separately.

This patch is to allocate a clock rate array to cache every clock
rate.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 14 +++++++++-----
 drivers/interconnect/qcom/icc-rpm.h |  2 +-
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index e0309e246523..45d23aaeabf6 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -274,20 +274,19 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 	do_div(rate, qn->buswidth);
 	rate = min_t(u64, rate, LONG_MAX);
 
-	if (qp->bus_clk_rate == rate)
-		return 0;
-
 	for (i = 0; i < qp->num_clks; i++) {
+		if (qp->bus_clk_rate[i] == rate)
+			continue;
+
 		ret = clk_set_rate(qp->bus_clks[i].clk, rate);
 		if (ret) {
 			pr_err("%s clk_set_rate error: %d\n",
 			       qp->bus_clks[i].id, ret);
 			return ret;
 		}
+		qp->bus_clk_rate[i] = rate;
 	}
 
-	qp->bus_clk_rate = rate;
-
 	return 0;
 }
 
@@ -332,6 +331,11 @@ int qnoc_probe(struct platform_device *pdev)
 	if (!qp)
 		return -ENOMEM;
 
+	qp->bus_clk_rate = devm_kcalloc(dev, cd_num, sizeof(*qp->bus_clk_rate),
+					GFP_KERNEL);
+	if (!qp->bus_clk_rate)
+		return -ENOMEM;
+
 	data = devm_kzalloc(dev, struct_size(data, nodes, num_nodes),
 			    GFP_KERNEL);
 	if (!data)
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 4457fcc5b84c..f6c4ac960102 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -34,7 +34,7 @@ struct qcom_icc_provider {
 	enum qcom_icc_type type;
 	struct regmap *regmap;
 	unsigned int qos_offset;
-	u64 bus_clk_rate;
+	u64 *bus_clk_rate;
 	struct clk_bulk_data bus_clks[];
 };
 
-- 
2.25.1

