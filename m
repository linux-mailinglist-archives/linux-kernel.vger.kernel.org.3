Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE410564F77
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbiGDIMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiGDIMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:12:03 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9B4B1FA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 01:11:59 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id f2so6902803wrr.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 01:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XdfZuCz31I3dZ9oZhErj8lvxSYGHlQH77vSFPPyQopc=;
        b=Ge1INB7cKd6HbqaH4ZXMeX/l3dO8/q5UGHnCGDbV+bcEPzZWk+k0IHWd3Z3kBG5MU0
         Z7fR+3LRRwMTEMET3bg12K3bNHWwz6GkI9xvsDcQhOCi1j/AD18o7ZQHRVaOPJQKuL+q
         eeyS4+Bvc93d1Rn/mNy4wBGwdTwZzKGMVhaRwMZCGPtElDKdHttoh6zYhUn7WhGuR0Fq
         GaUVhRUHxfYAcjaXB4vo8ZeA7uA3/a7qlpCGkLFp3DOyrqxQy9V3eokzUHq1ojU/F/Yp
         N4ha7h1jp3Ku1cgimvDXbeA1TgxrP1FPNhn7j/62mJpKJbYfzcXygex429chSmifkc29
         x7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XdfZuCz31I3dZ9oZhErj8lvxSYGHlQH77vSFPPyQopc=;
        b=eAG/J7o8G9/v5S17TDfqPe/IcTNwewrFvZNGzhhv4EL+Dolocj7XM2KyFBcFUrmAve
         9gltUVbhIsy3Y2ZlOgdvi403XiYp7tkacDa/04b4vbzrbPEyY576xddLRaoX8MBW84nS
         hLmc2jQ+XPZOySFpFJ3xvzMOwlS7EapIG9Z4I+FHdfaIaAu/GQFoajPLz9H0eSgtW0Y5
         UUQOrXXhW1wNt89D9gwLWj93MxT2nsS92nmIxzFuPsZ8PXSnUOc75kx80nyc5ZPn/D2S
         qrNKDHU3H7OrI+p0Yz96CMPNYJuJeb/rDEzK70qA5xdfnN2SBcdQN/w9mq4l7gVybVGS
         vMKg==
X-Gm-Message-State: AJIora88gxxkJuacR8/AyXmI14k9zo/GOuecGsXnNrVMT4VWbo88RZqZ
        IZfZWM4TGfdQO9+Ui64SQU96pA==
X-Google-Smtp-Source: AGRyM1uHtXRF4rfVMvWkJuFgqxnQW29twRsyx5gVj0TcSf6ZxXjLvxDofjYD1B9qmSYGx/LI2JBs+w==
X-Received: by 2002:a5d:52d0:0:b0:21d:3626:6cc3 with SMTP id r16-20020a5d52d0000000b0021d36266cc3mr21378760wrv.334.1656922318576;
        Mon, 04 Jul 2022 01:11:58 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:c4c4:4ed1:ae43:27f2])
        by smtp.gmail.com with ESMTPSA id u3-20020adfdd43000000b0021d650e4df4sm4388276wrm.87.2022.07.04.01.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 01:11:58 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, quic_jinlmao@quicinc.com,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v2 07/13] coresight: perf: traceid: Add perf notifiers for Trace ID
Date:   Mon,  4 Jul 2022 09:11:43 +0100
Message-Id: <20220704081149.16797-8-mike.leach@linaro.org>
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

Adds in notifier calls to the trace ID allocator that perf
events are starting and stopping.

This ensures that Trace IDs associated with CPUs remain the same
throughout the perf session, and are only released when all perf
sessions are complete.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index c039b6ae206f..ad3fdc07c60b 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -22,6 +22,7 @@
 #include "coresight-etm-perf.h"
 #include "coresight-priv.h"
 #include "coresight-syscfg.h"
+#include "coresight-trace-id.h"
 
 static struct pmu etm_pmu;
 static bool etm_perf_up;
@@ -228,6 +229,9 @@ static void free_event_data(struct work_struct *work)
 		*ppath = NULL;
 	}
 
+	/* mark perf event as done for trace id allocator */
+	coresight_trace_id_perf_stop();
+
 	free_percpu(event_data->path);
 	kfree(event_data);
 }
@@ -314,6 +318,9 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
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

