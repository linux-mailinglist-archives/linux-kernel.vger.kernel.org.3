Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54416523677
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245459AbiEKO65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245333AbiEKO5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:57:44 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9240B1DFDA9
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:57:41 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id b18so4019789lfv.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XZcABCuQiJ6MV3J10Fqs7sUH1y0873Bga2K+vj5NK2g=;
        b=a8aVVIu4GI2HZ+KTvb82sbWY59cb67j97G3NWXOLaYJroaNA5JsNJn0Md34JPXDAgE
         yG7gLiWKP2qV9b3BY6lOmhwvIm5NvnRyMEY47/mFkmm74FWSukH9/GJGNYhfDSt534G4
         F3FuiVxsPJQa/RwQb4ouwL5juVQNc+0Nwh48jj/5XrfDuy8Frc5dQeTgkZ8uc89eTCh6
         vKV+7gMsV9xqgGBvDWNxv7JNgDi9h2KifKkMRKiO6VAbaBLScqdsR5joff7tKzgKO3vi
         NUpAqH+pkhQHnk+kSMNDhY6tkZaUkVTbf0EjR/gcxYGZjsrr8HnzX0v5wB6nVz0Ng5/c
         yFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XZcABCuQiJ6MV3J10Fqs7sUH1y0873Bga2K+vj5NK2g=;
        b=qmLpuT5rzhmuyOFjv7Jq0LBhetCrYXbr4EofnRHuCYCoW1pr6+aZcBr4JunMSaGiBF
         dY0jTTo/7QlN+tZeolSnQmXjWTVEesRMZNgNq6sjg67e9N401BrEnrcA9ByKJD2J5nGa
         E982MjuuPg21pj57ZneoBL545uybkN2i4OJUnLPnG2nhCw6zVY9r8B3POTkAmNi+G3tL
         kF+GnZ+nILXAXjurJoEpyxD0aBO04AqqXiHgHs3qopnEMvgAqAjeD0Fh47GeIi3JPUM8
         omJGj9wBwma4L/cnphMJZiqrehRLkSdmWJEQCylE/0LBkgJBlok+yMUHznmhp6OGrw15
         Srqg==
X-Gm-Message-State: AOAM5329lWiuvMHHB+yqBPgWoGq74lFx5gZaXsbElfUjDhb4TIl88By5
        HUvSp9lzPSbxoy1r4799I3I7zA==
X-Google-Smtp-Source: ABdhPJwK/WWDDR7g3gLg/wWX1aT1ggLMOyilHSAtiXCR1IUqZzkT/ITGPnKzorWCZhQXfylEZkn1PA==
X-Received: by 2002:a05:6512:34cf:b0:474:44e4:83a5 with SMTP id w15-20020a05651234cf00b0047444e483a5mr2289351lfr.6.1652281059819;
        Wed, 11 May 2022 07:57:39 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-154.NA.cust.bahnhof.se. [98.128.181.154])
        by smtp.gmail.com with ESMTPSA id z26-20020a19f71a000000b0047255d210f3sm320793lfe.34.2022.05.11.07.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 07:57:39 -0700 (PDT)
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
Subject: [PATCH 12/14] PM: domains: Allocate governor data dynamically based on a genpd governor
Date:   Wed, 11 May 2022 16:57:02 +0200
Message-Id: <20220511145704.698189-13-ulf.hansson@linaro.org>
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

If a genpd doesn't have an associated governor assigned, several variables
in the struct generic_pm_domain becomes superfluous.

Rather than wasting memory in allocated genpds, let's move the variables
from the struct generic_pm_domain into a new separate struct. In this way,
we can instead dynamically decide when we need to allocate the
corresponding data for it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c          | 49 +++++++++++++++++++---------
 drivers/base/power/domain_governor.c | 48 +++++++++++++++------------
 include/linux/pm_domain.h            | 14 +++++---
 3 files changed, 70 insertions(+), 41 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index ac1eb7d2470b..a7de5fb8f073 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -527,7 +527,8 @@ static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 		goto out;
 
 	genpd->states[state_idx].power_on_latency_ns = elapsed_ns;
-	genpd->max_off_time_changed = true;
+	if (genpd->gd)
+		genpd->gd->max_off_time_changed = true;
 	pr_debug("%s: Power-%s latency exceeded, new value %lld ns\n",
 		 genpd->name, "on", elapsed_ns);
 
@@ -576,7 +577,8 @@ static int _genpd_power_off(struct generic_pm_domain *genpd, bool timed)
 		goto out;
 
 	genpd->states[state_idx].power_off_latency_ns = elapsed_ns;
