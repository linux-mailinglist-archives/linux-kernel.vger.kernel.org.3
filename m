Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96AB4F5B00
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377781AbiDFJjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 05:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1584533AbiDFJfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 05:35:48 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AFB42BBBB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 18:49:24 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id fu5so1186316pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 18:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JtLsVmzWpw6aeg4Qp3ng6b0/H2CF2NlVfMxyx7OIQro=;
        b=QkMwHYxq9UcLG5vRXsIswyuV9yCs2FkjLmR/C51CfN+JUKvyyxfM10lEgkTacvASvr
         PE7gX4SvG+VQcvaJokA2a84YlfbgpZl4fV7/aX6w7Az7pzn7AkFCl8uZSqBp7uL9YU6u
         vyx2+lWZFqkcsryL/ZqZHhFYygtiFDSWkUANc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JtLsVmzWpw6aeg4Qp3ng6b0/H2CF2NlVfMxyx7OIQro=;
        b=IufWQV0lds5J4AHRKiTGPKOZ9Zum2D3KrgOvPwi+K5c+HBPdBmBH5sy5STIhCIn1NV
         UYK+4NIj408Q7dpcmZn18AFszrzQEhBJ2hywWA13KA6FihfZpYvqTkrAq52XYA6d8bjz
         9TqisvN+gdhcY3K/0Hq7Iiy/7D4/uMs/otQTHjtC4Ad9JqLPIfkG7ZpQdbqimL3OabNk
         Lz1h9yhtfn2Jyj3I2fEJyBEOkusxWHgjZ424hsp1IIUJOY/h6Zulazn6CWw7Bja42IUv
         YmD738j1VtGkAxySWT11GWEIqCboSt4PMIn6ubzo+RhAsICZMQAMw7/MLOR1rzakg9hW
         8zXQ==
X-Gm-Message-State: AOAM533QTdp+HalALmlbcMCzIao18cUYuJFdgia1eGc6W48LQzozJtV3
        AufBPOjn0p1+06xMT1T7+eAE/w==
X-Google-Smtp-Source: ABdhPJy9ivlWHFuBq/goqkSpT277khrmyMBEXhXl9DMnRbx+u0uqd+X5wWEMqdXX2bCIbONpA3f+Zw==
X-Received: by 2002:a17:90b:4c09:b0:1c6:f64a:dd0 with SMTP id na9-20020a17090b4c0900b001c6f64a0dd0mr7233013pjb.45.1649209763544;
        Tue, 05 Apr 2022 18:49:23 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6903:769c:e1f5:9c25])
        by smtp.gmail.com with UTF8SMTPSA id q9-20020a056a00088900b004fe1a045e97sm6846993pfj.118.2022.04.05.18.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 18:49:22 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-kernel@vger.kernel.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        linux-pm@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Brian Norris <briannorris@chromium.org>
Subject: [RFC PATCH 1/2] soc: rockchip: power-domain: Manage resource conflicts with firmware
Date:   Tue,  5 Apr 2022 18:48:41 -0700
Message-Id: <20220405184816.RFC.1.Ib865f199d15221eab4ff77f70bd7e9e2eb04d32f@changeid>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
In-Reply-To: <20220406014842.2771799-1-briannorris@chromium.org>
References: <20220406014842.2771799-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On RK3399 platforms, power domains are managed mostly by the kernel
(drivers/soc/rockchip/pm_domains.c), but there are a few exceptions
where ARM Trusted Firmware has to be involved:

(1) system suspend/resume
(2) DRAM DVFS (a.k.a., "ddrfreq")

Exception (1) does not cause much conflict, since the kernel has
quiesced itself by the time we make the relevant PSCI call.

Exception (2) can cause conflict, because of two actions:

(a) ARM Trusted Firmware needs to read/modify/write the PMU_BUS_IDLE_REQ
    register to idle the memory controller domain; the kernel driver
    also has to touch this register for other domains.
(b) ARM Trusted Firmware needs to manage the clocks associated with
    these domains.

To elaborate on (b): idling a power domain has always required ungating
an array of clocks; see this old explanation from Rockchip:
https://lore.kernel.org/linux-arm-kernel/54503C19.9060607@rock-chips.com/

Historically, ARM Trusted Firmware has avoided this issue by using a
special PMU_CRU_GATEDIS_CON0 register -- this register ungates all the
necessary clocks -- when idling the memory controller. Unfortunately,
we've found that this register is not 100% sufficient; it does not turn
the relevant PLLs on [0].

So it's possible to trigger issues with something like the following:

