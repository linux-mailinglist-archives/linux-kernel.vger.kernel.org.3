Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F61C4C3D4F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 05:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237418AbiBYEeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 23:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiBYEd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 23:33:56 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16281A1C79
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 20:33:19 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 12so3635246pgd.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 20:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VZkOlRt88Na/YIqisqjyj2BrBEh3KUo347ybRf+z+Ic=;
        b=un52FzTjhgh2y02vmXU26Y6/z8V7sSU6RB9y+jOPuoyHleqbjRwuf65CsiH54Ll7NC
         S8+s8bVzT9LB31pMGqlaLLIOQBf5iGoAg/1VOqY6QdSTE/L0Z7+ufXEUL90Bl9ubog74
         ow0grIYR6bfy2WeDnOCovJNmmeXz4x2fWhhM9wqwW90gZGERdv9bJtNS44Aziu5WuVgr
         Y22yRh3oqL6n4arLU9Fp9lAA+MHZ6/rEP3bXTijArNmRIfi9p/ehXLDAqzGQ4KlA3Zbh
         1cboCiGwxbLF7fy56/Ow07LdVDP+Sj7lQGgqhzXqH+NVuYHtk9bFC0ylBZ4U049Oq51g
         ko8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VZkOlRt88Na/YIqisqjyj2BrBEh3KUo347ybRf+z+Ic=;
        b=uI4eRBjpVFoN4KeA/ChhQbA2BcSmIrnNzoP7x0CAI33l0zjjlwMTM4jiunI95rQf82
         d/enBcpPwA6nM8T8D7kheE/EUpOnWXQTVnEaE3mAQs3h2rdk7Cnyr1qYaJVKN3hO7iXU
         ydGnbTZJTHJS6bY12G7LinQdCFNVUmKIaiGSAnCQlIkrKjroR8LJ2WCPWFxnZPfnzw+r
         a9xuB9MOPhLCjeQxOemHoUvMWXxGhSRPEXeSpGVsZmT5Tu3AunBa6Hi3d1P14OcV9QjX
         j77QW+GZaUi3Wo4Vfu+FF6utGiSSiiT85lp6UoImfuWmp29uygXVDmpgGjwY5jZmVl6o
         BJhg==
X-Gm-Message-State: AOAM531oO60SZiyuNZPIbWxK1f0OSVBQTr7+6NNK22pV+QyDzmysv2+A
        KS0aN7aHjqvJQxySc8OWO9nUkg==
X-Google-Smtp-Source: ABdhPJy1eCKA21boP2GiNKnr8q1vQhvyXy9+Jh/H8EknNNz2D2K0yH8OGWHIP7FvjI4etf0gwweLSQ==
X-Received: by 2002:a63:3d5:0:b0:373:6b1:8e65 with SMTP id 204-20020a6303d5000000b0037306b18e65mr4671440pgd.408.1645763599113;
        Thu, 24 Feb 2022 20:33:19 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id s22-20020a056a0008d600b004f0eaa735f2sm1103505pfu.57.2022.02.24.20.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 20:33:18 -0800 (PST)
Date:   Fri, 25 Feb 2022 12:33:11 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] PM: cpu: Add CPU_LAST_PM_ENTER and
 CPU_FIRST_PM_EXIT support
Message-ID: <20220225043311.GB269879@dragon>
References: <20220223125536.230224-1-shawn.guo@linaro.org>
 <20220223125536.230224-2-shawn.guo@linaro.org>
 <20220223193050.y7parhlmnspcyom3@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223193050.y7parhlmnspcyom3@bogus>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 07:30:50PM +0000, Sudeep Holla wrote:
> On Wed, Feb 23, 2022 at 08:55:34PM +0800, Shawn Guo wrote:
> > It becomes a common situation on some platforms that certain hardware
> > setup needs to be done on the last standing cpu, and rpmh-rsc[1] is such
> > an existing example.  As figuring out the last standing cpu is really
> > something generic, it adds CPU_LAST_PM_ENTER (and CPU_FIRST_PM_EXIT)
> > event support to cpu_pm helper, so that individual driver can be
> > notified when the last standing cpu is about to enter low power state.
> 
> Sorry for not getting back on the previous email thread.
> When I meant I didn't want to use CPU_CLUSTER_PM_{ENTER,EXIT}, I wasn't
> thinking new ones to be added as alternative. With this OSI cpuidle, we
> have introduces the concept of power domains and I was check if we can
> associate these requirements to them rather than introducing the first
> and last cpu notion. The power domains already identify them in order
> to turn on or off. Not sure if there is any notification mechanism in
> genpd/power domains. I really don't like this addition. It is disintegrating
> all the solutions for OSI and makes it hard to understand.
> 
> One solution I can think of(not sure if others like or if that is feasible)
> is to create a parent power domain that encloses all the last level CPU
> power domains, which means when the last one is getting powered off, you
> will be asked to power off and you can take whatever action you want.

Thanks Sudeep for the input!  Yes, it works for me (if I understand your
suggestion correctly).  So the needed changes on top of the current
version would be:

