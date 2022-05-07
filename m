Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D43151E7F2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 17:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442577AbiEGPFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 11:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241703AbiEGPFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 11:05:43 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A165613F31;
        Sat,  7 May 2022 08:01:56 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c11so10019573plg.13;
        Sat, 07 May 2022 08:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tb8lo2vLduedMAIelY9SoqFHYzII084rI2sc4ZhfI0w=;
        b=Z1UWphWLYSdJfNWTpQXTN3ja1m1LkB4vTaFVRUO/sz7uKcTW0Xkc/mJ4cJKCoYZ9IN
         B8fAcJ7WYBd453Go0tCXmFw9GPHJ/4Hlbe1dpOEstb75M+1A/IULV/7Dwpv+2//sIZRI
         nYNpiURGYklzXRHiC9TO29DprH5nm0mo3qd83UHqCr371FQieX23JK4BRlyKYFtWmx9k
         ZA9og3HLGgrAAn5+7tw2aIBV2SB6SWNhGsNcru81H5i6Sw3y3SVcD5vzQ2VkRvAPEnS8
         eStDFk6//GaBUWQ0ZyXBPQfwl0GYuraJByxeDBh6b84uBLKQK39eDhWJLenNXatrFX6g
         mUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tb8lo2vLduedMAIelY9SoqFHYzII084rI2sc4ZhfI0w=;
        b=q4OK7a17GhXmTQeccNCPmwn2foNm7omMZu5CP+ngNj/XWlb/xBUkGjCHeJHiGobI4O
         JGlr0tBI7VsOngH7dPBYEZYqBM9UgmsX/lPWJQkJ/G1bztvgSIwHzKCtsFmu6jsiV7Ay
         JaGHNcnrFveoT9wOndlzQY+N/RztSs1+SUNyF4mqyHjqWsQKzdviYrTHHUa9nryjGipp
         dH2kc04+1GDvyL7IOkHkxgrtfcGJTFucxIROkp3VPfFGWZ8KDVeG9NDNt+rh1v8ycKeV
         HYWFBBTNL/CeRnNjR7l71RCw+Sgwg97mOSre01qE2OpooFgvRJnU8i4GoX8fuxgxJJvK
         nLyA==
X-Gm-Message-State: AOAM533GupoxgDwCFbZOPDVViTz3ODi4dseiDkM0wOTpQ1JM7JPQy+PL
        Q4ghSfGiZcfIr423Hivu88+hbkqa8ZsOCw==
X-Google-Smtp-Source: ABdhPJzRlOQdW++fZyDDzBBsBTIcYF8/3RC5uibjEm39fDftNA1Bw808J3mqWAFi9NhfQB3UuKdg8g==
X-Received: by 2002:a17:902:b698:b0:158:faee:442f with SMTP id c24-20020a170902b69800b00158faee442fmr8815310pls.75.1651935715886;
        Sat, 07 May 2022 08:01:55 -0700 (PDT)
Received: from localhost.localdomain ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id v21-20020a170902ca9500b0015e8d4eb2a8sm3711007pld.242.2022.05.07.08.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 08:01:55 -0700 (PDT)
From:   Chanwoo Choi <cwchoi00@gmail.com>
X-Google-Original-From: Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, johnson.wang@mediatek.com,
        mka@chromium.org, jia-wei.chang@mediatek.com,
        andrew-sh.cheng@mediatek.com, hsinyi@chromium.org,
        sibis@codeaurora.org, saravanak@google.com
Subject: [PATCH v2 1/5] PM / devfreq: Export devfreq_get_freq_range symbol within devfreq
Date:   Sun,  8 May 2022 00:01:41 +0900
Message-Id: <20220507150145.531864-2-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220507150145.531864-1-cw00.choi@samsung.com>
References: <20220507150145.531864-1-cw00.choi@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to get frequency range within devfreq governors,
export devfreq_get_freq_range symbol within devfreq.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/devfreq.c  | 20 ++++++++++++--------
 drivers/devfreq/governor.h |  2 ++
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index a525a609dfc6..01474daf4548 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -112,16 +112,16 @@ static unsigned long find_available_max_freq(struct devfreq *devfreq)
 }
 
 /**
- * get_freq_range() - Get the current freq range
+ * devfreq_get_freq_range() - Get the current freq range
  * @devfreq:	the devfreq instance
  * @min_freq:	the min frequency
  * @max_freq:	the max frequency
  *
  * This takes into consideration all constraints.
  */
