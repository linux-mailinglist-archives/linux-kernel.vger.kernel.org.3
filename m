Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A88D534E96
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238588AbiEZLvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbiEZLvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:51:31 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1F02CDF9
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:51:30 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id d129so1132897pgc.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b6k3SV/2S1GAZa9ElYwCPu3QFpy6+7ouZdodLYF77Eg=;
        b=legUHLb2Ee0bshJ1QbJG8LcjSMIqtKRbixMePTPiZEcUDPkkQFN267HpCA1jFH2J7i
         rGS0iYDVjK1GC0GvSFOiqQLKen+vc+VtZ8EOXdLo/qPxcFmymLIexh6kgJumiN7mYFj+
         J6rKWsicVRH3v9GpAakUPk4AfDJntjsKM5FLceeHrpnToV+987nv/FzLNy3S4+K3FZ2F
         rUV23pJ0j80ZpHT6uoNmAWM4IrQSfpzcR66leo/NeCjGXGFkvm28a/h8bynAShdfBsGL
         45+k1NsfTemXBUIlqh9sUL4pzdUAroSSOqM4749wgnNV1SQRFxgG6KXvm19oZ0GjzMsN
         f4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b6k3SV/2S1GAZa9ElYwCPu3QFpy6+7ouZdodLYF77Eg=;
        b=Lmxqg6nhvl9wL0SbNbepU4MpCO0I7NU3qmORBGHOPompzvwsjwhkn/mfT+Mfy2Okj9
         B2ZftvoO9KTwixZrGEjY/ijvjaH8amGO/CL96+JP73G1OdN6o8nN6c1egmV+I5JaVv+u
         rSpaaehrbOjRKMISkP4wZzGMOYLVH7LJ9LL+dgYvbJbxV049YxcAXrZ6QxdDvrU/hCLA
         fCmIKVDHmAGazejw2DkKsOEVVtNp9EDkb4u5k7h/PUepg7zZ7+3qESQT97xwBbfOGxX0
         xNuNbs8bj31N6t2MqD+RskfroDTREl3ygxBiwobTKmgupW5s2jE2G4nm9u840y1FG4P/
         ++7w==
X-Gm-Message-State: AOAM531OmlPx0ZAksLk+BwqFJJBJjK8jmh/S6Eo2z3dIS5IyR46ciQBV
        nBLc2uMCYq6mG5U1fJyS6T4Pf4wvqOJ2Jg==
X-Google-Smtp-Source: ABdhPJwZOiTJevyRe6XAQM2vVij0hiPhs8czMbGSWZxAAmYgERefN9RdPvVJGaeJvUfNt/FVir8xcA==
X-Received: by 2002:a63:5cb:0:b0:3f6:3a45:a479 with SMTP id 194-20020a6305cb000000b003f63a45a479mr31263406pgf.242.1653565890428;
        Thu, 26 May 2022 04:51:30 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902ab8700b0015e8d4eb272sm1295713plr.188.2022.05.26.04.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:51:30 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] cpufreq: Optimize cpufreq_show_cpus()
Date:   Thu, 26 May 2022 17:21:19 +0530
Message-Id: <b9fa08171c09343ace94a7343553a4bee4695c90.1653565641.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1653565641.git.viresh.kumar@linaro.org>
References: <cover.1653565641.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of specially adding a space for each CPU, except the first one,
lets add space for each of them and remove it at the end.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 2cad42774164..e24aa5d4bca5 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -843,12 +843,14 @@ ssize_t cpufreq_show_cpus(const struct cpumask *mask, char *buf)
 	unsigned int cpu;
 
 	for_each_cpu(cpu, mask) {
-		if (i)
-			i += scnprintf(&buf[i], (PAGE_SIZE - i - 2), " ");
-		i += scnprintf(&buf[i], (PAGE_SIZE - i - 2), "%u", cpu);
+		i += scnprintf(&buf[i], (PAGE_SIZE - i - 2), "%u ", cpu);
 		if (i >= (PAGE_SIZE - 5))
 			break;
 	}
+
+	/* Remove the extra space at the end */
+	i--;
+
 	i += sprintf(&buf[i], "\n");
 	return i;
 }
-- 
2.31.1.272.g89b43f80a514

