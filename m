Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEB1485B4A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 23:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244743AbiAEWHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 17:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244735AbiAEWHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:07:07 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D278C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 14:07:07 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id m1so547301pfk.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 14:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JAZ0hsqgb4smoBJmpx27TGiPS02PI7zOc+GPVjYnNJ4=;
        b=MBO3S9X4OtlF7MMEIX2+E0kiiu2pW0rY8fWYxOisF59ZArT2oS8sZ9z+BF61KkrTnz
         dhta7E7FtvW67RpUaHCVCKuPI4RLfqwoCWdEOnY/Ph77Z4nSIMnDa6EyJ+TnOuwsdESx
         kfDFPyKLJdccondVPt3PqUjsoiRGKkBZi+fpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JAZ0hsqgb4smoBJmpx27TGiPS02PI7zOc+GPVjYnNJ4=;
        b=FYgSvYSSDK3txz/rnnDnqBjlJUaG/6oTeQxQil/ljufJcw7n4+LCn3Na68K2nxfSAZ
         bp8AKXglHMZd1XBPNd0IMpGQlatqAzeTMSuetO4r1gXtCfXt4UyzN+ESTuKBQ9cnAf+K
         LsmqGUQm0xBgBGVncjw7/n54Q6VTp9KGNdwZe4vqiu+STSY4Ye+X5F+FRSGo962urXx0
         oVWXMs9LBzNAY1+QGFzls+1FkMjTguH7xVxqsZklWhghvUVwmJiIiixjo1865hzvPL3z
         VoQvS3c7+XrClddm5l1KEDHSJxt85Y4+7puXmlLmhGDah80jPSRlSd8pbbQkhXP1owGQ
         ASpw==
X-Gm-Message-State: AOAM531gLsnE+5DgsXMWDiz9oHSFg9ONgsYjBFwDItcxesLCKug3Me9B
        AyjltpH76vIL4TecY0fctoBnHg==
X-Google-Smtp-Source: ABdhPJwqpk3REZwe9zXEIejXDJp6Xk7WdPq9RF4ypQk7d9iqTnDU8UH1dCGEKFb2HI/UBnJTIwh6zA==
X-Received: by 2002:a63:6f87:: with SMTP id k129mr27197122pgc.248.1641420426777;
        Wed, 05 Jan 2022 14:07:06 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7fcd:6709:f1b5:a22a])
        by smtp.gmail.com with UTF8SMTPSA id o21sm20061pjq.20.2022.01.05.14.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 14:07:06 -0800 (PST)
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
Subject: [PATCH 02/17] iio:cros_ec_sensors: Add PL_CHROMEOS dependency
Date:   Wed,  5 Jan 2022 14:06:38 -0800
Message-Id: <20220105220653.122451-3-gwendal@chromium.org>
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
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 1 +
 drivers/iio/proximity/cros_ec_mkbp_proximity.c            | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index b2725c6adc7f1f..be3aab8d881625 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -851,3 +851,4 @@ EXPORT_SYMBOL_GPL(cros_ec_sensors_pm_ops);
 
 MODULE_DESCRIPTION("ChromeOS EC sensor hub core functions");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(PL_CHROMEOS);
diff --git a/drivers/iio/proximity/cros_ec_mkbp_proximity.c b/drivers/iio/proximity/cros_ec_mkbp_proximity.c
index 8213b00817132d..221d2e416326ea 100644
--- a/drivers/iio/proximity/cros_ec_mkbp_proximity.c
+++ b/drivers/iio/proximity/cros_ec_mkbp_proximity.c
@@ -268,4 +268,5 @@ static struct platform_driver cros_ec_mkbp_proximity_driver = {
 module_platform_driver(cros_ec_mkbp_proximity_driver);
 
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(PL_CHROMEOS);
 MODULE_DESCRIPTION("ChromeOS EC MKBP proximity sensor driver");
-- 
2.34.1.448.ga2b2bfdf31-goog

