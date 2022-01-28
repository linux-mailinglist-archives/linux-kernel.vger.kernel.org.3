Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C4B49FFC4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347431AbiA1RsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 12:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbiA1RsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:48:24 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80046C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 09:48:24 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id s9so12291073wrb.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 09:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iqkFOAkjr/CoSvch7L8qUsJD6WSchp1qw+iBKpjdcjw=;
        b=IP7iqnbYkgR7H0maenHsfs8aIxyeccBCnu+GtQn83TJPALAizbxKU2QMU7ihlvMdF4
         yN9bK4iQjdB2OyGt9pOrV8oEJLGs8A6sFtmXdqylWXCDa2jCwiP0rHdc8mKMF2yLW4qq
         X7rGimp1FDvdP0M2pJ+NYq/rVLheJAyPbIfFk3gnEetpMbvR2fqzKJQT851q3TWNQF+n
         7hiYxbpRNvccEKXYFBqZHz5mGSguEmUcmRGg9YGCg9lOhLLLcxpYzQwCHIx2k3Zffw5n
         eV/z68kL0yA303RNgn1qZp50F3UBcxBax6J2lHsq7Q9PHacGlbU+9kw9ns3KyWxkl3vQ
         EE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iqkFOAkjr/CoSvch7L8qUsJD6WSchp1qw+iBKpjdcjw=;
        b=t5hVT18ljRABck4I5q+dd9KQlKLTN9aSPCHIclIXhfAXVH9lfV+jkJXMfmsbOVLwkn
         KeSug37+jV/A3EgSWifay8B4pS1VWK2lP92QN+/IaH0YrTbMQZezr2S8MjRlUXXa+ZI4
         U8eRJxkO98ApPn61AJAvv7T7QmSusia/w258S4UQO5xJ6ygOz11kxgp2QHPNsnp9GFnX
         P9Z8PbBkZdXig+gaPn+2hYgPwQm47eO9d+SmBXlZYg7PlWKm87iMpv6lCXx5cltRg/u/
         iMFy5G2nmWtMeHwSTklCbx1txPuFyG2jAQjUBVwY4+rTWfzp1ILYSZb6byAv7mShcaAJ
         zCzQ==
X-Gm-Message-State: AOAM532PUznP/QZgx8MCHoAxEDgrkxsDQG803u1VhC4/S+usB/h7W26D
        wkSu7QkMk1Q41e9/os9IrRO4Sw==
X-Google-Smtp-Source: ABdhPJwyuV1GmA1fW5Dt7efa808kcWDbfbLETNXASznINJTGYA1I/UsORm2utPT1LAFfpI6nKS0csA==
X-Received: by 2002:a5d:63d1:: with SMTP id c17mr7925324wrw.6.1643392102996;
        Fri, 28 Jan 2022 09:48:22 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id b1sm6067090wrd.12.2022.01.28.09.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 09:48:22 -0800 (PST)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: i2c-hid: goodix: Fix a lockdep splat
Date:   Fri, 28 Jan 2022 17:46:25 +0000
Message-Id: <20220128174625.321750-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm was on the receiving end of a lockdep splat from this driver and after
scratching my head I couldn't be entirely sure it was a false positive
given we would also have to think about whether the regulator locking is
safe (since the notifier is called whilst holding regulator locks which
are also needed for regulator_is_enabled() ).

Regardless of whether it is a real bug or not, the mutex isn't needed.
We can use reference counting tricks instead to avoid races with the
notifier calls.

The observed splat follows:

------------------------------------------------------
kworker/u16:3/127 is trying to acquire lock:
ffff00008021fb20 (&ihid_goodix->regulator_mutex){+.+.}-{4:4}, at: ihid_goodix_vdd_notify+0x30/0x94

but task is already holding lock:
ffff0000835c60c0 (&(&rdev->notifier)->rwsem){++++}-{4:4}, at: blocking_notifier_call_chain+0x30/0x70

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&(&rdev->notifier)->rwsem){++++}-{4:4}:
       down_write+0x68/0x8c
       blocking_notifier_chain_register+0x54/0x70
       regulator_register_notifier+0x1c/0x24
       devm_regulator_register_notifier+0x58/0x98
       i2c_hid_of_goodix_probe+0xdc/0x158
       i2c_device_probe+0x25d/0x270
       really_probe+0x174/0x2cc
       __driver_probe_device+0xc0/0xd8
       driver_probe_device+0x50/0xe4
       __device_attach_driver+0xa8/0xc0
       bus_for_each_drv+0x9c/0xc0
       __device_attach_async_helper+0x6c/0xbc
       async_run_entry_fn+0x38/0x100
       process_one_work+0x294/0x438
       worker_thread+0x180/0x258
       kthread+0x120/0x130
       ret_from_fork+0x10/0x20

