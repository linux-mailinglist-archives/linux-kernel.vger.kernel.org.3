Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB6A485B50
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 23:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244899AbiAEWHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 17:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244738AbiAEWHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:07:19 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494A8C0611FF
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 14:07:19 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id v25so386807pge.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 14:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PQAUrFgorcQChaYcqsHSIiFt5ulFUGRGY3BpjOh+AJw=;
        b=norKUTqhmiHSAoefSGHXGuzelhkymZjpXWxLKmsi3/Ie+dkbRNKVBGh7OLCzNiPZ7D
         j0Cq8RZ8qJXqYswAZu99jt4zeIjjGt6qwQD3LcQcNQb1YysvUUHLwdhWg/jXfsx+Pq5H
         S3G7Ti+KSEt9gbHR0wkQDOPpz1Jd+HiDLg5dY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PQAUrFgorcQChaYcqsHSIiFt5ulFUGRGY3BpjOh+AJw=;
        b=fpCNlFUfMkgsMGMdCidG/0M/hWTLGVtYN0nXlESQ6tfbaleKykglT7mhsvB7n2REek
         00iIB5bUVFcWLGYk0uGUBmIMSkk65TKtMa8evyGmLA7y5WN/LAlQVOTTCu2fEjWdfyU1
         IZnBOIORPhOXFThGorpOciHj8xUluWA0H2G31A0368HN2JW8LvV4yeRdjoZU7E4wrF25
         gYBeW1iWI72b1Hswu/N6+9iJwE2OXkTBcM0yFHIL1/QZhretpaKczWIlq49T2aRfT6qB
         qWGUi6LG3L91nJdubsqUdGyNQ8sbeOSEfkLizeTj1jNHKwDskMdsnQ4BUHbpC9jXLze0
         yYEg==
X-Gm-Message-State: AOAM5324Z/n0oI+NVzNfR+B5WPcXSCWSWregzw13duk7RTqdwx5Vur99
        rl+Al/5AwDFZBBxIFIJdzqCvdw==
X-Google-Smtp-Source: ABdhPJwo4c/sJsLnm9k90BKZinHQ452HGA2zEOgfSQTjfsApIEnNyDVDUgEDSMAGI6UQUSrFW3VPTg==
X-Received: by 2002:a63:338c:: with SMTP id z134mr34669410pgz.459.1641420438886;
        Wed, 05 Jan 2022 14:07:18 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7fcd:6709:f1b5:a22a])
        by smtp.gmail.com with UTF8SMTPSA id nl16sm4080413pjb.22.2022.01.05.14.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 14:07:18 -0800 (PST)
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
Subject: [PATCH 08/17] rtc: cros_ec: Add PL_CHROMEOS dependency
Date:   Wed,  5 Jan 2022 14:06:44 -0800
Message-Id: <20220105220653.122451-9-gwendal@chromium.org>
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
 drivers/rtc/rtc-cros-ec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-cros-ec.c b/drivers/rtc/rtc-cros-ec.c
index 70626793ca6941..696fffdd8d6dd7 100644
--- a/drivers/rtc/rtc-cros-ec.c
+++ b/drivers/rtc/rtc-cros-ec.c
@@ -397,4 +397,5 @@ module_platform_driver(cros_ec_rtc_driver);
 MODULE_DESCRIPTION("RTC driver for Chrome OS ECs");
 MODULE_AUTHOR("Stephen Barber <smbarber@chromium.org>");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(PL_CHROMEOS);
 MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.34.1.448.ga2b2bfdf31-goog

