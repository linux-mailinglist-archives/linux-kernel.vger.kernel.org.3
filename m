Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA14546FAF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 00:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347876AbiFJWhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 18:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245351AbiFJWhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 18:37:08 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CCA3B33A1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 15:37:05 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id c14so401630pgu.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 15:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yxTKmB4sS7h/Z8phwbcD4zVGK1WAkBqCaZbZvLiMaQQ=;
        b=JPjWwckYKoPNyw4OGC/s9T6MO0IxTzrYasVilPoGlmghW6HDPVAOuNYObADGOB9Iwu
         1EtXhpICWFvpSljq3f0LQ0r6QM8El7TcmeZ+3cDOxYwLle4z0X6bVTTx5m3dmeAMc3bi
         Ahu9V1zZOI9gw/uTGQ1omzyo2BpmNRwXlY+DQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yxTKmB4sS7h/Z8phwbcD4zVGK1WAkBqCaZbZvLiMaQQ=;
        b=7YQFhG/4JEgDYQ8MmJedVZUD6DLsCsOCCupYGzye+rLB6NOb49pAL6kmMX6fFc23fV
         qtOjJEwWT3rG/gJ1d4/zkBULEQWQcA8Kl+oECmxuw01zqPihGFFNO/Xie4CRCpJZdwH5
         IDXNoX/NODXbEEXULea84XFxdkHJun/f9O7BT7JBGn8+1oW62xl9j5F7Y5xORbZUZK3k
         raEdfQi1BRWx8LnZreNZnhHr5SS0e1bF7QS9yYjc8/UmUCePtmioWCIGKO3a6CUO/73X
         /gWvmysRQq+bKmhrkrEPmBtQ+vTUqTwp2towIMwm3kl/zFsfjcE3try8Fx+7NfD+7RZA
         qgIA==
X-Gm-Message-State: AOAM53162Bvk2KinTT5G0jSystDTc3WUHm1rRy4zchy1Y62kiwVkBVMF
        MdwirZ6OTV4psvkX3I3AWxLJ+JVNo2DRUQ==
X-Google-Smtp-Source: ABdhPJx/ZXGR3bi/YwVT9Age17Wwy/fmmJFNXDASE+FWIwHXX+kq0zGSMGIhVx42BFl8+NTio4fNig==
X-Received: by 2002:a62:d045:0:b0:51b:fcf6:3add with SMTP id p66-20020a62d045000000b0051bfcf63addmr34225735pfg.68.1654900624752;
        Fri, 10 Jun 2022 15:37:04 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:290:ebca:2e9e:1570])
        by smtp.gmail.com with ESMTPSA id o6-20020aa79786000000b0050dc76281e0sm48359pfp.186.2022.06.10.15.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 15:37:04 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Benson Leung <bleung@chromium.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, Evan Green <evgreen@chromium.org>,
        Rajat Jain <rajatja@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH] platform/chrome: cros_ec: Always expose last resume result
Date:   Fri, 10 Jun 2022 15:37:02 -0700
Message-Id: <20220610223703.3387691-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last resume result exposing logic in cros_ec_sleep_event()
incorrectly requires S0ix support, which doesn't work on ARM based
systems where S0ix doesn't exist. That's because cros_ec_sleep_event()
only reports the last resume result when the EC indicates the last sleep
event was an S0ix resume. On ARM systems, the last sleep event is always
S3 resume, but the EC can still detect sleep hang events in case some
other part of the AP is blocking sleep.

Always expose the last resume result if the EC supports it so that this
works on all devices regardless of S0ix support. This fixes sleep hang
detection on ARM based chromebooks like Trogdor.

Cc: Evan Green <evgreen@chromium.org>
Cc: Rajat Jain <rajatja@chromium.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>
Fixes: 7235560ac77a ("platform/chrome: Add support for v1 of host sleep event")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

I originally was going to check for S3 only with !ARCH_X86 but I can't
convince myself that it's any use to limit the check to s0ix in general.
This approach assumes the last resume result is valid if the command is
supported, regardless of whether or not the AP supports s0ix or not.
This seems to be the case at least on ARM, and looking at the EC
convinces me that CONFIG_POWER_SLEEP_FAILURE_DETECTION is only enabled
on x86 devices that have s0ix.

 drivers/platform/chrome/cros_ec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index b3e94cdf7d1a..881d3ad09be0 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -135,10 +135,10 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
 	buf.msg.command = EC_CMD_HOST_SLEEP_EVENT;
 
 	ret = cros_ec_cmd_xfer_status(ec_dev, &buf.msg);
-
-	/* For now, report failure to transition to S0ix with a warning. */
+	/* Report failure to transition to system wide suspend with a warning. */
 	if (ret >= 0 && ec_dev->host_sleep_v1 &&
-	    (sleep_event == HOST_SLEEP_EVENT_S0IX_RESUME)) {
+	    (sleep_event == HOST_SLEEP_EVENT_S0IX_SUSPEND ||
+	     sleep_event == HOST_SLEEP_EVENT_S3_RESUME)) {
 		ec_dev->last_resume_result =
 			buf.u.resp1.resume_response.sleep_transitions;
 

base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
https://chromeos.dev

