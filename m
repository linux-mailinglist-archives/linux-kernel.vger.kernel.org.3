Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631F4523664
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245382AbiEKO54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245296AbiEKO5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:57:35 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED35B0A66
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:57:28 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id b32so2979817ljf.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RuUBzy6pAOx/2fxGiEYKY7mFwWo2FzQU6CYeL4BrxxI=;
        b=o8hXsXE5c4ON8KPp7GEAdAY7YklOEikWfvH1aLWfMNAQdIh0iiqGBkKIFhthlyakHL
         7iMkc1t8hCjnU5KZ/k/2Pjvd7nuwBBwUTWVcqUKRSndkGanMvz5PdQQf+7BNIBLodFnU
         3CIvHG/A+8w9hDkAiyPlv2wklLcYep/B1g7U1AwOMeLrGT5CjJcHhZw5DhsNV86zQM4O
         aiyGLbiJg49JQJu6bBUbve6U2vwX0fs2qwBz9G3TyCInS3YQANG+SRXMeEdwNP90OVpz
         8FABXu6lhlkN/bFxxngUlDaFLUUap8UdyRJfqhNiWVhXFNA2+GPcAYMYWs+s99miF1/P
         Nz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RuUBzy6pAOx/2fxGiEYKY7mFwWo2FzQU6CYeL4BrxxI=;
        b=gFgqJtvUUaL+sUKLRzpUwNyd1jOHBzEA/bnuXp3Ro/PBXD7IVgx/BC4CIqygYZUCuJ
         PSLt++RC0nzXMuYAC/IxHPhykvtOzeRCqc/nClODpF9pq3lNoj37CjC1ymVCys9FJASW
         ziau+RbwQifI9W16etJXV7IXV+kA0W4sbBAD0Xmjil5w+7jFr9uQDB9Oo3JFpn+yZJTU
         ot2nDLGKKauATgMuy8v06TXAnei1TfM2fNApLxwTOe19A+ODRW2okDLfZrgWQozWBnOM
         KoAJR51/K6Omu/eFrAmRuZCOZP2bhKVytgh2mWTzMiClLwZqmxoM0Bd7ci5b5PwM8hPR
         7Erg==
X-Gm-Message-State: AOAM533e6MnWEaOx+bCCdScyhXpNKdcDLjwLxTSxWMT4MTFvy4iREvij
        mpyWCiQVUJJ0UcKuCUrpSD9GUA==
X-Google-Smtp-Source: ABdhPJyyTYvDxXyb+HlvjzSp9j916LdDcMhVTFtP5yG1H1brnj3qB9maz/2b/ljY8PumXPuzwGd3JQ==
X-Received: by 2002:a2e:97c7:0:b0:24f:5a7:f398 with SMTP id m7-20020a2e97c7000000b0024f05a7f398mr17163217ljj.231.1652281047104;
        Wed, 11 May 2022 07:57:27 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-154.NA.cust.bahnhof.se. [98.128.181.154])
        by smtp.gmail.com with ESMTPSA id z26-20020a19f71a000000b0047255d210f3sm320793lfe.34.2022.05.11.07.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 07:57:26 -0700 (PDT)
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
Subject: [PATCH 05/14] PM: domains: Skip another warning in irq_safe_dev_in_sleep_domain()
Date:   Wed, 11 May 2022 16:56:55 +0200
Message-Id: <20220511145704.698189-6-ulf.hansson@linaro.org>
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

In irq_safe_dev_in_sleep_domain() we correctly skip the dev_warn_once() if
the corresponding genpd for the device, has the GENPD_FLAG_ALWAYS_ON flag
being set. For the same reason (the genpd is always-on in runtime), let's
also skip the warning if the GENPD_FLAG_RPM_ALWAYS_ON flag is set for the
genpd.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 269bfa3d2303..a3e727c9a4fa 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -143,7 +143,10 @@ static inline bool irq_safe_dev_in_sleep_domain(struct device *dev,
 	 * callbacks are allowed to sleep. This indicates a suboptimal
 	 * configuration for PM, but it doesn't matter for an always on domain.
 	 */
-	if (ret && !genpd_is_always_on(genpd))
+	if (genpd_is_always_on(genpd) || genpd_is_rpm_always_on(genpd))
+		return ret;
+
+	if (ret)
 		dev_warn_once(dev, "PM domain %s will not be powered off\n",
 				genpd->name);
 
-- 
2.25.1

