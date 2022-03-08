Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C50C4D22EB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 21:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350334AbiCHUvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 15:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243954AbiCHUvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:51:19 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F216133883
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 12:50:11 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id u10so28802495wra.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 12:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VVamIeahV8l6/c1hyhhpxgfx+OG8gkG+rm525YIuvz0=;
        b=FPhmT64PsgT9wEUvw9reJ1VNjnbBYXzxz89rDSMxHj2pErqkE+vZ5sLTVpe+Y0dC2A
         EDUC9kCJ4iirUpVLewKhc67YodUQY6ISeX49DeGg+2zOTKN6S2+0lH5MdVeTHSWwn5x/
         ZvrwBWj121Y+mKNfHRoqLBeuE27YFyiCF5+vJ3MvGwT92k4dcWhs5NGVoKy5DYHvce/j
         59ywsaaN7HIaCI4gbMvp72/Gc9WYWbC7toBET/d1J/AYVn6YsYe/vU1aMY31vAkxWJH9
         8xJWWvJWpJUW8X6iqXsqxzfpMqqqdXWV5qdGBPGH8GgydqC89m4nmonMxDoEqsdVH6Yj
         FQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VVamIeahV8l6/c1hyhhpxgfx+OG8gkG+rm525YIuvz0=;
        b=lO7oXiNovDPnOYJ8joUSNnAjuQdVzg5XUsWo1n2v/KgNtyGjhc7FPBz7vjPTVaTXCK
         93ubmcbEeWOU+AdQlxRYwh+TO6zoLs5YWng3kgQmSCKnWzBPJEoI6+09gr1dJZEvvngp
         BEnmORYzvjdkpffUNDkUDQwAY6wZtFOhOOULtj5ZQtGs+pnjOtm0Q1mUL1/A/20hQXZ1
         xbuceEeFxENs9fwV8Ctc1/yxE/3Hhcm72m26VVZClsuTdLQ3/am2mCZA4c8IMFsIncF4
         3iTVN6DBExtXaMZ1VnbL5P84neRTxqwsd3NjwyCTkDa7VaNs2XL+bs9kFartGrumgJuX
         ENCg==
X-Gm-Message-State: AOAM530hzoyEtJld9B5fEqrdm0Q4mF4ym7/j5O9qKIjcjGkEmOT+p8JE
        QVG3i1KcCNrifpnfdV5xUdCO8w==
X-Google-Smtp-Source: ABdhPJyc0DjjNk0UnsK59psw4hHmQCTr0W+xIIc2VbXZ+sHbsFh0hrk8Z3A8GkXu5hVknJGx971TRw==
X-Received: by 2002:adf:d1a8:0:b0:1f0:59c5:5e18 with SMTP id w8-20020adfd1a8000000b001f059c55e18mr13807188wrc.585.1646772610571;
        Tue, 08 Mar 2022 12:50:10 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6809:2201:546d:7d59:1703:bf96])
        by smtp.gmail.com with ESMTPSA id p26-20020a1c741a000000b00389ab9a53c8sm3245758wmc.36.2022.03.08.12.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 12:50:10 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.org, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH 07/10] perf: cs-etm: Update event to read trace ID from sysfs
Date:   Tue,  8 Mar 2022 20:49:57 +0000
Message-Id: <20220308205000.27646-8-mike.leach@linaro.org>
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

Read the current trace ID values associated with a CPU
from sysfs.

Previously used the static association algorithm that is no longer
used as it did not scale and was broken for larger core counts.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 2e8b2c4365a0..f48087d07bcb 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -43,11 +43,13 @@ struct cs_etm_recording {
 };
 
 static const char *metadata_etmv3_ro[CS_ETM_PRIV_MAX] = {
+	[CS_ETM_ETMTRACEIDR]	= "traceid",
 	[CS_ETM_ETMCCER]	= "mgmt/etmccer",
 	[CS_ETM_ETMIDR]		= "mgmt/etmidr",
 };
 
 static const char * const metadata_etmv4_ro[] = {
+	[CS_ETMV4_TRCTRACEIDR]		= "mgmt/trctraceid",
 	[CS_ETMV4_TRCIDR0]		= "trcidr/trcidr0",
 	[CS_ETMV4_TRCIDR1]		= "trcidr/trcidr1",
 	[CS_ETMV4_TRCIDR2]		= "trcidr/trcidr2",
@@ -629,8 +631,9 @@ static void cs_etm_save_etmv4_header(__u64 data[], struct auxtrace_record *itr,
 
 	/* Get trace configuration register */
 	data[CS_ETMV4_TRCCONFIGR] = cs_etmv4_get_config(itr);
-	/* Get traceID from the framework */
-	data[CS_ETMV4_TRCTRACEIDR] = coresight_get_trace_id(cpu);
+	/* Get traceID from the sysfs */
+	data[CS_ETMV4_TRCTRACEIDR] = cs_etm_get_ro(cs_etm_pmu, cpu,
+						   metadata_etmv4_ro[CS_ETMV4_TRCTRACEIDR]);
 	/* Get read-only information from sysFS */
 	data[CS_ETMV4_TRCIDR0] = cs_etm_get_ro(cs_etm_pmu, cpu,
 					       metadata_etmv4_ro[CS_ETMV4_TRCIDR0]);
@@ -677,9 +680,10 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
 		magic = __perf_cs_etmv3_magic;
 		/* Get configuration register */
 		info->priv[*offset + CS_ETM_ETMCR] = cs_etm_get_config(itr);
-		/* Get traceID from the framework */
+		/* Get traceID from sysfs */
 		info->priv[*offset + CS_ETM_ETMTRACEIDR] =
-						coresight_get_trace_id(cpu);
+			cs_etm_get_ro(cs_etm_pmu, cpu,
+				      metadata_etmv3_ro[CS_ETM_ETMTRACEIDR]);
 		/* Get read-only information from sysFS */
 		info->priv[*offset + CS_ETM_ETMCCER] =
 			cs_etm_get_ro(cs_etm_pmu, cpu,
-- 
2.17.1

