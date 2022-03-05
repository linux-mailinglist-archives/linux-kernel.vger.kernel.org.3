Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66B14CE458
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 12:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiCELDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 06:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbiCELDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 06:03:10 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F3B42A3A
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 03:02:20 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b11so18330624lfb.12
        for <linux-kernel@vger.kernel.org>; Sat, 05 Mar 2022 03:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QtezqBfvBQqDRuuBd+mbRNujOo+NSYK6eGVKvKPxXek=;
        b=ETWXwjXJ0+6aGaHL0bcf1kwUm8cg9PfNj6ARTV+jrBf7PxDndBI9cy4DBOZrcHOi5v
         fgd2ldPOwSYWlA3umB7J7qrZlFGbGiyOMpw76+BCK0FweEFW+qHfKk1CWKGVSH+EYSMi
         +e86lJJsGLaEL/N2O6vz+okX7hE+yJWFE6Nlx/Kbx660nouzLR1h6ZVhuTnYRH9vOWjg
         cF1eUMcaSn2OkkWSqoJBQ2+RMSTaJfoh46NHm6toX9RLzGm68K+g5Zaf5wbs2zwL9znB
         zMZZGOnkFftgJ6QdaKvFG87hTXvciuZRLcV/qpaExdrGN0isP9QY/Jg2Xq4m+zdQUt20
         B5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QtezqBfvBQqDRuuBd+mbRNujOo+NSYK6eGVKvKPxXek=;
        b=m4SpFOX0hN/A2HIZQnTOGWeIVB7iP1VCBaEIIWtV5yr200YNGsum4Wkh9QHy992Y5X
         y670p9JpU0k0bwaU1MEoH1UIeWMWFipauzXnzTlx4TWT+XIw03caddJ3wGw17hkTIqcG
         99H1JXA1KHXa5Rb6bYpH5TitB4NsnA71Jbsn0ny7nEtvdmGlY//hwwJOtZT8qaeH9cx7
         BNYkvQE+Sy2IWK9SUP9UeofgHDuWsQo8HRroCl34pdloHQ96wKp9uJjbndi3IHHQiJ9w
         MQunL+vwwam5FCctFpjK5ocE0DFaD0U7C6Ve4nXGErvAJj5HxfwYEN0LVMrfcPDK8k8+
         P3Uw==
X-Gm-Message-State: AOAM5323t/KcJRcXsqR9dq4La9G0Z/nhpuhgE6d3jkL+TrZ9G3fuDflk
        52uDz8mkiYROXCeqXxuAm0hXSg==
X-Google-Smtp-Source: ABdhPJxvo+wmA7Cw0WFQHWHhB68tYqTKswrj0qufjQKhn/0DJ2pE5EZe7MZoeVrBJr59KjAF3XVrGQ==
X-Received: by 2002:a05:6512:48c:b0:443:3d4f:e559 with SMTP id v12-20020a056512048c00b004433d4fe559mr2028909lfq.309.1646478138036;
        Sat, 05 Mar 2022 03:02:18 -0800 (PST)
Received: from eriador.lan ([2001:470:dd84:abc0::8a5])
        by smtp.gmail.com with ESMTPSA id y13-20020a19750d000000b0044823678a20sm308789lfe.215.2022.03.05.03.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 03:02:17 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PM: core: keep irq flags in device_pm_check_callbacks
