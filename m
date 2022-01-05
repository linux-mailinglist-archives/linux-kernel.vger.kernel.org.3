Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A223485B4D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 23:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244733AbiAEWH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 17:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244765AbiAEWHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:07:13 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C9EC034003
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 14:07:13 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id c9-20020a17090a1d0900b001b2b54bd6c5so5809728pjd.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 14:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MFjLGa+0+++AfzpjvF0zXJFCTTIub9VV/ZwCYiShdxE=;
        b=LdHKuoWU8g/RWqZgTPlqLd9ZX+63pQu8ECKFejzJ/xwclXE6VROdzPn5bH5gu4IrNa
         0zgwVlx8/17ULX6aqGnplKQIkeKurzAoXmISk/LoflyqjvGcUDWAW1pg076aSlPpZ9dW
         /PoEbC+mBOxkP/CxUKuzB/Asz4xDAwlME04rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MFjLGa+0+++AfzpjvF0zXJFCTTIub9VV/ZwCYiShdxE=;
        b=2eCfYE5GX5vXqLI2y7FjqqGfki+DEwlT4jyYk1aC1mP2Ki0+VyEjVIUoBP8PGd6oxj
         On1fZwrkf1C+VwVvf16z+271+8lTmEs04JkuVYQDoOUTUX+X6XJe+LhR6dvSAPrnV+3r
         Z/60Nth8JFeeZsjqAUSfQ1WyXVrZzS9Da4ESeheEkHfsY1qzJeDQ3bVIDMctELoTCFod
         qlRGm5B6Zfyit7kA6yGdg6wywnZeS5dVCg6jocsMKRjH9ZRFIhFGQEupvzd/VcMOk+ww
         AbPtbY9olHGWQKIONXoaiNF2v6M05Ea/r5czYKwlNP08BY9vF6HPEdlByDjxrTI7WOeq
         gR/w==
X-Gm-Message-State: AOAM531MbkzNxeoqVyaIGtWtdPeAQxyuF9Tbtwk5Cz9DJvTsf7J9feqK
        WwLsbShQd9P5Ic1TzpBe+QwQag==
X-Google-Smtp-Source: ABdhPJzTeAbpQHAN3aOYT/yPwkeieIwRqzZ3h0B2lFO6a+G6WYrV5lKndx8KZjBUJ93ExQ4O87sTJA==
X-Received: by 2002:a17:902:bf02:b0:149:c653:22af with SMTP id bi2-20020a170902bf0200b00149c65322afmr8296195plb.139.1641420432941;
        Wed, 05 Jan 2022 14:07:12 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7fcd:6709:f1b5:a22a])
        by smtp.gmail.com with UTF8SMTPSA id s8sm91930pfu.190.2022.01.05.14.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 14:07:12 -0800 (PST)
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
Subject: [PATCH 05/17] rtc: wilco: Add PL_CHROMEOS dependency
Date:   Wed,  5 Jan 2022 14:06:41 -0800
Message-Id: <20220105220653.122451-6-gwendal@chromium.org>
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
 drivers/rtc/rtc-wilco-ec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-wilco-ec.c b/drivers/rtc/rtc-wilco-ec.c
index 2a205a64645213..82f6e707bb0af0 100644
--- a/drivers/rtc/rtc-wilco-ec.c
+++ b/drivers/rtc/rtc-wilco-ec.c
@@ -191,4 +191,5 @@ module_platform_driver(wilco_ec_rtc_driver);
 MODULE_ALIAS("platform:rtc-wilco-ec");
 MODULE_AUTHOR("Nick Crews <ncrews@chromium.org>");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(PL_CHROMEOS);
 MODULE_DESCRIPTION("Wilco EC RTC driver");
-- 
2.34.1.448.ga2b2bfdf31-goog

