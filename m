Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DB5523658
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245278AbiEKO5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245243AbiEKO5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:57:22 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9432968F99
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:57:21 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id q130so2955253ljb.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5o32wUvvQH//2mVRnrNn2QEStbroChjE5Xk/XzAuRBk=;
        b=dki0vUPuO6N2MH4IL3ZTgEaxHGtGP6p6K0m8Q72dfkfKBbFT0OwqRrUiuBrl3lXLgZ
         JFjAobUlKptUEqnzST5BCRTsTA/rZijsUSqp69imeyxWu9csCASx04zP2ecPcCxgtG29
         SEmcuQQFzv+jHpS16Oml5yWyakl16G2yDbL598oH0xaLD25bYYNYmY35usC091wBaR97
         d5YeKaCQ7WmbxTgul/MLdJgLW9GdTi2tlX77R14DOyZ7VpC+5Y0IiIgtn5XFhIrNNUS6
         fdD2XyMqPjitot5O893/T4TZDMsiuEanmcy0qR0CybUhE0Bs2o3a9vnlxr12ytHgUslf
         DDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5o32wUvvQH//2mVRnrNn2QEStbroChjE5Xk/XzAuRBk=;
        b=UpZZimiSMyddu5JEDOQ2e4yWP3vUkxpo5WMrIjtudw8lJC0uCNG3ntEgp+xqjGPEUe
         o6j+PxC8trSCtXXjsyYHVWMwOKV+K5rGFLw3kGEN+DBFhAueAsqxQXNa0aAjJwgm+aX7
         N1UfeGdPriOeSxkUvkJl05Ix089BzsHYsX4gjr38Un2vuYV0uQGlhkIm98B/nYjCkLGG
         HZijqjmKMmj+GJST4zuaesorrDsNSae6wOEwVA5qo6WmTOjhJJd8z6il3nEtJY1KnndL
         AR1Tq7Y9iVAhuswN2tk7E92od31/V5Zf7wGpAUk6WKxGPB8/Hby8fXW+5EG8B0Ume5/6
         SGaQ==
X-Gm-Message-State: AOAM530WgDsKn0Rd/68BQyLnVaoBf/uByX4CPGO0oWYuw5R6uzDyfgmc
        5+OUWnwl/Gzt3sqju2puol+ScQ==
X-Google-Smtp-Source: ABdhPJxN7/QyIiPpFUbdwfUHavikSQxiBF96wJKrFR+5weGOmkPZiZowCNcAmTYK4Y2f75InPhl2lQ==
X-Received: by 2002:a05:651c:b90:b0:250:7fa3:b234 with SMTP id bg16-20020a05651c0b9000b002507fa3b234mr17825253ljb.188.1652281039986;
        Wed, 11 May 2022 07:57:19 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-154.NA.cust.bahnhof.se. [98.128.181.154])
        by smtp.gmail.com with ESMTPSA id z26-20020a19f71a000000b0047255d210f3sm320793lfe.34.2022.05.11.07.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 07:57:19 -0700 (PDT)
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
Subject: [PATCH 01/14] PM: domains: Add GENPD_FLAG_RPM_ALWAYS_ON for the always-on governor
Date:   Wed, 11 May 2022 16:56:51 +0200
Message-Id: <20220511145704.698189-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511145704.698189-1-ulf.hansson@linaro.org>
References: <20220511145704.698189-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than relying on the genpd provider to set the corresponding flag,
GENPD_FLAG_RPM_ALWAYS_ON, when the always-on governor is being used, let's
add it in pm_genpd_init(). In this way, it starts to benefits all genpd
providers immediately.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 18cd7965e5d6..262bda9b56ef 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2016,6 +2016,10 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 		genpd->dev_ops.start = pm_clk_resume;
 	}
 
+	/* The always-on governor works better with the corresponding flag. */
+	if (gov == &pm_domain_always_on_gov)
+		genpd->flags |= GENPD_FLAG_RPM_ALWAYS_ON;
+
 	/* Always-on domains must be powered on at initialization. */
 	if ((genpd_is_always_on(genpd) || genpd_is_rpm_always_on(genpd)) &&
 			!genpd_status_on(genpd))
-- 
2.25.1

