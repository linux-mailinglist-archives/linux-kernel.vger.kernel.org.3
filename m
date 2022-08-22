Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318E359CAF9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 23:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238191AbiHVVk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 17:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiHVVkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 17:40:55 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A99520B1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 14:40:54 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 202so10562262pgc.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 14:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=ABKKHKOpeHgVabWRGp+gR63dGUxiLMPakCVue+4/OYs=;
        b=KNLLffBDzmvzvDQj49RUi8Ur71pmj6u3rvTez/W03jco+vImwiz3zbxecx6MyxWhWj
         UQ38ZQlw+MkIsTZWzvNgNGIwmIhkrmN7oQhb754i1gv0GUsM1G5HV7jgYy+Mc60OAsmj
         52fi5r2oUrm9uqA5Z73KJEgo4XAEiRzhZwwCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ABKKHKOpeHgVabWRGp+gR63dGUxiLMPakCVue+4/OYs=;
        b=7lBFBgbwmfpZrrm7PQv42AT+bHB6uK4btk9Uo+jygAijPa5QbfJymvrjplK+3GIrOe
         e2c32tyoi4owi3ymYbd56APVwyE+HiWBJpr6OyM1KXgYecQGHLkKBJpHOdLenCAT4lBn
         2hGq5m7466YtthnotH+vhCfs4i9j7hVfgFkrRiHPt1lF9YaafKD9zgewsYWyiIPyhpYQ
         UH2p17tcWumgY+frecd5c3DcAZooGylMf67o/FlFo6P7uNRsWeaPHSKX9vIUfHA2PQvC
         jrClxSzM5Ct6XHm3V/S26NYIjrkjbIbo1rQuHcN0iAArhAVvZ89ny/zDi6mYpi1Sn7mY
         RrSQ==
X-Gm-Message-State: ACgBeo2HntNUm9HALdGeG6r0ly+b1Dpw9eJQLB40UdnKHoqoi0Nbny0l
        GR7hvBxrDxJnXdBPLi6zjqlYQQ==
X-Google-Smtp-Source: AA6agR5XqD1DgH5CzbRGibOuEptbijWWR2KiixydAL4ajE86MbBbcMzu4s8z3ZvXa6Hfiff4O7EE0Q==
X-Received: by 2002:a63:e241:0:b0:41b:b374:caf8 with SMTP id y1-20020a63e241000000b0041bb374caf8mr18946966pgj.310.1661204453849;
        Mon, 22 Aug 2022 14:40:53 -0700 (PDT)
Received: from evgreen-glaptop.lan ([98.45.66.167])
        by smtp.gmail.com with ESMTPSA id a10-20020a17090a70ca00b001faf9ab9df7sm5088038pjm.25.2022.08.22.14.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 14:40:53 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Rajat Jain <rajatja@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3] platform/chrome: cros_ec: Expose suspend_timeout_ms in debugfs
Date:   Mon, 22 Aug 2022 14:40:40 -0700
Message-Id: <20220822144026.v3.1.Idd188ff3f9caddebc17ac357a13005f93333c21f@changeid>
X-Mailer: git-send-email 2.31.0
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

In modern Chromebooks, the embedded controller has a mechanism where
it will watch a hardware-controlled line that toggles in suspend, and
wake the system up if an expected sleep transition didn't occur. This
can be very useful for detecting power management issues where the
system appears to suspend, but doesn't actually reach its lowest
expected power states.

Sometimes it's useful in debug and test scenarios to be able to control
the duration of that timeout, or even disable the EC timeout mechanism
altogether. Add a debugfs control to set the timeout to values other
than the EC-defined default, for more convenient debug and
development iteration.

Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v3:
 - s/suspend_timeout/suspend_timeout_ms/ in docs (Prashant)
 - Same in code (Tzung-Bi)
 - Added Prashant's review tag (thanks Prashant!)

