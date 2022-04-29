Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8079051580B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381328AbiD2WNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238948AbiD2WM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:12:57 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE73DCA97
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:09:38 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f4dee8688cso85667947b3.16
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 15:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hKM9bITdw0PGb2XwX81mFD9iQzTpEY1OKJb9nL2wmVM=;
        b=OoLk1SvFv/jTJtrMYW0SOQyQRGCBGpFgc/vEoNllR1AaKSyYPbAn38fZE7kG1JaLNw
         sexAk7BDkPLMod8qlp9KvRVu4XZVkwoG6sot1ziSm12s8n1f0lWwP3pd4NZO9hDjSCIo
         n4EVt4n/T4i6LWzvHIC5efT4Il77PiWFZq+vsVus4b88F/GLYaYnxrTF2BhYrTHjVvyZ
         YJSlHx/76rMlgL8unw+vVcNr0SJeZky16wGNg4m9e30BDCrhD2L42ccHx+nJLraDz9Cv
         QE7K62V9FK7wicbv99MdhKS9km/Q3/YCc5Tw9pA87iGWFI/wHo6va2SanzKXtugCTKxa
         BOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hKM9bITdw0PGb2XwX81mFD9iQzTpEY1OKJb9nL2wmVM=;
        b=ijBTddNgwJ2KXj1ocEDyeoN2xPyxls0bct5fYzz8gbM9w+0jRjOVfX6bK15qbOydzA
         jX8mLC9Jy9yMy0U8zNv2th5Dd+NH+WjYKpDvfFq8sDstEo9qcHVsZBsqciGFRnNH8Nqb
         9EF4LpHvG+hbtMNF2+4TK1mCFEO6bLTFy3JfzdCRslkXSFv1PTFQTXDrkumYrokdCfUd
         N/zSG9JrwSt1nSnK2ctKBWnzy3XRuRTtjKHPoPcviw2UMEo04KmagvicfO026c8D4ppM
         xy5tL9EW2zH1dyzdycdhHyqCkaEFEKAtCy2J0heKa6OA1w0Y+Qm9TpT5yFkFgYFPWONL
         Kpow==
X-Gm-Message-State: AOAM530+lCQc6mioQwbyDAqI6x4CLiMy9VlEk2YkVvDlUlOsuUsVF9xL
        DmuVmRXgIUkt+PaRmdp6E+LO7UyEnaB2ZO0=
X-Google-Smtp-Source: ABdhPJwkaqvpwIOQfXloIgXrKBqVrkXz9dU2lTi8+9Th0do7w1YPgiKZjeu5emN11KLpq4+CmhlxSMcUnqAj3JA=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:52dc:281f:8619:9d36])
 (user=saravanak job=sendgmr) by 2002:a81:b88:0:b0:2f7:ccdd:642f with SMTP id
 130-20020a810b88000000b002f7ccdd642fmr1475417ywl.303.1651270177291; Fri, 29
 Apr 2022 15:09:37 -0700 (PDT)
Date:   Fri, 29 Apr 2022 15:09:32 -0700
Message-Id: <20220429220933.1350374-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v1] driver core: Extend deferred probe timeout on driver registration
From:   Saravana Kannan <saravanak@google.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Will Deacon <will@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        iommu@lists.linux-foundation.org, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The deferred probe timer that's used for this currently starts at
late_initcall and runs for driver_deferred_probe_timeout seconds. The
assumption being that all available drivers would be loaded and
registered before the timer expires. This means, the
driver_deferred_probe_timeout has to be pretty large for it to cover the
worst case. But if we set the default value for it to cover the worst
case, it would significantly slow down the average case. For this
reason, the default value is set to 0.

Also, with CONFIG_MODULES=y and the current default values of
driver_deferred_probe_timeout=0 and fw_devlink=on, devices with missing
drivers will cause their consumer devices to always defer their probes.
This is because device links created by fw_devlink defer the probe even
before the consumer driver's probe() is called.

Instead of a fixed timeout, if we extend an unexpired deferred probe
timer on every successful driver registration, with the expectation more
modules would be loaded in the near future, then the default value of
driver_deferred_probe_timeout only needs to be as long as the worst case
time difference between two consecutive module loads.

So let's implement that and set the default value to 10 seconds when
CONFIG_MODULES=y.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Rob Herring <robh@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Will Deacon <will@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc: linux-gpio@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 ++++--
 drivers/base/base.h                           |  1 +
 drivers/base/dd.c                             | 19 +++++++++++++++++++
 drivers/base/driver.c                         |  1 +
 4 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7123524a86b8..fcc1dfc877a9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -939,8 +939,10 @@
 			[KNL] Debugging option to set a timeout in seconds for
 			deferred probe to give up waiting on dependencies to
 			probe. Only specific dependencies (subsystems or
-			drivers) that have opted in will be ignored. A timeout of 0
-			will timeout at the end of initcalls. This option will also
+			drivers) that have opted in will be ignored. A timeout
+			of 0 will timeout at the end of initcalls. If the time
+			out hasn't expired, it'll be restarted by each
+			successful driver registration. This option will also
 			dump out devices still on the deferred probe list after
 			retrying.
 
diff --git a/drivers/base/base.h b/drivers/base/base.h
index 2882af26392a..ab71403d102f 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -159,6 +159,7 @@ extern char *make_class_name(const char *name, struct kobject *kobj);
 extern int devres_release_all(struct device *dev);
 extern void device_block_probing(void);
 extern void device_unblock_probing(void);
+extern void deferred_probe_extend_timeout(void);
 
 /* /sys/devices directory */
 extern struct kset *devices_kset;
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index f47cab21430f..603379b5f9dd 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -255,7 +255,12 @@ static int deferred_devs_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(deferred_devs);
 
+#ifdef CONFIG_MODULES
+int driver_deferred_probe_timeout = 10;
+#else
 int driver_deferred_probe_timeout;
+#endif
+
 EXPORT_SYMBOL_GPL(driver_deferred_probe_timeout);
 static DECLARE_WAIT_QUEUE_HEAD(probe_timeout_waitqueue);
 
@@ -315,6 +320,20 @@ static void deferred_probe_timeout_work_func(struct work_struct *work)
 }
 static DECLARE_DELAYED_WORK(deferred_probe_timeout_work, deferred_probe_timeout_work_func);
 
+void deferred_probe_extend_timeout(void)
+{
+	/*
+	 * If the work hasn't been queued yet or if the work expired, don't
+	 * start a new one.
+	 */
+	if (cancel_delayed_work(&deferred_probe_timeout_work)) {
+		schedule_delayed_work(&deferred_probe_timeout_work,
+				driver_deferred_probe_timeout * HZ);
+		pr_debug("Extended deferred probe timeout by %d secs\n",
+					driver_deferred_probe_timeout);
+	}
+}
+
 /**
  * deferred_probe_initcall() - Enable probing of deferred devices
  *
diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index 8c0d33e182fd..77a77b2095cd 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -177,6 +177,7 @@ int driver_register(struct device_driver *drv)
 		return ret;
 	}
 	kobject_uevent(&drv->p->kobj, KOBJ_ADD);
+	deferred_probe_extend_timeout();
 
 	return ret;
 }
-- 
2.36.0.464.gb9c8b46e94-goog

