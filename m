Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B826C4642BF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345547AbhK3X2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345136AbhK3X11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:27:27 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C607C061756;
        Tue, 30 Nov 2021 15:24:06 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id u3so57955769lfl.2;
        Tue, 30 Nov 2021 15:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rbxS+czlvl4v2Ex+Hd7Oo4aKfN8xGGc3cJeJXZnVPgU=;
        b=HhEWquLQ1nSVC/e/vGlnslyaUjur7LLJIXBgEEdgcOwtHVYtU7j576qG3Nd8u0q4yT
         5Kc1fmoFvaz9J/yx2Jcm4eB1IeND5aJ+tQSjvEW+AXkpu9E7mYRQimIr3bdQ77ryelmt
         aYQB9pcnq9hqHZp4xL8bazBlrSIKEaEvGexN93349d36OOZeZRuZHH6+ewjqgeOhNWTi
         57pKRVQzSEjKzql9ubMSk1KGVFbksJAfPXOMyb1LpO7VIvyJQvf+EVnTo7MOgQW99rFJ
         YG8LsTEYiU60RLns4GP8tce8aJkTWG20ljC1thd1YisRvN75x9Q2wEKzq081Vndn4Of7
         fDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rbxS+czlvl4v2Ex+Hd7Oo4aKfN8xGGc3cJeJXZnVPgU=;
        b=HBaVr13P/3KXm69QguuBM7Qd11dCxHb7n/LwVSGML3TQcFWFzVuPoRjKeGb7LJjc3l
         Idz9Yubx2AEx90CN7cdcRXPczIaQKVoWXmxnDIVzzCP6bmTkV1cAffFhTSHeHLYwsX9s
         g1keNOYKkPaUxzlVauS6VGdBAfdcTML3MWt6o1rleghFNLDqgtvbAhTDyOl06SBp9n9x
         8BzOkp4Pyk28n2uSUWkdIb6NISRwFoS6DEXuWCfxEuKE49mm9ouBiwM2uUH86XnzrWpi
         MQtB+ri+QN76i9rPlcRpEfnSknZrxJo0ePfjNTrGxv28lvbeJKpMS/kZfLLhI+gmhiV7
         BbGg==
X-Gm-Message-State: AOAM530nCtsvdF+07AAete16I5dX64olCDMWbLebl64guQmVl/5aW88h
        kzukW+dchVdxq4wT3CmAZdU=
X-Google-Smtp-Source: ABdhPJw5K2z1aIR5u0J91Op29NS99ZpT3qc+p0CSCPrgbki7rybvBaya2Vv6r2NRdWPQzzI5F4P6sg==
X-Received: by 2002:a05:6512:318f:: with SMTP id i15mr2082253lfe.341.1638314644917;
        Tue, 30 Nov 2021 15:24:04 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id x199sm1860735lff.284.2021.11.30.15.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 15:24:04 -0800 (PST)
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
Subject: [PATCH v16 10/40] drm/tegra: submit: Add missing pm_runtime_mark_last_busy()
Date:   Wed,  1 Dec 2021 02:23:17 +0300
Message-Id: <20211130232347.950-11-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211130232347.950-1-digetx@gmail.com>
References: <20211130232347.950-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Runtime PM auto-suspension doesn't work without pm_runtime_mark_last_busy(),
add it.

Cc: <stable@vger.kernel.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/submit.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tegra/submit.c b/drivers/gpu/drm/tegra/submit.c
index c32698404e36..1ba4d539da06 100644
--- a/drivers/gpu/drm/tegra/submit.c
+++ b/drivers/gpu/drm/tegra/submit.c
@@ -504,8 +504,10 @@ static void release_job(struct host1x_job *job)
 	kfree(job_data->used_mappings);
 	kfree(job_data);
 
-	if (pm_runtime_enabled(client->base.dev))
+	if (pm_runtime_enabled(client->base.dev)) {
+		pm_runtime_mark_last_busy(client->base.dev);
 		pm_runtime_put_autosuspend(client->base.dev);
+	}
 }
 
 int tegra_drm_ioctl_channel_submit(struct drm_device *drm, void *data,
-- 
2.33.1

