Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB6249BA39
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1587980AbiAYRU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1587610AbiAYRSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:18:32 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEBEC061763
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 09:18:31 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id r25so4488113wrc.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 09:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oPK1edLyJrRFFEyWcyiec8UXIbfSrQa/ueeEQUG7KDE=;
        b=RBU/1hiKjmlJ/Dsr3f5tqnVKDSzIfG098aUQFPkk8pdvkwB9NxZ9fq978c+MJXXa9/
         zVgVf1bmsirhIaK0aosP+k8kVheG0uePIBt2bXmWmJRAazGxqVRqhNNdpJlJDy7JANVf
         Q63Y/moYNAdGodSAJcMXeoYipauvf5OicgkYR87blsbq5ItgeusS0XkJbd/sl+9A2R2U
         +CNv3ki9rKVXRCpMe2+lmnJnXEdNAFXqDbZ1A1TBL++/iIRFY0aqYTEg2BgkW04HDGvh
         WfPCtqkyNSoqU/nSkvCbR093D4fDEHRktLYmUjnBMx7Iq0BETJ+TbZAp4lsvT7Lwgrct
         DbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oPK1edLyJrRFFEyWcyiec8UXIbfSrQa/ueeEQUG7KDE=;
        b=Za3GRrgnw4dtGqw4XnIBz133zDljkjjaMlLEwBLLbWDGgCX7vqku/XKiYUA0PrQ6EV
         RnclJmbDyn5dWJrOMLwQD4u3R9Z1r7uesafpIzOREwM8KJGzFCG06nr3Oz+Hhn9I7/Bc
         BpB/sLrjSqs/UzxhDQ5F6rgn7EhYZ4YnUt5DZMy+Bx2bwoFNcBhQLfjcLEpCQ1cLzrrd
         VU1sszRfCnMNoH0UfgcSaDdW0ehBGNQrpqvfoOtnIJM8FgbbVi+VXcZtWqqmT4F77tvX
         6P5f521GlpHph8m5hl9EOrtwplIvVvVqFjERYojhxKujTJA2wHzVg3lqH5WBO/n3Pw8h
         P7Aw==
X-Gm-Message-State: AOAM533Dx88Vo18Ny5XMe/txgSRFY61R4YARTgqwJVTKKNlwxI/hvro+
        6b+KFs3GeR0BcMsvS+LeW6csRQ==
X-Google-Smtp-Source: ABdhPJzButqKQFOvZwcUyr9EDDzPhcmJ8XRTMpdAQyrjNaDbtrxGArgpECjJWYYyEKSsXv4rRmFvKg==
X-Received: by 2002:a05:6000:1091:: with SMTP id y17mr19040004wrw.310.1643131109892;
        Tue, 25 Jan 2022 09:18:29 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:f589:cf7d:b2ee:bb5e])
        by smtp.gmail.com with ESMTPSA id t18sm17561901wri.34.2022.01.25.09.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 09:18:29 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     robh@kernel.org, lukasz.luba@arm.com, heiko@sntech.de,
        arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v7 3/5] powercap/drivers/dtpm: Add CPU DT initialization support
Date:   Tue, 25 Jan 2022 18:18:07 +0100
Message-Id: <20220125171809.1273269-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220125171809.1273269-1-daniel.lezcano@linaro.org>
References: <20220125171809.1273269-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the previous DT changes in the core code, use the 'setup'
callback to initialize the CPU DTPM backend.

Code is reorganized to stick to the DTPM table description. No
functional changes.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/powercap/dtpm_cpu.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 5763e0ce2af5..eed5ad688d46 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -21,6 +21,7 @@
 #include <linux/cpuhotplug.h>
 #include <linux/dtpm.h>
 #include <linux/energy_model.h>
+#include <linux/of.h>
 #include <linux/pm_qos.h>
 #include <linux/slab.h>
 #include <linux/units.h>
@@ -176,6 +177,17 @@ static int cpuhp_dtpm_cpu_offline(unsigned int cpu)
 }
 
 static int cpuhp_dtpm_cpu_online(unsigned int cpu)
+{
+	struct dtpm_cpu *dtpm_cpu;
+
+	dtpm_cpu = per_cpu(dtpm_per_cpu, cpu);
+	if (dtpm_cpu)
+		return dtpm_update_power(&dtpm_cpu->dtpm);
+
+	return 0;
+}
+
+static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
 {
 	struct dtpm_cpu *dtpm_cpu;
 	struct cpufreq_policy *policy;
@@ -183,6 +195,10 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 	char name[CPUFREQ_NAME_LEN];
 	int ret = -ENOMEM;
 
+	dtpm_cpu = per_cpu(dtpm_per_cpu, cpu);
+	if (dtpm_cpu)
+		return 0;
+
 	policy = cpufreq_cpu_get(cpu);
 	if (!policy)
 		return 0;
@@ -191,10 +207,6 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 	if (!pd)
 		return -EINVAL;
 
-	dtpm_cpu = per_cpu(dtpm_per_cpu, cpu);
-	if (dtpm_cpu)
-		return dtpm_update_power(&dtpm_cpu->dtpm);
-
 	dtpm_cpu = kzalloc(sizeof(*dtpm_cpu), GFP_KERNEL);
 	if (!dtpm_cpu)
 		return -ENOMEM;
@@ -207,7 +219,7 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 
 	snprintf(name, sizeof(name), "cpu%d-cpufreq", dtpm_cpu->cpu);
 
-	ret = dtpm_register(name, &dtpm_cpu->dtpm, NULL);
+	ret = dtpm_register(name, &dtpm_cpu->dtpm, parent);
 	if (ret)
 		goto out_kfree_dtpm_cpu;
 
@@ -231,7 +243,18 @@ static int cpuhp_dtpm_cpu_online(unsigned int cpu)
 	return ret;
 }
 
-static int __init dtpm_cpu_init(void)
+static int dtpm_cpu_setup(struct dtpm *dtpm, struct device_node *np)
+{
+	int cpu;
+
+	cpu = of_cpu_node_to_id(np);
+	if (cpu < 0)
+		return 0;
+
+	return __dtpm_cpu_setup(cpu, dtpm);
+}
+
+static int dtpm_cpu_init(void)
 {
 	int ret;
 
@@ -272,4 +295,5 @@ static int __init dtpm_cpu_init(void)
 struct dtpm_subsys_ops dtpm_cpu_ops = {
 	.name = KBUILD_MODNAME,
 	.init = dtpm_cpu_init,
+	.setup = dtpm_cpu_setup,
 };
-- 
2.25.1

