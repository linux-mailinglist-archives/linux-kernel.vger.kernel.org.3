Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8117A56633A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 08:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiGEGiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 02:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiGEGhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 02:37:53 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777C61116C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 23:37:52 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id z1so4411225plb.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 23:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=squH0g0ZyU7acyau8EuY18KsACXTY7LGnn7ZEWB58Lg=;
        b=Y4sqp8vcqK0ALA7AZ9P2jYTozrprGqlIqpn3QMeikjM434aKeOFJjtSOQemje8qnn1
         t+8B4RYTSsgxEsPO5qMnKpf7FwPhNVSSBod+4rHYCbvJmb1mFtLqLptxPYT/8gop3g7c
         aWw8jOjQuTKNBTN+7t7NTgm+gkdEgZcOTtEXkKa7CnjUkJgx1O1MrVF3JNfRRwoLf6Uw
         YOyWlhv5y9YbHkH2XdugJeiuvkSVLnwBbhNcqCWfIA05GvPi4lFJiz/76mdMS76mouv4
         xgXU0F5rZrMbIdCt5LELNyJfQ1lI9HSenLZ3u6slBBOJsYTQRZRIqzVrLHqf8G6tSVRr
         Zhnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=squH0g0ZyU7acyau8EuY18KsACXTY7LGnn7ZEWB58Lg=;
        b=lPHLcuEJUX9w4eOFoNocIDZke1zAyj5irXBajGwdDh1L8wb6yAjsY1Uo+ryU3xRY7U
         hG/XVWe76QyG5dYOXXQFWRVkGAb5K0J0JfT6NY7llocqVSpSb7gbqKcLfShcANpy/A4N
         C4WjPfDlyvb1wBWpyiBA3H2Wqc+EtN7oVkPL7XR6TM3hVHUjH2JtgA5VmFE74hnJ75pJ
         WLLqjhuRNN7Ragh3st3QdFpO7x6512sh1vp5U1bCchzOnuiCErRZjjp6BVUC/PQsRqKG
         2V9Kujd4Ga0YEbvSCOVT3JtptE3acN+Mq3WiLV5ZQhjYKj6iSlshN2vwMcokDaSznt3t
         9oQw==
X-Gm-Message-State: AJIora8sngDcICYFudwtFSTEs5X1wqbCGaihLozC9+QnWFQbf7Ny6fbs
        T/B0hIjzl5alAaiTyzNxFnY2rg==
X-Google-Smtp-Source: AGRyM1vIrbOyKhZN37oEO47IfDs25UzM+FR08FROKrVikQXrvi4krROTDiK3WgvfWn0UZf3yFokTIw==
X-Received: by 2002:a17:902:d701:b0:16a:2206:9ba8 with SMTP id w1-20020a170902d70100b0016a22069ba8mr39319081ply.168.1657003071996;
        Mon, 04 Jul 2022 23:37:51 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id x12-20020a17090a1f8c00b001ef307e1deesm11522008pja.18.2022.07.04.23.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 23:37:51 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/4] OPP: Add generic key finding helpers and use them for freq APIs
Date:   Tue,  5 Jul 2022 12:07:38 +0530
Message-Id: <d8f2353d3bcf079aeff46f519b4557c5edc4823e.1657002904.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1657002904.git.viresh.kumar@linaro.org>
References: <cover.1657002904.git.viresh.kumar@linaro.org>
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

There are three type of helpers, to find exact, ceil, and floor values,
replicated for multiple key types, freq, level, bw. And all of these
helpers share a lot of boilerplate code.

Add generic key finding helpers to reduce code redundancy.

Also update the freq finder helpers to use the new infrastructure.

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 229 +++++++++++++++++++++++++--------------------
 1 file changed, 130 insertions(+), 99 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index fc0232f695c6..c850b8691ee6 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -427,6 +427,131 @@ int dev_pm_opp_get_opp_count(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_opp_count);
 