-	genpd->max_off_time_changed = true;
+	if (genpd->gd)
+		genpd->gd->max_off_time_changed = true;
 	pr_debug("%s: Power-%s latency exceeded, new value %lld ns\n",
 		 genpd->name, "off", elapsed_ns);
 
@@ -772,7 +774,7 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
 	dev = gpd_data->base.dev;
 
 	for (;;) {
-		struct generic_pm_domain *genpd;
+		struct generic_pm_domain *genpd = ERR_PTR(-ENODATA);
 		struct pm_domain_data *pdd;
 		struct gpd_timing_data *td;
 
@@ -782,18 +784,17 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
 				dev->power.subsys_data->domain_data : NULL;
 		if (pdd) {
 			td = to_gpd_data(pdd)->td;
-			if (td)
+			if (td) {
 				td->constraint_changed = true;
-			genpd = dev_to_genpd(dev);
-		} else {
-			genpd = ERR_PTR(-ENODATA);
+				genpd = dev_to_genpd(dev);
+			}
 		}
 
 		spin_unlock_irq(&dev->power.lock);
 
 		if (!IS_ERR(genpd)) {
 			genpd_lock(genpd);
-			genpd->max_off_time_changed = true;
+			genpd->gd->max_off_time_changed = true;
 			genpd_unlock(genpd);
 		}
 
@@ -922,7 +923,7 @@ static int genpd_runtime_suspend(struct device *dev)
 			td->suspend_latency_ns = elapsed_ns;
 			dev_dbg(dev, "suspend latency exceeded, %lld ns\n",
 				elapsed_ns);
-			genpd->max_off_time_changed = true;
+			genpd->gd->max_off_time_changed = true;
 			td->constraint_changed = true;
 		}
 	}
@@ -1002,7 +1003,7 @@ static int genpd_runtime_resume(struct device *dev)
 			td->resume_latency_ns = elapsed_ns;
 			dev_dbg(dev, "resume latency exceeded, %lld ns\n",
 				elapsed_ns);
-			genpd->max_off_time_changed = true;
+			genpd->gd->max_off_time_changed = true;
 			td->constraint_changed = true;
 		}
 	}
@@ -1617,6 +1618,7 @@ static int genpd_get_cpu(struct generic_pm_domain *genpd, struct device *dev)
 static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 			    struct device *base_dev)
 {
+	struct genpd_governor_data *gd = genpd->gd;
 	struct generic_pm_domain_data *gpd_data;
 	int ret;
 
@@ -1625,7 +1627,7 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev))
 		return -EINVAL;
 
-	gpd_data = genpd_alloc_dev_data(dev, genpd->gov);
+	gpd_data = genpd_alloc_dev_data(dev, gd);
 	if (IS_ERR(gpd_data))
 		return PTR_ERR(gpd_data);
 
@@ -1641,7 +1643,8 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	dev_pm_domain_set(dev, &genpd->domain);
 
 	genpd->device_count++;
-	genpd->max_off_time_changed = true;
+	if (gd)
+		gd->max_off_time_changed = true;
 
 	list_add_tail(&gpd_data->base.list_node, &genpd->dev_list);
 
@@ -1695,7 +1698,8 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
 	}
 
 	genpd->device_count--;
-	genpd->max_off_time_changed = true;
+	if (genpd->gd)
+		genpd->gd->max_off_time_changed = true;
 
 	genpd_clear_cpumask(genpd, gpd_data->cpu);
 	dev_pm_domain_set(dev, NULL);
@@ -1970,12 +1974,25 @@ static int genpd_set_default_power_state(struct generic_pm_domain *genpd)
 
 static int genpd_alloc_data(struct generic_pm_domain *genpd)
 {
+	struct genpd_governor_data *gd = NULL;
 	int ret;
 
 	if (genpd_is_cpu_domain(genpd) &&
 	    !zalloc_cpumask_var(&genpd->cpus, GFP_KERNEL))
 		return -ENOMEM;
 
+	if (genpd->gov) {
+		gd = kzalloc(sizeof(*gd), GFP_KERNEL);
+		if (!gd) {
+			ret = -ENOMEM;
+			goto free;
+		}
+
+		gd->max_off_time_ns = -1;
+		gd->max_off_time_changed = true;
+		gd->next_wakeup = KTIME_MAX;
+	}
+
 	/* Use only one "off" state if there were no states declared */
 	if (genpd->state_count == 0) {
 		ret = genpd_set_default_power_state(genpd);
@@ -1983,11 +2000,13 @@ static int genpd_alloc_data(struct generic_pm_domain *genpd)
 			goto free;
 	}
 
+	genpd->gd = gd;
 	return 0;
 
 free:
 	if (genpd_is_cpu_domain(genpd))
 		free_cpumask_var(genpd->cpus);
+	kfree(gd);
 	return ret;
 }
 
