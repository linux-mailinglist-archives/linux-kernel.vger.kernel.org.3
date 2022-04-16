Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A799D5033A1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiDPDNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 23:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiDPDNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 23:13:14 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D124411BE43
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 20:10:42 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n8so8412244plh.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 20:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VY8Lzz5EimCpkjGUcpeQXpZeI+y6B6IrYwQXORdA5Z4=;
        b=JNLYvRruuouv1lIEsB9WXFX8prGK50AUcd72WtHr5pHDxJ0u7eufpl+IaQaXiseqd/
         0/tmBSdedsF6w2wutfZHv6tw4d/8tBIm8ILJBzcavAtnNA2GIdvwT2qE/SH3dul/EuHb
         oD5BzKTcHnh62vZznR6SBCsA+WFjlwD/jmrmB4o0tABAoKiE8z3tVdPKf0qRqK3UR4kU
         1Dj/UsWcoMvyCzykDMIA3DQTuxywEMGOmdKY+6GuGnCY93GL1KNW/4Ly7WcY+e3/3Pi0
         pPJ2JnDDVWTLt+BcofE/hfLIs8so9epAw/dkusXh0kC+2t0UCCtbdYNLZB7gwhp/Byao
         2VeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VY8Lzz5EimCpkjGUcpeQXpZeI+y6B6IrYwQXORdA5Z4=;
        b=r+tALY2GPWPpB8n8f7DmF5HevBBSGu+3mfbth4CcjPnqUUvdREFAlczCcYB+3lxaI7
         zecNcSITU5kUDQVO0FLcTIacgBh6Ub9z6YJs6T7emgcfWX7rKpTTmXwiikw0QUMzoqP1
         OWUXPrmv7NA8Xf7J52fB7LEUicu3ODT0puxqx/EUKJhgloSAtYUNxCbPCpCcGB2TNu3g
         STnCgLk7fYDL3xkcaYknzKEmquwYLa4dGwKZEovGCKV2SnPJHaG++GCSd8V+Dm0dCoTQ
         /KIUJIkcV1LuCKvXMtns8yo1DEg3Zx0S/RATtWv8vZ1Y2OtXyiPVO5cDGENE8uPeyh5B
         CnzA==
X-Gm-Message-State: AOAM532OTEU7+uU+gq67huxhqQUidsbOyIwfFE5PP1inX/+LA7sxJHfs
        OeZMw+XMNgx/dm95pYSLF45wEg==
X-Google-Smtp-Source: ABdhPJw+05BRuL9HJwdtciBouLj9h+IrUen0e6NtL/BciK0Q3nuZDNw7jLV1eweSKoKZPJBmq5Wd1A==
X-Received: by 2002:a17:903:41ca:b0:158:7f07:e7bc with SMTP id u10-20020a17090341ca00b001587f07e7bcmr1715266ple.32.1650078642229;
        Fri, 15 Apr 2022 20:10:42 -0700 (PDT)
Received: from localhost.localdomain ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id f33-20020a631021000000b0039dbae3fce0sm5719120pgl.43.2022.04.15.20.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 20:10:41 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 1/2] interconnect: qcom: icc-rpm: Fix for cached clock rate
Date:   Sat, 16 Apr 2022 11:10:28 +0800
Message-Id: <20220416031029.693211-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220416031029.693211-1-leo.yan@linaro.org>
References: <20220416031029.693211-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All nodes within an interconnect bus share interconnect bus clocks, but
every node has its own cached clock rate values, this can lead to
unexpected clock rate setting.

Let's see an example shown in below, in this case, a bus have two nodes
A and B, and its buswidth is 8:

  step1: vote bandwidth 1600M for node(A):

    aggregated(bw) = 1600M
    qcom_icc_node(A)->rate = 1600M / 8 = 200MHz

  step2: vote bandwidth 1600M for node(B):

    aggregated(bw) = 1600M + 1600M = 3200M
    qcom_icc_node(B)->rate = 3200M / 8 = 400MHz

  step3: unvote bandwidth 1600M for node(A)

    aggregated(bw) = 3200M - 1600M = 1600M
    target_clock = 1600M / 8 = 200MHz

The problem is in step 3, the calculated target clock rate is 200MHz,
which equals to the cached clock rate in node(A) (See step 1),
unfortunately, qcom_icc_set() skips to set the new clock rate 200MHz in
this case, so the bus clock rate will continue to stay at 400MHz.

To resolve the issue, one possible solution is to invoke clk_get_rate()
to retrieve the clock rates on the fly, thus we can totally remove the
cached clock rates.  But after review the code, many bus clock has set
the flag CLK_GET_RATE_NOCACHE, this results in the retrieving bus clock
rate is time cost for iterating parent clock nodes, and even challenges
bus clock drivers to provide recalc_rate() callbacks.

So this patch moves the cached rates into structure qcom_icc_provider,
we use it as a central place to maintain bus clock handlers and cached
clock rate, therefore, it can smoothly dismiss the mismatching problem.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 4 ++--
 drivers/interconnect/qcom/icc-rpm.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 34125e8f8b60..e0309e246523 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -274,7 +274,7 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 	do_div(rate, qn->buswidth);
 	rate = min_t(u64, rate, LONG_MAX);
 
-	if (qn->rate == rate)
+	if (qp->bus_clk_rate == rate)
 		return 0;
 
 	for (i = 0; i < qp->num_clks; i++) {
@@ -286,7 +286,7 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 		}
 	}
 
-	qn->rate = rate;
+	qp->bus_clk_rate = rate;
 
 	return 0;
 }
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 26dad006034f..4457fcc5b84c 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -26,6 +26,7 @@ enum qcom_icc_type {
  * @type: the ICC provider type
  * @qos_offset: offset to QoS registers
  * @regmap: regmap for QoS registers read/write access
+ * @bus_clk_rate: bus clock rate in Hz
  */
 struct qcom_icc_provider {
 	struct icc_provider provider;
@@ -33,6 +34,7 @@ struct qcom_icc_provider {
 	enum qcom_icc_type type;
 	struct regmap *regmap;
 	unsigned int qos_offset;
+	u64 bus_clk_rate;
 	struct clk_bulk_data bus_clks[];
 };
 
@@ -66,7 +68,6 @@ struct qcom_icc_qos {
  * @mas_rpm_id:	RPM id for devices that are bus masters
  * @slv_rpm_id:	RPM id for devices that are bus slaves
  * @qos: NoC QoS setting parameters
- * @rate: current bus clock rate in Hz
  */
 struct qcom_icc_node {
 	unsigned char *name;
@@ -77,7 +78,6 @@ struct qcom_icc_node {
 	int mas_rpm_id;
 	int slv_rpm_id;
 	struct qcom_icc_qos qos;
-	u64 rate;
 };
 
 struct qcom_icc_desc {
-- 
2.25.1

