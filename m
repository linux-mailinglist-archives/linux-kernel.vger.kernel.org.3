Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CEC522F8C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241535AbiEKJgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241792AbiEKJgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:36:07 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5551901F;
        Wed, 11 May 2022 02:36:04 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s16so1322261pgs.3;
        Wed, 11 May 2022 02:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a8xDXgJ4/lqPi969fLyf/an203hLh1dd+Ogx2mSsnkc=;
        b=eMs9bvwzqXI93+qWBooZmVhbDqAMQPjAlRGALO3t9ZCfGAFhbVrV8Pde/+l1js8d1f
         xTVLuqJIkLtuY/6DA94I66c8ZNHSZnv67S5mpZGoo/qsAEoTBOOIyuJGexUtkyx0vuVf
         X9eg1rNplzgG3V7eV1Nrd5Z8QPRrV76721WjZeo/65G6gaPynB+OIhTy7pIT1L8IX0fV
         y258u0VtVGz+vSiI3TTU2MnqX8wpsE+saLauo5mb+dKy9tLfVZ1XEP0YgJ0hmGmVYl/y
         8oy5j+MsPDcfSA+kUyatQELsMN4ILm2DwHY93lTAzk7PF6pgylFm57WvOdLbfw9lD86y
         5x9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a8xDXgJ4/lqPi969fLyf/an203hLh1dd+Ogx2mSsnkc=;
        b=TUMPLLnyJSyVKUJhUxa9t1UyWwBCXNPOscX43BGHrIIMMsDvlQIGbJy6S7v4p8xK/A
         xQjRWFEBId0OYEXRM/lVz/jKqImiPgdPjacG0QtQ/qalgtpkUsTWt3UF4VODNxUpOdzz
         zzdxdlK/oO0PjHsTHUQHuRnkUqVZEXNHNI9pSeI25H36wA7+iGAyvTJOGgu6mep0egJ5
         tUVf8jV7/s8kTfo+FBcL04Ll/5Ngtfyrfmq1UVkIZvweiRZyLq23HPS5W0RLPB8Ob/qU
         /qelzdC6rHOp2baT90K8gomEYuWW63H+eIWdhwCFpLBVqeLvJhEf58tAWena1bNYCgd/
         8fsg==
X-Gm-Message-State: AOAM532ORaioMn/W3XB8Ag0nYQeO7cbSziagRDQPaRhNJLLT9JTFKeFK
        v6n5rk1D/g1KqXtT8IatiUJCPWJ6umxsow==
X-Google-Smtp-Source: ABdhPJz6s5p+3CkeRyqasps8BZIK0qNbPTF8EjUWReQ669cBXXbxwFQwZIc3WLIU2U1bqGjNOO5xZA==
X-Received: by 2002:a63:d145:0:b0:3c1:4ba0:d890 with SMTP id c5-20020a63d145000000b003c14ba0d890mr20160529pgj.607.1652261764063;
        Wed, 11 May 2022 02:36:04 -0700 (PDT)
Received: from localhost.localdomain ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id p14-20020a17090a428e00b001dcf8960a13sm3492640pjg.40.2022.05.11.02.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 02:36:03 -0700 (PDT)
From:   Chanwoo Choi <cwchoi00@gmail.com>
X-Google-Original-From: Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     johnson.wang@mediatek.com, mka@chromium.org, wenst@chromium.org,
        jia-wei.chang@mediatek.com, andrew-sh.cheng@mediatek.com,
        hsinyi@chromium.org, saravanak@google.com, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH v4 1/4] PM / devfreq: Export devfreq_get_freq_range symbol within devfreq
Date:   Wed, 11 May 2022 18:35:51 +0900
Message-Id: <20220511093554.17535-2-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511093554.17535-1-cw00.choi@samsung.com>
References: <20220511093554.17535-1-cw00.choi@samsung.com>
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
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Johnson Wang <johnson.wang@mediatek.com>
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

