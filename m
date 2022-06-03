Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3FC53C4D3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 08:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241441AbiFCGUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 02:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241395AbiFCGUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 02:20:37 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75B433355
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 23:20:34 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id n8so6215223plh.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 23:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AJWbZrhYBBK/nZwEp8oEDzNVeqkUQnXH1sic0IKz15o=;
        b=FYJXrijbSyRV9DxoEDjyD5K0VwHrFPs2Rxn229GB700FpcNUBGlnxk/4+4TUtNVXTs
         EFykN0qpLNv4lF0FHxHrVyKOCkp4oe4UbnbRR9/X0CMmPhS4DDKsGO+dpFn1ZG3o9PS5
         1uDP0ePVuxajD0juj1+hWAR+JjeUm25WCnRdEr83g5g+kOG40UKKZ94YRoTcaUucAbBU
         ewE+Fvz4B6TpBOq8OwgaGUcTFgA6Cvgt+xfZ9wy7zhMztaGUUV2awuWnykBWGFJ13HOt
         qSkUtbilU1K7oM4WKjgwp2ZX8Y00mqlg9VqSmBTzJo7HBkul5J5NYTHCvALlNns6ci7l
         pjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AJWbZrhYBBK/nZwEp8oEDzNVeqkUQnXH1sic0IKz15o=;
        b=2nIoTjPLTWNFMgLsnuiq5/8qk4ZAqEfhjCTHShE0abglF6J5vbi/V5oTjYQXdy/4Hq
         Wkg3fKp/Dqr+jIg3gDTmZ/tFUzprS6xDmUU4fkpWbIxlZBjznT81ES+GEHNlKXVKrOzV
         AJrzxADD1T/CxpECujg7BqetVS/DKaaCFCc4ggUZc3s130NBBRSZQw0jffKWZ2VP3jzO
         MI8dKj5nRZYdhOFtMOE4PwB3Yphq1ZDJky9U3Lsdl0Zoqm9lw2n/fCirXC2y90iCfBrd
         3p/V2oW2tei6hRLIgpqfJGe9HyTJb6iP3IbKy6PHXgQgF4Ve+Q9wB7Jcy21FohzXCVzW
         0LXA==
X-Gm-Message-State: AOAM530BGnwUKjC9/64ECT4IrxgHGZAALkMrq+ELV9U2fc8H/iosWjCt
        g6PZnMMQpqIt/y3YanlPdr6dJg==
X-Google-Smtp-Source: ABdhPJx6Fes6DwkCQHCVRV+H/LydnWY82HwtV8Rol5UHgNxnFTNnHK9lxTrRfSlmwBiUM6XO+kBz6g==
X-Received: by 2002:a17:902:db0a:b0:167:466e:b72c with SMTP id m10-20020a170902db0a00b00167466eb72cmr2387021plx.172.1654237234341;
        Thu, 02 Jun 2022 23:20:34 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id r14-20020a63ec4e000000b003fb0354c43asm4387425pgj.32.2022.06.02.23.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 23:20:33 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] OPP: Use generic key finding helpers for freq key
Date:   Fri,  3 Jun 2022 11:50:17 +0530
Message-Id: <7bbf461f918b62867305f7ede05ee6691246f3e9.1654235445.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1654235445.git.viresh.kumar@linaro.org>
References: <cover.1654235445.git.viresh.kumar@linaro.org>
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

