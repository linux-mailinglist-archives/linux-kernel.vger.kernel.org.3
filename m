Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4661A4D22E4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 21:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350292AbiCHUvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 15:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350274AbiCHUvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:51:05 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3182432ED1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 12:50:08 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id k24so20957191wrd.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 12:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LSx46Zr8CS5+IFp2YS6e6Ha2KieIvZZnjZpzZmpCaRc=;
        b=DKd1skywiEYI0uWSl4whWGPs1qJaVU0tgUMdx/rl+nePouWjVVzDg3uy8EiRce3+f+
         7yzBz83zfqUX6YHUi9tOyPa1k9jxBXjn5qdhTxnUXLKPzIDHMreRdzemfgV4vxrO7AXC
         y6yJRLCAS4dkGGN0MBvuyJZXoMGhsEBzX19izVvjuQdxxvyStOxHAXS1pcJgcZj9x/Ag
         1nQDCprNuNnyFdvqveKnxpokO3qHKZhFv/vJq/zGp01AdAE4mS0pVHdK182R0sFKGOYC
         H3wQfvVWvIzSd1mM7styL1ujDtLC1sKnkNDRxZr8kV/ZlCayP/OAQFhEWytjhLfj7vR2
         as2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LSx46Zr8CS5+IFp2YS6e6Ha2KieIvZZnjZpzZmpCaRc=;
        b=r2k8d7TV98nIEKePtzzYiHZLdjwdixlpM498bZvjAeHxU5l9E4ByRfgBPm0x2Sxqoq
         oukW1AN2KyyaUHriwl06vE1T8YL4I8n14E1g4nLs1XvDu9+UO1KvMktQEhS9eXtnewLR
         2UdxLaxjPkOkEGL1iSBTJlyQqAvHJ9mlLvz14j5zwRPzRD3I4tSmQ8t0E7aVb+/dWGCo
         0UT5fTWvWy7TtSR+xUKARz2nnpnOkOB09riFRCbfFR1RZX/zlyOGqYCQZSiv0GtA4qdu
         jD27EW3HhHuifIEwRIIJRzeNk9OfvjcfkBUUuYqr+ewU2BkK2wchf8+XfTFnqxjgzDJ8
         3ZlA==
X-Gm-Message-State: AOAM531T3VUFC3h8hp7xhTrOAS7uH0x+R2jZS5b6e76rGjT1Jgix4Vvw
        7WZh8AVnn0ctZG2wWliDfR7Mkg==
X-Google-Smtp-Source: ABdhPJyd7vwDkz1rPuDSK+nJGsWP1TastawOkho5vhwKTYa01x9JG6lgrXm0BwOOCtJ+IJesykYW0w==
X-Received: by 2002:a5d:4811:0:b0:1f1:d736:4862 with SMTP id l17-20020a5d4811000000b001f1d7364862mr13771648wrq.147.1646772606714;
        Tue, 08 Mar 2022 12:50:06 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:546d:7d59:1703:bf96])
        by smtp.gmail.com with ESMTPSA id p26-20020a1c741a000000b00389ab9a53c8sm3245758wmc.36.2022.03.08.12.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 12:50:06 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH 02/10] coresight: trace-id: Set up source trace ID map for system
Date:   Tue,  8 Mar 2022 20:49:52 +0000
Message-Id: <20220308205000.27646-3-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220308205000.27646-1-mike.leach@linaro.org>
References: <20220308205000.27646-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds in a CoreSight trace ID map for the entire system.

This will be used by all source drivers to be allocated their trace IDs.

The checks for sources to have unique IDs has been removed - this is now
guaranteed by the ID allocation mechanisms, and inappropriate where
multiple ID maps are in use in larger systems

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/coresight-core.c | 64 ++++++--------------
 drivers/hwtracing/coresight/coresight-priv.h |  1 +
 2 files changed, 20 insertions(+), 45 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index af00dca8d1ac..bbf415c252f9 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -22,6 +22,7 @@
 #include "coresight-etm-perf.h"
 #include "coresight-priv.h"
 #include "coresight-syscfg.h"
+#include "coresight-trace-id.h"
 
 static DEFINE_MUTEX(coresight_mutex);
 static DEFINE_PER_CPU(struct coresight_device *, csdev_sink);
