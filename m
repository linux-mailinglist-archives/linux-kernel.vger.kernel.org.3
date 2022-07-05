Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C56566393
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 09:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiGEHBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiGEHA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:00:56 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAE811C07
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:00:55 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id i8-20020a17090a4b8800b001ef8a65bfbdso4101835pjh.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 00:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yne49kj4HQHNC6O00jzXvoEbyLaflHJsRm88BUWfTRA=;
        b=MVk6ugHg/PsAUBgTbj5ES8HglG1EVcnPkitNAK3zaiR4Vmr9/p1WzQ8DajGvAG0Smx
         SaE7JeE3gyz/lsQUd0jvG3zOMeDbA+NgoImSRfMn3oIa5qUtoE2a2X/utbeCfsp9IDG6
         Qpjm/6DnRtLIxO24wPS93MxGXo2sRA6MFmYjIscJ3YtoK4+alR3s6qBle2VCbMu8yf8m
         NO6B9BMIPJpMhmeHdpx+xBwXX8hXnPE78dlZf0+0Bl8cddT0to95XAFKbhrWGPCNZOEi
         F47n112KYmLdtqm8jD81BfpE4298b24o919ZHQLr8NutTChyMDeFvFI2GlDIuuA9On7g
         9G1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yne49kj4HQHNC6O00jzXvoEbyLaflHJsRm88BUWfTRA=;
        b=I6lXxJyEOuuWsQh70JsR+tNNRdWCt6S6JdISikIBeB3JkwZHm0W2ZTv5/Ecj8cmbzw
         yoxBlkLWMnnKLk8cZC8EZ/nydHqR9UB1eWM8ebrsMRUI8lkwc+mGcrSY9YVtuxDmZAHk
         Oeo0rSNpMwQPZMFee6HpFywLRFRrN3/8veHnyZ0nMhMwlORicWyxj+t9nc73l9A1Xu/K
         XSK4PGBaouzvEQzV/+uqBMSNfsqXzTJS8TokyZQOxWyVJ7ACtYP/u2pElDGdkz4rrqvz
         xWgejEqtLOzM6XHsJznW96ngu6g07qPn3T4XXKhcUFtGX9xCvf/6LriKJsqRxOY/GOBj
         cG7w==
X-Gm-Message-State: AJIora/HWIv6BbBdJtfCQ0hPJ0NlMzFL5Up5jbwR5A0fsW1gKAnwoloy
        Env/7S9g/ncz3qZlKcoPCQPofg==
X-Google-Smtp-Source: AGRyM1tpszP8t3guUioLy0gqcXoXDweT4feRKVPX/H1jc/zN/5TI9ZdMvol1LMS3SbaG/KoBGayG/A==
X-Received: by 2002:a17:902:6b41:b0:16a:55f6:95ee with SMTP id g1-20020a1709026b4100b0016a55f695eemr40987923plt.156.1657004454759;
        Tue, 05 Jul 2022 00:00:54 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id l22-20020a17090a3f1600b001ecfa85c8f0sm11564120pjc.26.2022.07.05.00.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 00:00:54 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 08/13] OPP: Add key specific assert() method to key finding helpers
Date:   Tue,  5 Jul 2022 12:30:11 +0530
Message-Id: <1428eae4e3d3454eed6fccf1c53435402c102f4c.1657003420.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1657003420.git.viresh.kumar@linaro.org>
References: <cover.1657003420.git.viresh.kumar@linaro.org>
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

The helpers for the clock key, at least, would need to assert that the
helpers are called only for single clock case. Prepare for that by
adding an argument to the key finding helpers.

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 52 +++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 261f5e1abfe1..e1696cf63409 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -481,10 +481,15 @@ static struct dev_pm_opp *_opp_table_find_key(struct opp_table *opp_table,
 		unsigned long *key, int index, bool available,
 		unsigned long (*read)(struct dev_pm_opp *opp, int index),
 		bool (*compare)(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
-				unsigned long opp_key, unsigned long key))
+				unsigned long opp_key, unsigned long key),
+		bool (*assert)(struct opp_table *opp_table))
 {
 	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
 
+	/* Assert that the requirement is met */
+	if (assert && !assert(opp_table))
+		return ERR_PTR(-EINVAL);
+
 	mutex_lock(&opp_table->lock);
 
 	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
@@ -509,7 +514,8 @@ static struct dev_pm_opp *
 _find_key(struct device *dev, unsigned long *key, int index, bool available,
 	  unsigned long (*read)(struct dev_pm_opp *opp, int index),
 	  bool (*compare)(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
-			  unsigned long opp_key, unsigned long key))
+			  unsigned long opp_key, unsigned long key),
+	  bool (*assert)(struct opp_table *opp_table))
 {
 	struct opp_table *opp_table;
 	struct dev_pm_opp *opp;
@@ -522,7 +528,7 @@ _find_key(struct device *dev, unsigned long *key, int index, bool available,
 	}
 
 	opp = _opp_table_find_key(opp_table, key, index, available, read,
-				  compare);
+				  compare, assert);
 
 	dev_pm_opp_put_opp_table(opp_table);
 