1. enable a power domain (e.g., RK3399_PD_VDU) -- kernel will
   temporarily enable relevant clocks/PLLs, then turn them back off
   2. a PLL (e.g., PLL_NPLL) is part of the clock tree for
      RK3399_PD_VDU's clocks but otherwise unused; NPLL is disabled
3. perform a ddrfreq transition (rk3399_dmcfreq_target() -> ...
   drivers/clk/rockchip/clk-ddr.c / ROCKCHIP_SIP_DRAM_FREQ)
   4. ARM Trusted Firmware unagates VDU clocks (via PMU_CRU_GATEDIS_CON0)
   5. ARM Trusted firmware idles the memory controller domain
   6. Step 5 waits on the VDU domain/clocks, but NPLL is still off

i.e., we hang the system.

So for (b), we need to at a minimum manage the relevant PLLs on behalf
of firmware. It's easier to simply manage the whole clock tree, in a
similar way we do in rockchip_pd_power().

For (a), we need to provide mutual exclusion betwen rockchip_pd_power()
and firmware. To resolve that, we simply grab the PMU mutex and release
it when ddrfreq is done.

The Chromium OS kernel has been carrying versions of part of this hack
for a while, based on some new custom notifiers [1]. I've rewritten as a
simple function call between the drivers, which is OK because:

 * the PMU driver isn't enabled, and we don't have this problem at all
   (the firmware should have left us in an OK state, and there are no
   runtime conflicts); or
 * the PMU driver is present, and is a single instance.

And the power-domain driver cannot be removed, so there's no lifetime
management to worry about.

For completeness, there's a 'dmc_pmu_mutex' to guard (likely
theoretical?) probe()-time races. It's OK for the memory controller
driver to start running before the PMU, because the PMU will avoid any
critical actions during the block() sequence.

[0] The RK3399 TRM for PMU_CRU_GATEDIS_CON0 only talks about ungating
    clocks. Based on experimentation, we've found that it does not power
    up the necessary PLLs.

[1] CHROMIUM: soc: rockchip: power-domain: Add notifier to dmc driver
    https://chromium-review.googlesource.com/q/I242dbd706d352f74ff706f5cbf42ebb92f9bcc60
    Notably, the Chromium solution only handled conflict (a), not (b).
    In practice, item (b) wasn't a problem in many cases because we
    never managed to fully power off PLLs. Now that the (upstream) video
    decoder driver performs runtime clock management, we often power off
    NPLL.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/soc/rockchip/pm_domains.c | 118 ++++++++++++++++++++++++++++++
 include/soc/rockchip/pm_domains.h |  25 +++++++
 2 files changed, 143 insertions(+)
 create mode 100644 include/soc/rockchip/pm_domains.h

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 1b029e494274..bc0afc52299b 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -8,6 +8,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/err.h>
+#include <linux/mutex.h>
 #include <linux/pm_clock.h>
 #include <linux/pm_domain.h>
 #include <linux/of_address.h>
@@ -16,6 +17,7 @@
 #include <linux/clk.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
+#include <soc/rockchip/pm_domains.h>
 #include <dt-bindings/power/px30-power.h>
 #include <dt-bindings/power/rk3036-power.h>
 #include <dt-bindings/power/rk3066-power.h>
