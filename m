Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D00F4E2D43
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350727AbiCUQJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350654AbiCUQJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:09:44 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0BE26127;
        Mon, 21 Mar 2022 09:08:19 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l7-20020a05600c1d0700b0038c99618859so1561175wms.2;
        Mon, 21 Mar 2022 09:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8P3wAYvgFlPve71dG0z5aPiI1G8WoaU4vYr3l4vmoOE=;
        b=PRxcN0YNqKTcaPjS0fn0z0+BAh24QLYfgc7tCFaUIUeirq+WgcTYaaPR5xBOBrQ37O
         mZEf5NhpLWOAeOMNXZaAtup6p8iYbmcFAx7+nDcFlzHAOlkbAdbQwvnhidkreZvJSF41
         l3a1SRIp6XOKo+FKzOs0UvjcM45dYZHiRHBURWd9DjYWadg4VTqGfyhnGmZegRf8j72A
         CN1QTPm1JDR8DE659hbJLf42IeiDlmuLP2sBsh1zUqpaHiMRTnhAhyXGhzWBo7KniSJ4
         kPappCdFCUyo95amfaAE5GcJSk5viWXQNqRWRctm+IBlLwI/AMaIc3Zvj6YjwIXOV7nS
         /LsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8P3wAYvgFlPve71dG0z5aPiI1G8WoaU4vYr3l4vmoOE=;
        b=IXuUWMx5sZV37mafhHN4xvO5M3Z0G1Dq07MejXSfPD5bOWfr1r5N26ogGMb+YtQW5H
         cakzyH4wpBwHLep106S92+SaqHJaNC+YhEJYOOu4KgYOhcQL7mQVeo8bL977o4mI9QHM
         HGModriV/zkfuoWGmgbyHHGluQ7r9wVF3RBa2oK63JoRWA2Wo3cuZpsQ/rhU5wfQMVNq
         QW2TY9aHgVkaaSibU7NsHtGQ82WHcWO7kXMlvxCnGPP2f2Wj90ZtdSoqzTKMKumxNTTs
         cgp0LRh7ofg6iyjyiZY+YjMJf2oQYDWXXjGC6uCn6sW0oEs4NEVZu4tpytzRuthX4lZ3
         uhGA==
X-Gm-Message-State: AOAM531XKMSVwKydXvY4j7T93ZH6wnCVKv0CyT93inybgeg4Zk5NTMdG
        sGlB9xgXlMqKLv7MiAtyC7w=
X-Google-Smtp-Source: ABdhPJzmmXYtPahfLRvOnqB6/yj41g20w5qnbJ6O5r6QRbfydnecXu5FG6FeZnUGX9jQvmC42c/tAA==
X-Received: by 2002:a05:600c:4f47:b0:381:6c3e:19dc with SMTP id m7-20020a05600c4f4700b003816c3e19dcmr19786922wmq.155.1647878897647;
        Mon, 21 Mar 2022 09:08:17 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id az19-20020a05600c601300b0038cadf3aa69sm2603864wmb.36.2022.03.21.09.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 09:08:17 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v5 02/18] clk: qcom: gcc-ipq806x: skip pxo/cxo fixed clk if already present
Date:   Mon, 21 Mar 2022 16:38:39 +0100
Message-Id: <20220321153855.12082-3-ansuelsmth@gmail.com>
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

Skip pxo/cxo clock registration if they are already defined in DTS as fixed
clock.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index d6b7adb4be38..27f6d7626abb 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/regmap.h>
 #include <linux/reset-controller.h>
@@ -3061,15 +3062,22 @@ static int gcc_ipq806x_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct regmap *regmap;
+	struct clk *clk;
 	int ret;
 
-	ret = qcom_cc_register_board_clk(dev, "cxo_board", "cxo", 25000000);
-	if (ret)
-		return ret;
+	clk = clk_get(dev, "cxo");
+	if (IS_ERR(clk)) {
+		ret = qcom_cc_register_board_clk(dev, "cxo_board", "cxo", 25000000);
+		if (ret)
+			return ret;
+	}
 
-	ret = qcom_cc_register_board_clk(dev, "pxo_board", "pxo", 25000000);
-	if (ret)
-		return ret;
+	clk = clk_get(dev, "pxo");
+	if (IS_ERR(clk)) {
+		ret = qcom_cc_register_board_clk(dev, "pxo_board", "pxo", 25000000);
+		if (ret)
+			return ret;
+	}
 
 	ret = qcom_cc_probe(pdev, &gcc_ipq806x_desc);
 	if (ret)
-- 
2.34.1

