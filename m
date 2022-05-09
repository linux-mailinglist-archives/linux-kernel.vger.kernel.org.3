Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD6251FBFD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 14:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbiEIMHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 08:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbiEIMHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 08:07:42 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC86E1E59D1;
        Mon,  9 May 2022 05:03:48 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id i24so12052919pfa.7;
        Mon, 09 May 2022 05:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tb8lo2vLduedMAIelY9SoqFHYzII084rI2sc4ZhfI0w=;
        b=ZRHkr3S2QGq6EUydoCOjBK/VRlIcFcPOLSyuj9jY2DGuk5m043jTlpt6RT0meT0B9t
         XILmX4VPlUb2WRIr6o1TO4RE4UxrYTUlfkQsPt/uam0a12C/8BbsVT733NYZu5WTci7m
         pGE/LbZMpPTy+7dM4uN5qiX/fub0oV0ikt08Dv9gXfDpvn7ITiY/oi5rnrhYOCaj6WXs
         WrYnvL3Lgg6d8UMZYUWN7SHelt5CwIInoueL4w4tzSUKNpo/KRYkQmlDtR0/STP3VVjh
         kU4CaRV5JvL3nWMhMZGejgJihlTvMC9DfdIxg2dbtPNtv8JU69J87pZPl9wa0Jmo1qty
         9GTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tb8lo2vLduedMAIelY9SoqFHYzII084rI2sc4ZhfI0w=;
        b=eS30LFFJGMefU9dTcuAAOvPtp8g3NUed8gwYPKl3yVCcWz7m6hXLcAG310l9IevInO
         VYS5YaMJTBDmGU3MG66vkgEamidxCrFmTswM0OtnUcK74XE2bGIeB2GIggZ/ZeQNQn+Y
         FMwkKIc1RSJBvysPtc/LZk95H/flgwRu9ULaPHQ1NfW6j2na6zdcOOpU2MgMGlaFfywg
         Q+owATLPVb6vaAZzz+yv2TakGb68yiSyWqoDQwHC5nH2gW5squvZdpzhrA0ucAnzZT71
         eHKYcCVFT18SRSc6QpE4z7PdjuCemtkouJyfIeLpf/doZe6GOlUdLy6OKXtyhPKsyjJf
         Gd8g==
X-Gm-Message-State: AOAM5303QtEokSXLl35fwXPD+csfCCyIhq+DCjk5S/SPfVHWPpXPITBR
        yO7fIlzY6yFVfJjC6SLqXxfGvuWeH2wBFw==
X-Google-Smtp-Source: ABdhPJxB6af99WIma3qIYmNE9iiC8qLXYxpU2v4glMfAk/T1AE+jyKZjTaHOD3YSt0KMu6iveyizEA==
X-Received: by 2002:a63:30e:0:b0:3c6:5a3c:64bd with SMTP id 14-20020a63030e000000b003c65a3c64bdmr11152195pgd.371.1652097827582;
        Mon, 09 May 2022 05:03:47 -0700 (PDT)
Received: from localhost.localdomain ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id c4-20020a170903234400b0015e8d4eb245sm7020283plh.143.2022.05.09.05.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 05:03:47 -0700 (PDT)
From:   Chanwoo Choi <cwchoi00@gmail.com>
X-Google-Original-From: Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     johnson.wang@mediatek.com, mka@chromium.org, wenst@chromium.org,
        jia-wei.chang@mediatek.com, andrew-sh.cheng@mediatek.com,
        hsinyi@chromium.org, saravanak@google.com, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH v3 1/4] PM / devfreq: Export devfreq_get_freq_range symbol within devfreq
Date:   Mon,  9 May 2022 21:03:34 +0900
Message-Id: <20220509120337.92472-2-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220509120337.92472-1-cw00.choi@samsung.com>
References: <20220509120337.92472-1-cw00.choi@samsung.com>
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

