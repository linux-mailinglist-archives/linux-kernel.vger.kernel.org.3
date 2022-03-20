Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26D24E1CD3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 17:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245625AbiCTQa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 12:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245510AbiCTQ3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 12:29:48 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23C034B82;
        Sun, 20 Mar 2022 09:28:24 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n35so5686727wms.5;
        Sun, 20 Mar 2022 09:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qACBw0o2MS9FzPU5J+S+Zvtw1uM7Qy8GLYaDlXl8cVc=;
        b=Gu96SgxR2BRZgvbcjxwYGKy6KLs/BH8wEZ2sUn683L4g4gYCubbO9u5LI9gwBewJcn
         XyyQNIN54mqyxKfjzgo89gNdSdg1iFgg+RJ9Ue+ohYVTayFhWiIR3KpUKXn5rneGVvo1
         hsQMbGVjug0+D2+ECIvn0x6BCcDUGYoX0GP1IICptqJ+lCDRIi+qoA3C96NfC7JhwSkH
         JuvoxEDGAtEer7VEDSkBvCNRvTQ271wGI4mdcHNsuB2Ut8fXSVyE9Kz+1gyW8iMTSKQ/
         0Kv0Fl32SSo4ENG7vxAad1mFV3Tm2G+qttTxY/0WiUDXEw0tSQAHE73W02GElw4xvErp
         axWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qACBw0o2MS9FzPU5J+S+Zvtw1uM7Qy8GLYaDlXl8cVc=;
        b=TtYZIUTtnaWcjDuIsaqJuHjuqvnX4Oas/PUj3mzwk4i/VGJXywBtxbQ1P9jsiOGY3a
         D1Bfz0fzd/7//R9Ar4JS+TrDOHU8PauWgrIuILogEnkQ6lAEx8u91NuWCZD80icuXyN8
         dG6OnpFyBC6G3h1J8iaJcBcYbwNLqOn7jXwpPSk1JkPpZ6yNYvumZoVS6wfkQkWHV+pa
         zkbbnAWZQvjjFiff47veJ2H5NNgJa0Ko6Qjhe2b5C9KGhpxbqCFESL86CI3G1yeJUjvf
         vuc5jm6EPl1JlxvXJbtiT0ZELrswE3BnXQYRXpmdpnaZsiVzMDULmuZkLsDLvl3P4feI
         LYRw==
X-Gm-Message-State: AOAM5308lrIEtWgkwSY5y85a//tYf1piPTwPx/IJSYzwOeFVJuj2x1HK
        KnAUiSioGQ3eZvJbpTvzF1xdFCg1Qhk=
X-Google-Smtp-Source: ABdhPJyaVqH19TZ8oSCRunHt+DNGlKUL/2HjCU0KAma4v5MBNLdhixUegE+ejMc3iZKqgvp3elvpIw==
X-Received: by 2002:a05:600c:1e0b:b0:38c:9ac5:b486 with SMTP id ay11-20020a05600c1e0b00b0038c9ac5b486mr4652704wmb.71.1647793703357;
        Sun, 20 Mar 2022 09:28:23 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id y6-20020a05600015c600b00203fa70b4ebsm6760085wry.53.2022.03.20.09.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 09:28:22 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 11/18] clk: qcom: krait-cc: force sec_mux to QSB
Date:   Sun, 20 Mar 2022 12:34:23 +0100
Message-Id: <20220320113430.26076-12-ansuelsmth@gmail.com>
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

Now that we have converted every driver to parent_data, it was
notice that the bootloader can't really leave the system in a
strange state where l2 or the cpu0/1 can be sourced in a number of ways
for example cpu1 sourcing out of qsb, l2 sourcing out of pxo.
To correctly reset the mux and the HFPLL force the sec_mux to QSB.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/krait-cc.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/krait-cc.c b/drivers/clk/qcom/krait-cc.c
index 5f98ee1c3681..299eb4c81d96 100644
--- a/drivers/clk/qcom/krait-cc.c
+++ b/drivers/clk/qcom/krait-cc.c
@@ -15,6 +15,8 @@
 
 #include "clk-krait.h"
 
+#define QSB_RATE	1
+
 static unsigned int sec_mux_map[] = {
 	2,
 	0,
@@ -181,6 +183,13 @@ krait_add_sec_mux(struct device *dev, struct clk *qsb, int id,
 	if (ret)
 		clk = ERR_PTR(ret);
 
+	/*
+	 * Force the sec_mux to be set to QSB rate.
+	 * This is needed to correctly set the parents and
+	 * to later reset mux and HFPLL to a known freq.
+	 */
+	clk_set_rate(clk, QSB_RATE);
+
 err_clk:
 	if (unique_aux)
 		kfree(parent_name);
@@ -378,7 +387,7 @@ static int krait_cc_probe(struct platform_device *pdev)
 	 */
 	cur_rate = clk_get_rate(l2_pri_mux_clk);
 	aux_rate = 384000000;
-	if (cur_rate == 1) {
+	if (cur_rate == QSB_RATE) {
 		dev_info(dev, "L2 @ QSB rate. Forcing new rate.\n");
 		cur_rate = aux_rate;
 	}
@@ -389,7 +398,7 @@ static int krait_cc_probe(struct platform_device *pdev)
 	for_each_possible_cpu(cpu) {
 		clk = clks[cpu];
 		cur_rate = clk_get_rate(clk);
-		if (cur_rate == 1) {
+		if (cur_rate == QSB_RATE) {
 			dev_info(dev, "CPU%d @ QSB rate. Forcing new rate.\n", cpu);
 			cur_rate = aux_rate;
 		}
-- 
2.34.1

