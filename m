Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B85D59877D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245551AbiHRP30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344357AbiHRP3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:29:21 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DAA2DEC
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 08:29:20 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id pm17so2019429pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 08:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=1Eoyvkcq9AAxY99icUW84Rt92U/5ub05QuVo7keBPxs=;
        b=n1W6kKUu2A7eMT68Y4o3rn50CZAJjXpLXiQrDalqIBg62jFCqTsoCA2LDMNlxznuvY
         7Yv1lwg1Pg5C2O1nBr/rjNEJ3pp08M9sZvhKQHRuPgOg32a9wcHym1XDI1P2CxUo5oRv
         ox+r8P85wAvmxDVTRmE69blQCOJpI6U5LKo2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=1Eoyvkcq9AAxY99icUW84Rt92U/5ub05QuVo7keBPxs=;
        b=DB8zq9ZcHyTNzv/hF17gia4ldvfx/c+hqXMsjZmZNa62O1P5lOjHvFT9d6EXaZCJtF
         ZF11kGZXY3d7youlIWUQPwBnVCpjn8wf/XaxmY5jNQE08gTuHtw1iNpL3J5B3INrBdqg
         WK65aSKHrrK0Lsztj1OH/8nTREnz5jkam0NxPNiZNE9YlLcuFyfibvnaaX93sM9FZNI6
         VoplVVaBjIymMlI4F1DryUKD7aCD9+lFCv8IQwsWosrcUFO952pzRyydNDidPqza5w+m
         Kn3WZ7ubbKuFapR1ZmKJhS18H7nr4w+VsmKYMJDgynm3Ha5Ovm4ZsKp7UZ5IkQ7G1WB0
         VPzA==
X-Gm-Message-State: ACgBeo26K3rcsL4jZKMv7cN2ssq8So/c0KQDdZv8z+neH21LknORVSTH
        7mE6nk2gGC4QDgUiFGn6HKOwow==
X-Google-Smtp-Source: AA6agR51XZUuKM9rBU7FLOtPuOpvhlht6MYLcClHV+ieYV7gldBty9sNBZUdTiVtZPHV1c5AvLZwwA==
X-Received: by 2002:a17:902:e947:b0:170:d739:8cbe with SMTP id b7-20020a170902e94700b00170d7398cbemr3097176pll.141.1660836559944;
        Thu, 18 Aug 2022 08:29:19 -0700 (PDT)
Received: from evgreen-glaptop.lan ([98.45.66.167])
        by smtp.gmail.com with ESMTPSA id m11-20020a17090a7f8b00b001f89383d587sm1613494pjl.56.2022.08.18.08.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 08:29:19 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Prashant Malani <pmalani@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Rajat Jain <rajatja@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] platform/chrome: cros_ec: Expose suspend_timeout_ms in debugfs
Date:   Thu, 18 Aug 2022 08:29:09 -0700
Message-Id: <20220818082827.v2.1.Idd188ff3f9caddebc17ac357a13005f93333c21f@changeid>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
---

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
index 1fe0add99a2a99..9f79c641b2d09f 100644
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
+		sleep states. The suspend_timeout file controls the amount of
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
index 8aace50d446d65..e8d3e2a29a58f5 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -115,7 +115,7 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
 	if (ec_dev->host_sleep_v1) {
 		buf.u.req1.sleep_event = sleep_event;
 		buf.u.req1.suspend_params.sleep_timeout_ms =
-				EC_HOST_SLEEP_TIMEOUT_DEFAULT;
+				ec_dev->suspend_timeout;
 
 		buf.msg.outsize = sizeof(buf.u.req1);
 		if ((sleep_event == HOST_SLEEP_EVENT_S3_RESUME) ||
@@ -188,6 +188,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 	ec_dev->max_passthru = 0;
 	ec_dev->ec = NULL;
 	ec_dev->pd = NULL;
+	ec_dev->suspend_timeout = EC_HOST_SLEEP_TIMEOUT_DEFAULT;
 
 	ec_dev->din = devm_kzalloc(dev, ec_dev->din_size, GFP_KERNEL);
 	if (!ec_dev->din)
diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index 0dbceee87a4b1a..d7f5338c1ab1cf 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -470,6 +470,9 @@ static int cros_ec_debugfs_probe(struct platform_device *pd)
 	debugfs_create_x32("last_resume_result", 0444, debug_info->dir,
 			   &ec->ec_dev->last_resume_result);
 
+	debugfs_create_u16("suspend_timeout_ms", 0664, debug_info->dir,
+			   &ec->ec_dev->suspend_timeout);
+
 	ec->debug_info = debug_info;
 
 	dev_set_drvdata(&pd->dev, ec);
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 408b29ca4004be..60132444f7daa6 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -169,6 +169,7 @@ struct cros_ec_device {
 	int event_size;
 	u32 host_event_wake_mask;
 	u32 last_resume_result;
+	u16 suspend_timeout;
 	ktime_t last_event_time;
 	struct notifier_block notifier_ready;
 
-- 
2.31.0

