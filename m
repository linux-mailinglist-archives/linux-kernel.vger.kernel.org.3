Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C0E485B4C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 23:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244792AbiAEWHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 17:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244763AbiAEWHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:07:13 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332F4C034001
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 14:07:11 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id c3so600482pls.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 14:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6jcvkqfureefJWtY49QrDZ31/h8LqodVrPjXJxowm5Q=;
        b=PxKWE6vk3ejtduSG1XIW/PQO0ysPTSogaJPVWw0n+iF5f92LH01AWDPRFiMNIUq+Em
         AOgOGZ1mJ9B1tIYkoDXhl6kctlgphMaoX4GUJUC/MLMymtIdvT3WnPq4T4ACFzbIMdAD
         De5LfvNbPZ73QrgthSU7OKLfrdwXvOOnvUim0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6jcvkqfureefJWtY49QrDZ31/h8LqodVrPjXJxowm5Q=;
        b=vQmaITlVRZf1bx5hcEjKAXdn5ZqVrXDMwOaViqiSeRVU44StZbVzH7yNb7H/ZqZ0Ja
         1RX1o0OCiuP37gtaPxUjJi0azyVvRojgo9z9ddzt1vmQpy+FWE7L98R5AC4lRSybadgp
         F8v3Cz8EGTx6sh57K4FIp7xScU8eSO6KKl05c5UwnKaD4v33Wb2WBBrm9Wqc9EtNJoeB
         p7d38Iah89toSwmQTZCp/ipOjd3IVXx1sXxn8urZljZl1OVBDKpkPyaZU04keT/RDHZ7
         hU6aQFaUCdeREcB4IF8gnByoARaLz/ByLh0I2o2QH8nRE3BN/wNm7J8Q/QX9smnN97Ss
         QT+Q==
X-Gm-Message-State: AOAM530IHqL6iE5/OoVzqhO986Q05Q3eCuUTV2Szf/sIuwr3RQ+iisuV
        iewHh+1VGV9DFiJtKS3zpQeVHw==
X-Google-Smtp-Source: ABdhPJxBQInWyMlT7ixb1YlPOw6bMdCph+IMgJm4wLh0z0+yI/XbVypXr04SHYBuYVEEJkrtmr7svw==
X-Received: by 2002:a17:902:700c:b0:149:5536:1ac4 with SMTP id y12-20020a170902700c00b0014955361ac4mr54541858plk.11.1641420430737;
        Wed, 05 Jan 2022 14:07:10 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7fcd:6709:f1b5:a22a])
        by smtp.gmail.com with UTF8SMTPSA id a1sm97137pfv.99.2022.01.05.14.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 14:07:10 -0800 (PST)
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
Subject: [PATCH 04/17] power_supply: chromeos: Add PL_CHROMEOS dependency
Date:   Wed,  5 Jan 2022 14:06:40 -0800
Message-Id: <20220105220653.122451-5-gwendal@chromium.org>
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
 drivers/power/supply/cros_usbpd-charger.c | 1 +
 drivers/power/supply/wilco-charger.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
index d89e08efd2ad0f..fdedcea010f637 100644
--- a/drivers/power/supply/cros_usbpd-charger.c
+++ b/drivers/power/supply/cros_usbpd-charger.c
@@ -722,5 +722,6 @@ static struct platform_driver cros_usbpd_charger_driver = {
 module_platform_driver(cros_usbpd_charger_driver);
 
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(PL_CHROMEOS);
 MODULE_DESCRIPTION("ChromeOS EC USBPD charger");
 MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/drivers/power/supply/wilco-charger.c b/drivers/power/supply/wilco-charger.c
index 98ade073ef05fe..aeacdbf0b5df80 100644
--- a/drivers/power/supply/wilco-charger.c
+++ b/drivers/power/supply/wilco-charger.c
@@ -189,4 +189,5 @@ module_platform_driver(wilco_charge_driver);
 MODULE_ALIAS("platform:" DRV_NAME);
 MODULE_AUTHOR("Nick Crews <ncrews@chromium.org>");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(PL_CHROMEOS);
 MODULE_DESCRIPTION("Wilco EC charge control driver");
-- 
2.34.1.448.ga2b2bfdf31-goog