+/* Helpers to read keys */
+static unsigned long _read_freq(struct dev_pm_opp *opp, int index)
+{
+	return opp->rate;
+}
+
+/* Generic comparison helpers */
+static bool _compare_exact(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
+			   unsigned long opp_key, unsigned long key)
+{
+	if (opp_key == key) {
+		*opp = temp_opp;
+		return true;
+	}
+
+	return false;
+}
+
+static bool _compare_ceil(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
+			  unsigned long opp_key, unsigned long key)
+{
+	if (opp_key >= key) {
+		*opp = temp_opp;
+		return true;
+	}
+
+	return false;
+}
+
+static bool _compare_floor(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
+			   unsigned long opp_key, unsigned long key)
+{
+	if (opp_key > key)
+		return true;
+
+	*opp = temp_opp;
+	return false;
+}
+
+/* Generic key finding helpers */
+static struct dev_pm_opp *_opp_table_find_key(struct opp_table *opp_table,
+		unsigned long *key, int index, bool available,
+		unsigned long (*read)(struct dev_pm_opp *opp, int index),
+		bool (*compare)(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
+				unsigned long opp_key, unsigned long key))
+{
+	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
+
+	mutex_lock(&opp_table->lock);
+
+	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
+		if (temp_opp->available == available) {
+			if (compare(&opp, temp_opp, read(temp_opp, index), *key))
+				break;
+		}
+	}
+
+	/* Increment the reference count of OPP */
+	if (!IS_ERR(opp)) {
+		*key = read(opp, index);
+		dev_pm_opp_get(opp);
+	}
+
+	mutex_unlock(&opp_table->lock);
+
+	return opp;
+}
+
+static struct dev_pm_opp *
+_find_key(struct device *dev, unsigned long *key, int index, bool available,
+	  unsigned long (*read)(struct dev_pm_opp *opp, int index),
+	  bool (*compare)(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
+			  unsigned long opp_key, unsigned long key))
+{
+	struct opp_table *opp_table;
+	struct dev_pm_opp *opp;
+
+	opp_table = _find_opp_table(dev);
+	if (IS_ERR(opp_table)) {
+		dev_err(dev, "%s: OPP table not found (%ld)\n", __func__,
+			PTR_ERR(opp_table));
+		return ERR_CAST(opp_table);
+	}
+
+	opp = _opp_table_find_key(opp_table, key, index, available, read,
+				  compare);
+
+	dev_pm_opp_put_opp_table(opp_table);
+
+	return opp;
+}
+
+static struct dev_pm_opp *_find_key_exact(struct device *dev,
+		unsigned long key, int index, bool available,
+		unsigned long (*read)(struct dev_pm_opp *opp, int index))
+{
+	/*
+	 * The value of key will be updated here, but will be ignored as the
+	 * caller doesn't need it.
+	 */
+	return _find_key(dev, &key, index, available, read, _compare_exact);
+}
+
+static struct dev_pm_opp *_opp_table_find_key_ceil(struct opp_table *opp_table,
+		unsigned long *key, int index, bool available,
+		unsigned long (*read)(struct dev_pm_opp *opp, int index))
+{
+	return _opp_table_find_key(opp_table, key, index, available, read,
+				   _compare_ceil);
+}
+
+static struct dev_pm_opp *_find_key_ceil(struct device *dev, unsigned long *key,
+		int index, bool available,
+		unsigned long (*read)(struct dev_pm_opp *opp, int index))
+{
+	return _find_key(dev, key, index, available, read, _compare_ceil);
+}
+
+static struct dev_pm_opp *_find_key_floor(struct device *dev,
+		unsigned long *key, int index, bool available,
+		unsigned long (*read)(struct dev_pm_opp *opp, int index))
+{
+	return _find_key(dev, key, index, available, read, _compare_floor);
+}
+
 /**
  * dev_pm_opp_find_freq_exact() - search for an exact frequency
  * @dev:		device for which we do this operation
@@ -451,61 +576,16 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_get_opp_count);
  * use.
  */
 struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
-					      unsigned long freq,
-					      bool available)
+		unsigned long freq, bool available)
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
 
 static noinline struct dev_pm_opp *_find_freq_ceil(struct opp_table *opp_table,
 						   unsigned long *freq)
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
@@ -529,23 +609,7 @@ static noinline struct dev_pm_opp *_find_freq_ceil(struct opp_table *opp_table,
 struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 					     unsigned long *freq)
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
 
@@ -570,40 +634,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_ceil);
 struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 					      unsigned long *freq)
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

