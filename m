Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED88F523673
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiEKO6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245325AbiEKO5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:57:38 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3691FD866
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:57:33 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id t25so2956004ljd.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1l+XmFy90zJUqh6uSXg8CIYQDjU5HDLCDj0R7eANRVs=;
        b=KSlADItncdzu7g/umHmQz3OtajEsfndFD+dkoDvvfzlZo2fREDqcLmV+CqiHDXFjMm
         oeO36+yXMVzEjqnEB2JFbNi5ovuCxSyQstqQU2zqnhch+RNOaLIGnOxPIXKl89dM76S+
         y68pdPWTEqXeoAaGuijCxJDG5i+aAjNLrS7+pq0N/tFdq1UxdeIv5q7AHzIGl/o9yOKv
         z1bVdY1tDEp6mE2bbZK+lYRn8/t3SWLflT9lMDsxzLePFj+MH2abaHEn5gRurfe52+OU
         78XUs9Pymg+1GL7aUV2ZHJ34OWGWNNZhOQCpodipAI1erTZBuSIzA4LoRF8t222NbymO
         kQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1l+XmFy90zJUqh6uSXg8CIYQDjU5HDLCDj0R7eANRVs=;
        b=jSJGCOMLy0MM/ruUSDFrKZcXC/BuVvmTwULSaChWt/rTTCN1GCvFzidQu7e1f75Aoi
         XjdcKcw3DWL6Y9UZ/Bo+/wOWQrFjDo9Dq8fdp7AZXPRlWBECLDre5ASc6pbrPLLtViLj
         1GGHSX73YjCrc4BZR5FP9vh89+UYYk0OFE9lhDS4vYu1HmHW7d6/38YzN/bnIkeTWAoI
         a8ERj0MCVITh+s6f+zlszaNMq5tCsFID6P6HaUfAwvze0+r1JpW8NG/ml7yJtwoDObTK
         UFJ/5ClhYZgUnOZRLl77H3q4GMoxR3OuPcBBjazOR/uyDf/cKGsYC9upT966RKKIU1Mw
         Aabg==
X-Gm-Message-State: AOAM531yz/VSsuBmFO6GaIvWjjpUBvzbUCl1WmeOYJKl6Kl+8DmCacmW
        uNfxGz+3Y5WOiKuJ9/ZXQyyhZA==
X-Google-Smtp-Source: ABdhPJxXvTOm0cxB4sH4Yz2HTmmgnHipU4lVOgRNiD0Lw1H2QftanODBihzRGG0PhZdXh4L4C788JQ==
X-Received: by 2002:a2e:3304:0:b0:250:9109:2e80 with SMTP id d4-20020a2e3304000000b0025091092e80mr17593469ljc.508.1652281052855;
        Wed, 11 May 2022 07:57:32 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-154.NA.cust.bahnhof.se. [98.128.181.154])
        by smtp.gmail.com with ESMTPSA id z26-20020a19f71a000000b0047255d210f3sm320793lfe.34.2022.05.11.07.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 07:57:31 -0700 (PDT)
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
Subject: [PATCH 08/14] PM: domains: Measure suspend/resume latencies in genpd based on governor
Date:   Wed, 11 May 2022 16:56:58 +0200
Message-Id: <20220511145704.698189-9-ulf.hansson@linaro.org>
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

The QoS latency measurements for devices in genpd_runtime_suspend|resume()
are superfluous, unless the corresponding genpd has a governor assigned to
it, which would make use of the data.

Therefore, let's improve the behaviour in genpd by making the measurements
conditional, based upon if there's a governor assigned.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 4c059a858957..2cdfbe48dde0 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -881,7 +881,7 @@ static int genpd_runtime_suspend(struct device *dev)
 	struct generic_pm_domain_data *gpd_data = dev_gpd_data(dev);
 	struct gpd_timing_data *td = gpd_data->td;
 	bool runtime_pm = pm_runtime_enabled(dev);
-	ktime_t time_start;
+	ktime_t time_start = 0;
 	s64 elapsed_ns;
 	int ret;
 
@@ -902,8 +902,7 @@ static int genpd_runtime_suspend(struct device *dev)
 		return -EBUSY;
 
 	/* Measure suspend latency. */
-	time_start = 0;
-	if (runtime_pm)
+	if (td && runtime_pm)
 		time_start = ktime_get();
 
 	ret = __genpd_runtime_suspend(dev);
@@ -917,9 +916,9 @@ static int genpd_runtime_suspend(struct device *dev)
 	}
 
 	/* Update suspend latency value if the measured time exceeds it. */
-	if (runtime_pm) {
+	if (td && runtime_pm) {
 		elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
-		if (td && (elapsed_ns > td->suspend_latency_ns)) {
+		if (elapsed_ns > td->suspend_latency_ns) {
 			td->suspend_latency_ns = elapsed_ns;
 			dev_dbg(dev, "suspend latency exceeded, %lld ns\n",
 				elapsed_ns);
@@ -956,11 +955,10 @@ static int genpd_runtime_resume(struct device *dev)
 	struct generic_pm_domain *genpd;
 	struct generic_pm_domain_data *gpd_data = dev_gpd_data(dev);
 	struct gpd_timing_data *td = gpd_data->td;
-	bool runtime_pm = pm_runtime_enabled(dev);
-	ktime_t time_start;
+	bool timed = td && pm_runtime_enabled(dev);
+	ktime_t time_start = 0;
 	s64 elapsed_ns;
 	int ret;
-	bool timed = true;
 
 	dev_dbg(dev, "%s()\n", __func__);
 
@@ -988,8 +986,7 @@ static int genpd_runtime_resume(struct device *dev)
 
  out:
 	/* Measure resume latency. */
-	time_start = 0;
-	if (timed && runtime_pm)
+	if (timed)
 		time_start = ktime_get();
 
 	ret = genpd_start_dev(genpd, dev);
@@ -1001,9 +998,9 @@ static int genpd_runtime_resume(struct device *dev)
 		goto err_stop;
 
 	/* Update resume latency value if the measured time exceeds it. */
-	if (timed && runtime_pm) {
+	if (timed) {
 		elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
-		if (td && (elapsed_ns > td->resume_latency_ns)) {
+		if (elapsed_ns > td->resume_latency_ns) {
 			td->resume_latency_ns = elapsed_ns;
 			dev_dbg(dev, "resume latency exceeded, %lld ns\n",
 				elapsed_ns);
-- 
2.25.1

