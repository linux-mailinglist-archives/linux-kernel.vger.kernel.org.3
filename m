Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E33564F69
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbiGDIMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbiGDIL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:11:56 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F681B1E7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 01:11:55 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id j7so4905629wmp.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 01:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ENeqPY38I5RkKtR3x+NAjXJGNLiXjGEjs0/S3/8e+0g=;
        b=fZnGLarNI4qm9uYt1V8DlHg9SSr0ryyK0I7SFQetRoQLwyxzw36owZAEn5z4u1d2Lp
         JSLDUYGr5yB9Mgajwai3P3x5P3PsqKQOkR4Mh6CUb4ntoN+uwJD2wYKHIPo3wZ93JlN4
         KfXKx6j6rpDL9w/rK5cNqGyHxRlMyIw55cSkgLdJWmFu9/7oxLTmqrgemdCtaVbT9RHC
         XKLqCM7kfKSNUNJP8AkZHgv0rW+oWtWwn05c1ofVlgIApjC5W+kjv03WxA3AcWgSo457
         oE3hrB8XRdL//gWOkosCD5FSfgRJIhEW1uPm8EkddOyFsrtDmQd+HxxhqNGfAMgPE0AW
         lOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ENeqPY38I5RkKtR3x+NAjXJGNLiXjGEjs0/S3/8e+0g=;
        b=JLnz51sACdwOsZIWG9i6zxSIJJCiojtylzoq29XC4QRGiz24pMkpNGJDK4WM7s7QzH
         GMFUCfU8qbkBbdEvjs7MkdpuoAy/1mHily3cO8QX/3sRPQiuokLU3ufKKypifGJPIsJe
         sUx+YTEnbknGCtL4RQvU/2coHd658ngucHJbsX3a4wwthjK40Yw3k7O5qVNBpo2N/e20
         Pcm/PWhvzhMzj+O5zL3sqET0F89DwBDRo6sXktFVpjFflf9tyh7Qkr8FCQjCeyXB0u52
         AXDvLtVKQogGMyTQ3Cd7MiNV/r5Mr77vIvUKipCvnJ5WNM3ak19IaPJH7ID4eYwhreaR
         IYRQ==
X-Gm-Message-State: AJIora91/epSZ3qAmYnrnCr+1CGrlhoHY2WqyNozgmdzvPKgXh40IMgE
        eqVX/ZO/nIyULSF8rprGkdzyig==
X-Google-Smtp-Source: AGRyM1tbg7T3RfKE51u/Ld3uOhZDTDvnB2ymDvYMNW9HAL27M8QNYUar9r7Hv5lpOk+aVOoUgxitRA==
X-Received: by 2002:a05:600c:1d0e:b0:3a0:50bb:55e0 with SMTP id l14-20020a05600c1d0e00b003a050bb55e0mr30617774wms.89.1656922313887;
        Mon, 04 Jul 2022 01:11:53 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:c4c4:4ed1:ae43:27f2])
        by smtp.gmail.com with ESMTPSA id u3-20020adfdd43000000b0021d650e4df4sm4388276wrm.87.2022.07.04.01.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 01:11:53 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v2 02/13] coresight: trace-id: update CoreSight core to use Trace ID API
Date:   Mon,  4 Jul 2022 09:11:38 +0100
Message-Id: <20220704081149.16797-3-mike.leach@linaro.org>
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

Initialises the default trace ID map.

This will be used by all source drivers to be allocated their trace IDs.

The checks for sources to have unique IDs has been removed - this is now
guaranteed by the ID allocation mechanisms, and inappropriate where
multiple ID maps are in use in larger systems

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/coresight-core.c | 49 ++------------------
 1 file changed, 4 insertions(+), 45 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 1edfec1e9d18..be69e05fde1f 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -22,6 +22,7 @@
 #include "coresight-etm-perf.h"
 #include "coresight-priv.h"
 #include "coresight-syscfg.h"
+#include "coresight-trace-id.h"
 
 static DEFINE_MUTEX(coresight_mutex);
 static DEFINE_PER_CPU(struct coresight_device *, csdev_sink);
@@ -84,45 +85,6 @@ struct coresight_device *coresight_get_percpu_sink(int cpu)
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
@@ -431,12 +393,6 @@ static int coresight_enable_source(struct coresight_device *csdev, u32 mode)
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
@@ -1775,6 +1731,9 @@ static int __init coresight_init(void)
 	if (ret)
 		goto exit_bus_unregister;
 
+	/* initialise the default trace ID map */
+	coresight_trace_id_init_default_map();
+
 	/* initialise the coresight syscfg API */
 	ret = cscfg_init();
 	if (!ret)
-- 
2.17.1

