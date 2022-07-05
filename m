Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057D456633F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 08:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiGEGiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 02:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiGEGh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 02:37:59 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D8911A1E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 23:37:58 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t5-20020a17090a6a0500b001ef965b262eso1315787pjj.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 23:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mcN5aWF/+F7X9Dd6NAzqDokTXFgMVn5D4Bvd5NBE264=;
        b=VJGq5G0/CDZRAMAODM6TfM4aIIch7aVu0lmqTWD4KxBuCoZ3DtXshzKbGvH0pTJCkk
         kqOPW/s0S3SstmRjP5V7qA1hI0jhELXOGvgmzo7ueKs7DgvgDtYl8hfd8xmXjRbZL4hB
         qx+xXyuh4PHs/3EZuM5T382nVrxnyBuewtQJ9aFNq53Jym+SYUY4EEfiJGi5fCEewGyZ
         Etm10IzQX44BALDRFy4ygoxAdgpQm2Z3WfZI1RURwKzKMq5BkQD0InTarsSRbC9+SRgi
         Nlv4O36UZuuxbgADmoIAQofXtqho+3p2KD0CwI4cw0KdbxYShx4ARrsIYu1JyhHlYoKe
         AIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mcN5aWF/+F7X9Dd6NAzqDokTXFgMVn5D4Bvd5NBE264=;
        b=Q73xL+hYFh5BuragO2jm1XYQhxQNWbyNPE18m60Gqg7tZ6Vr42P2XPEz5r3KxIFZFO
         pXULa/QwaKTfMbg6EM59+pa7HZap8UKLBPzNEEqjg8EeStIWEqPGDhtxAhQ/Divn6y/d
         UxXElj1OyUp/mJ5tNim0oVAsi50vjp3zrIrOlY8j1kkj/vS0PqRx1EHCr1FcxpCg+zRh
         w0HfX6dhwi1q8O4DBq/egCGWNJQwIPqp8Agrdyd1jebJMgpvXYU06GzidEH+zxRPkj+k
         HjjRgHD1/PctyeUWy3Mm2lwvUaGNpqaiAQdQ9li5mTC3jE7rcpRpycr5BDsiHUQbr3v6
         5VQg==
X-Gm-Message-State: AJIora+2MWLVov2vEO2foBzfbwLCtprGXV5FzfCUfsYouvKco1Dm/yAh
        ZywgcFTIZO+G5Mav7cofqjYycw==
X-Google-Smtp-Source: AGRyM1s6eL8w4tjHdNsJxvPP4VeAZaAPooYVPfK1Mk2uaInhFxM7fBf4tBdImNj41uKdR3Yv7hf81w==
X-Received: by 2002:a17:90b:4c49:b0:1ec:e8a2:b5f0 with SMTP id np9-20020a17090b4c4900b001ece8a2b5f0mr40764256pjb.21.1657003077666;
        Mon, 04 Jul 2022 23:37:57 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902780600b0016a4db13429sm22464251pll.192.2022.07.04.23.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 23:37:57 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 4/4] OPP: Use generic key finding helpers for bandwidth key
Date:   Tue,  5 Jul 2022 12:07:40 +0530
Message-Id: <c26b8501250a39a64a27330ec5888a355ab6c9d4.1657002904.git.viresh.kumar@linaro.org>
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

Use the recently added generic key findings helpers to find bandwidth
key values.

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 83 +++++++++-------------------------------------
 1 file changed, 15 insertions(+), 68 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 968fdbbc0693..5ad43dbfd87f 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -438,6 +438,11 @@ static unsigned long _read_level(struct dev_pm_opp *opp, int index)
 	return opp->level;
 }
 
+static unsigned long _read_bw(struct dev_pm_opp *opp, int index)
+{
+	return opp->bandwidth[index].peak;
+}
+
 /* Generic comparison helpers */
 static bool _compare_exact(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
 			   unsigned long opp_key, unsigned long key)
@@ -711,42 +716,14 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_ceil);
  * The callers are required to call dev_pm_opp_put() for the returned OPP after
  * use.
  */
-struct dev_pm_opp *dev_pm_opp_find_bw_ceil(struct device *dev,
-					   unsigned int *bw, int index)
+struct dev_pm_opp *dev_pm_opp_find_bw_ceil(struct device *dev, unsigned int *bw,
+					   int index)
 {
-	struct opp_table *opp_table;
-	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
-
-	if (!dev || !bw) {
-		dev_err(dev, "%s: Invalid argument bw=%p\n", __func__, bw);
-		return ERR_PTR(-EINVAL);
-	}
-
-	opp_table = _find_opp_table(dev);
-	if (IS_ERR(opp_table))
-		return ERR_CAST(opp_table);
-
-	if (index >= opp_table->path_count)
-		return ERR_PTR(-EINVAL);
-
-	mutex_lock(&opp_table->lock);
-
-	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
-		if (temp_opp->available && temp_opp->bandwidth) {
-			if (temp_opp->bandwidth[index].peak >= *bw) {
-				opp = temp_opp;
-				*bw = opp->bandwidth[index].peak;
-
-				/* Increment the reference count of OPP */
-				dev_pm_opp_get(opp);
-				break;
-			}
-		}
-	}
-
-	mutex_unlock(&opp_table->lock);
-	dev_pm_opp_put_opp_table(opp_table);
+	unsigned long temp = *bw;
+	struct dev_pm_opp *opp;
 
+	opp = _find_key_ceil(dev, &temp, index, true, _read_bw);
+	*bw = temp;
 	return opp;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_bw_ceil);
@@ -773,41 +750,11 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_find_bw_ceil);
 struct dev_pm_opp *dev_pm_opp_find_bw_floor(struct device *dev,
 					    unsigned int *bw, int index)
 {
-	struct opp_table *opp_table;
-	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
-
-	if (!dev || !bw) {
-		dev_err(dev, "%s: Invalid argument bw=%p\n", __func__, bw);
-		return ERR_PTR(-EINVAL);
-	}
-
-	opp_table = _find_opp_table(dev);
-	if (IS_ERR(opp_table))
-		return ERR_CAST(opp_table);
-
-	if (index >= opp_table->path_count)
-		return ERR_PTR(-EINVAL);
-
-	mutex_lock(&opp_table->lock);
-
-	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
-		if (temp_opp->available && temp_opp->bandwidth) {
-			/* go to the next node, before choosing prev */
-			if (temp_opp->bandwidth[index].peak > *bw)
-				break;
-			opp = temp_opp;
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
-		*bw = opp->bandwidth[index].peak;
+	unsigned long temp = *bw;
+	struct dev_pm_opp *opp;
 
+	opp = _find_key_floor(dev, &temp, index, true, _read_bw);
+	*bw = temp;
 	return opp;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_bw_floor);
-- 
2.31.1.272.g89b43f80a514