Changes in v2:
 - Update release version to 6.1 (Tzung-Bi)
 - Reference EC_HOST_SLEEP_TIMEOUT_INFINITE (Tzung-Bi)
 - Name the debugfs file suspend_timeout_ms (Prashant)

 Documentation/ABI/testing/debugfs-cros-ec   | 22 +++++++++++++++++++++
 drivers/platform/chrome/cros_ec.c           |  3 ++-
 drivers/platform/chrome/cros_ec_debugfs.c   |  3 +++
 include/linux/platform_data/cros_ec_proto.h |  1 +
 4 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/debugfs-cros-ec b/Documentation/ABI/testing/debugfs-cros-ec
index 1fe0add99a2a99..66fe915acd739b 100644
--- a/Documentation/ABI/testing/debugfs-cros-ec
+++ b/Documentation/ABI/testing/debugfs-cros-ec
@@ -54,3 +54,25 @@ Description:
 		this feature.
 
 		Output will be in the format: "0x%08x\n".
+
+What:		/sys/kernel/debug/<cros-ec-device>/suspend_timeout_ms
+Date:		August 2022
+KernelVersion:	6.1
+Description:
+		Some ECs have a feature where they will track transitions to the
+		a hardware-controlled sleep line, such as Intel's SLP_S0 line,
+		in order to detect cases where a system failed to go into deep
+		sleep states. The suspend_timeout_ms file controls the amount of
+		time in milliseconds the EC will wait before declaring a sleep
+		timeout event and attempting to wake the system.
+
+		Supply 0 to use the default value coded into EC firmware. Supply
+		65535 (EC_HOST_SLEEP_TIMEOUT_INFINITE) to disable the EC sleep
+		failure detection mechanism. Values in between 0 and 65535
+		indicate the number of milliseconds the EC should wait after a
+		sleep transition before declaring a timeout. This includes both
+		the duration after a sleep command was received but before the
+		hardware line changed, as well as the duration between when the
+		hardware line changed and the kernel sent an EC resume command.
+
+		Output will be in the format: "%u\n".
diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 8aace50d446d65..32140a7150d013 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -115,7 +115,7 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
 	if (ec_dev->host_sleep_v1) {
 		buf.u.req1.sleep_event = sleep_event;
 		buf.u.req1.suspend_params.sleep_timeout_ms =
-				EC_HOST_SLEEP_TIMEOUT_DEFAULT;
+				ec_dev->suspend_timeout_ms;
 
 		buf.msg.outsize = sizeof(buf.u.req1);
 		if ((sleep_event == HOST_SLEEP_EVENT_S3_RESUME) ||
@@ -188,6 +188,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 	ec_dev->max_passthru = 0;
 	ec_dev->ec = NULL;
 	ec_dev->pd = NULL;
+	ec_dev->suspend_timeout_ms = EC_HOST_SLEEP_TIMEOUT_DEFAULT;
 
 	ec_dev->din = devm_kzalloc(dev, ec_dev->din_size, GFP_KERNEL);
 	if (!ec_dev->din)
diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index 0dbceee87a4b1a..4e63adf083ea1f 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -470,6 +470,9 @@ static int cros_ec_debugfs_probe(struct platform_device *pd)
 	debugfs_create_x32("last_resume_result", 0444, debug_info->dir,
 			   &ec->ec_dev->last_resume_result);
 
+	debugfs_create_u16("suspend_timeout_ms", 0664, debug_info->dir,
+			   &ec->ec_dev->suspend_timeout_ms);
+
 	ec->debug_info = debug_info;
 
 	dev_set_drvdata(&pd->dev, ec);
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 408b29ca4004be..e43107e0bee162 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -169,6 +169,7 @@ struct cros_ec_device {
 	int event_size;
 	u32 host_event_wake_mask;
 	u32 last_resume_result;
+	u16 suspend_timeout_ms;
 	ktime_t last_event_time;
 	struct notifier_block notifier_ready;
 
-- 
2.31.0