@@ -139,6 +141,109 @@ struct rockchip_pmu {
 #define DOMAIN_RK3568(name, pwr, req, wakeup)		\
 	DOMAIN_M(name, pwr, pwr, req, req, req, wakeup)
 
+/*
+ * Dynamic Memory Controller may need to coordinate with us -- see
+ * rockchip_pmu_block().
+ *
+ * dmc_pmu_mutex protects registration-time races, so DMC driver doesn't try to
+ * block() while we're initializing the PMU.
+ */
+static DEFINE_MUTEX(dmc_pmu_mutex);
+static struct rockchip_pmu *dmc_pmu;
+
+/*
+ * Block PMU transitions and make sure they don't interfere with ARM Trusted
+ * Firmware operations. There are two conflicts, noted in the comments below.
+ *
+ * Caller must unblock PMU transitions via rockchip_pmu_unblock().
+ */
+int rockchip_pmu_block(void)
+{
+	struct rockchip_pmu *pmu;
+	struct generic_pm_domain *genpd;
+	struct rockchip_pm_domain *pd;
+	int i, ret;
+
+	mutex_lock(&dmc_pmu_mutex);
+
+	/* No PMU (yet)? Then we just block rockchip_pmu_probe(). */
+	if (!dmc_pmu)
+		return 0;
+	pmu = dmc_pmu;
+
+	/*
+	 * mutex blocks all idle transitions: we can't touch the
+	 * PMU_BUS_IDLE_REQ (our ".idle_offset") register while ARM Trusted
+	 * Firmware might be using it.
+	 */
+	mutex_lock(&pmu->mutex);
+
+	/*
+	 * Power domain clocks: Per Rockchip, we *must* keep certain clocks
+	 * enabled for the duration of power-domain transitions. Most
+	 * transitions are handled by this driver, but some cases (in
+	 * particular, DRAM DVFS / memory-controller idle) must be handled by
+	 * firmware. Firmware can handle most clock management via a special
+	 * "ungate" register (PMU_CRU_GATEDIS_CON0), but unfortunately, this
+	 * doesn't handle PLLs. We can assist this transition by doing the
+	 * clock management on behalf of firmware.
+	 */
+	for (i = 0; i < pmu->genpd_data.num_domains; i++) {
+		genpd = pmu->genpd_data.domains[i];
+		if (genpd) {
+			pd = to_rockchip_pd(genpd);
+			ret = clk_bulk_enable(pd->num_clks, pd->clks);
+			if (ret < 0) {
+				dev_err(pmu->dev,
+					"failed to enable clks for domain '%s': %d\n",
+					genpd->name, ret);
+				goto err;
+			}
+		}
+	}
+
+	return 0;
+
+err:
+	for (i = i - 1; i >= 0; i--) {
+		genpd = pmu->genpd_data.domains[i];
+		if (genpd) {
+			pd = to_rockchip_pd(genpd);
+			clk_bulk_disable(pd->num_clks, pd->clks);
+		}
+	}
+	mutex_unlock(&pmu->mutex);
+	mutex_unlock(&dmc_pmu_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rockchip_pmu_block);
+
+/* Unblock PMU transitions. */
+void rockchip_pmu_unblock(void)
+{
+	struct rockchip_pmu *pmu;
+	struct generic_pm_domain *genpd;
+	struct rockchip_pm_domain *pd;
+	int i;
+
+	if (dmc_pmu) {
+		pmu = dmc_pmu;
+		for (i = 0; i < pmu->genpd_data.num_domains; i++) {
+			genpd = pmu->genpd_data.domains[i];
+			if (genpd) {
+				pd = to_rockchip_pd(genpd);
+				clk_bulk_disable(pd->num_clks, pd->clks);
+			}
+		}
+
+		mutex_unlock(&pmu->mutex);
+	}
+
+	mutex_unlock(&dmc_pmu_mutex);
+}
+EXPORT_SYMBOL_GPL(rockchip_pmu_unblock);
+
 static bool rockchip_pmu_domain_is_idle(struct rockchip_pm_domain *pd)
 {
 	struct rockchip_pmu *pmu = pd->pmu;
@@ -690,6 +795,12 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 
 	error = -ENODEV;
 
+	/*
+	 * Prevent any rockchip_pmu_block() from racing with the remainder of
+	 * setup (clocks, register initialization).
+	 */
+	mutex_lock(&dmc_pmu_mutex);
+
 	for_each_available_child_of_node(np, node) {
 		error = rockchip_pm_add_one_domain(pmu, node);
 		if (error) {
@@ -719,10 +830,17 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 		goto err_out;
 	}
 
+	/* We only expect one PMU. */
+	if (!WARN_ON_ONCE(dmc_pmu))
+		dmc_pmu = pmu;
+
+	mutex_unlock(&dmc_pmu_mutex);
+
 	return 0;
 
 err_out:
 	rockchip_pm_domain_cleanup(pmu);
+	mutex_unlock(&dmc_pmu_mutex);
 	return error;
 }
 
diff --git a/include/soc/rockchip/pm_domains.h b/include/soc/rockchip/pm_domains.h
new file mode 100644
index 000000000000..7dbd941fc937
--- /dev/null
+++ b/include/soc/rockchip/pm_domains.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2022, The Chromium OS Authors. All rights reserved.
+ */
+
+#ifndef __SOC_ROCKCHIP_PM_DOMAINS_H__
+#define __SOC_ROCKCHIP_PM_DOMAINS_H__
+
+#ifdef CONFIG_ROCKCHIP_PM_DOMAINS
+
+int rockchip_pmu_block(void);
+void rockchip_pmu_unblock(void);
+
+#else /* CONFIG_ROCKCHIP_PM_DOMAINS */
+
+static inline int rockchip_pmu_block(void)
+{
+	return 0;
+}
+
+static inline void rockchip_pmu_unblock(void) { }
+
+#endif /* CONFIG_ROCKCHIP_PM_DOMAINS */
+
+#endif /* __SOC_ROCKCHIP_PM_DOMAINS_H__ */
-- 
2.35.1.1094.g7c7d902a7c-goog

