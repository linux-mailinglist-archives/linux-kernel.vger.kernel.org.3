Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9473652366E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245342AbiEKO6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245324AbiEKO5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:57:38 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E421FD840
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:57:32 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id p26so4006409lfh.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2gFFvwdN/Sbzb6gl/THgYR/bjpxtOmE1Z07RfTChlck=;
        b=AKMBOxosg+GEA7ZZLPUVvSF9Nz2ZhFwCheRbwlKRxf5eHcI/lcg2XZ/v0Q1fKU3Y8r
         PyEMzM0zsZpNRhjZ/q3kO6e+AS1vgy1HuYHmkxc3od8ILggFTkUv33Q7QR9m+ikgKhwt
         bK6jV3XkOGqKRwsa5Vr8Took8lIY9B7N75kQyHZBrbsJEXIsVreCgmzUbXHffQGKsaTE
         4PFbREOn5I8aK2EUBC/48mzJHHMVl4buN8+wyF2G7ysE30SgmFl44/boOgrPx9ZhOnJI
         LkHXt1ItXHq8C6FaK0r/YlZjmFLmH8bfe58M/tZcC+H9vIiPtym5x8NqCC2FLyfh1h/B
         4PpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2gFFvwdN/Sbzb6gl/THgYR/bjpxtOmE1Z07RfTChlck=;
        b=w9SieJwrfxD8N5R6qCHPdGtbhQxFVz0zooDZOU+A2BZ4r/v/G0h+z6r0tMlWJTswub
         Zh876bO6MKY+ghDQpKePHNqPG/A/1azQqjyOOE9WmLT83oSIEgtsSCtU0EM0fk84RbAZ
         DJ1FJ3KgCkVXn8e70OE5OrAdGr7QziXypFfuqW0svO2lzNhoNmlxcE7+qoMareInQkJq
         UdfNCNwRUCnV/sYi9oYliKVDkFX+HZ5ZWamTdCrTdjY6ySreP9f1zouufAdYQFq2oMJb
         J7tNna9bKjxyqQgHoemKflB35R45/enm/uwGlEJlV3i2OpJ+hru0S9ZHVz4sIpihEv5h
         VyAg==
X-Gm-Message-State: AOAM530VmJ2HhxPVGKzW+a5CrpfgUmIfvGnaZgWi5cDWYTwq99WWhIFF
        d99E09YKMwYFXIKAukzbsKOn8A==
X-Google-Smtp-Source: ABdhPJyKM/oX7q2GnhgQf0vJUOqTliTzVsmMWV8dFynsx6Tt6u0Zi82/g1j3o0k081btT4lf1QlnJQ==
X-Received: by 2002:ac2:5456:0:b0:471:f9e6:7388 with SMTP id d22-20020ac25456000000b00471f9e67388mr19548791lfn.504.1652281051171;
        Wed, 11 May 2022 07:57:31 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-154.NA.cust.bahnhof.se. [98.128.181.154])
        by smtp.gmail.com with ESMTPSA id z26-20020a19f71a000000b0047255d210f3sm320793lfe.34.2022.05.11.07.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 07:57:30 -0700 (PDT)
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
Subject: [PATCH 07/14] PM: domains: Move the next_wakeup variable into the struct gpd_timing_data
Date:   Wed, 11 May 2022 16:56:57 +0200
Message-Id: <20220511145704.698189-8-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511145704.698189-1-ulf.hansson@linaro.org>
References: <20220511145704.698189-1-ulf.hansson@linaro.org>
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

If the corresponding genpd for the device doesn't use a governor, the
variable next_wakeup within the struct generic_pm_domain_data becomes
superfluous.

To avoid wasting memory, let's move it into the struct gpd_timing_data,
which is already being allocated based upon if there is governor assigned.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c          | 9 +++++----
 drivers/base/power/domain_governor.c | 2 +-
 include/linux/pm_domain.h            | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index ca86fb3db901..4c059a858957 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -478,15 +478,16 @@ EXPORT_SYMBOL_GPL(dev_pm_genpd_set_performance_state);
  */
 void dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next)
 {
-	struct generic_pm_domain_data *gpd_data;
 	struct generic_pm_domain *genpd;
+	struct gpd_timing_data *td;
 
 	genpd = dev_to_genpd_safe(dev);
 	if (!genpd)
 		return;
 
-	gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
-	gpd_data->next_wakeup = next;
+	td = to_gpd_data(dev->power.subsys_data->domain_data)->td;
+	if (td)
+		td->next_wakeup = next;
 }
 EXPORT_SYMBOL_GPL(dev_pm_genpd_set_next_wakeup);
 
@@ -1518,7 +1519,6 @@ static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev,
 
 	gpd_data->base.dev = dev;
 	gpd_data->nb.notifier_call = genpd_dev_pm_qos_notifier;
-	gpd_data->next_wakeup = KTIME_MAX;
 
 	/* Allocate data used by a governor. */
 	if (has_governor) {
@@ -1530,6 +1530,7 @@ static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev,
 
 		td->constraint_changed = true;
 		td->effective_constraint_ns = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS;
+		td->next_wakeup = KTIME_MAX;
 		gpd_data->td = td;
 	}
 
diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 62be9b3f8c90..599b3909821c 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -139,7 +139,7 @@ static void update_domain_next_wakeup(struct generic_pm_domain *genpd, ktime_t n
 	 * is able to enter its optimal idle state.
 	 */
 	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
-		next_wakeup = to_gpd_data(pdd)->next_wakeup;
+		next_wakeup = to_gpd_data(pdd)->td->next_wakeup;
 		if (next_wakeup != KTIME_MAX && !ktime_before(next_wakeup, now))
 			if (ktime_before(next_wakeup, domain_wakeup))
 				domain_wakeup = next_wakeup;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 126a4b9ab215..1f370f074f30 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -182,6 +182,7 @@ struct gpd_timing_data {
 	s64 suspend_latency_ns;
 	s64 resume_latency_ns;
 	s64 effective_constraint_ns;
+	ktime_t	next_wakeup;
 	bool constraint_changed;
 	bool cached_suspend_ok;
 };
@@ -200,7 +201,6 @@ struct generic_pm_domain_data {
 	unsigned int performance_state;
 	unsigned int default_pstate;
 	unsigned int rpm_pstate;
-	ktime_t	next_wakeup;
 	void *data;
 };
 
-- 
2.25.1