-> #0 (&ihid_goodix->regulator_mutex){+.+.}-{4:4}:
       __lock_acquire+0xd24/0xfe8
       lock_acquire+0x288/0x2f4
       __mutex_lock+0xa0/0x338
       mutex_lock_nested+0x3c/0x5c
       ihid_goodix_vdd_notify+0x30/0x94
       notifier_call_chain+0x6c/0x8c
       blocking_notifier_call_chain+0x48/0x70
       _notifier_call_chain.isra.0+0x18/0x20
       _regulator_enable+0xc0/0x178
       regulator_enable+0x40/0x7c
       goodix_i2c_hid_power_up+0x18/0x20
       i2c_hid_core_power_up.isra.0+0x1c/0x2c
       i2c_hid_core_probe+0xd8/0x3d4
       i2c_hid_of_goodix_probe+0x14c/0x158
       i2c_device_probe+0x25c/0x270
       really_probe+0x174/0x2cc
       __driver_probe_device+0xc0/0xd8
       driver_probe_device+0x50/0xe4
       __device_attach_driver+0xa8/0xc0
       bus_for_each_drv+0x9c/0xc0
       __device_attach_async_helper+0x6c/0xbc
       async_run_entry_fn+0x38/0x100
       process_one_work+0x294/0x438
       worker_thread+0x180/0x258
       kthread+0x120/0x130
       ret_from_fork+0x10/0x20

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&(&rdev->notifier)->rwsem);
                               lock(&ihid_goodix->regulator_mutex);
                               lock(&(&rdev->notifier)->rwsem);
  lock(&ihid_goodix->regulator_mutex);

 *** DEADLOCK ***

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/hid/i2c-hid/i2c-hid-of-goodix.c | 28 +++++++++++--------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-of-goodix.c b/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
index b4dad66fa954d..ec6c73f75ffe0 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
@@ -27,7 +27,6 @@ struct i2c_hid_of_goodix {

 	struct regulator *vdd;
 	struct notifier_block nb;
-	struct mutex regulator_mutex;
 	struct gpio_desc *reset_gpio;
 	const struct goodix_i2c_hid_timing_data *timings;
 };
@@ -67,8 +66,6 @@ static int ihid_goodix_vdd_notify(struct notifier_block *nb,
 		container_of(nb, struct i2c_hid_of_goodix, nb);
 	int ret = NOTIFY_OK;

-	mutex_lock(&ihid_goodix->regulator_mutex);
-
 	switch (event) {
 	case REGULATOR_EVENT_PRE_DISABLE:
 		gpiod_set_value_cansleep(ihid_goodix->reset_gpio, 1);
@@ -87,8 +84,6 @@ static int ihid_goodix_vdd_notify(struct notifier_block *nb,
 		break;
 	}

-	mutex_unlock(&ihid_goodix->regulator_mutex);
-
 	return ret;
 }

@@ -102,8 +97,6 @@ static int i2c_hid_of_goodix_probe(struct i2c_client *client,
 	if (!ihid_goodix)
 		return -ENOMEM;

-	mutex_init(&ihid_goodix->regulator_mutex);
-
 	ihid_goodix->ops.power_up = goodix_i2c_hid_power_up;
 	ihid_goodix->ops.power_down = goodix_i2c_hid_power_down;

@@ -130,25 +123,28 @@ static int i2c_hid_of_goodix_probe(struct i2c_client *client,
 	 *   long. Holding the controller in reset apparently draws extra
 	 *   power.
 	 */
-	mutex_lock(&ihid_goodix->regulator_mutex);
 	ihid_goodix->nb.notifier_call = ihid_goodix_vdd_notify;
 	ret = devm_regulator_register_notifier(ihid_goodix->vdd, &ihid_goodix->nb);
-	if (ret) {
-		mutex_unlock(&ihid_goodix->regulator_mutex);
+	if (ret)
 		return dev_err_probe(&client->dev, ret,
 			"regulator notifier request failed\n");
-	}

 	/*
 	 * If someone else is holding the regulator on (or the regulator is
 	 * an always-on one) we might never be told to deassert reset. Do it
-	 * now. Here we'll assume that someone else might have _just
-	 * barely_ turned the regulator on so we'll do the full
-	 * "post_power_delay" just in case.
+	 * now... and temporarily bump the regulator reference count just to
+	 * make sure it is impossible for this to race with our own notifier!
+	 * We also assume that someone else might have _just barely_ turned
+	 * the regulator on so we'll do the full "post_power_delay" just in
+	 * case.
 	 */
-	if (ihid_goodix->reset_gpio && regulator_is_enabled(ihid_goodix->vdd))
+	if (ihid_goodix->reset_gpio && regulator_is_enabled(ihid_goodix->vdd)) {
+		ret = regulator_enable(ihid_goodix->vdd);
+		if (ret)
+			return ret;
 		goodix_i2c_hid_deassert_reset(ihid_goodix, true);
-	mutex_unlock(&ihid_goodix->regulator_mutex);
+		regulator_disable(ihid_goodix->vdd);
+	}

 	return i2c_hid_core_probe(client, &ihid_goodix->ops, 0x0001, 0);
 }

base-commit: e783362eb54cd99b2cac8b3a9aeac942e6f6ac07
--
2.34.1

