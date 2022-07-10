Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEFA56CF23
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 14:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiGJMgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 08:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiGJMf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 08:35:56 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8B213F0F
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 05:35:36 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l68so1644516wml.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 05:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linexp-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=icoUiwKgc5ZfQQb9kyqtM6xsdul/av8PcZiURdbMJFs=;
        b=vkJN2lqSLPWI+/BzP3FTUMAWQRWtBP8xmHL3ekSHL5rJH0Ptvb9mdaQLLWO8JOWHSS
         kjEd5BEORRxLXF908meXd+XqhmnZfRVJAO1/FqhWSMhANXxpNAsldabulQmFmkEEA+o5
         t4tpeAHg4R/FtM/QEFw/2Om2c0s5au2jD1TGufvbMyEJbQ9I+hZK2Gchmm7XO/5fLuqI
         Bdguu6GimTFv1+2L+AUtIsu5zHTCJnzCIex4Z0z4yXa7uqsxl78ctfrq0n6Vyti1Ps5K
         4YObqy2kT9BQcoxU0YeB3CmQj5Pjd7odxPYxuMw0nwZ4VFaIpoJ6FvbFSk+bL4IXjOOe
         sOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=icoUiwKgc5ZfQQb9kyqtM6xsdul/av8PcZiURdbMJFs=;
        b=r0+T9y3VF6CNA4pzNjP62DP0cf5gn4BnsLsA8+GfoC7HHxZf9PeEQsBCCvM1f6MA0j
         WiuOKCEv/DtjasDTjdKETHy9MdakUQ0wyEk0UjbHpByNMS4kPRvmctd9EGGzlLtF5oK3
         hy6T5q+49blO9ejVyXtVmP7Q99DwmNwPr3X+X9Tb/BfcjtyTc4AfNyep4lt6lDpw8FNr
         Nc6Ohp6l8TcdCpj0rNWa57IYZDXtNB8aZXOfMSic6w+r9+wQufTgeQhz6kh0ugpmEQ7p
         VedWZonKKNqZu/l48olv+6mTM1/muBibAGXa1K9ysZ7gZn1/xIWsjlOaaOZiCegdw6fc
         bZ3g==
X-Gm-Message-State: AJIora/gSpr/ngleOU1/WG9tMMt60mRW5ackNlK1uwMQy5IcBSs0gKYn
        5vPrhGq8MspMZNFvyj0dmFnX8A==
X-Google-Smtp-Source: AGRyM1vscx2qlLVeh0vOTuSaNxBbf1hHDyONcEKP7d1JduHpRBsmUTYb7SigAchElqILmC+8nPWvWw==
X-Received: by 2002:a05:600c:22c9:b0:3a2:d069:a046 with SMTP id 9-20020a05600c22c900b003a2d069a046mr10690759wmg.29.1657456535250;
        Sun, 10 Jul 2022 05:35:35 -0700 (PDT)
Received: from localhost.localdomain (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c22d800b003a0375c4f73sm3775144wmg.44.2022.07.10.05.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 05:35:35 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linexp.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        abailon@baylibre.com, lukasz.luba@arm.com,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v5 10/12] thermal/of: Store the trips in the thermal zone
Date:   Sun, 10 Jul 2022 14:35:10 +0200
Message-Id: <20220710123512.1714714-12-daniel.lezcano@linexp.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710123512.1714714-1-daniel.lezcano@linexp.org>
References: <20220710123512.1714714-1-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the thermal zone contains the trip point, we can store them
directly when registering the thermal zone. That will allow another
step forward to remove the duplicate thermal zone structure we find in
the thermal_of code.

Cc: Alexandre Bailon <abailon@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>
---
 drivers/thermal/thermal_of.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 19243c57b3f4..e187461dd396 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -1119,11 +1119,9 @@ int __init of_parse_thermal_zones(void)
 		tzp->slope = tz->slope;
 		tzp->offset = tz->offset;
 
-		zone = thermal_zone_device_register(child->name, tz->ntrips,
-						    mask, tz,
-						    ops, tzp,
-						    tz->passive_delay,
-						    tz->polling_delay);
+		zone = thermal_zone_device_register_with_trips(child->name, tz->trips, tz->ntrips,
+							       mask, tz, ops, tzp, tz->passive_delay,
+							       tz->polling_delay);
 		if (IS_ERR(zone)) {
 			pr_err("Failed to build %pOFn zone %ld\n", child,
 			       PTR_ERR(zone));
-- 
2.25.1

