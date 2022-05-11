Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7EE523667
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245486AbiEKO6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245305AbiEKO5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:57:37 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAB71AD5A3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:57:30 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id bx33so2927351ljb.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bl8rpHW4c3CiFMsX2DAaPyQ7hRT28ZNH8vs9g1j1WIc=;
        b=gwNW8kn6F4StiafOJBEyuoeas2dplhxakMCkbmJ5pa779M+8mNuBYtJ8+wZrFuDEtD
         iL3gMOmPhwBVgwqJDa7RilmY+kZ674O5esZOGux0YHLjV2ZvCIXnIE4Qre/LI7yDlM+r
         dRHVPsHPPX5HnY0QUtkQT+dY43EAM+bZhkJKFi58PI+AKJjrZ0VSI912DRkze5Uuu7sv
         1MZn7hyt+DjkWI0Fn115LCpIDoiOt4qLfJ0CFXIx2p2TqbZGq6OntoaBzjUHWoWmV8QH
         d+1/XOGpJot3pw7ai6NXha5jRaGfI9dhnxOLfKpNIcmx+B/xTYXprAXve7yQBgs2CwgZ
         c2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bl8rpHW4c3CiFMsX2DAaPyQ7hRT28ZNH8vs9g1j1WIc=;
        b=tHtvc4pZ8i9kaY9H3ikF90GmY7X8V3Lp8wGNZP1TtCxrEdItVsijPWGPxpGSAlDHdq
         7yxJ+gZEgxR58bfd5fut21YAXQC5bgEcxYiYuzYzOrdcisCNerlnoFBupCQBt/s22mjH
         sHoCxZ13+KBXwjmHkmrDGlGrTnxoyUl2CJvEcJObDXF2mVrcoE8xE9UEkurh/kecHBUH
         f8DvkJ3ZtvKN8zfdQjB0niA7X4eQoxJ+Gi/obPX/6XNeWu2wAJY7EFPXRF3GAYSM8lgf
         Aj/3cKwQJRZiCKYl3xhnQbuWPAQf2MuqO5H4nZeIKJC1xT3JyGVHkWRyxmtf8kO3UMui
         TBNg==
X-Gm-Message-State: AOAM530HyPo2HrQnJ47an+vLitMmjys8xpxlTCs6CiKgmVGEwkrylL10
        P0sXdDZJ8B/Qs/SOnQ38q5Y50A==
X-Google-Smtp-Source: ABdhPJxMcTq2eSQHDiwNWQsDX/A48wtxQ8/Nmme8fG3v2YBLDyaKJ7rAlDVk6lXwrPr1t7QCVrKRqw==
X-Received: by 2002:a2e:964b:0:b0:24e:ee06:5b70 with SMTP id z11-20020a2e964b000000b0024eee065b70mr11174894ljh.126.1652281048825;
        Wed, 11 May 2022 07:57:28 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-154.NA.cust.bahnhof.se. [98.128.181.154])
        by smtp.gmail.com with ESMTPSA id z26-20020a19f71a000000b0047255d210f3sm320793lfe.34.2022.05.11.07.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 07:57:27 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/14] PM: domains: Allocate gpd_timing_data dynamically based on governor
Date:   Wed, 11 May 2022 16:56:56 +0200
Message-Id: <20220511145704.698189-7-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511145704.698189-1-ulf.hansson@linaro.org>
References: <20220511145704.698189-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a genpd doesn't have an associated governor assigned, there's really no
point to allocate the per device gpd_timing_data, as the data isn't being
used by a governor anyway.