Date:   Sat,  5 Mar 2022 14:02:14 +0300
Message-Id: <20220305110214.3018986-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function device_pm_check_callbacks() can be called under the spin
lock (in the reported case it happens from genpd_add_device() ->
dev_pm_domain_set(), when the genpd uses spinlocks rather than mutexes.

However this function uncoditionally uses spin_lock_irq() /
spin_unlock_irq(), thus not preserving the CPU flags. Use the
irqsave/irqrestore instead.

The backtrace for the reference:
[    2.752010] ------------[ cut here ]------------
[    2.756769] raw_local_irq_restore() called with IRQs enabled
[    2.762596] WARNING: CPU: 4 PID: 1 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x34/0x50
[    2.772338] Modules linked in:
[    2.775487] CPU: 4 PID: 1 Comm: swapper/0 Tainted: G S                5.17.0-rc6-00384-ge330d0d82eff-dirty #684
[    2.781384] Freeing initrd memory: 46024K
[    2.785839] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    2.785841] pc : warn_bogus_irq_restore+0x34/0x50
[    2.785844] lr : warn_bogus_irq_restore+0x34/0x50
[    2.785846] sp : ffff80000805b7d0
[    2.785847] x29: ffff80000805b7d0 x28: 0000000000000000 x27: 0000000000000002
[    2.785850] x26: ffffd40e80930b18 x25: ffff7ee2329192b8 x24: ffff7edfc9f60800
[    2.785853] x23: ffffd40e80930b18 x22: ffffd40e80930d30 x21: ffff7edfc0dffa00
[    2.785856] x20: ffff7edfc09e3768 x19: 0000000000000000 x18: ffffffffffffffff
[    2.845775] x17: 6572206f74206465 x16: 6c696166203a3030 x15: ffff80008805b4f7
[    2.853108] x14: 0000000000000000 x13: ffffd40e809550b0 x12: 00000000000003d8
[    2.860441] x11: 0000000000000148 x10: ffffd40e809550b0 x9 : ffffd40e809550b0
[    2.867774] x8 : 00000000ffffefff x7 : ffffd40e809ad0b0 x6 : ffffd40e809ad0b0
[    2.875107] x5 : 000000000000bff4 x4 : 0000000000000000 x3 : 0000000000000000
[    2.882440] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff7edfc03a8000
[    2.889774] Call trace:
[    2.892290]  warn_bogus_irq_restore+0x34/0x50
[    2.896770]  _raw_spin_unlock_irqrestore+0x94/0xa0
[    2.901690]  genpd_unlock_spin+0x20/0x30
[    2.905724]  genpd_add_device+0x100/0x2d0
[    2.909850]  __genpd_dev_pm_attach+0xa8/0x23c
[    2.914329]  genpd_dev_pm_attach_by_id+0xc4/0x190
[    2.919167]  genpd_dev_pm_attach_by_name+0x3c/0xd0
[    2.924086]  dev_pm_domain_attach_by_name+0x24/0x30
[    2.929102]  psci_dt_attach_cpu+0x24/0x90
[    2.933230]  psci_cpuidle_probe+0x2d4/0x46c
[    2.937534]  platform_probe+0x68/0xe0
[    2.941304]  really_probe.part.0+0x9c/0x2fc
[    2.945605]  __driver_probe_device+0x98/0x144
[    2.950085]  driver_probe_device+0x44/0x15c
[    2.954385]  __device_attach_driver+0xb8/0x120
[    2.958950]  bus_for_each_drv+0x78/0xd0
[    2.962896]  __device_attach+0xd8/0x180
[    2.966843]  device_initial_probe+0x14/0x20
[    2.971144]  bus_probe_device+0x9c/0xa4
[    2.975092]  device_add+0x380/0x88c
[    2.978679]  platform_device_add+0x114/0x234
[    2.983067]  platform_device_register_full+0x100/0x190
[    2.988344]  psci_idle_init+0x6c/0xb0
[    2.992113]  do_one_initcall+0x74/0x3a0
[    2.996060]  kernel_init_freeable+0x2fc/0x384
[    3.000543]  kernel_init+0x28/0x130
[    3.004132]  ret_from_fork+0x10/0x20
[    3.007817] irq event stamp: 319826
[    3.011404] hardirqs last  enabled at (319825): [<ffffd40e7eda0268>] __up_console_sem+0x78/0x84
[    3.020332] hardirqs last disabled at (319826): [<ffffd40e7fd6d9d8>] el1_dbg+0x24/0x8c
[    3.028458] softirqs last  enabled at (318312): [<ffffd40e7ec90410>] _stext+0x410/0x588
[    3.036678] softirqs last disabled at (318299): [<ffffd40e7ed1bf68>] __irq_exit_rcu+0x158/0x174
[    3.045607] ---[ end trace 0000000000000000 ]---

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/base/power/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 04ea92cbd9cf..08c8a69d7b81 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -2018,7 +2018,9 @@ static bool pm_ops_is_empty(const struct dev_pm_ops *ops)
 
 void device_pm_check_callbacks(struct device *dev)
 {
-	spin_lock_irq(&dev->power.lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->power.lock, flags);
 	dev->power.no_pm_callbacks =
 		(!dev->bus || (pm_ops_is_empty(dev->bus->pm) &&
 		 !dev->bus->suspend && !dev->bus->resume)) &&
@@ -2027,7 +2029,7 @@ void device_pm_check_callbacks(struct device *dev)
 		(!dev->pm_domain || pm_ops_is_empty(&dev->pm_domain->ops)) &&
 		(!dev->driver || (pm_ops_is_empty(dev->driver->pm) &&
 		 !dev->driver->suspend && !dev->driver->resume));
-	spin_unlock_irq(&dev->power.lock);
+	spin_unlock_irqrestore(&dev->power.lock, flags);
 }
 
 bool dev_pm_skip_suspend(struct device *dev)
-- 
2.34.1

