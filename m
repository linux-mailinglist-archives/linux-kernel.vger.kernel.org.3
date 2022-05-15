Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FD2527629
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 08:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbiEOGmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 02:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235880AbiEOGmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 02:42:37 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043592CE0C;
        Sat, 14 May 2022 23:42:37 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 202so11267094pgc.9;
        Sat, 14 May 2022 23:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jHoiiJnHaNxKGmdGlLTGyX4TUtGSyjY88OutPdITYRg=;
        b=TXw+i+bQKAdvXrV/lWICdHZCsWSVMpk+d2HPACKk2B6zaN09RH3YvbXXGnyLPeUnAh
         UwecqpTwVTVeFg0LcSwMIM9hMwYT9mY+90XbciLa/O8d1gHIltBYIXQ4fqzPtP+Tgg/R
         rwtbAAb6E+Cs+M7ZyGKRz2EYNpE5uwu/vNxoWoFOgm6V2a2AC9Pv3fIIik1tCJt/SLhb
         75J58Ohml89s8iHDQ2nkCCjfYhsKiHMei+VN0JZi2dL/U89NeG+9yeT21k3yAiQHQMqd
         eKouDFbwHvEes25IR2t0xgSUQ77zeAFygXUWxVNvwKuyOnYmxP28jbFBdsFjofxn4tiL
         xW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jHoiiJnHaNxKGmdGlLTGyX4TUtGSyjY88OutPdITYRg=;
        b=rQOWCbfRjCsj2DHZGTclzN3aGJA9zT/cLSO+Mwnyndi97BP06ZgeqYqyaMzXfySnvz
         C5x4gdn26NMrG4LJDr1HCJbFKiRaxwowXiSWqYtF0Eari7qFY0QM6RpzZ4rB51c7cL4H
         vvTyg9TuBlfYXmm0cwAPrZ4qg5oysazbEsyDWrUT28ncS4LbA7aLteAgvvSraxFE2ide
         +yXXpcww6Aq5Vp2QddlGOqLEqL5J4LcMxzek83Kne3IPWoc1mwUEDYDxxsJ7a0FwRCQW
         vRo7K12KZbr1p2S8KlRwxDwY1qehI5DSOqdRMe7Y51qPrydpberUN08BeF75RgnGGHw8
         0F7A==
X-Gm-Message-State: AOAM533igRMhD8gWk8iPvq5s+A71t0six+2DHOSrT2lUYKaLfX/duWpr
        eXzMmbI1LpiPJigabmdZKoKzpR7r2uNcp8dJ
X-Google-Smtp-Source: ABdhPJyVg2kGbF7B3nhQRG6rI1vby0IkE4VgLt98KUxzOmJrd5yLL/6h83HAjfdjuWTewrm7Tsj0vQ==
X-Received: by 2002:a05:6a00:98c:b0:50d:f856:53d8 with SMTP id u12-20020a056a00098c00b0050df85653d8mr12020989pfg.49.1652596956582;
        Sat, 14 May 2022 23:42:36 -0700 (PDT)
Received: from alarm.. ([103.51.72.28])
        by smtp.gmail.com with ESMTPSA id g24-20020a170902d5d800b0015e8d4eb2e3sm4568687plh.301.2022.05.14.23.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 23:42:36 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>
Subject: [PATCHv2 5/6] thermal: exynos: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
Date:   Sun, 15 May 2022 06:41:22 +0000
Message-Id: <20220515064126.1424-6-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220515064126.1424-1-linux.amoon@gmail.com>
References: <20220515064126.1424-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the newlly introduced pm_sleep_ptr() macro, and mark the
functions __maybe_unused. These functions can then be moved outside the
CONFIG_PM_SUSPEND block, and the compiler can then process them and
detect build failures independently of the config. If unused, they will
simply be discarded by the compiler.

Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v1: new patch in this series.
---
 drivers/thermal/samsung/exynos_tmu.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 0faec0f16db6..f8a527f19383 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1149,15 +1149,14 @@ static int exynos_tmu_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int exynos_tmu_suspend(struct device *dev)
+static int __maybe_unused exynos_tmu_suspend(struct device *dev)
 {
 	exynos_tmu_control(to_platform_device(dev), false);
 
 	return 0;
 }
 
-static int exynos_tmu_resume(struct device *dev)
+static int __maybe_unused exynos_tmu_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 
@@ -1169,15 +1168,11 @@ static int exynos_tmu_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(exynos_tmu_pm,
 			 exynos_tmu_suspend, exynos_tmu_resume);
-#define EXYNOS_TMU_PM	(&exynos_tmu_pm)
-#else
-#define EXYNOS_TMU_PM	NULL
-#endif
 
 static struct platform_driver exynos_tmu_driver = {
 	.driver = {
 		.name   = "exynos-tmu",
-		.pm     = EXYNOS_TMU_PM,
+		.pm     = pm_sleep_ptr(&exynos_tmu_pm),
 		.of_match_table = exynos_tmu_match,
 	},
 	.probe = exynos_tmu_probe,
-- 
2.36.1

