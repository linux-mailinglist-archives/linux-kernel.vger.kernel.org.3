Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338B1564F78
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbiGDIMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbiGDIL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:11:57 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39940AE51
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 01:11:56 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m6-20020a05600c3b0600b003a0489f412cso5818226wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 01:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ChF7YhZJ5oK75QeSz9xjFEI1oMT1B8ivnJmEVxe44YU=;
        b=KHXoITi0VlpeFAc8mJ41i/+VC2MOXFq3PO13PX0hhyD6csdOI5JyfnQ0JCf45ShCfK
         yihaboRiHuf/MuarutvS7tkoTe7DbxKFNvlqmtJEIKEYdB0AbaS0CnR4ms8x7RLT0y7A
         Wqr17+DQNb3tbvrzs44QDCk3zGNpU7Ldwp81P7PQFUrsLUNX8Ka9scUWs6NPynzucj7V
         x20GHD5CtVmBbEHtc8nIGpwvz4hEeZ9tKvpEnuQimFK40Os5d4J3fq/ttkHbOv+h6398
         IGMb7UiUqIi/SqXAUh3Rjx9+HyaahAlYcCydH3fp1gsriIpWdZTHYAS4H94insYDxPdL
         SB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ChF7YhZJ5oK75QeSz9xjFEI1oMT1B8ivnJmEVxe44YU=;
        b=JRE1xKnxZf6okbV/FV/voSdfSsCGUjYw0tYh1IzYef/wo2M51kQAHNLV48kcWPdUoJ
         bmRfMBKZJr50DjOaRRNMVwHWqdoZJ9bn2prnAem8bz22D13xeE9VuM+OY+rYZg+zCpfn
         Wp1oFHNneGYJEgAGDB5UppEhCndzPu+6xKReIlwZnbqz60mENje4dNlp3nh5wMCe4/WK
         73a6CXzx0f/0gIfKfzitt71aWU3+QLSF6H9iH1j8az8+AspI90MX+6lUnYSQPNRz4hJb
         HpdDENUq3VpayMKYgeQwwEGq04t+UIKN4brs9IuXcFFGj3Q+Nikyzw0JgIYGcYYu1mty
         4/rQ==
X-Gm-Message-State: AJIora8wuVAVMB5mIAySWxZ7+tpIRENfgbIhoc5IrWE/V+g3accJsZkm
        ldtbAIRo4EXyuX2sWGUvysnWZerafpE4EA==
X-Google-Smtp-Source: AGRyM1u0JcpNIODBc3BhqBED6dntz8ygCUA0VYPXOsX8sMEhi3g5Lq7sdG+kcp3kb4yLdDgsAKYylA==
X-Received: by 2002:a05:600c:3481:b0:3a1:918d:6719 with SMTP id a1-20020a05600c348100b003a1918d6719mr14506687wmq.35.1656922314833;
        Mon, 04 Jul 2022 01:11:54 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:c4c4:4ed1:ae43:27f2])
        by smtp.gmail.com with ESMTPSA id u3-20020adfdd43000000b0021d650e4df4sm4388276wrm.87.2022.07.04.01.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 01:11:54 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v2 03/13] coresight: stm: Update STM driver to use Trace ID API
Date:   Mon,  4 Jul 2022 09:11:39 +0100
Message-Id: <20220704081149.16797-4-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220704081149.16797-1-mike.leach@linaro.org>
References: <20220704081149.16797-1-mike.leach@linaro.org>
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

