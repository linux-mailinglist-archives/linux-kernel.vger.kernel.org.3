Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC6A54376C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 17:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242860AbiFHPbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 11:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240721AbiFHPbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:31:38 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5A13CA7F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 08:31:26 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a2so27669198lfg.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 08:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PszhJWgHAI6pVsyU6iHd0WPiwfriVIOotwYAT+LX6GU=;
        b=CJ9bUUwJ5I/2DRNLCwUbHItekG3dQdL6+dLnCT2zVgL6qMZvEEUR9eCHnpXyDYeVM0
         dHfBKU7+U7dn9sO5zja+12uiXSJNCU1BzI7Ay6FoFGiczeGbMo8JcM5s0Swu6eCOtkZC
         Q+AK6UE4hVeKkKwh8MtJbSqpCOMeJZaZbLqpVVMjRNypYaxgB4wW94kwpPirlmsO/Iab
         DMgJ3LT0anyUrRiN30L60/8iJERFGNyJB/KrOMmJhtQbJZ5awHODafZlDF9otpqrBbMq
         k4Ei9DQ6XDDZKioxSUzM1Pgt9K7gWnHt+lU0YdjTnlU8eTqSsEFB6VbxCz2yTZJJV5XL
         AtUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PszhJWgHAI6pVsyU6iHd0WPiwfriVIOotwYAT+LX6GU=;
        b=RT5vX3j2c9BeYAO58FK81OP27bmxWnAHz0TjnaGl9dU366m/FauC1GiY9iqxHywmaL
         QGnL2i0mq0JItu3c7xOihtctcW9PvOcuZoYIH17VGh2EHjiqSHZzmMwcr1fB2gpIzake
         13NwOlazfO26kWmvI6QIil96pjpoWT3ZX56KMX6IQjcW0nj+ZmI6BOHSHIlMnWd3uCyD
         M7/k6tyOgJj8vG3ntc9VN3wqjri5YSb5qmLbZa9NRcCDgm4k3h/dfOoDD0LWPMiB0yPs
         jlPnKqpWxmHMhLSHOCT/zho/2lIlgMijbyr+NwWvjqtbsZpyoK36dZd31WNh42V/sXZf
         L07Q==
X-Gm-Message-State: AOAM531qnrNiC5vbtYVtoKtxHFDBijk/U1c/NOdW0xpYYbJoqXAuxLJl
        gWTCtsXdUQvGeWHVn9omD20Qj9LCmJ1I/g==
X-Google-Smtp-Source: ABdhPJw0DT7ia5MoypxM38XOxKE1ZGLksy/tIyqFVdh0t9mXVXB4daSntt2cx1ZWggrI94fa5IiEvg==
X-Received: by 2002:ac2:5463:0:b0:479:15cc:5cfe with SMTP id e3-20020ac25463000000b0047915cc5cfemr18622178lfn.656.1654702284777;
        Wed, 08 Jun 2022 08:31:24 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-133-137.NA.cust.bahnhof.se. [155.4.133.137])
        by smtp.gmail.com with ESMTPSA id k6-20020a2e92c6000000b002556a17e193sm3348345ljh.38.2022.06.08.08.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 08:31:23 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Tony Lindgren <tony@atomide.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Axe Yang <axe.yang@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM: runtime: Extend support for wakeirq for force_suspend|resume
Date:   Wed,  8 Jun 2022 17:31:20 +0200
Message-Id: <20220608153120.303070-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A driver that makes use of pm_runtime_force_suspend|resume() to support
system suspend/resume, currently needs to manage the wakeirq support
itself. To avoid the boilerplate code in the driver's system suspend/resume
callbacks in particular, let's extend pm_runtime_force_suspend|resume() to
deal with the wakeirq.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Note that, the reason behind this patch came up while discussing an MMC patch
for a Mediatek MMC host driver [1].

Kind regards
Ulf Hansson

[1]
https://lkml.org/lkml/2022/6/8/813

---
 drivers/base/power/runtime.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 676dc72d912d..445a724cbded 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1876,10 +1876,13 @@ int pm_runtime_force_suspend(struct device *dev)
 
 	callback = RPM_GET_CALLBACK(dev, runtime_suspend);
 
+	dev_pm_enable_wake_irq_check(dev, true);
 	ret = callback ? callback(dev) : 0;
 	if (ret)
 		goto err;
 
+	dev_pm_enable_wake_irq_complete(dev);
+
 	/*
 	 * If the device can stay in suspend after the system-wide transition
 	 * to the working state that will follow, drop the children counter of
@@ -1896,6 +1899,7 @@ int pm_runtime_force_suspend(struct device *dev)
 	return 0;
 
 err:
+	dev_pm_disable_wake_irq_check(dev, true);
 	pm_runtime_enable(dev);
 	return ret;
 }
@@ -1929,9 +1933,11 @@ int pm_runtime_force_resume(struct device *dev)
 
 	callback = RPM_GET_CALLBACK(dev, runtime_resume);
 
+	dev_pm_disable_wake_irq_check(dev, false);
 	ret = callback ? callback(dev) : 0;
 	if (ret) {
 		pm_runtime_set_suspended(dev);
+		dev_pm_enable_wake_irq_check(dev, false);
 		goto out;
 	}
 
-- 
2.25.1