@@ -531,35 +537,42 @@ _find_key(struct device *dev, unsigned long *key, int index, bool available,
 
 static struct dev_pm_opp *_find_key_exact(struct device *dev,
 		unsigned long key, int index, bool available,
-		unsigned long (*read)(struct dev_pm_opp *opp, int index))
+		unsigned long (*read)(struct dev_pm_opp *opp, int index),
+		bool (*assert)(struct opp_table *opp_table))
 {
 	/*
 	 * The value of key will be updated here, but will be ignored as the
 	 * caller doesn't need it.
 	 */
-	return _find_key(dev, &key, index, available, read, _compare_exact);
+	return _find_key(dev, &key, index, available, read, _compare_exact,
+			 assert);
 }
 
 static struct dev_pm_opp *_opp_table_find_key_ceil(struct opp_table *opp_table,
 		unsigned long *key, int index, bool available,
-		unsigned long (*read)(struct dev_pm_opp *opp, int index))
+		unsigned long (*read)(struct dev_pm_opp *opp, int index),
+		bool (*assert)(struct opp_table *opp_table))
 {
 	return _opp_table_find_key(opp_table, key, index, available, read,
-				   _compare_ceil);
+				   _compare_ceil, assert);
 }
 
 static struct dev_pm_opp *_find_key_ceil(struct device *dev, unsigned long *key,
 		int index, bool available,
-		unsigned long (*read)(struct dev_pm_opp *opp, int index))
+		unsigned long (*read)(struct dev_pm_opp *opp, int index),
+		bool (*assert)(struct opp_table *opp_table))
 {
-	return _find_key(dev, key, index, available, read, _compare_ceil);
+	return _find_key(dev, key, index, available, read, _compare_ceil,
+			 assert);
 }
 
 static struct dev_pm_opp *_find_key_floor(struct device *dev,
 		unsigned long *key, int index, bool available,
-		unsigned long (*read)(struct dev_pm_opp *opp, int index))
+		unsigned long (*read)(struct dev_pm_opp *opp, int index),
+		bool (*assert)(struct opp_table *opp_table))
 {
-	return _find_key(dev, key, index, available, read, _compare_floor);
+	return _find_key(dev, key, index, available, read, _compare_floor,
+			 assert);
 }
 
 /**
@@ -588,14 +601,15 @@ static struct dev_pm_opp *_find_key_floor(struct device *dev,
 struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 		unsigned long freq, bool available)
 {
-	return _find_key_exact(dev, freq, 0, available, _read_freq);
+	return _find_key_exact(dev, freq, 0, available, _read_freq, NULL);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_exact);
 
 static noinline struct dev_pm_opp *_find_freq_ceil(struct opp_table *opp_table,
 						   unsigned long *freq)
 {
-	return _opp_table_find_key_ceil(opp_table, freq, 0, true, _read_freq);
+	return _opp_table_find_key_ceil(opp_table, freq, 0, true, _read_freq,
+					NULL);
 }
 
 /**
@@ -619,7 +633,7 @@ static noinline struct dev_pm_opp *_find_freq_ceil(struct opp_table *opp_table,
 struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 					     unsigned long *freq)
 {
-	return _find_key_ceil(dev, freq, 0, true, _read_freq);
+	return _find_key_ceil(dev, freq, 0, true, _read_freq, NULL);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_ceil);
 
@@ -644,7 +658,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_ceil);
 struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 					      unsigned long *freq)
 {
-	return _find_key_floor(dev, freq, 0, true, _read_freq);
+	return _find_key_floor(dev, freq, 0, true, _read_freq, NULL);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
 
@@ -666,7 +680,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
 struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
 					       unsigned int level)
 {
-	return _find_key_exact(dev, level, 0, true, _read_level);
+	return _find_key_exact(dev, level, 0, true, _read_level, NULL);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_exact);
 
@@ -691,7 +705,7 @@ struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
 	unsigned long temp = *level;
 	struct dev_pm_opp *opp;
 
-	opp = _find_key_ceil(dev, &temp, 0, true, _read_level);
+	opp = _find_key_ceil(dev, &temp, 0, true, _read_level, NULL);
 	*level = temp;
 	return opp;
 }
@@ -722,7 +736,7 @@ struct dev_pm_opp *dev_pm_opp_find_bw_ceil(struct device *dev, unsigned int *bw,
 	unsigned long temp = *bw;
 	struct dev_pm_opp *opp;
 
-	opp = _find_key_ceil(dev, &temp, index, true, _read_bw);
+	opp = _find_key_ceil(dev, &temp, index, true, _read_bw, NULL);
 	*bw = temp;
 	return opp;
 }
@@ -753,7 +767,7 @@ struct dev_pm_opp *dev_pm_opp_find_bw_floor(struct device *dev,
 	unsigned long temp = *bw;
 	struct dev_pm_opp *opp;
 
-	opp = _find_key_floor(dev, &temp, index, true, _read_bw);
+	opp = _find_key_floor(dev, &temp, index, true, _read_bw, NULL);
 	*bw = temp;
 	return opp;
 }
-- 
2.31.1.272.g89b43f80a514

