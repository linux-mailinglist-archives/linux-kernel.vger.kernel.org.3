Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9BC485B4B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 23:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244780AbiAEWHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 17:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244744AbiAEWHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:07:09 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391D5C0611FF
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 14:07:09 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id r16-20020a17090a0ad000b001b276aa3aabso5839362pje.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 14:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LX5pXfG+butX7PRIDLTetDtnnvnRwz0ZJoarir0k50Y=;
        b=kAOosDQsKNBaEWNx0ksC6vAF2ut3CkfPeMe8V88lvBVtOMOpJ3vuxTZavP1eJSmG/n
         3f7u1EUM3ylUlFSE4Kd4FxuZYfshAsuoxGPWQvdgUFW2R5WhRrnapXBANhl/dzCRLndY
         og7oq7MQbIItAf7/vl0y7SnLMzeU0tH6yG/Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LX5pXfG+butX7PRIDLTetDtnnvnRwz0ZJoarir0k50Y=;
        b=rdmbcMoPrKICcvciQ7ZYbtlwXLdd+A/yyrEj6ETbk6X6BG4xNw/JiwnjpStmtVWv1E
         +HxMXeEnyX46bcqOb9dFLkOPP0hhphlmo/f70vGdcMeD3FE5fYHt7hY9a19tlQtGaoCZ
         Xiquq6gauIMJe2MlGwj9UcsfhipHP9UhWkND3OEZCbmYl69TvZ+tQxb+EEkow6lXM3sK
         YeCcfvelr9O78PhY1l2mnNN0lqoDpbwxrdg8cs4w1SkHhaBPPfeBg5cVvTOVL+2g690a
         SAZwWZQ3Xb5lmOzlXEd8QJ+PADx7LQhdLGThXgVG3LF0bc4qncjJy2IXUWu2nkFOYav/
         27rA==
X-Gm-Message-State: AOAM531p9VAk94o5v/5JUbvSdVlNC683+zohXNn3FMwz7S+xV56Udoax
        c7OM7Vzp2e16S2IlLFuC2aSssw==
X-Google-Smtp-Source: ABdhPJzAw0JMNjx3nruSuRv4n+UKGaku/jPPkdG9PGoP6vJvRNsSSTuixlnH21ix5SZV1CB70rKVoA==
X-Received: by 2002:a17:90a:db81:: with SMTP id h1mr6542076pjv.163.1641420428719;
        Wed, 05 Jan 2022 14:07:08 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7fcd:6709:f1b5:a22a])
        by smtp.gmail.com with UTF8SMTPSA id l2sm108505pfu.13.2022.01.05.14.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 14:07:08 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, groeck@chromium.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, benjamin.tissoires@redhat.com,
        jic23@kernel.org, dtor@chromium.org, hverkuil-cisco@xs4all.nl,
        mchehab@kernel.org, lee.jones@linaro.org, pmalani@chromium.org,
        sre@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lgirdwood@gmail.com,
        a.zummo@towertech.it, cychiang@chromium.org, perex@perex.cz
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 03/17] platform/chrome: Add PL_CHROMEOS dependency
Date:   Wed,  5 Jan 2022 14:06:39 -0800
Message-Id: <20220105220653.122451-4-gwendal@chromium.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20220105220653.122451-1-gwendal@chromium.org>
References: <20220105220653.122451-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use 'make nsdeps' to add missing dependencies.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/platform/chrome/cros_ec_sensorhub.c  | 1 +
 drivers/platform/chrome/cros_ec_typec.c      | 1 +
 drivers/platform/chrome/cros_usbpd_notify.c  | 1 +
 drivers/platform/chrome/wilco_ec/debugfs.c   | 1 +
 drivers/platform/chrome/wilco_ec/telemetry.c | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_sensorhub.c b/drivers/platform/chrome/cros_ec_sensorhub.c
index 31fb8bdaad5a35..b469e19a296a74 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub.c
@@ -261,3 +261,4 @@ MODULE_ALIAS("platform:" DRV_NAME);
 MODULE_AUTHOR("Gwendal Grignou <gwendal@chromium.org>");
 MODULE_DESCRIPTION("ChromeOS EC MEMS Sensor Hub Driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PL_CHROMEOS);
diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 5de0bfb0bc4d99..1db7aabeb9b4b5 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -1167,3 +1167,4 @@ module_platform_driver(cros_typec_driver);
 MODULE_AUTHOR("Prashant Malani <pmalani@chromium.org>");
 MODULE_DESCRIPTION("Chrome OS EC Type C control");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PL_CHROMEOS);
diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
index 3a5a14b8175347..28c5f7b50e0e22 100644
--- a/drivers/platform/chrome/cros_usbpd_notify.c
+++ b/drivers/platform/chrome/cros_usbpd_notify.c
@@ -256,6 +256,7 @@ module_init(cros_usbpd_notify_init);
 module_exit(cros_usbpd_notify_exit);
 
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PL_CHROMEOS);
 MODULE_DESCRIPTION("ChromeOS power delivery notifier device");
 MODULE_AUTHOR("Jon Flatley <jflat@chromium.org>");
 MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platform/chrome/wilco_ec/debugfs.c
index a812788a0bdcc2..7b9869bba0fb4b 100644
--- a/drivers/platform/chrome/wilco_ec/debugfs.c
+++ b/drivers/platform/chrome/wilco_ec/debugfs.c
@@ -282,4 +282,5 @@ module_platform_driver(wilco_ec_debugfs_driver);
 MODULE_ALIAS("platform:" DRV_NAME);
 MODULE_AUTHOR("Nick Crews <ncrews@chromium.org>");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(PL_CHROMEOS);
 MODULE_DESCRIPTION("Wilco EC debugfs driver");
diff --git a/drivers/platform/chrome/wilco_ec/telemetry.c b/drivers/platform/chrome/wilco_ec/telemetry.c
index 60da7a29f2ff2d..ebcc4e4628997f 100644
--- a/drivers/platform/chrome/wilco_ec/telemetry.c
+++ b/drivers/platform/chrome/wilco_ec/telemetry.c
@@ -469,4 +469,5 @@ module_exit(telem_module_exit);
 MODULE_AUTHOR("Nick Crews <ncrews@chromium.org>");
 MODULE_DESCRIPTION("Wilco EC telemetry driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PL_CHROMEOS);
 MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.34.1.448.ga2b2bfdf31-goog

