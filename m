Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3487053A9BB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 17:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354984AbiFAPPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 11:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354959AbiFAPPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 11:15:00 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F3690CFA
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 08:14:58 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x17so2805264wrg.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 08:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LHnieHEw4RPGKoOIEHTzAQkLNeagtaYCFgNXH9dPMac=;
        b=cRdEo239VtaUXETw8ISO74XI8xvlfNc4i6PeNXes20SRN+U49YXxawZ22ws9eo+uGW
         08YhaRFvqcL30b0APelTlZaKS/b91/6+aN/n7rRGlmbEGzHzt/RQpqtNic67opWgnOxv
         Q9yvdI9SIWSgKm1qDasS1on1xvQSJ6xxc6Rba4P5fjryXHMJoWjnLezdtKkhhUf74KBc
         lgbHtnWnG/bzht7LlMafWPzF/F18JdjX71KzxvJ1ExBqjxA3DAcWnjX078B//XTIGABW
         XHiPSH+tWHJoIYUIs6+DXYPdcyOx6PRIN7X8x362YocTWFqWypP4pbT2iVX8hzs+hooR
         vLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LHnieHEw4RPGKoOIEHTzAQkLNeagtaYCFgNXH9dPMac=;
        b=D+ILuQ6KGJHkmKomRTkk5sL3RdETXn9jdFU0+SBrLc8qsR6k5hXFZv6wZuNAEZ3Y1+
         5eIq3Oxl3RyjvGQlgjUPSxoEazgI63Hv8MB7pWtCINs52ugE5kjFfkzpRqmABpjXeAba
         qmHm93AAVRFBURfm19219VYhpoqBH4Ifegr+4mZnFzcfvNZqU7B1lPHlt6Uj2bT7uHDu
         nd6iMF6aPysD/5pcy3XyrFSrfvwEQf3y//ho5+FhTMXH+W/FRv3f0fA01qHZJQmSsjPp
         CQEoMuT+PFy4UlI6sDEGbs8FBRR6BP5OcE2XvLxSwFe8BJNlI5r+Pz5avxFYuNzDAKQM
         K0bA==
X-Gm-Message-State: AOAM530JoqfOCmBm/aRLrdF67RUMZAMVU2e7dOaKQgDcLiWeBKFVDS0U
        rVdkhTmVwDGAl0r23P8KPQAcONlOhZ0WyA==
X-Google-Smtp-Source: ABdhPJyvsaFdVNck29C4extor+IlOzl9uYZ5uxE6guTkWtBxC73ZOWwV/rDc7ugpxlSVciZH79tmJA==
X-Received: by 2002:adf:f582:0:b0:210:f0:24ac with SMTP id f2-20020adff582000000b0021000f024acmr251274wro.444.1654096497485;
        Wed, 01 Jun 2022 08:14:57 -0700 (PDT)
Received: from localhost.localdomain (176-182-171-101.abo.bbox.fr. [176.182.171.101])
        by smtp.gmail.com with ESMTPSA id y5-20020adff6c5000000b0020c5253d926sm1882077wrp.114.2022.06.01.08.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 08:14:56 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_manafm@quicinc.com, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/3] thermal/core: Encapsulate the set_cur_state function
Date:   Wed,  1 Jun 2022 17:14:39 +0200
Message-Id: <20220601151441.9128-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Concentrate the actions in a single place when a cooling device state
is changed. Provide a function to do that instead of calling the
underlying ops.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h    |  1 +
 drivers/thermal/thermal_helpers.c | 32 ++++++++++++++++++++++++-------
 drivers/thermal/thermal_sysfs.c   |  7 ++-----
 3 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 726e327b4205..4689f6cf898f 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -65,6 +65,7 @@ static inline bool cdev_is_power_actor(struct thermal_cooling_device *cdev)
 		cdev->ops->power2state;
 }
 
+int thermal_cdev_set_state(struct thermal_cooling_device *cdev, int state);
 void thermal_cdev_update(struct thermal_cooling_device *);
 void __thermal_cdev_update(struct thermal_cooling_device *cdev);
 
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 3edd047e144f..d5f162fad1ab 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -182,14 +182,32 @@ void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms)
 		*delay_jiffies = round_jiffies(*delay_jiffies);
 }
 
-static void thermal_cdev_set_cur_state(struct thermal_cooling_device *cdev,
-				       int target)
+/**
+ * thermal_cdev_set_state - set the cooling device state
+ * @cdev: a pointer to a thermal_cooling_device
+ * @state: the target state
+ *
+ * Set the state of the cooling device passed as parameter. The
+ * cooling device lock must be held when calling this function.
+ *
+ * Return: 0 in case of success, otherwise the return value is the one
+ * returned by the backend for the ops
+ */
+int thermal_cdev_set_state(struct thermal_cooling_device *cdev, int state)
 {
-	if (cdev->ops->set_cur_state(cdev, target))
-		return;
+	int ret;
 
-	thermal_notify_cdev_state_update(cdev->id, target);
-	thermal_cooling_device_stats_update(cdev, target);
+	/*
+	 * No check is needed for the ops->set_cur_state as the
+	 * registering function checked the ops are correctly set
+	 */
+	ret = cdev->ops->set_cur_state(cdev, state);
+	if (!ret) {
+		thermal_notify_cdev_state_update(cdev->id, state);
+		thermal_cooling_device_stats_update(cdev, state);
+	}
+
+	return ret;
 }
 
 void __thermal_cdev_update(struct thermal_cooling_device *cdev)
@@ -207,7 +225,7 @@ void __thermal_cdev_update(struct thermal_cooling_device *cdev)
 			target = instance->target;
 	}
 
-	thermal_cdev_set_cur_state(cdev, target);
+	thermal_cdev_set_state(cdev, target);
 
 	trace_cdev_update(cdev, target);
 	dev_dbg(&cdev->device, "set to state %lu\n", target);
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 1c4aac8464a7..935e79909121 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -617,12 +617,9 @@ cur_state_store(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 
 	mutex_lock(&cdev->lock);
-
-	result = cdev->ops->set_cur_state(cdev, state);
-	if (!result)
-		thermal_cooling_device_stats_update(cdev, state);
-
+	result = thermal_cdev_set_state(cdev, state);
 	mutex_unlock(&cdev->lock);
+
 	return result ? result : count;
 }
 
-- 
2.25.1

