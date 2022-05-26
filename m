Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9831534E3A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346362AbiEZLnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344229AbiEZLn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:43:29 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2493B01E
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:43:28 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id f4so1131749pgf.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ICLhiag2MG0TcU1CEpBsvSmVvNH61YfDddhyxbVjdo=;
        b=NW3YMKYJ2u6ZAxIW+TAVBUtdPiLuFvlZHr6YJoG4Ay6ruPQbO0BRBiUMuadLF1tS5P
         rMJvo1tBeBzSFjuOGuz8mSj3DHBFWTfsXKke8DCaoW2seKowZE30sbWA6tL0jdJ/D+Q9
         Ys8sdsQ0yTjrTIANPxf1dmRwCkcC2X3G+MRJeq33yDWVMwB8vGdD1DnM63uZiVDpXKOJ
         mDmI5mHiiXFoi4BauIWA9/v5ynSrigrhSd5WYdnp5hx92XWD18qJhUbiVy1KQTq4VVea
         ZUpDY029BHf3cfjNe1KrQwGqkTW18KxMa0s7lCYmPUaFrwabwBlX2re4xTqmKcWbpRXE
         9JYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ICLhiag2MG0TcU1CEpBsvSmVvNH61YfDddhyxbVjdo=;
        b=ned+bvRCjxdJvMOUPYj2q/h3dbIZFd+9YIQPv2djzstUa0xmZGrnCb9W/FLRBLdCnJ
         XrONYcfJzxuT1AUuxfHEzhXxlngLZJW6/CAmOAgOG1v+VN7AsUikWiYKXZDouVeLXpNy
         GW1QFtpob4W3uvHDI4N2k2r5F+vDB9pOy0LoDi4NIxqohtzc8eUD/mK4veK3KPxYdLm7
         KDHjhtjgJUYddHbkAwR/4uY3su2YLWyLBYCkwwP+/RHkUIjzVjd6/PW6sF6zNFHd7SnF
         +iZLF39ptk3AZRZz34M8xWDLB8MZieFa0imT4yki8TzVCD3r77N2sIS0TqzlTuqO6i4B
         BBSA==
X-Gm-Message-State: AOAM531f2OecohwPZMSRELJGdfTLs3+swkF53diCxiGmuKFhbE6i0lDD
        VM26ohOM3JIUT1etHuOYN1VKug==
X-Google-Smtp-Source: ABdhPJx/KoTEA762ymydMHQN0pjB5UfQPe0kbSUc+S/RuBIuRxVbzsu5Us3zo1Pk5dKcHW0zMevydg==
X-Received: by 2002:a63:eb4e:0:b0:3fb:74d2:92d1 with SMTP id b14-20020a63eb4e000000b003fb74d292d1mr754826pgk.105.1653565407845;
        Thu, 26 May 2022 04:43:27 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902f64100b001618b70dcc9sm1328235plg.101.2022.05.26.04.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:43:27 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/31] OPP: Track if clock name is configured by platform
Date:   Thu, 26 May 2022 17:12:00 +0530
Message-Id: <60d629a2f476598de60e44430ef754f0838ecc9d.1653564321.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1653564321.git.viresh.kumar@linaro.org>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
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

Track if the clock name is configured by the platform or not. This is a
preparatory change and will be used by later commits. This also makes
the behavior of the clkname API similar to other ones, which allow
repeated calls to the same API for each CPU.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 7 +++++++
 drivers/opp/opp.h  | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index ff0364733dcb..254782b3a6a0 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2277,6 +2277,10 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
 		goto err;
 	}
 
+	/* Another CPU that shares the OPP table has set the clkname ? */
+	if (opp_table->clk_configured)
+		return opp_table;
+
 	/* clk shouldn't be initialized at this point */
 	if (WARN_ON(opp_table->clk)) {
 		ret = -EBUSY;
@@ -2291,6 +2295,8 @@ struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
 		goto err;
 	}
 
+	opp_table->clk_configured = true;
+
 	return opp_table;
 
 err:
@@ -2311,6 +2317,7 @@ void dev_pm_opp_put_clkname(struct opp_table *opp_table)
 
 	clk_put(opp_table->clk);
 	opp_table->clk = ERR_PTR(-EINVAL);
+	opp_table->clk_configured = false;
 
 	dev_pm_opp_put_opp_table(opp_table);
 }
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 45e3a55239a1..9e1cfcb0ea98 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -149,6 +149,7 @@ enum opp_table_access {
  * @supported_hw: Array of version number to support.
  * @supported_hw_count: Number of elements in supported_hw array.
  * @prop_name: A name to postfix to many DT properties, while parsing them.
+ * @clk_configured: Clock name is configured by the platform.
  * @clk: Device's clock handle
  * @regulators: Supply regulators
  * @regulator_count: Number of power supply regulators. Its value can be -1
@@ -200,6 +201,7 @@ struct opp_table {
 	unsigned int *supported_hw;
 	unsigned int supported_hw_count;
 	const char *prop_name;
+	bool clk_configured;
 	struct clk *clk;
 	struct regulator **regulators;
 	int regulator_count;
-- 
2.31.1.272.g89b43f80a514

