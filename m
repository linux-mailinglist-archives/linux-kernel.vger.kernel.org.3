Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77554D22EC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 21:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350303AbiCHUvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 15:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350277AbiCHUvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:51:06 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50B333891
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 12:50:08 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r10so5143wrp.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 12:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oYqW9DzD5vwTM1HoTzl1M8XZ0WUdjZwmOMUBLoaQedw=;
        b=kwI9hOE21xzvlIG6kdrnHeuEPF6g66blY3CFHrAc2UD8TeLvKhI54dUHCtSErqPWlE
         5w1WxnMEH4u+uohEKCsPAAUqDzUdksImLm/W/JBEgRJmbrnlOLdk5jh5/+zlOfoxndrx
         65dV41IyvoBzSlGLjXT7yKpFHl+E7YkVy1oa2YYMabq6+tYyCe2LeA4zxeRwG+HafaxU
         nvng3fPDRjKUzxZlKe0qQwmYcvLo+UWJLv2cZcRP7VM1nckq9rLT2Tp/sLrToNM7Xy9Y
         v6WBC47e65Yp72Py5aI/LefiN2/wqEnj+6E6gjl/AILmt2SchXe3uUycBx4hwKvnNEvz
         t20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oYqW9DzD5vwTM1HoTzl1M8XZ0WUdjZwmOMUBLoaQedw=;
        b=c5/vHYCK/KxzRiMf2BDyqiHu16ekMr6Oqt8sKAMm9Z+4zXD8DDrPGHmV7oOyR5ANJ0
         A/RvsZLRGfGOTrmccCMUlXiz7B6qTJzO36ZM26hyh6z0oe/4cat3EfwLb1lh1+Xbpo1s
         Mk7izbubl+Y7y1aUDfTv3hMpwGg8yBnwTXD7pxjL/88u4DI8aiF5hc42z/ATEx01Yiza
         U3NKOw3K2xtYi+TMHrNR8mGAhdugCM2AcpFFA4vPTh31C+j/gXfE1qr/fO7ZRF8cyiHr
         LkUlOCb+STnDFleern+W5XdcMyajCm5QpoSk+FN8XHSqRSsCX0pBu747pBOTAUbmh7Ye
         muqg==
X-Gm-Message-State: AOAM533KDKEIH+QKy5OD7fGAHyYZeC0b+bPJXQq9F2LFJ27kj63wQ+x7
        XQGpMdbEtW7UiE1EZsobwRTqYw==
X-Google-Smtp-Source: ABdhPJzKg0st+pjq2d0t8XXWYDVKnWlRHCW0ZEWuOCuqNDzl8hjHvkNfLUxdT3Aupg7aNHVRMe8zHA==
X-Received: by 2002:a5d:68c3:0:b0:1f0:4b40:90f with SMTP id p3-20020a5d68c3000000b001f04b40090fmr13434737wrw.443.1646772607455;
        Tue, 08 Mar 2022 12:50:07 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:546d:7d59:1703:bf96])
        by smtp.gmail.com with ESMTPSA id p26-20020a1c741a000000b00389ab9a53c8sm3245758wmc.36.2022.03.08.12.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 12:50:07 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH 03/10] coresight: stm: Update STM driver to use Trace ID api
Date:   Tue,  8 Mar 2022 20:49:53 +0000
Message-Id: <20220308205000.27646-4-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220308205000.27646-1-mike.leach@linaro.org>
References: <20220308205000.27646-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
---
 drivers/hwtracing/coresight/coresight-stm.c | 41 +++++++--------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index bb14a3a8a921..6c2c29ae99fe 100644
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
 
+	trace_id = coresight_trace_id_get_system_id(coresight_get_trace_id_map());
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
 
+	coresight_trace_id_put_system_id(coresight_get_trace_id_map(), drvdata->traceid);
 	coresight_unregister(drvdata->csdev);
 
 	stm_unregister_device(&drvdata->stm);
-- 
2.17.1