@@ -50,6 +51,19 @@ static DEFINE_PER_CPU(struct list_head *, tracer_path);
  */
 static struct list_head *stm_path;
 
+/*
+ * Set up a global trace ID map.
+ * We may need a per sink ID map in future for larger / multi sink systems.
+ */
+static struct coresight_trace_id_map trace_id_map;
+
+/* Allow drivers to reference ID map when getting trace IDs */
+struct coresight_trace_id_map *coresight_get_trace_id_map(void)
+{
+	return &trace_id_map;
+}
+EXPORT_SYMBOL_GPL(coresight_get_trace_id_map);
+
 /*
  * When losing synchronisation a new barrier packet needs to be inserted at the
  * beginning of the data collected in a buffer.  That way the decoder knows that
@@ -84,45 +98,6 @@ struct coresight_device *coresight_get_percpu_sink(int cpu)
 }
 EXPORT_SYMBOL_GPL(coresight_get_percpu_sink);
 
-static int coresight_id_match(struct device *dev, void *data)
-{
-	int trace_id, i_trace_id;
-	struct coresight_device *csdev, *i_csdev;
-
-	csdev = data;
-	i_csdev = to_coresight_device(dev);
-
-	/*
-	 * No need to care about oneself and components that are not
-	 * sources or not enabled
-	 */
-	if (i_csdev == csdev || !i_csdev->enable ||
-	    i_csdev->type != CORESIGHT_DEV_TYPE_SOURCE)
-		return 0;
-
-	/* Get the source ID for both components */
-	trace_id = source_ops(csdev)->trace_id(csdev);
-	i_trace_id = source_ops(i_csdev)->trace_id(i_csdev);
-
-	/* All you need is one */
-	if (trace_id == i_trace_id)
-		return 1;
-
-	return 0;
-}
-
-static int coresight_source_is_unique(struct coresight_device *csdev)
-{
-	int trace_id = source_ops(csdev)->trace_id(csdev);
-
-	/* this shouldn't happen */
-	if (trace_id < 0)
-		return 0;
-
-	return !bus_for_each_dev(&coresight_bustype, NULL,
-				 csdev, coresight_id_match);
-}
-
 static int coresight_find_link_inport(struct coresight_device *csdev,
 				      struct coresight_device *parent)
 {
@@ -431,12 +406,6 @@ static int coresight_enable_source(struct coresight_device *csdev, u32 mode)
 {
 	int ret;
 
-	if (!coresight_source_is_unique(csdev)) {
-		dev_warn(&csdev->dev, "traceID %d not unique\n",
-			 source_ops(csdev)->trace_id(csdev));
-		return -EINVAL;
-	}
-
 	if (!csdev->enable) {
 		if (source_ops(csdev)->enable) {
 			ret = coresight_control_assoc_ectdev(csdev, true);
@@ -1763,11 +1732,15 @@ static int __init coresight_init(void)
 	if (ret)
 		goto exit_bus_unregister;
 
+	/* initialise the trace ID map */
+	coresight_trace_id_init_id_map(coresight_get_trace_id_map());
+
 	/* initialise the coresight syscfg API */
 	ret = cscfg_init();
 	if (!ret)
 		return 0;
 
+	coresight_trace_id_release_id_map(coresight_get_trace_id_map());
 	etm_perf_exit();
 exit_bus_unregister:
 	bus_unregister(&coresight_bustype);
@@ -1776,6 +1749,7 @@ static int __init coresight_init(void)
 
 static void __exit coresight_exit(void)
 {
+	coresight_trace_id_release_id_map(coresight_get_trace_id_map());
 	cscfg_exit();
 	etm_perf_exit();
 	bus_unregister(&coresight_bustype);
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index ff1dd2092ac5..d3032ac545c1 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -166,6 +166,7 @@ int coresight_make_links(struct coresight_device *orig,
 			 struct coresight_device *target);
 void coresight_remove_links(struct coresight_device *orig,
 			    struct coresight_connection *conn);
+struct coresight_trace_id_map *coresight_get_trace_id_map(void);
 
 #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM3X)
 extern int etm_readl_cp14(u32 off, unsigned int *val);
-- 
2.17.1

