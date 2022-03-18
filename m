Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1E04DDDD8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238673AbiCRQKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238615AbiCRQKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:10:14 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213C34AE34;
        Fri, 18 Mar 2022 09:08:42 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w4so10797849edc.7;
        Fri, 18 Mar 2022 09:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qACBw0o2MS9FzPU5J+S+Zvtw1uM7Qy8GLYaDlXl8cVc=;
        b=km16Z+cKEwCChOsCYdoT+uvOMbQ2HmYwAtO2zGRyK7DbstRT3h1/6ms7fuDpu62Ga/
         qL4EYXRQk35G9V3lo7mWtk//sWquZsSJ/GW/KHD3VssSJRYzFnsFI8Mjj3sD260zUXUB
         uw3YVQSlwulvIrl49JoCsCbBSDh/E46TQT+NJ7E2UBeRLuzHyrnuYVeBtfc2J13+qAIG
         2ULaLTDL8lGpk7mh8hcQ1AfPeQimMWlgiTrTzU7ElGWqLFAYaRPp3Tq7plqKukXFUKSM
         XonEbpRVIFAaG7PCx8JdUrYSWbkpThZGyunHTat5SyVF/lgxjWO3EbBFwSWgbUw4DMk5
         0wuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qACBw0o2MS9FzPU5J+S+Zvtw1uM7Qy8GLYaDlXl8cVc=;
        b=7SO9pGEOtbOX2qM7lLRP3XipHjWaqG9IGrTJx/+jbYdbiRhcvOw3/qMmJbjHPF9ZJ+
         vNuJT1tBNTDFdaIWHFi+TFRFUM1jC2i5Z8zFbiFOKbyAGyAdQMliJXhdQqzOHoQzPccO
         Hz8We3OlzDOtz8iXLpA4oWIKYnUd22tmXUYG22OGemuIGKztoJ8ZDu/WABw/4Z9jTP/a
         rEhxv4E/+MsEBJFKr2TzvjY5marnppbg34TDmfq9TskH4rQcpz7t3gOm/ql58Put2ECZ
         fzH3yL6ZoE2EUe69Zdf09P3BstRdtrEhpVAEfs8w2FIlaDRSTYl3zAZUeGB7YYbVVRxN
         IpUg==
X-Gm-Message-State: AOAM5318xxfUdj81lyPX+WFPFq8/KY7b4RjsPV7juZXsR9K+5vloYQtw
        DX2dIfGqX1fNwP2oSBdj1XI=
X-Google-Smtp-Source: ABdhPJxaNruxE4aIncRA4vlNPdeo6ao9VEiuNQfFsN99Dk1aZR4Tl+GCx1j+pSAYgH/9l1RbqWYsHQ==
X-Received: by 2002:aa7:de96:0:b0:418:f9ca:67f6 with SMTP id j22-20020aa7de96000000b00418f9ca67f6mr8608415edv.25.1647619720474;
        Fri, 18 Mar 2022 09:08:40 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id e9-20020a170906c00900b006d4a45869basm3754118ejz.199.2022.03.18.09.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 09:08:40 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v2 11/16] clk: qcom: krait-cc: force sec_mux to QSB
Date:   Fri, 18 Mar 2022 17:08:22 +0100
Message-Id: <20220318160827.8860-12-ansuelsmth@gmail.com>
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