To avoid wasting memory, let's therefore convert the corresponding td
variable in the struct generic_pm_domain_data into a pointer and manage the
allocation of its data dynamically.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c          | 48 +++++++++++++++++++---------
 drivers/base/power/domain_governor.c |  9 ++++--
 include/linux/pm_domain.h            |  2 +-
 3 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index a3e727c9a4fa..ca86fb3db901 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -773,13 +773,16 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
 	for (;;) {
 		struct generic_pm_domain *genpd;
 		struct pm_domain_data *pdd;
+		struct gpd_timing_data *td;
 
 		spin_lock_irq(&dev->power.lock);
 
 		pdd = dev->power.subsys_data ?
 				dev->power.subsys_data->domain_data : NULL;
 		if (pdd) {
-			to_gpd_data(pdd)->td.constraint_changed = true;
+			td = to_gpd_data(pdd)->td;
+			if (td)
+				td->constraint_changed = true;
 			genpd = dev_to_genpd(dev);
 		} else {
 			genpd = ERR_PTR(-ENODATA);
@@ -875,7 +878,7 @@ static int genpd_runtime_suspend(struct device *dev)
 	struct generic_pm_domain *genpd;
 	bool (*suspend_ok)(struct device *__dev);
 	struct generic_pm_domain_data *gpd_data = dev_gpd_data(dev);
-	struct gpd_timing_data *td = &gpd_data->td;
+	struct gpd_timing_data *td = gpd_data->td;
 	bool runtime_pm = pm_runtime_enabled(dev);
 	ktime_t time_start;
 	s64 elapsed_ns;
@@ -915,7 +918,7 @@ static int genpd_runtime_suspend(struct device *dev)
 	/* Update suspend latency value if the measured time exceeds it. */
 	if (runtime_pm) {
 		elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
-		if (elapsed_ns > td->suspend_latency_ns) {
+		if (td && (elapsed_ns > td->suspend_latency_ns)) {
 			td->suspend_latency_ns = elapsed_ns;
 			dev_dbg(dev, "suspend latency exceeded, %lld ns\n",
 				elapsed_ns);
@@ -951,7 +954,7 @@ static int genpd_runtime_resume(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
 	struct generic_pm_domain_data *gpd_data = dev_gpd_data(dev);
-	struct gpd_timing_data *td = &gpd_data->td;
+	struct gpd_timing_data *td = gpd_data->td;
 	bool runtime_pm = pm_runtime_enabled(dev);
 	ktime_t time_start;
 	s64 elapsed_ns;
@@ -999,7 +1002,7 @@ static int genpd_runtime_resume(struct device *dev)
 	/* Update resume latency value if the measured time exceeds it. */
 	if (timed && runtime_pm) {
 		elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
-		if (elapsed_ns > td->resume_latency_ns) {
+		if (td && (elapsed_ns > td->resume_latency_ns)) {
 			td->resume_latency_ns = elapsed_ns;
 			dev_dbg(dev, "resume latency exceeded, %lld ns\n",
 				elapsed_ns);
@@ -1496,9 +1499,11 @@ EXPORT_SYMBOL_GPL(dev_pm_genpd_resume);
 
 #endif /* CONFIG_PM_SLEEP */
 
-static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev)
+static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev,
+							   bool has_governor)
 {
 	struct generic_pm_domain_data *gpd_data;
+	struct gpd_timing_data *td;
 	int ret;
 
 	ret = dev_pm_get_subsys_data(dev);
@@ -1512,26 +1517,38 @@ static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev)
 	}
 
 	gpd_data->base.dev = dev;
-	gpd_data->td.constraint_changed = true;
-	gpd_data->td.effective_constraint_ns = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS;
 	gpd_data->nb.notifier_call = genpd_dev_pm_qos_notifier;
 	gpd_data->next_wakeup = KTIME_MAX;
 
-	spin_lock_irq(&dev->power.lock);
+	/* Allocate data used by a governor. */
+	if (has_governor) {
+		td = kzalloc(sizeof(*td), GFP_KERNEL);
+		if (!td) {
+			ret = -ENOMEM;
+			goto err_free;
+		}
 
-	if (dev->power.subsys_data->domain_data) {
-		ret = -EINVAL;
-		goto err_free;
+		td->constraint_changed = true;
+		td->effective_constraint_ns = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS;
+		gpd_data->td = td;
 	}
 
-	dev->power.subsys_data->domain_data = &gpd_data->base;
+	spin_lock_irq(&dev->power.lock);
+
+	if (dev->power.subsys_data->domain_data)
+		ret = -EINVAL;
+	else
+		dev->power.subsys_data->domain_data = &gpd_data->base;
 
 	spin_unlock_irq(&dev->power.lock);
 
+	if (ret)
+		goto err_free;
+
 	return gpd_data;
 
  err_free:
-	spin_unlock_irq(&dev->power.lock);
+	kfree(gpd_data->td);
 	kfree(gpd_data);
  err_put:
 	dev_pm_put_subsys_data(dev);
@@ -1547,6 +1564,7 @@ static void genpd_free_dev_data(struct device *dev,
 
 	spin_unlock_irq(&dev->power.lock);
 
+	kfree(gpd_data->td);
 	kfree(gpd_data);
 	dev_pm_put_subsys_data(dev);
 }
@@ -1611,7 +1629,7 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev))
 		return -EINVAL;
 
-	gpd_data = genpd_alloc_dev_data(dev);
+	gpd_data = genpd_alloc_dev_data(dev, genpd->gov);
 	if (IS_ERR(gpd_data))
 		return PTR_ERR(gpd_data);
 
diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index c13e44823f16..62be9b3f8c90 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -18,6 +18,8 @@ static int dev_update_qos_constraint(struct device *dev, void *data)
 	s64 constraint_ns;
 
 	if (dev->power.subsys_data && dev->power.subsys_data->domain_data) {
+		struct gpd_timing_data *td = dev_gpd_data(dev)->td;
+
 		/*
 		 * Only take suspend-time QoS constraints of devices into
 		 * account, because constraints updated after the device has
@@ -25,7 +27,8 @@ static int dev_update_qos_constraint(struct device *dev, void *data)
 		 * anyway.  In order for them to take effect, the device has to
 		 * be resumed and suspended again.
 		 */
-		constraint_ns = dev_gpd_data(dev)->td.effective_constraint_ns;
+		constraint_ns = td ? td->effective_constraint_ns :
+				PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS;
 	} else {
 		/*
 		 * The child is not in a domain and there's no info on its
@@ -49,7 +52,7 @@ static int dev_update_qos_constraint(struct device *dev, void *data)
  */
 static bool default_suspend_ok(struct device *dev)
 {
-	struct gpd_timing_data *td = &dev_gpd_data(dev)->td;
+	struct gpd_timing_data *td = dev_gpd_data(dev)->td;
 	unsigned long flags;
 	s64 constraint_ns;
 
@@ -215,7 +218,7 @@ static bool __default_power_down_ok(struct dev_pm_domain *pd,
 		 * domain to turn off and on (that's how much time it will
 		 * have to wait worst case).
 		 */
-		td = &to_gpd_data(pdd)->td;
+		td = to_gpd_data(pdd)->td;
 		constraint_ns = td->effective_constraint_ns;
 		/*
 		 * Zero means "no suspend at all" and this runs only when all
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 043d48e4420a..126a4b9ab215 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -193,7 +193,7 @@ struct pm_domain_data {
 
 struct generic_pm_domain_data {
 	struct pm_domain_data base;
-	struct gpd_timing_data td;
+	struct gpd_timing_data *td;
 	struct notifier_block nb;
 	struct notifier_block *power_nb;
 	int cpu;
-- 
2.25.1

