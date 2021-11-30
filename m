Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D0D46425A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345252AbhK3X13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240800AbhK3X1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:27:19 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54AEC061746;
        Tue, 30 Nov 2021 15:23:58 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id bi37so57905256lfb.5;
        Tue, 30 Nov 2021 15:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rGt0BYEmXAksyhDFPu2BDGLoJLdnyV3VilAtYqDDqgs=;
        b=hYjs50JpK/p++K58Ujc9ubcdJqB861uXepZV1bX+eetvwMqZMXLA80AwSAwW69dTqV
         HocIqoiHXDV1gnFBCLYGwGovcCzTKFaLnrJOTCP1nr0OCTN1Iwsx/7zr2/R7mPbPL5pT
         vp2ZjrkAXKi5np9ryjhh3kQC7B6lwUmTeGZ4iiLuRyylMogAeaRoOLm+caPjCW0HxxAF
         AJke/JX8phasLWgR64TIxDMfrg/tQBv4TSPdUGrzKKBHAkzOCfZZuWuXkS04kgBLAmS7
         HGk75M06RG/vwWydfuyXGFP3JErdCrkInMMFKh5HPm338XenpNcNCuZYlHiBcKlvJSI4
         nSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rGt0BYEmXAksyhDFPu2BDGLoJLdnyV3VilAtYqDDqgs=;
        b=K1b3KAA+cY+OXiFRyCOBHHb/53sMfjtciKgVRf6hNYAHKaT13kjDtjm4rZ+dxyyx/p
         Am4dBl+qWxYdP+OGrITs71BR2Sy2VdcAoMkrw8rmLQQfNS6Mb5gI3HHDuMxQFHRkYPD7
         ft9bgepRQHV+TBWhWx+hLa0ZOTQyCTtA6WK35KJXM7LbDxUcJhOneYZR19nj9iQgp2f/
         ypTWfCWzxUjqhvB92DdU02GSODlr7XtudxF2yzCgrd7gxL7R5709r/CJQfC+7J0q/msx
         1KkjLeJgGINg5lnbZDFy2hyKTxLxHh7C6hYXPgPOhobrd4nX7xP5RCJKF858uVue0rQD
         Zf+A==
X-Gm-Message-State: AOAM53370d51wVv+cehz9Jdmkiegt+FjzdpWh4kKSLet5oahlUiVxD3d
        zFCBxMf0MONS6wWQ3SzdXUk=
X-Google-Smtp-Source: ABdhPJxapGltrB+HI+20V4TuzLOGRIh5IkpXbQ9OWJEwi4DFAiNSljeWPGxdtCrOEA2u2i0odAiHpg==
X-Received: by 2002:a19:7709:: with SMTP id s9mr2287962lfc.682.1638314637278;
        Tue, 30 Nov 2021 15:23:57 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id x199sm1860735lff.284.2021.11.30.15.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 15:23:56 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: [PATCH v16 03/40] soc/tegra: Don't print error message when OPPs not available
Date:   Wed,  1 Dec 2021 02:23:10 +0300
Message-Id: <20211130232347.950-4-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211130232347.950-1-digetx@gmail.com>
References: <20211130232347.950-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously we assumed that devm_tegra_core_dev_init_opp_table() will
be used only by drivers that will always have device with OPP table,
but this is not true anymore. For example now Tegra30 will have OPP table
for PWM, but Tegra20 not and both use the same driver. Hence let's not
print the error message about missing OPP table in the common helper,
we can print it elsewhere.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
index 35c882da55fc..32c346b72635 100644
--- a/drivers/soc/tegra/common.c
+++ b/drivers/soc/tegra/common.c
@@ -136,9 +136,7 @@ int devm_tegra_core_dev_init_opp_table(struct device *dev,
 	 */
 	err = devm_pm_opp_of_add_table(dev);
 	if (err) {
-		if (err == -ENODEV)
-			dev_err_once(dev, "OPP table not found, please update device-tree\n");
-		else
+		if (err != -ENODEV)
 			dev_err(dev, "failed to add OPP table: %d\n", err);
 
 		return err;
-- 
2.33.1

