Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70875A086B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 07:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbiHYFWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 01:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiHYFWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 01:22:48 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6FB9E8A9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 22:22:47 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id p13so6205661pld.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 22:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=iCasLDNUU4I0Jvm9uv7/lmaTZb534+kQ2JJzlEAGgVs=;
        b=ZO4Btx4iXxJLni//F+xoZy2N6xzC2V7b+5Z0aO2j6R0wSXg0WDTp/CnzD1C3z8Lww2
         8HhM4nRSekycf98PzpxdMnLywyUQwkWVxlJ2qIesNY0rG3tLrd+LaDqplIYnLWbzEl69
         obbxJaX5S3XqxltviPBh5d1UB6ZQKtkt8GtwA0eElWuy/AQPAcSm7grOz3d2X7IiAXp1
         upMrN2mihK/f/xJAJmkrE6LcTol+GVwCFTq9VBLTDa3QYuFSXPRFpqVz1EaHPqxYcQxb
         dBPo5MtZGNYVvieBy+TzfjtTtHeuLAroOEQDN0aP4H+Yni1XzCTG4D+7gCsIUNvJEJ90
         564g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=iCasLDNUU4I0Jvm9uv7/lmaTZb534+kQ2JJzlEAGgVs=;
        b=NTasq2A43+mt9aAN0NS+9SlZHjA97vZQxmeQ0xgRGbhzs+jGiwylM0quViAsYIAIKR
         cY0kVbHY8/Q8G9qM/mxZ6a5fleA/hUVYz5zgUUPFaCCMyw6toeJFC59Tc0GEPum76gNx
         OBlvEAiSDraAFSiMzwZwWOCa+lcqT0BmcBHfBN6fVqQD7cbbp6/LxzVc/2W3Mr0CTDBu
         iitPX9IuPRihEzS7zaZHVq/Kv9QogTJz7oChuKgqE+BPTKOUBsLU5pZjzVVTK3mH/k8m
         D/q4bwKLm1jKHb+ivLDxJd3SsqvdaYXVEb5trwxqtgInX02azQDVnK0aTAKzilGVKcQV
         cdHg==
X-Gm-Message-State: ACgBeo3AyLU55npkAUJ8LXXqBrL3OM3LNw5YfDRuh5cmZtEWgpCRajma
        11Sfmrs+71CoqYNukMrFhu6r4g==
X-Google-Smtp-Source: AA6agR6pm9HVyhNr+GrQdxfFDMygHSJeTNVyUkWEGUvLvm3pHXeRRLgicmiPaBZ7ndAfW2l377hk+A==
X-Received: by 2002:a17:90b:4d89:b0:1fb:1cf5:e23d with SMTP id oj9-20020a17090b4d8900b001fb1cf5e23dmr2702070pjb.133.1661404966607;
        Wed, 24 Aug 2022 22:22:46 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c60:5362:9d7f:2354:1d0a:78e3])
        by smtp.gmail.com with ESMTPSA id ik19-20020a170902ab1300b00172a4170ff5sm13529027plb.86.2022.08.24.22.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 22:22:46 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2] coresight: etm4x: Fix crash observed on Qcom ETM parts with 'Low power override'
Date:   Thu, 25 Aug 2022 10:52:32 +0530
Message-Id: <20220825052232.11013-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.3
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

Some Qualcomm ETM implementations require skipping powering up
the trace unit, as the ETMs are in the same power domain as
their CPU cores.

Via commit 5214b563588e ("coresight: etm4x: Add support for
sysreg only devices"), the setting of 'skip_power_up' flag was
moved after the 'etm4_init_arch_data' function is called, whereas
the flag value is itself used inside the function. This causes
a crash when ETM mode 'Low-power state behavior override' is set
on some Qualcomm parts.

Fix the same.

Fixes: 5214b563588e ("coresight: etm4x: Add support for sysreg only devices")
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 - v1 can be seen here: https://lore.kernel.org/lkml/20220803191236.3037591-1-bhupesh.sharma@linaro.org/
 - Addressed the review comments from Suzuki.
 - Rebased on linux-next.

 drivers/hwtracing/coresight/coresight-etm4x-core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index d39660a3e50c..14c1c7869795 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -977,6 +977,16 @@ static bool etm4_init_sysreg_access(struct etmv4_drvdata *drvdata,
 	if (!cpu_supports_sysreg_trace())
 		return false;
 
+	/*
+	 * Some Qualcomm implementations require skipping powering up the trace unit,
+	 * as the ETMs are in the same power domain as their CPU cores.
+	 *
+	 * Since the 'skip_power_up' flag is used inside 'etm4_init_arch_data' function,
+	 * initialize it before the function is called.
+	 */
+	if (fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
+		drvdata->skip_power_up = true;
+
 	/*
 	 * ETMs implementing sysreg access must implement TRCDEVARCH.
 	 */
@@ -1951,8 +1961,7 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
 		return -EINVAL;
 
 	/* TRCPDCR is not accessible with system instructions. */
-	if (!desc.access.io_mem ||
-	    fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
+	if (!desc.access.io_mem)
 		drvdata->skip_power_up = true;
 
 	major = ETM_ARCH_MAJOR_VERSION(drvdata->arch);
-- 
2.35.3

