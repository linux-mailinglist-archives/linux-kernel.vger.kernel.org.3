Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AC956546E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 14:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbiGDMJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 08:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbiGDMIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 08:08:41 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DC512089
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 05:08:30 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id b2so8784482pfb.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 05:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zM6k7wksuNvGlGq6D8pYCpU91RIfKXfSwe1O1batFpM=;
        b=Pk79kImAgR1NPXrXBciuZ0mSuzaxskitVfe4NlJ2XlyTl0xMFuwItkbbi0cprHg6PF
         O/koDJOxvLb0hVLFIl0DvA3UYks4ajZlwD4ysoMPfq7cLIuLD03ucdgN2W1XiBgARkHG
         7XXdd4ID1CI9ykMAZaCXoaLOjf8pE4W2kR2G4bfMprveeyUOPvS4zKR2JCZdXUWp0n3M
         BvXSI4iI1+i9VJvp9SqVajDbKSPxAT9OjTUmp8X3DENT2hpcktHKFwRZLJaPWxNA4+VR
         L9qNGc7D7VVgeW0RoD4RKMKciIRAyKpnz//IV2y8FJuiSwgmInto+4iwU4jgt+Nejrp6
         wPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zM6k7wksuNvGlGq6D8pYCpU91RIfKXfSwe1O1batFpM=;
        b=hv8MdfPAwrLk/NeuZTDTTHTMzM8k1iF4lzmLCHtPuLRtoiTZjGANSHPqkhkFZhCTFh
         o6UeCg2UoCN2VwPKxhtMFtqBjj6btdz4KCoexSPEZ5R87hrPyHvoRkKtSYB3QFFuYAsi
         6PXeRMt69xEPR3nLDJ5YT4ACcTLV1/XkVmKUgB2oQIedQl77LdCYkTr/3IAmtr+dRyDZ
         P0zKTGnKZkdCcOlswvv4tVcnlwlz6wbnNTWG1qMEH0sXJ46OOH+cNgs06FqY7jU9JeTD
         xr3BPjyBbZEfJW9LWetQHAx9OroJuy5V7EY9W1UF1SE/3Us8GlpZYxvjiIKxUvuZ6LRV
         nJOw==
X-Gm-Message-State: AJIora9EA3XbR44fgPmnNGp+JEjFRlfNfP7GSD/jRAdzjCnKcxv1kq/t
        buzkIkD3sY0ewhT1F+87q70Pwg==
X-Google-Smtp-Source: AGRyM1uqmJynJNrbJeDxw4sHqdMSf2eDgcVImaSFfyVb2XrpmBPc3tF3N1I5pjtaPgA1Xtm+BTaJ5Q==
X-Received: by 2002:a65:6054:0:b0:411:5e12:21b2 with SMTP id a20-20020a656054000000b004115e1221b2mr24544781pgp.222.1656936510437;
        Mon, 04 Jul 2022 05:08:30 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902714200b0016a522915e5sm21089580plm.83.2022.07.04.05.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:08:30 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Qiang Yu <yuq825@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 07/20] drm/lima: Migrate to dev_pm_opp_set_config()
Date:   Mon,  4 Jul 2022 17:37:45 +0530
Message-Id: <734af371b2523219c719111be72d932dc3fd7eb9.1656935522.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1656935522.git.viresh.kumar@linaro.org>
References: <cover.1656935522.git.viresh.kumar@linaro.org>
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

The OPP core now provides a unified API for setting all configuration
types, i.e. dev_pm_opp_set_config().

Lets start using it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/gpu/drm/lima/lima_devfreq.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_devfreq.c b/drivers/gpu/drm/lima/lima_devfreq.c
index dc83c5421125..011be7ff51e1 100644
--- a/drivers/gpu/drm/lima/lima_devfreq.c
+++ b/drivers/gpu/drm/lima/lima_devfreq.c
@@ -112,6 +112,11 @@ int lima_devfreq_init(struct lima_device *ldev)
 	unsigned long cur_freq;
 	int ret;
 	const char *regulator_names[] = { "mali", NULL };
+	const char *clk_names[] = { "core", NULL };
+	struct dev_pm_opp_config config = {
+		.regulator_names = regulator_names,
+		.clk_names = clk_names,
+	};
 
 	if (!device_property_present(dev, "operating-points-v2"))
 		/* Optional, continue without devfreq */
@@ -119,11 +124,7 @@ int lima_devfreq_init(struct lima_device *ldev)
 
 	spin_lock_init(&ldevfreq->lock);
 
-	ret = devm_pm_opp_set_clkname(dev, "core");
-	if (ret)
-		return ret;
-
-	ret = devm_pm_opp_set_regulators(dev, regulator_names);
+	ret = devm_pm_opp_set_config(dev, &config);
 	if (ret) {
 		/* Continue if the optional regulator is missing */
 		if (ret != -ENODEV)
-- 
2.31.1.272.g89b43f80a514