Use the recently added generic key findings helpers to find frequency
key values.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 113 ++++-----------------------------------------
 1 file changed, 8 insertions(+), 105 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 7ef6eafc7946..2e6cb2abf0b9 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -575,62 +575,16 @@ _find_key_floor(struct device *dev, unsigned long *key, int index, bool availabl
  * The callers are required to call dev_pm_opp_put() for the returned OPP after
  * use.
  */
-struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
-					      unsigned long freq,
+struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev, unsigned long freq,
 					      bool available)
 {
-	struct opp_table *opp_table;
-	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
-
-	opp_table = _find_opp_table(dev);
-	if (IS_ERR(opp_table)) {
-		int r = PTR_ERR(opp_table);
-
-		dev_err(dev, "%s: OPP table not found (%d)\n", __func__, r);
-		return ERR_PTR(r);
-	}
-
-	mutex_lock(&opp_table->lock);
-
-	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
-		if (temp_opp->available == available &&
-				temp_opp->rate == freq) {
-			opp = temp_opp;
-
-			/* Increment the reference count of OPP */
-			dev_pm_opp_get(opp);
-			break;
-		}
-	}
-
-	mutex_unlock(&opp_table->lock);
-	dev_pm_opp_put_opp_table(opp_table);
-
-	return opp;
+	return _find_key_exact(dev, freq, 0, available, _read_freq);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_exact);
 
-static noinline struct dev_pm_opp *_find_freq_ceil(struct opp_table *opp_table,
-						   unsigned long *freq)
+static noinline struct dev_pm_opp *_find_freq_ceil(struct opp_table *opp_table, unsigned long *freq)
 {
-	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
-
-	mutex_lock(&opp_table->lock);
-
-	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
-		if (temp_opp->available && temp_opp->rate >= *freq) {
-			opp = temp_opp;
-			*freq = opp->rate;
-
-			/* Increment the reference count of OPP */
-			dev_pm_opp_get(opp);
-			break;
-		}
-	}
-
-	mutex_unlock(&opp_table->lock);
-
-	return opp;
+	return _opp_table_find_key_ceil(opp_table, freq, 0, true, _read_freq);
 }
 
 /**
@@ -651,26 +605,9 @@ static noinline struct dev_pm_opp *_find_freq_ceil(struct opp_table *opp_table,
  * The callers are required to call dev_pm_opp_put() for the returned OPP after
  * use.
  */
-struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
-					     unsigned long *freq)
+struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev, unsigned long *freq)
 {
-	struct opp_table *opp_table;
-	struct dev_pm_opp *opp;
-
-	if (!dev || !freq) {
-		dev_err(dev, "%s: Invalid argument freq=%p\n", __func__, freq);
-		return ERR_PTR(-EINVAL);
-	}
-
-	opp_table = _find_opp_table(dev);
-	if (IS_ERR(opp_table))
-		return ERR_CAST(opp_table);
-
-	opp = _find_freq_ceil(opp_table, freq);
-
-	dev_pm_opp_put_opp_table(opp_table);
-
-	return opp;
+	return _find_key_ceil(dev, freq, 0, true, _read_freq);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_ceil);
 
@@ -692,43 +629,9 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_ceil);
  * The callers are required to call dev_pm_opp_put() for the returned OPP after
  * use.
  */
-struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
-					      unsigned long *freq)
+struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev, unsigned long *freq)
 {
-	struct opp_table *opp_table;
-	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
-
-	if (!dev || !freq) {
-		dev_err(dev, "%s: Invalid argument freq=%p\n", __func__, freq);
-		return ERR_PTR(-EINVAL);
-	}
-
-	opp_table = _find_opp_table(dev);
-	if (IS_ERR(opp_table))
-		return ERR_CAST(opp_table);
-
-	mutex_lock(&opp_table->lock);
-
-	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
-		if (temp_opp->available) {
-			/* go to the next node, before choosing prev */
-			if (temp_opp->rate > *freq)
-				break;
-			else
-				opp = temp_opp;
-		}
-	}
-
-	/* Increment the reference count of OPP */
-	if (!IS_ERR(opp))
-		dev_pm_opp_get(opp);
-	mutex_unlock(&opp_table->lock);
-	dev_pm_opp_put_opp_table(opp_table);
-
-	if (!IS_ERR(opp))
-		*freq = opp->rate;
-
-	return opp;
+	return _find_key_floor(dev, freq, 0, true, _read_freq);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
 
-- 
2.31.1.272.g89b43f80a514

