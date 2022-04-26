Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B55510032
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351540AbiDZOSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351504AbiDZOSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:18:40 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D4B13E3E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:15:28 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id p10so32189919lfa.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zxzRefBI77z9hgqatEhKgv+DKfty9U6ghK1LVbo7j6g=;
        b=QLGRhd2Pi4JCAUmodnhxjytlHsjYsMztxt8K9xc9qpYANI7AaZrhTsscio79IjkUQI
         yXTk3H5XAsGl1hvlWbmja6j8KSC4ujPyuzGpvoJ01C56f1V0zQfoiuUmz3llwVoHJKBg
         4mSQSgXTuwl2xGlP0GuQRQ1CKGSwZ/N6zsFtXfB8Wn3ROzZS1nEFZHTrsxZ0cQlZcroP
         7v7G8RaiUEDKK2NNHSGXscxZjbEwOqX3Fw7eaNovtrd6HauNzxO+YfXM4TdncNnICHFv
         PdU/ClRkVedYyYqtUjd9ZuU23nbodUEy0nQIR2/45L2R9leg7o8jvY1UQa95gM8Y9CD+
         f2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zxzRefBI77z9hgqatEhKgv+DKfty9U6ghK1LVbo7j6g=;
        b=MH9Z73/xW4ZESrDSYB6B7FZ6oqcIMj6mHdnksWhwdyVObaAB2fFLYRjhV/Q+T0zczw
         4+gQ5S9QpfX+wiyZMoXYDlL1iCLKg9T7H4u4UtLnBEcoyxNeUphv5+/5jZOBVrDV17oM
         Tox2rIDr5/jK2Zl9fcdrZx2DgvirDGq6UULh3B+PTavBzB3GQc5h1FABt/8pVWKMZzJG
         qFM3KsRubDEqT41pNuzTjzXp27tgWkRHqtWzFbSvXEFQ9sX3mT/wgdMMMJV3lcHlWgGn
         RIqALrtRJeii8dC6y7YGi3+HQ/Qlc3vp5S6CzDK5J5kPA7O0yOVAZrULQf6iCAFE5yRo
         0LfQ==
X-Gm-Message-State: AOAM533TcVUv/SaDFVBDTbNfqsPiF5CgcBeh5EFntuGPu2uZ0nBCAVxh
        YSH/GeQicON0uYh4cx6vAIfOzA==
X-Google-Smtp-Source: ABdhPJwZM0hz5NTNslZdZTT4y9WKN1tMWLtl28kfh2I/DoQpBRrptcN0q0StrVDO9i2WSkdgy7mAhw==
X-Received: by 2002:a05:6512:6c2:b0:46b:9578:7c63 with SMTP id u2-20020a05651206c200b0046b95787c63mr17462809lff.204.1650982527150;
        Tue, 26 Apr 2022 07:15:27 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-154.NA.cust.bahnhof.se. [98.128.181.154])
        by smtp.gmail.com with ESMTPSA id g23-20020a2ea4b7000000b0024f096abebdsm1043360ljm.78.2022.04.26.07.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 07:15:22 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     Kevin Hilman <khilman@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] PM: domains: Drop redundant code for genpd always-on governor
Date:   Tue, 26 Apr 2022 16:15:06 +0200
Message-Id: <20220426141507.89868-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426141507.89868-1-ulf.hansson@linaro.org>
References: <20220426141507.89868-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to recent changes, the always-on governor is always used with a genpd
that has the GENPD_FLAG_RPM_ALWAYS_ON flag being set. This means genpd,
doesn't invoke the governor's ->power_down_ok() callback, which makes the
code in governor redundant, so let's drop it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain_governor.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index cd08c5885190..c13e44823f16 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -327,11 +327,6 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 	return _default_power_down_ok(pd, ktime_get());
 }
 
-static bool always_on_power_down_ok(struct dev_pm_domain *domain)
-{
-	return false;
-}
-
 #ifdef CONFIG_CPU_IDLE
 static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 {
@@ -401,6 +396,5 @@ struct dev_power_governor simple_qos_governor = {
  * pm_genpd_gov_always_on - A governor implementing an always-on policy
  */
 struct dev_power_governor pm_domain_always_on_gov = {
-	.power_down_ok = always_on_power_down_ok,
 	.suspend_ok = default_suspend_ok,
 };
-- 
2.25.1

