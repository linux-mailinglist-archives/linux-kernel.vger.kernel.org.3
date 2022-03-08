Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9F94D22ED
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 21:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbiCHUv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 15:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350283AbiCHUvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:51:08 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4167231528
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 12:50:11 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id j26so16591wrb.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 12:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dJy0pQDaSOg6ATnrDsu3nm+8IQXiwbkO3KaKWIh49Fg=;
        b=wvuMmLT+F1MWoxrCIV8vR3igpSzRRRGPxcd7SkROFQl2o4JeVO/3Bjq+ZMX6lNEnOi
         0axIxIE2KuvY2zmfWOcfb/Go4f1evSnclofHZOYBoykBb1aFg67AhOh7b5ESx2QfoMSl
         wfYT4qdM3UOr9kgOFMzZ5dV6TdWVLzy2vsDPLWv7X0rMAeyn+lbxbvpUH3JajCRiQ45K
         Lg3RzEv5FMje6+YSStoY8lDgkvIVv7yzkOqh47Np87VWnkJw3m5tlmuTinUr6I4hUxOY
         8ac9y+Y7YXLXRcE8c4FK+hgh27i3Ioz62BiquIOoIxgT8SQ1ZbcSjXUp4lAVv24u9/vc
         n4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dJy0pQDaSOg6ATnrDsu3nm+8IQXiwbkO3KaKWIh49Fg=;
        b=vHvIQJf/PXLisarc4fK873XB7/fIJcHvyBJaF7PD3CXaboa1NgBszeKZ9IW9VF5L7w
         CMeBSa5oN4hNEpLtm6kLJUOdeJX9zCg7lE+8iWouKJa2WTwbkNiSoeN3cGrqFvzTLk+7
         PFkK2VrgbOq1hmYu39Egl14G2DqCQf7SjrOaUlCCuAJHnuNvBLwcPCGiVgX0GKaex3hb
         rlKq7PxIr9tebAWll5IOav2ah+uyR4sssqtvIRBQnB2PWNOqHgA14ruT3nh/tzEWhkzS
         zmjCA9UIyLKm0IOzGoTWBVfnxOU0HV7s1cYTjBqRfbE8chaBWmfZoxrZ2jNbLmTvx8hK
         ylpg==
X-Gm-Message-State: AOAM532omcf3qVlkAzUKe5UXGlc0Q56pulV6pUYNg8kphPqSuPSV5Hr3
        1VONcDAgoCAv9JMLEFrCtK1pWQ==
X-Google-Smtp-Source: ABdhPJwrdYIm6NC2LtonrqL5iaAbZgZ0elUfWZnw8rLwjTiE05M4nIE0BpoE0G1LHn5PCawBIn3IxA==
X-Received: by 2002:a5d:5850:0:b0:1f0:2d5b:dc35 with SMTP id i16-20020a5d5850000000b001f02d5bdc35mr13445051wrf.344.1646772609794;
        Tue, 08 Mar 2022 12:50:09 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:546d:7d59:1703:bf96])
        by smtp.gmail.com with ESMTPSA id p26-20020a1c741a000000b00389ab9a53c8sm3245758wmc.36.2022.03.08.12.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 12:50:09 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH 06/10] coresight: perf: traceid: Add perf notifiers for trace ID
Date:   Tue,  8 Mar 2022 20:49:56 +0000
Message-Id: <20220308205000.27646-7-mike.leach@linaro.org>
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

Adds in notifier calls to the trace ID allocator that perf
events are starting and stopping.

This ensures that Trace IDs associated with CPUs remain the same
throughout the perf session, and are only release when all perf
sessions are complete.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index c039b6ae206f..008f9dac429d 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -22,6 +22,7 @@
 #include "coresight-etm-perf.h"
 #include "coresight-priv.h"
 #include "coresight-syscfg.h"
+#include "coresight-trace-id.h"
 
 static struct pmu etm_pmu;
 static bool etm_perf_up;
@@ -223,11 +224,21 @@ static void free_event_data(struct work_struct *work)
 		struct list_head **ppath;
 
 		ppath = etm_event_cpu_path_ptr(event_data, cpu);
-		if (!(IS_ERR_OR_NULL(*ppath)))
+		if (!(IS_ERR_OR_NULL(*ppath))) {
 			coresight_release_path(*ppath);
+			/*
+			 * perf may have read a trace id for a cpu, but never actually
+			 * executed code on that cpu - which means the trace id would
+			 * not release on disable. Re-release here to be sure.
+			 */
+			coresight_trace_id_put_cpu_id(cpu, coresight_get_trace_id_map());
+		}
 		*ppath = NULL;
 	}
 
+	/* mark perf event as done for trace id allocator */
+	coresight_trace_id_perf_stop();
+
 	free_percpu(event_data->path);
 	kfree(event_data);
 }
@@ -314,6 +325,9 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 		sink = user_sink = coresight_get_sink_by_id(id);
 	}
 
+	/* tell the trace ID allocator that a perf event is starting up */
+	coresight_trace_id_perf_start();
+
 	/* check if user wants a coresight configuration selected */
 	cfg_hash = (u32)((event->attr.config2 & GENMASK_ULL(63, 32)) >> 32);
 	if (cfg_hash) {
-- 
2.17.1

