Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99695545ED4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347049AbiFJIY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347657AbiFJIYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:24:21 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A6B3F6EF8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:21:22 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s135so8488493pgs.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 01:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LHHuKFlrfiwau/eix3fAQG/B41w5f5VbH6st3U+c9yg=;
        b=qpRmeBDFnpX+0rY9SPHC4csJPf3+qr18qzno5cixRFke77gbJUAkX/VMqrLgU6AXz8
         AVoPCidOJ5FJ6OCUtZOFEUJzbajcL58+Uo4SAMH5O1KZwIhMT+hkHvsUPlLEmZ/Hdy7z
         ttAeeW6fBuTZ61Ip3SLGhRrDJmu//KCr/lbwYeX5QbVlFnH/R+etNSOLv5Luz/YHeV9b
         PvtMra1SxtNGVebOXEatzvyGuSxHyoWYs+vzozH7lDgEZuoP219BrvEYCHD7LqcQeaWS
         I67XKVdw4zP3xKQpBcCUYvdTx0cjLEOmiSAka21bQLLYTrXymehCuzA4gmtqiPz8p8Pt
         zn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LHHuKFlrfiwau/eix3fAQG/B41w5f5VbH6st3U+c9yg=;
        b=ujVnSr0knM//hfzOW5HHlO5Flb+9l2fWLjuFqP3/mzFCA3e6BCRmL0d10fHeOI7Ywt
         r2FclVoqi7II/EmDE3bRDJg7zOA+CmJSVa9EsjqKpNZluEqgBD1GYNB63hOIv9fRCIC8
         TwURFFKhmxAeRCe6r7rK0kmpJfkabBv+06jpGNL6gNsJkBsSfqv+7qzA3kXeiLNybW4c
         BCeKdXB14JbPAz8F/M3V5dti/JqQaiLhZl6ErRZnVAz4OKImbjW/KOMMPmTDXDaMd/LM
         Anhq8NgHXi2nk86vJ4TmbpLLzucnXg10qvGY+LCf7VKIClBKm5hmWOC4AKH1cNjKDT0h
         ZYOA==
X-Gm-Message-State: AOAM533uTJmnLPgOOs4ixk0y8m17cmS7FiLISW89BTvDtYmdaTLe6l0U
        rXZn3clTQFZwUzXrmVxYa3zS5MRZcoJPgw==
X-Google-Smtp-Source: ABdhPJw8Dg0/0KuozXdpvKCtDw5sE3Runm5YTRBLrbg/SZwW+IZDbktvS84eJDcilFAzRr6i6aPRuw==
X-Received: by 2002:a63:fd48:0:b0:3fd:a873:aae4 with SMTP id m8-20020a63fd48000000b003fda873aae4mr23306412pgj.492.1654849281898;
        Fri, 10 Jun 2022 01:21:21 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id o62-20020a17090a0a4400b001e2b19e6cfesm1092544pjo.12.2022.06.10.01.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 01:21:21 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] OPP: Add key specific assert() method to key finding helpers
Date:   Fri, 10 Jun 2022 13:50:50 +0530
Message-Id: <6afbc4c795216b31c200ae0c19072403a1caab2f.1654849214.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1654849214.git.viresh.kumar@linaro.org>
References: <cover.1654849214.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helpers for the clock key, at least, would need to assert that the
helpers are called only for single clock case. Prepare for that by
adding an argument to the key finding helpers.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 56 +++++++++++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 20 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 1e143bd8e589..b8e6dc0a9b36 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -477,10 +477,15 @@ static struct dev_pm_opp *_opp_table_find_key(struct opp_table *opp_table,
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
@@ -505,7 +510,8 @@ static struct dev_pm_opp *
 _find_key(struct device *dev, unsigned long *key, int index, bool available,
 	  unsigned long (*read)(struct dev_pm_opp *opp, int index),
 	  bool (*compare)(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
-			  unsigned long opp_key, unsigned long key))
+			  unsigned long opp_key, unsigned long key),
+	  bool (*assert)(struct opp_table *opp_table))
 {
 	struct opp_table *opp_table;
 	struct dev_pm_opp *opp;
@@ -518,7 +524,7 @@ _find_key(struct device *dev, unsigned long *key, int index, bool available,
 	}
 
 	opp = _opp_table_find_key(opp_table, key, index, available, read,
-				  compare);
+				  compare, assert);
 
 	dev_pm_opp_put_opp_table(opp_table);
 
@@ -527,35 +533,42 @@ _find_key(struct device *dev, unsigned long *key, int index, bool available,
 
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
@@ -584,14 +597,15 @@ static struct dev_pm_opp *_find_key_floor(struct device *dev,
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
@@ -615,7 +629,7 @@ static noinline struct dev_pm_opp *_find_freq_ceil(struct opp_table *opp_table,
 struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
 					     unsigned long *freq)
 {
-	return _find_key_ceil(dev, freq, 0, true, _read_freq);
+	return _find_key_ceil(dev, freq, 0, true, _read_freq, NULL);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_ceil);
 
@@ -640,7 +654,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_ceil);
 struct dev_pm_opp *dev_pm_opp_find_freq_floor(struct device *dev,
 					      unsigned long *freq)
 {
-	return _find_key_floor(dev, freq, 0, true, _read_freq);
+	return _find_key_floor(dev, freq, 0, true, _read_freq, NULL);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
 
@@ -662,7 +676,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_floor);
 struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
 					       unsigned int level)
 {
-	return _find_key_exact(dev, level, 0, true, _read_level);
+	return _find_key_exact(dev, level, 0, true, _read_level, NULL);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_exact);
 
@@ -684,8 +698,8 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_exact);
 struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
 					      unsigned int *level)
 {
-	return _find_key_ceil(dev, (unsigned long *)level, 0, true,
-			      _read_level);
+	return _find_key_ceil(dev, (unsigned long *)level, 0, true, _read_level,
+			      NULL);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_ceil);
 
@@ -711,7 +725,8 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_ceil);
 struct dev_pm_opp *dev_pm_opp_find_bw_ceil(struct device *dev, unsigned int *bw,
 					   int index)
 {
-	return _find_key_ceil(dev, (unsigned long *)bw, index, true, _read_bw);
+	return _find_key_ceil(dev, (unsigned long *)bw, index, true, _read_bw,
+			      NULL);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_bw_ceil);
 
@@ -737,7 +752,8 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_find_bw_ceil);
 struct dev_pm_opp *dev_pm_opp_find_bw_floor(struct device *dev,
 					    unsigned int *bw, int index)
 {
-	return _find_key_floor(dev, (unsigned long *)bw, index, true, _read_bw);
+	return _find_key_floor(dev, (unsigned long *)bw, index, true, _read_bw,
+			       NULL);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_bw_floor);
 
-- 
2.31.1.272.g89b43f80a514

