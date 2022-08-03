Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C52D58929E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 21:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238442AbiHCTM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 15:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236436AbiHCTMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 15:12:55 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC17C186F9
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 12:12:54 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so3105798pjf.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 12:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=4zK98BC9usZ9tCVJy5TId+ZcNTpp4zIbOepI4rir8+w=;
        b=jefqFTwXKQxf9ICOYbWVIDyQg4yWmfjrIZmSzw/bSBZ83YTAGVnnRSeh6mOJNxCZ5g
         yDnFiIHRXE0f4s0Kwp9tvz4GBi5F9zihVzVEqhhu9+DEDOLhz3TIJv4XDi7MFbqir6g2
         evAIYudAWhonqSxE9Ml/Xtwox+WswEwhojHLS3Osj/nk3oxZ3pX3Zn1sNNRmFno42nth
         6EHSqaZ7JGpv+5T+zrriqdYmxMLuk9UdqgOcUXjHSFXv/cyOqMLaEqrIzMQlq4NsAv1z
         bJISEiPsEWdfj2rR/Gs84Jd2TlK+ec74LfRdkE9ZhRnAQS382UBb14kRtGGJBKuLpBDz
         l3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=4zK98BC9usZ9tCVJy5TId+ZcNTpp4zIbOepI4rir8+w=;
        b=7HhKxtwhWmQJSXUP4cfstbp+RQl4Yuj5UO3dIds+xQs9RW6VURVaquRcbQNRvjrslU
         zsGKbGbbNiDbnBJOqH4nL5v7oURvCoql+9BQa4K+VR98XoWEpjlNGYgIpWEa5MyKmvod
         T/e0gmtDDMlOEPehY6+Sx3LqyD4TcoxrCuGyH2YxPJQ2jULyZp/hudKN1vBStQC0zv08
         QriTh+3bGWENZlmT3n0GHKUyGN8ZyX4c9LljC8afW/YtpNV12WUCAK/lfgYsL9vG9fIB
         KGOBTa5JSDYDBSrhtXNuF64liOSYSE/RhKTb2Jv4iUNA+Sv9b3sPdqDux6OXpt6DBGhs
         8qiA==
X-Gm-Message-State: ACgBeo0IHbbh1QQsii44vU/KWz7FlTMoscVoYMsFbZ+zKi/s5jLjRo+s
        9RxGjCfrqK+1GMg7SMFMcU+GeQ==
X-Google-Smtp-Source: AA6agR7eif7XcVJJauFJ7KJikkw8K6ljVbPKusohoOjLWeaqzENPk+57orK916Zy3RzqqeWDsMgaPA==
X-Received: by 2002:a17:902:6b82:b0:16d:d268:3842 with SMTP id p2-20020a1709026b8200b0016dd2683842mr26784523plk.16.1659553973988;
        Wed, 03 Aug 2022 12:12:53 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c5e:ddbf:1bd6:4443:9e5b:2aa2])
        by smtp.gmail.com with ESMTPSA id a2-20020a17090a740200b001f1694dafb1sm1971285pjg.44.2022.08.03.12.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 12:12:53 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] coresight: etm4x: Fix crash observed on Qcom ETM parts with 'Low power override'
Date:   Thu,  4 Aug 2022 00:42:36 +0530
Message-Id: <20220803191236.3037591-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.3
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
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index d39660a3e50c..cf6254b87fd5 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1943,6 +1943,16 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
 	init_arg.csa = &desc.access;
 	init_arg.pid = etm_pid;
 
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
 	if (smp_call_function_single(drvdata->cpu,
 				etm4_init_arch_data,  &init_arg, 1))
 		dev_err(dev, "ETM arch init failed\n");
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

