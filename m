Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0469850B9B3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448495AbiDVOOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448447AbiDVON6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:13:58 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF3B5AA5A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:10:58 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id x3so5159969wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PYeD7CphIZ5NH/umo7M0wjdcvUu12ITU6k0/hQvLpn4=;
        b=ZALoyjG8zCeEignAj44ruQpeuReq8DfH1PQ77vyqmSCU6416JBsIknodyI9lNyoqVt
         0lQ1f4NBwYJDpwMZ5QiWkdT5dcveL1rzIeSJn3bfuNMM8ltdQZWwc8wPeSP3usbealiB
         Xvu6jN+bwjLIIgDp6D0CK03EOuT5rJxZ0XoukaPsM+C5PKSFVuloS3nTU4ICshUgxgCr
         vL6vSqLI1bydjYbf4+xXByyC+gi7QxfIALHv2phJfVVbzBxLhrfCYR0dhLUH7BxM22MP
         hQMCQUv48hKvYY247w1nv+GGvk9EciUifUWvlPJk3H0k814PutkwIDGmdV0CqWoGzcpV
         /Xtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PYeD7CphIZ5NH/umo7M0wjdcvUu12ITU6k0/hQvLpn4=;
        b=Uqjk3HbRVaYKZMa5zF+9Z3Yx+oJw2x3P1cA1JRavRmON+U0iKKhoYkSVVlyJ7cOWec
         2b9s/61mPbL7htjfN/Zj2boXQMV91PtS732jt7GwHEbYfL8NDX3ymp1ikxGHYa+qBCZq
         GZ4aBkM/SmucL+cPZM6N1dYKjxRqCrYlsKtiQMiHk7T1TzujrOq4Ztqr7cvtdBvLS6fN
         o3Ou+nApazfHpsj962qRWL9x3LK/WhodGmUUCrOVGGxVn/q7MPGlvO2k2tzJVpi0JuvG
         /P/B/DqkfMZA8XbyDdDxWisfc6ZtcRO9NmRJdjJNunOi0+vNaUG95mV9xxJD8d3a6qaf
         tjlQ==
X-Gm-Message-State: AOAM531ZJtb3kFeyEINn2EhAC0KfNe9tUpZ4/XtVqIiQoEy3jdS60+5g
        GcLEyFPhKvWGDWE+ZwDIpey1tw==
X-Google-Smtp-Source: ABdhPJw/DrTqoY84qNlsyOJcHJJoiMOi4jdHj0vLja2zZ+SWSQRqWgoDISxntvHncsYjySGdb9tGcQ==
X-Received: by 2002:a05:600c:4e94:b0:392:8e2a:d794 with SMTP id f20-20020a05600c4e9400b003928e2ad794mr13888303wmq.107.1650636657065;
        Fri, 22 Apr 2022 07:10:57 -0700 (PDT)
Received: from localhost.localdomain (static-176-182-171-101.ncc.abo.bbox.fr. [176.182.171.101])
        by smtp.gmail.com with ESMTPSA id f189-20020a1c38c6000000b0038ff83b9792sm4607430wma.43.2022.04.22.07.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 07:10:56 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     srinivas.pandruvada@intel.com, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH 1/2] Revert "thermal/core: Deprecate changing cooling device state from userspace"
Date:   Fri, 22 Apr 2022 16:10:28 +0200
Message-Id: <20220422141029.968212-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit a67a46af4ad6342378e332b7420c1d1a2818c53f.

It has been reported the warning is annoying as the cooling device
state is still needed on some production system.

Meanwhile we provide a way to consolidate the thermal framework to
prevent multiple actors acting on the cooling devices with conflicting
decisions, let's revert this warning.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_sysfs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index f154bada2906..1c4aac8464a7 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -610,9 +610,6 @@ cur_state_store(struct device *dev, struct device_attribute *attr,
 	unsigned long state;
 	int result;
 
-	dev_warn_once(&cdev->device,
-		      "Setting cooling device state is deprecated\n");
-	
 	if (sscanf(buf, "%ld\n", &state) != 1)
 		return -EINVAL;
 
-- 
2.25.1