1) Declare MPM as a PD (power domain) provider and have it be the
   parent PD of cpu cluster (the platform has only one cluster including
   4 cpus).

diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
index 5bc5ce0b5d77..0cd0a9722ec5 100644
--- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
@@ -240,6 +240,7 @@ CPU_PD3: cpu3 {
 
                CLUSTER_PD: cpu-cluster0 {
                        #power-domain-cells = <0>;
+                       power-domains = <&mpm>;
                        domain-idle-states = <&CLUSTER_SLEEP_0>;
                };
        };
@@ -490,6 +491,7 @@ mpm: interrupt-controller@45f01b8 {
                        interrupt-controller;
                        interrupt-parent = <&intc>;
                        #interrupt-cells = <2>;
+                       #power-domain-cells = <0>;
                        qcom,mpm-pin-count = <96>;
                        qcom,mpm-pin-map = <2 275>,     /* tsens0_tsens_upper_lower_int */
                                           <5 296>,     /* lpass_irq_out_sdc */


2) Add PD in MPM driver and call qcom_mpm_enter_sleep() from .power_off
   hook of the PD.

diff --git a/drivers/irqchip/qcom-mpm.c b/drivers/irqchip/qcom-mpm.c
index d3d8251e57e4..f4409c169a3a 100644
--- a/drivers/irqchip/qcom-mpm.c
+++ b/drivers/irqchip/qcom-mpm.c
@@ -4,7 +4,6 @@
  * Copyright (c) 2010-2020, The Linux Foundation. All rights reserved.
  */
 
-#include <linux/cpu_pm.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/init.h>
@@ -18,6 +17,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/slab.h>
 #include <linux/soc/qcom/irq.h>
 #include <linux/spinlock.h>
@@ -84,7 +84,7 @@ struct qcom_mpm_priv {
 	unsigned int map_cnt;
 	unsigned int reg_stride;
 	struct irq_domain *domain;
-	struct notifier_block pm_nb;
+	struct generic_pm_domain genpd;
 };
 
 static u32 qcom_mpm_read(struct qcom_mpm_priv *priv, unsigned int reg,
@@ -312,23 +312,12 @@ static int qcom_mpm_enter_sleep(struct qcom_mpm_priv *priv)
 	return 0;
 }
 
-static int qcom_mpm_cpu_pm_callback(struct notifier_block *nb,
-				    unsigned long action, void *data)
+static int mpm_pd_power_off(struct generic_pm_domain *genpd)
 {
-	struct qcom_mpm_priv *priv = container_of(nb, struct qcom_mpm_priv,
-						  pm_nb);
-	int ret = NOTIFY_OK;
-
-	switch (action) {
-	case CPU_LAST_PM_ENTER:
-		if (qcom_mpm_enter_sleep(priv))
-			ret = NOTIFY_BAD;
-		break;
-	default:
-		ret = NOTIFY_DONE;
-	}
+	struct qcom_mpm_priv *priv = container_of(genpd, struct qcom_mpm_priv,
+						  genpd);
 
-	return ret;
+	return qcom_mpm_enter_sleep(priv);
 }
 
 static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
@@ -336,6 +325,7 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
 	struct platform_device *pdev = of_find_device_by_node(np);
 	struct device *dev = &pdev->dev;
 	struct irq_domain *parent_domain;
+	struct generic_pm_domain *genpd;
 	struct qcom_mpm_priv *priv;
 	unsigned int pin_cnt;
 	int i, irq;
@@ -387,6 +377,26 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
 	if (irq < 0)
 		return irq;
 
+	genpd = &priv->genpd;
+	genpd->flags = GENPD_FLAG_IRQ_SAFE;
+	genpd->power_off = mpm_pd_power_off;
+
+	genpd->name = devm_kasprintf(dev, GFP_KERNEL, "%s", dev_name(dev));
+	if (!genpd->name)
+		return -ENOMEM;
+
+	ret = pm_genpd_init(genpd, NULL, false);
+	if (ret) {
+		dev_err(dev, "failed to init genpd: %d\n", ret);
+		return ret;
+	}
+
+	ret = of_genpd_add_provider_simple(np, genpd);
+	if (ret) {
+		dev_err(dev, "failed to add genpd provider: %d\n", ret);
+		goto remove_genpd;
+	}
+
 	priv->mbox_client.dev = dev;
 	priv->mbox_chan = mbox_request_channel(&priv->mbox_client, 0);
 	if (IS_ERR(priv->mbox_chan)) {
@@ -420,15 +430,14 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
 		goto remove_domain;
 	}
 
-	priv->pm_nb.notifier_call = qcom_mpm_cpu_pm_callback;
-	cpu_pm_register_notifier(&priv->pm_nb);
-
 	return 0;
 
 remove_domain:
 	irq_domain_remove(priv->domain);
 free_mbox:
 	mbox_free_channel(priv->mbox_chan);
+remove_genpd:
+	pm_genpd_remove(genpd);
 	return ret;
 }
 

Let's me know if this is what you are asking for, thanks!

Shawn
