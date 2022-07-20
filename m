Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7937F57B4F9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 13:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239121AbiGTLDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 07:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiGTLDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 07:03:10 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD63C2A956
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 04:03:08 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u5so2555351wrm.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 04:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Grqol63HiejCmLbuLyNSkrynj326MhV0v8EmmfiIV4=;
        b=nPj7GVWzBXO4RYQR/h63XBjQoOLHy11LNpwIDH617fHez/Z4MTJbWOc5HpMT4YRg+e
         sDbHvE89lubQCG58vmGiff60Hdu6aSeXxT4FVFiTBVuaPiI73G+cw4cMRNMIHbWbEQj6
         nu6WvP6xVn05i4YMeqtsbMKg+63UNW86ItY9lSdO6T6xWDYHAsqrs3Wo+FYTJmKpe6+6
         orpneVGB4+fzoU0JygohoMMtEx/ppKhL01RMlytCNwZiG6TQZXQD0kfo4p2KWuk1iUGu
         d5O83WvzfZfqZIJCLZWSU7aWNXFvZKD7f1QWPIDPlXl9iFE+tIZV1PwdGN/mjP4CA6VG
         vFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Grqol63HiejCmLbuLyNSkrynj326MhV0v8EmmfiIV4=;
        b=EEbLIDhHmgxHoJLnQXQEgVxMjd9YZRfSHtVpdv/ZTwJxYBcp4PdTMhnvP16y21dUYw
         58OPH3CmC2TSfaLjYiufOmX0eOpxyqzntCF3sCkola2QnevsROxtqt2WOwmDp75Vt1Yh
         81eBByCt9sFYzvxevHq1Wya3I9laW+gPaxhjh+AbTgzKuUqqL6EpjzQATLfsUMXB0Krj
         K2SYcfhx1bYOTkgyZK5PnolbVl5zzD4edgEAeCWyoqkHKQmhSOvsQLBePSe5pMBOlW1e
         SL1sSC/O1yydKXlP6ljQj2pgJfyc8OxlPUaBKrNBXxgU0UZ2ztLKjRQH/Qu960ImMTwe
         5sSA==
X-Gm-Message-State: AJIora8VpBrITUxl49oVWvJFkHNPwPe9h6AX8z+jCKUiCXhnYAEeUAgr
        l8cq6LYBWvciX6uIIlAyAYXfvg==
X-Google-Smtp-Source: AGRyM1vq+rsgEwuDKC+RyP11nR3PyRH6fD1iFUKSpgZb+K7geNzHvNmZwn7GlV2BbBTx/fyam84hJQ==
X-Received: by 2002:adf:eace:0:b0:21d:6e90:2bf8 with SMTP id o14-20020adfeace000000b0021d6e902bf8mr28476828wrn.349.1658314987314;
        Wed, 20 Jul 2022 04:03:07 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id k22-20020a05600c1c9600b003a2e5f536b3sm2300298wms.24.2022.07.20.04.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 04:03:05 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Subject: [RFC] PM: domains: Reverse the order of performance and enabling ops
Date:   Wed, 20 Jul 2022 14:02:46 +0300
Message-Id: <20220720110246.762939-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.3
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

Rather than enabling and then setting the performance state, which usually
translates into two different levels (voltages) in order to get to the
one required by the consumer, we could give a chance to the providers to
cache the performance state needed by the consumer and then, when powering
on the power domain, the provider could use the cached level instead.
Also the drop_performance and power_off have to be reversed so that
when the last active consumer suspends, the level doesn't actually drop
until the pd is disabled.

For the power domains that do not provide the set_performance, things
remain unchanged, as does for the power domains that only provide the
set_performance but do not provide the power_on/off.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/base/power/domain.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 5a2e0232862e..38647c304b73 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -939,8 +939,8 @@ static int genpd_runtime_suspend(struct device *dev)
 		return 0;

 	genpd_lock(genpd);
-	gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
 	genpd_power_off(genpd, true, 0);
+	gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
 	genpd_unlock(genpd);

 	return 0;
@@ -978,9 +978,8 @@ static int genpd_runtime_resume(struct device *dev)
 		goto out;

 	genpd_lock(genpd);
+	genpd_restore_performance_state(dev, gpd_data->rpm_pstate);
 	ret = genpd_power_on(genpd, 0);
-	if (!ret)
-		genpd_restore_performance_state(dev, gpd_data->rpm_pstate);
 	genpd_unlock(genpd);

 	if (ret)
@@ -1018,8 +1017,8 @@ static int genpd_runtime_resume(struct device *dev)
 err_poweroff:
 	if (!pm_runtime_is_irq_safe(dev) || genpd_is_irq_safe(genpd)) {
 		genpd_lock(genpd);
-		gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
 		genpd_power_off(genpd, true, 0);
+		gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
 		genpd_unlock(genpd);
 	}

@@ -2747,17 +2746,6 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 	dev->pm_domain->detach = genpd_dev_pm_detach;
 	dev->pm_domain->sync = genpd_dev_pm_sync;

-	if (power_on) {
-		genpd_lock(pd);
-		ret = genpd_power_on(pd, 0);
-		genpd_unlock(pd);
-	}
-
-	if (ret) {
-		genpd_remove_device(pd, dev);
-		return -EPROBE_DEFER;
-	}
-
 	/* Set the default performance state */
 	pstate = of_get_required_opp_performance_state(dev->of_node, index);
 	if (pstate < 0 && pstate != -ENODEV && pstate != -EOPNOTSUPP) {
@@ -2769,6 +2757,18 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 			goto err;
 		dev_gpd_data(dev)->default_pstate = pstate;
 	}
+
+	if (power_on) {
+		genpd_lock(pd);
+		ret = genpd_power_on(pd, 0);
+		genpd_unlock(pd);
+	}
+
+	if (ret) {
+		genpd_remove_device(pd, dev);
+		return -EPROBE_DEFER;
+	}
+
 	return 1;

 err:
--
2.34.3

