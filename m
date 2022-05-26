Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E78B53496F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 05:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244748AbiEZDqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 23:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbiEZDqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 23:46:24 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1960BDA2C
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 20:46:18 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2fed274f3fbso3359867b3.17
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 20:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=o/QH0joN+MugcyRHull52tGgjdzjVgF+TdLryasZ3OQ=;
        b=RGPxjbKyMwcIxA2s03U5bdMAKmdBqar/f9ZLCnfb2UZlQH9CZS4tHnNV6daOpRgUNd
         wFwuE/fyGzgV+7YzA06Dyp8Cv9lGrB/NCoggmDp0xiqq2OsU2CDT70ANtBd/9H6RK8EW
         n8gpulIOK8U5yciXzMafYX69ntsdkCopahJA1BMxX8qhWZHNu1r2aGN9Ms07JlO6mPa/
         KNr9m6gIonyZvJb/NlGauCfUs+xNrcdIIKhYzRdgjZ37xULcphyrKW/3HhP7QMZ3s8ol
         BDHkO7ZOP/NTzHHG9yPPc2io1Z+f/zgD5h2lLO0VI2kDS9wZg7djwkBwygbLtWO7ZpI1
         zmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=o/QH0joN+MugcyRHull52tGgjdzjVgF+TdLryasZ3OQ=;
        b=yjVyWmXuKIUl+XXbYySTr55p3SmkMW7TzmfSgi/RWKft863DYBOsR+jl9qDO3Q55Ah
         2+2GFgAOrtyO3+nhR5iiPOsJ39ka7l9dpF0hs5ELSnxTnY+0q9lWFrzFypzPfAzxxAQP
         MNzcOBUAqa9wMqjACTWyhQrQHKAZZaOjza2YNyriqSgfdAuZ8qSG8rqWIDMODkkn9Mx8
         ECK6szw6tXJ/9jkwuxvYyQyyHHDo9W98mITr3CvsQknmG1ve0SO84jrZvzEnYSxR26lL
         ZxQ9tAss05pJvkuHgBoThQd5KpHF15UHqVv4BtkvcU1xVS5z6Zu+xrK4ybk5zLm4/YZq
         L+fA==
X-Gm-Message-State: AOAM5325ISBmewIKvbYhQk6VrqnluTHLAlWBBCtFnifcRPpTcKgnN+F8
        3uqsV5iZ93YaDexOVJk+F1340AOEK+hi5so=
X-Google-Smtp-Source: ABdhPJyTq9NixuM0Ihvbq7fgWYMs3p9ob+kOt9sgXq4qKiYBdS/V6BnGyENeSt/NfIcvpHnbJuwRLLL+/EBqkHM=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:cbc9:88bf:e847:ab95])
 (user=saravanak job=sendgmr) by 2002:a05:6902:102a:b0:64f:4132:9be with SMTP
 id x10-20020a056902102a00b0064f413209bemr32123591ybt.288.1653536777885; Wed,
 25 May 2022 20:46:17 -0700 (PDT)
Date:   Wed, 25 May 2022 20:46:08 -0700
In-Reply-To: <20220526034609.480766-1-saravanak@google.com>
Message-Id: <20220526034609.480766-2-saravanak@google.com>
Mime-Version: 1.0
References: <20220526034609.480766-1-saravanak@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH v1 1/2] driver core: Fix wait_for_device_probe() &
 deferred_probe_timeout interaction
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     kernel-team@android.com, linux-kernel@vger.kernel.org,
        John Stultz <jstultz@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Basil Eljuse <Basil.Eljuse@arm.com>,
        Ferry Toth <fntoth@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        linux-pm@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mounting NFS rootfs was timing out when deferred_probe_timeout was
non-zero [1].  This was because ip_auto_config() initcall times out
waiting for the network interfaces to show up when
deferred_probe_timeout was non-zero. While ip_auto_config() calls
wait_for_device_probe() to make sure any currently running deferred
probe work or asynchronous probe finishes, that wasn't sufficient to
account for devices being deferred until deferred_probe_timeout.

Commit 35a672363ab3 ("driver core: Ensure wait_for_device_probe() waits
until the deferred_probe_timeout fires") tried to fix that by making
sure wait_for_device_probe() waits for deferred_probe_timeout to expire
before returning.

However, if wait_for_device_probe() is called from the kernel_init()
context:

- Before deferred_probe_initcall() [2], it causes the boot process to
  hang due to a deadlock.

- After deferred_probe_initcall() [3], it blocks kernel_init() from
  continuing till deferred_probe_timeout expires and beats the point of
  deferred_probe_timeout that's trying to wait for userspace to load
  modules.

Neither of this is good. So revert the changes to
wait_for_device_probe().

[1] - https://lore.kernel.org/lkml/TYAPR01MB45443DF63B9EF29054F7C41FD8C60@TYAPR01MB4544.jpnprd01.prod.outlook.com/
[2] - https://lore.kernel.org/lkml/YowHNo4sBjr9ijZr@dev-arch.thelio-3990X/
[3] - https://lore.kernel.org/lkml/Yo3WvGnNk3LvLb7R@linutronix.de/

Cc: John Stultz <jstultz@google.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Rob Herring <robh@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Basil Eljuse <Basil.Eljuse@arm.com>
Cc: Ferry Toth <fntoth@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Anders Roxell <anders.roxell@linaro.org>
Cc: linux-pm@vger.kernel.org
Fixes: 35a672363ab3 ("driver core: Ensure wait_for_device_probe() waits until the deferred_probe_timeout fires")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---

 drivers/base/dd.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 2fc8507f59ee..91f63cd33b12 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -263,7 +263,6 @@ int driver_deferred_probe_timeout;
 #endif
 
 EXPORT_SYMBOL_GPL(driver_deferred_probe_timeout);
-static DECLARE_WAIT_QUEUE_HEAD(probe_timeout_waitqueue);
 
 static int __init deferred_probe_timeout_setup(char *str)
 {
@@ -318,7 +317,6 @@ static void deferred_probe_timeout_work_func(struct work_struct *work)
 	list_for_each_entry(p, &deferred_probe_pending_list, deferred_probe)
 		dev_info(p->device, "deferred probe pending\n");
 	mutex_unlock(&deferred_probe_mutex);
-	wake_up_all(&probe_timeout_waitqueue);
 }
 static DECLARE_DELAYED_WORK(deferred_probe_timeout_work, deferred_probe_timeout_work_func);
 
@@ -736,9 +734,6 @@ int driver_probe_done(void)
  */
 void wait_for_device_probe(void)
 {
-	/* wait for probe timeout */
-	wait_event(probe_timeout_waitqueue, !driver_deferred_probe_timeout);
-
 	/* wait for the deferred probe workqueue to finish */
 	flush_work(&deferred_probe_work);
 
-- 
2.36.1.124.g0e6072fb45-goog

