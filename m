Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D6C523662
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245378AbiEKO5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbiEKO5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:57:25 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43B26AA64
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:57:23 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id t25so4031089lfg.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FiBV3RuZHkNt12iyxe5bJpydrAvajHAN4kw3wSlCMnc=;
        b=yvMYuV9LwZ+uQZR4bryt2mLHm4+REdWKBopwfobrmdHoVZRpOeQlWzVnFxuR51p5Gp
         A2avs/W7zovDB1xAgfvnpP7B+jKhQ8vdElzMdEqfYSUTezyG7/rzrf484HSk0HbDIoUQ
         dPAinQ6DnJUKkEUt59IpkWcrl3I6F/nEMEEEY5DUP0lKlBKIM1yUYwGUEWc2I/8pz6wD
         TUDFJ3JUIlfOljrZPAOWtbxFq5edGrPtbgQ/+XnxfJ/zZDDjPrdkGYAhq51eFm+jZ2Fx
         +k8b87NKJBCHykNviJdhUZnDwZ6imof1WiSUQvxcLsq5ZnJLJ0az6eU/GKxwxdLlCC5o
         DbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FiBV3RuZHkNt12iyxe5bJpydrAvajHAN4kw3wSlCMnc=;
        b=LkWma0ssUea1M3zLFnZfc+IsU8sqLsiLIAbOLmD8JjSpixVXb4tSpK6KJcc+VcAvKO
         rWAZFpGYlCEmSS9mASMcCp9ndyKc4OnAAG8oBXzQF355P2aSr0auP1Lr6LJC5o48YNkR
         ZzK+mYjYzrmV+u1jaWQrAQ5YFSAO0vAHg/sTJ6d/huQVPWKHZ7cc+TqaMhUYsYqDvtwJ
         7NZRJ6OCNPsw8YJ5NfxMuen5vQQI2L3Qh8M3T8yepIQRpG8MSs8KHejHbkyqT2k6BHXH
         dkrOkdKTZQcuCWakcXHzlyqmKMgZSLRTI/wKe9usZzfclDyXD3pEP8HFBmiHCehEgc1I
         lsKw==
X-Gm-Message-State: AOAM530fjCksZZuOLBhB6H0qz1DRHO13CPewosLw3v+TqbkRx0qWWL0z
        C4Vui2W5IlKaZrO/sn36AbaSu1apqr1G3g==
X-Google-Smtp-Source: ABdhPJw9fbJPMaUL49JJmqpdiItGez/51B1goqNb6N0vrbxzmmbTUFsFO8uPBWzeN9BwDLXMg82kaA==
X-Received: by 2002:a05:6512:ad4:b0:473:b1a0:30de with SMTP id n20-20020a0565120ad400b00473b1a030demr20996097lfu.610.1652281042063;
        Wed, 11 May 2022 07:57:22 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-154.NA.cust.bahnhof.se. [98.128.181.154])
        by smtp.gmail.com with ESMTPSA id z26-20020a19f71a000000b0047255d210f3sm320793lfe.34.2022.05.11.07.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 07:57:21 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/14] PM: domains: Drop redundant code for genpd always-on governor
Date:   Wed, 11 May 2022 16:56:52 +0200
Message-Id: <20220511145704.698189-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511145704.698189-1-ulf.hansson@linaro.org>
References: <20220511145704.698189-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to recent changes, the always-on governor is always used with a genpd
that has the GENPD_FLAG_RPM_ALWAYS_ON flag being set. This means genpd,
doesn't invoke the governor's ->power_down_ok() callback, which makes the
code in the governor redundant, so let's drop it.

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

