Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7335485B58
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 23:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245025AbiAEWJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 17:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244818AbiAEWH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:07:29 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E98DC061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 14:07:29 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id z3so587450plg.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 14:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tVr5tsBIFoV2HC1TEE5aaTaB9VBlhsL3hfLUSJOK4IA=;
        b=PlLsNKNRkuwQbKEq9tWO6/GHbn35IlnQUZOUMdLDDlKuSeBmmOOry0mMQ579fwox5k
         SbCs6GmzLlVDOZDPufp5vMlZgTm5ClSu9APFIYZ7AXH5dX3sTg6o/3kQXl++JM8B4IO1
         bDLHZhaaws95zyFGN0HhzgXfhXqeXg0/NhpAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tVr5tsBIFoV2HC1TEE5aaTaB9VBlhsL3hfLUSJOK4IA=;
        b=5sriyVknOmoQJu1LszX9yZbc17Mb6372Q9uvUXexecr1fY3cGN9pdgi4hJ7978fk3V
         NkYsVDslreS8kNxO5ef9Zu8bjycHwsK+TUzwA+N/5+Saz75RE/qQ2j6hB/6UYC7HEpJK
         E/Jgyp8BSuJiAUrJCm782t+RCwo+XietxyjQFPzgLUMm5zy+VlI5dGRVlAvbtssFUx31
         kPVja92O6B5ZtHaCgjQfEXH2dOw8ap5A8ctW2cKFI0oi828LWw216WELen8Uoa8oCGL2
         V2E4uaW8NcC9L5xsEjEmA/EeSLMaJgBaH7QgzT4mFNG7XvBGRnIuFb1+/64bh1impLkX
         Hghw==
X-Gm-Message-State: AOAM532Vy4OkebNC2Z1jVZG//L5dv88OiBogtqE5kBzRrIQ0+Lc/8jSk
        U83Wq4TK91fUQaEeSserZB5XX3CqTKipWA==
X-Google-Smtp-Source: ABdhPJzWhuqiVnUhxPvgWyJvDNWpjUiA2zzpJIGjB+Sp7v4l0DlnD38MAIe+DBaH89q7VWXRXrk10A==
X-Received: by 2002:a17:902:dac4:b0:148:fde0:692a with SMTP id q4-20020a170902dac400b00148fde0692amr55966395plx.47.1641420449178;
        Wed, 05 Jan 2022 14:07:29 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7fcd:6709:f1b5:a22a])
        by smtp.gmail.com with UTF8SMTPSA id k23sm3049499pji.3.2022.01.05.14.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 14:07:28 -0800 (PST)
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
Subject: [PATCH 13/17] media: cros-ec-cec: Add PL_CHROMEOS dependency
Date:   Wed,  5 Jan 2022 14:06:49 -0800
Message-Id: <20220105220653.122451-14-gwendal@chromium.org>
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
 drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
index 2d95e16cd24893..273af1688c4cda 100644
--- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
+++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
@@ -352,4 +352,5 @@ module_platform_driver(cros_ec_cec_driver);
 MODULE_DESCRIPTION("CEC driver for ChromeOS ECs");
 MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PL_CHROMEOS);
 MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.34.1.448.ga2b2bfdf31-goog

