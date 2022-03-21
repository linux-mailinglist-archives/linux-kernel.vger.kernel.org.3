Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864F24E34B9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbiCUXro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbiCUXqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:46:52 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB3791ACD;
        Mon, 21 Mar 2022 16:45:25 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id j13-20020a05600c1c0d00b0038c8f94aac2so461571wms.3;
        Mon, 21 Mar 2022 16:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qACBw0o2MS9FzPU5J+S+Zvtw1uM7Qy8GLYaDlXl8cVc=;
        b=iw4y1sosX82Uo7ZrwSqURxgcrLwJCvxn4uZoH3seSgje+Ees4ov9mTKU6d9ywwq5aI
         ywxWQmy8rDQtQza0VIJkaP/n9uVWm8JNIZSRt+z25JKHsnUudVhUgGSdzvIV4nzfQMOP
         6+dRijY7DZ4+LIhGrN6nGekLsEYXl0/Kej861IGv3SxJRvQCjKNObHlTqM0fVtkcH2kt
         2q6DkLoEttaT6u+wE2bLgU3HbsvhbK+mCDu/SAwoR7lu3/jDgqXxJzpaFo86b/OorIgP
         ISrptaYCONGiPSS/hebIU4MxMaHDT1iC+SHWMB6p+7oc0+4R6+lQWSnfg835+zkiqEmS
         Y1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qACBw0o2MS9FzPU5J+S+Zvtw1uM7Qy8GLYaDlXl8cVc=;
        b=eCDoosUc3642FZdFyiNABzcgqLLh3F21xTRyTTQ2pCESyRYzanWXUSU+picVG8uVhG
         FQAze3IY5vuCC/R50KMMBrEI0GxoXZIWreuKqz+rrDfwcdbTN8I1DF5nyzwMT1rv6lVD
         qHQvS3yHMEjSlRM03A1CKtJftyKjRXFugLFVaFU3DMuPjKKgR4FcOHMRsBwmVux3y15J
         /5MD8aRoepgyBXvlwfgDZB4e5sotaPe0qkshUuHHimxsT+tB2ezqMk9C153y4gTYhX89
         PzRm4lrS23e1W/foGzP302g5LzZ2imsCX+rNT48gVosdp8XgHYTFT+Kh3QbT2HFd9HJ+
         PBBg==
X-Gm-Message-State: AOAM530TZZRcmvHF5JAxMOlsqs4CRRtVdeqmUjITe9F04mWPRBSJY3q6
        Bp2+TcjK/S4z5k1AW5A4gRg1iXtPdIM=
X-Google-Smtp-Source: ABdhPJyc6HIlSVB3CoyWYcnXdbT1/VUCA3ga7IMCIxjAuQXe/ByImscn1BxBBGeNjhxgth3dsqjwqQ==
X-Received: by 2002:a05:600c:2146:b0:38c:ab68:1919 with SMTP id v6-20020a05600c214600b0038cab681919mr1273044wml.52.1647906323799;
        Mon, 21 Mar 2022 16:45:23 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id n10-20020a5d588a000000b002052e4aaf89sm105497wrf.80.2022.03.21.16.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 16:45:23 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v6 11/18] clk: qcom: krait-cc: force sec_mux to QSB
Date:   Tue, 22 Mar 2022 00:15:41 +0100
Message-Id: <20220321231548.14276-12-ansuelsmth@gmail.com>
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