@@ -1997,6 +2016,7 @@ static void genpd_free_data(struct generic_pm_domain *genpd)
 		free_cpumask_var(genpd->cpus);
 	if (genpd->free_states)
 		genpd->free_states(genpd->states, genpd->state_count);
+	kfree(genpd->gd);
 }
 
 static void genpd_lock_init(struct generic_pm_domain *genpd)
@@ -2036,9 +2056,6 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	atomic_set(&genpd->sd_count, 0);
 	genpd->status = is_off ? GENPD_STATE_OFF : GENPD_STATE_ON;
 	genpd->device_count = 0;
-	genpd->max_off_time_ns = -1;
-	genpd->max_off_time_changed = true;
-	genpd->next_wakeup = KTIME_MAX;
 	genpd->provider = NULL;
 	genpd->has_provider = false;
 	genpd->accounting_time = ktime_get_mono_fast_ns();
diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 599b3909821c..282a3a135827 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -146,19 +146,21 @@ static void update_domain_next_wakeup(struct generic_pm_domain *genpd, ktime_t n
 	}
 
 	list_for_each_entry(link, &genpd->parent_links, parent_node) {
-		next_wakeup = link->child->next_wakeup;
+		struct genpd_governor_data *cgd = link->child->gd;
+
+		next_wakeup = cgd ? cgd->next_wakeup : KTIME_MAX;
 		if (next_wakeup != KTIME_MAX && !ktime_before(next_wakeup, now))
 			if (ktime_before(next_wakeup, domain_wakeup))
 				domain_wakeup = next_wakeup;
 	}
 