-static void get_freq_range(struct devfreq *devfreq,
-			   unsigned long *min_freq,
-			   unsigned long *max_freq)
+void devfreq_get_freq_range(struct devfreq *devfreq,
+			    unsigned long *min_freq,
+			    unsigned long *max_freq)
 {
 	unsigned long *freq_table = devfreq->profile->freq_table;
 	s32 qos_min_freq, qos_max_freq;
@@ -158,6 +158,7 @@ static void get_freq_range(struct devfreq *devfreq,
 	if (*min_freq > *max_freq)
 		*min_freq = *max_freq;
 }
+EXPORT_SYMBOL(devfreq_get_freq_range);
 
 /**
  * devfreq_get_freq_level() - Lookup freq_table for the frequency
@@ -418,7 +419,7 @@ int devfreq_update_target(struct devfreq *devfreq, unsigned long freq)
 	err = devfreq->governor->get_target_freq(devfreq, &freq);
 	if (err)
 		return err;
-	get_freq_range(devfreq, &min_freq, &max_freq);
+	devfreq_get_freq_range(devfreq, &min_freq, &max_freq);
 
 	if (freq < min_freq) {
 		freq = min_freq;
@@ -785,6 +786,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 {
 	struct devfreq *devfreq;
 	struct devfreq_governor *governor;
+	unsigned long min_freq, max_freq;
 	int err = 0;
 
 	if (!dev || !profile || !governor_name) {
@@ -849,6 +851,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		goto err_dev;
 	}
 
+	devfreq_get_freq_range(devfreq, &min_freq, &max_freq);
+
 	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
 	devfreq->opp_table = dev_pm_opp_get_opp_table(dev);
 	if (IS_ERR(devfreq->opp_table))
@@ -1587,7 +1591,7 @@ static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
 	unsigned long min_freq, max_freq;
 
 	mutex_lock(&df->lock);
-	get_freq_range(df, &min_freq, &max_freq);
+	devfreq_get_freq_range(df, &min_freq, &max_freq);
 	mutex_unlock(&df->lock);
 
 	return sprintf(buf, "%lu\n", min_freq);
@@ -1641,7 +1645,7 @@ static ssize_t max_freq_show(struct device *dev, struct device_attribute *attr,
 	unsigned long min_freq, max_freq;
 
 	mutex_lock(&df->lock);
-	get_freq_range(df, &min_freq, &max_freq);
+	devfreq_get_freq_range(df, &min_freq, &max_freq);
 	mutex_unlock(&df->lock);
 
 	return sprintf(buf, "%lu\n", max_freq);
@@ -1955,7 +1959,7 @@ static int devfreq_summary_show(struct seq_file *s, void *data)
 
 		mutex_lock(&devfreq->lock);
 		cur_freq = devfreq->previous_freq;
-		get_freq_range(devfreq, &min_freq, &max_freq);
+		devfreq_get_freq_range(devfreq, &min_freq, &max_freq);
 		timer = devfreq->profile->timer;
 
 		if (IS_SUPPORTED_ATTR(devfreq->governor->attrs, POLLING_INTERVAL))
diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index 002a7d67e39d..b0dbfee8bbf2 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -89,6 +89,8 @@ int devm_devfreq_add_governor(struct device *dev,
 
 int devfreq_update_status(struct devfreq *devfreq, unsigned long freq);
 int devfreq_update_target(struct devfreq *devfreq, unsigned long freq);
+void devfreq_get_freq_range(struct devfreq *devfreq, unsigned long *min_freq,
+			    unsigned long *max_freq);
 
 static inline int devfreq_update_stats(struct devfreq *df)
 {
-- 
2.25.1

