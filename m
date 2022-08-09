Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F9758E340
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiHIWeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiHIWeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:34:12 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E37165657
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:34:10 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id l22so15826855wrz.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 15:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pwmExfB0GU/JJ9bsvT+Z4EqrCVu9SNKAksEtRHBxI8c=;
        b=Z4RIHXx2IQwAP86ikkh4MNKsWkkqKaqtVe7+XWls9mfoBm1XVBXKdaxnV0rAABxB8F
         zzAOptbOaCD2N+sPvVv/Us4uZbDH4QaTw3cVStW72TdA5ctoG79RDmDsV8qN54MoDElW
         NegpbPFuGJtw2irpEOxr6Dagjq1WShiAq3+JXY7ptTSaYOzqyMxvh6ZrcXdWIrtEykx1
         mwrGeeXpxlXv+sXubgNompPOSzBNah47Mz3ZIQedtfOTkiyON5vLZVkDAXmjYyre912V
         IWjUMEyrBQDoO7tPym7/m44GSqXZkGBqgwuR6iL3+c0I9+qYLVv5dhZfVbKkNzqvyVkE
         SU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pwmExfB0GU/JJ9bsvT+Z4EqrCVu9SNKAksEtRHBxI8c=;
        b=NsN2dYIYA7P8dZEJODylLfSefjkrMqOg5ZuVmGHX+LJde92TZ4PZU8+T+QCQFonI5c
         aKMLdSXwCymoeklBr1o6ykOt0rQeiQGu2J+68SKq4kRDqUQ0Rg5JkIgHWKgDaRbrsOjX
         1INVObBBBrHq5T85wifjm5a+zBmp9JEaxildirwZu4dMO2ZNVBc9ZvhnUyQi5xfgTzwj
         A47uRqVoxg/jvjvqBNaZnPfLQlbYbfZFN3Nxo1C4I4INnNnsYNGezzI06o2OC8naLgUl
         Xk3QOoJseJ+HfU2FSQo4ITZQZGVmGKDmROSpR3WslKFS0VlqenPHNdUc2BZdAom0dWfC
         vSkg==
X-Gm-Message-State: ACgBeo2jRQcwDt0RXbL510rqYYd5Y/f6HVTv6P8bTYmWObhPVr2pvNY9
        ry6AVAWi8e+Xf/xs/oefm2CjRw==
X-Google-Smtp-Source: AA6agR7EUmPacdCEPnPG02meijZWkKgpofbAikoxKS59mwKYjzne7lsFcnucKSh9I9HHbzWw+zAZUw==
X-Received: by 2002:adf:fd0d:0:b0:21e:f27b:10dd with SMTP id e13-20020adffd0d000000b0021ef27b10ddmr16064160wrr.295.1660084449201;
        Tue, 09 Aug 2022 15:34:09 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:a6:74a6:5a0e:f3e2])
        by smtp.gmail.com with ESMTPSA id e20-20020a05600c4b9400b003a2cf1ba9e2sm311650wmp.6.2022.08.09.15.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:34:08 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v3 03/13] coresight: stm: Update STM driver to use Trace ID API
Date:   Tue,  9 Aug 2022 23:33:51 +0100
Message-Id: <20220809223401.24599-4-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220809223401.24599-1-mike.leach@linaro.org>
References: <20220809223401.24599-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates the STM driver to use the trace ID allocation API.
This uses the _system_id calls to allocate an ID on device poll,
and release on device remove.

The sysfs access to the STMTRACEIDR register has been changed from RW
to RO. Having this value as writable is not appropriate for the new
Trace ID scheme - and had potential to cause errors in the previous
scheme if values clashed with other sources.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-stm.c | 41 +++++++--------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index bb14a3a8a921..9ef3e923a930 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -31,6 +31,7 @@
 #include <linux/stm.h>
 
 #include "coresight-priv.h"
+#include "coresight-trace-id.h"
 
 #define STMDMASTARTR			0xc04
 #define STMDMASTOPR			0xc08
@@ -615,24 +616,7 @@ static ssize_t traceid_show(struct device *dev,
 	val = drvdata->traceid;
 	return sprintf(buf, "%#lx\n", val);
 }
-
-static ssize_t traceid_store(struct device *dev,
-			     struct device_attribute *attr,
-			     const char *buf, size_t size)
-{
-	int ret;
-	unsigned long val;
-	struct stm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-
-	ret = kstrtoul(buf, 16, &val);
-	if (ret)
-		return ret;
-
-	/* traceid field is 7bit wide on STM32 */
-	drvdata->traceid = val & 0x7f;
-	return size;
-}
-static DEVICE_ATTR_RW(traceid);
+static DEVICE_ATTR_RO(traceid);
 
 #define coresight_stm_reg(name, offset)	\
 	coresight_simple_reg32(struct stm_drvdata, name, offset)
@@ -819,14 +803,6 @@ static void stm_init_default_data(struct stm_drvdata *drvdata)
 	 */
 	drvdata->stmsper = ~0x0;
 
-	/*
-	 * The trace ID value for *ETM* tracers start at CPU_ID * 2 + 0x10 and
-	 * anything equal to or higher than 0x70 is reserved.  Since 0x00 is
-	 * also reserved the STM trace ID needs to be higher than 0x00 and
-	 * lowner than 0x10.
-	 */
-	drvdata->traceid = 0x1;
-
 	/* Set invariant transaction timing on all channels */
 	bitmap_clear(drvdata->chs.guaranteed, 0, drvdata->numsp);
 }
@@ -854,7 +830,7 @@ static void stm_init_generic_data(struct stm_drvdata *drvdata,
 
 static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 {
-	int ret;
+	int ret, trace_id;
 	void __iomem *base;
 	struct device *dev = &adev->dev;
 	struct coresight_platform_data *pdata = NULL;
@@ -938,12 +914,22 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 		goto stm_unregister;
 	}
 
+	trace_id = coresight_trace_id_get_system_id();
+	if (trace_id < 0) {
+		ret = trace_id;
+		goto cs_unregister;
+	}
+	drvdata->traceid = (u8)trace_id;
+
 	pm_runtime_put(&adev->dev);
 
 	dev_info(&drvdata->csdev->dev, "%s initialized\n",
 		 (char *)coresight_get_uci_data(id));
 	return 0;
 
+cs_unregister:
+	coresight_unregister(drvdata->csdev);
+
 stm_unregister:
 	stm_unregister_device(&drvdata->stm);
 	return ret;
@@ -953,6 +939,7 @@ static void stm_remove(struct amba_device *adev)
 {
 	struct stm_drvdata *drvdata = dev_get_drvdata(&adev->dev);
 
+	coresight_trace_id_put_system_id(drvdata->traceid);
 	coresight_unregister(drvdata->csdev);
 
 	stm_unregister_device(&drvdata->stm);
-- 
2.17.1