-	genpd->next_wakeup = domain_wakeup;
+	genpd->gd->next_wakeup = domain_wakeup;
 }
 
 static bool next_wakeup_allows_state(struct generic_pm_domain *genpd,
 				     unsigned int state, ktime_t now)
 {
-	ktime_t domain_wakeup = genpd->next_wakeup;
+	ktime_t domain_wakeup = genpd->gd->next_wakeup;
 	s64 idle_time_ns, min_sleep_ns;
 
 	min_sleep_ns = genpd->states[state].power_off_latency_ns +
@@ -188,8 +190,9 @@ static bool __default_power_down_ok(struct dev_pm_domain *pd,
 	 * All subdomains have been powered off already at this point.
 	 */
 	list_for_each_entry(link, &genpd->parent_links, parent_node) {
-		struct generic_pm_domain *sd = link->child;
-		s64 sd_max_off_ns = sd->max_off_time_ns;
+		struct genpd_governor_data *cgd = link->child->gd;
+
+		s64 sd_max_off_ns = cgd ? cgd->max_off_time_ns : -1;
 
 		if (sd_max_off_ns < 0)
 			continue;
@@ -247,7 +250,7 @@ static bool __default_power_down_ok(struct dev_pm_domain *pd,
 	 * time and the time needed to turn the domain on is the maximum
 	 * theoretical time this domain can spend in the "off" state.
 	 */
-	genpd->max_off_time_ns = min_off_time_ns -
+	genpd->gd->max_off_time_ns = min_off_time_ns -
 		genpd->states[state].power_on_latency_ns;
 	return true;
 }
@@ -262,6 +265,7 @@ static bool __default_power_down_ok(struct dev_pm_domain *pd,
 static bool _default_power_down_ok(struct dev_pm_domain *pd, ktime_t now)
 {
 	struct generic_pm_domain *genpd = pd_to_genpd(pd);
+	struct genpd_governor_data *gd = genpd->gd;
 	int state_idx = genpd->state_count - 1;
 	struct gpd_link *link;
 
@@ -272,11 +276,11 @@ static bool _default_power_down_ok(struct dev_pm_domain *pd, ktime_t now)
 	 * cannot be met.
 	 */
 	update_domain_next_wakeup(genpd, now);
-	if ((genpd->flags & GENPD_FLAG_MIN_RESIDENCY) && (genpd->next_wakeup != KTIME_MAX)) {
+	if ((genpd->flags & GENPD_FLAG_MIN_RESIDENCY) && (gd->next_wakeup != KTIME_MAX)) {
 		/* Let's find out the deepest domain idle state, the devices prefer */
 		while (state_idx >= 0) {
 			if (next_wakeup_allows_state(genpd, state_idx, now)) {
-				genpd->max_off_time_changed = true;
+				gd->max_off_time_changed = true;
 				break;
 			}
 			state_idx--;
@@ -284,14 +288,14 @@ static bool _default_power_down_ok(struct dev_pm_domain *pd, ktime_t now)
 
 		if (state_idx < 0) {
 			state_idx = 0;
-			genpd->cached_power_down_ok = false;
+			gd->cached_power_down_ok = false;
 			goto done;
 		}
 	}
 
-	if (!genpd->max_off_time_changed) {
-		genpd->state_idx = genpd->cached_power_down_state_idx;
-		return genpd->cached_power_down_ok;
+	if (!gd->max_off_time_changed) {
+		genpd->state_idx = gd->cached_power_down_state_idx;
+		return gd->cached_power_down_ok;
 	}
 
 	/*
@@ -300,12 +304,16 @@ static bool _default_power_down_ok(struct dev_pm_domain *pd, ktime_t now)
 	 * going to be called for any parent until this instance
 	 * returns.
 	 */
-	list_for_each_entry(link, &genpd->child_links, child_node)
-		link->parent->max_off_time_changed = true;
+	list_for_each_entry(link, &genpd->child_links, child_node) {
+		struct genpd_governor_data *pgd = link->parent->gd;
+
+		if (pgd)
+			pgd->max_off_time_changed = true;
+	}
 
-	genpd->max_off_time_ns = -1;
-	genpd->max_off_time_changed = false;
-	genpd->cached_power_down_ok = true;
+	gd->max_off_time_ns = -1;
+	gd->max_off_time_changed = false;
+	gd->cached_power_down_ok = true;
 
 	/*
 	 * Find a state to power down to, starting from the state
@@ -313,7 +321,7 @@ static bool _default_power_down_ok(struct dev_pm_domain *pd, ktime_t now)
 	 */
 	while (!__default_power_down_ok(pd, state_idx)) {
 		if (state_idx == 0) {
-			genpd->cached_power_down_ok = false;
+			gd->cached_power_down_ok = false;
 			break;
 		}
 		state_idx--;
@@ -321,8 +329,8 @@ static bool _default_power_down_ok(struct dev_pm_domain *pd, ktime_t now)
 
 done:
 	genpd->state_idx = state_idx;
-	genpd->cached_power_down_state_idx = genpd->state_idx;
-	return genpd->cached_power_down_ok;
+	gd->cached_power_down_state_idx = genpd->state_idx;
+	return gd->cached_power_down_ok;
 }
 
 static bool default_power_down_ok(struct dev_pm_domain *pd)
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 1f370f074f30..ebc351698090 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -91,6 +91,14 @@ struct gpd_dev_ops {
 	int (*stop)(struct device *dev);
 };
 
+struct genpd_governor_data {
+	s64 max_off_time_ns;
+	bool max_off_time_changed;
+	ktime_t next_wakeup;
+	bool cached_power_down_ok;
+	bool cached_power_down_state_idx;
+};
+
 struct genpd_power_state {
 	s64 power_off_latency_ns;
 	s64 power_on_latency_ns;
@@ -114,6 +122,7 @@ struct generic_pm_domain {
 	struct list_head child_links;	/* Links with PM domain as a child */
 	struct list_head dev_list;	/* List of devices */
 	struct dev_power_governor *gov;
+	struct genpd_governor_data *gd;	/* Data used by a genpd governor. */
 	struct work_struct power_off_work;
 	struct fwnode_handle *provider;	/* Identity of the domain provider */
 	bool has_provider;
@@ -134,11 +143,6 @@ struct generic_pm_domain {
 	int (*set_performance_state)(struct generic_pm_domain *genpd,
 				     unsigned int state);
 	struct gpd_dev_ops dev_ops;
-	s64 max_off_time_ns;	/* Maximum allowed "suspended" time. */
-	ktime_t next_wakeup;	/* Maintained by the domain governor */
-	bool max_off_time_changed;
-	bool cached_power_down_ok;
-	bool cached_power_down_state_idx;
 	int (*attach_dev)(struct generic_pm_domain *domain,
 			  struct device *dev);
 	void (*detach_dev)(struct generic_pm_domain *domain,
-- 
2.25.1

