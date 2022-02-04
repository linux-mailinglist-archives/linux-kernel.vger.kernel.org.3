Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CD04A9BEA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359707AbiBDPYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359685AbiBDPYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:24:36 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E263AC06173D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 07:24:36 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id v4so32993pjh.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 07:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CP130Joo5LnzHA5fd0JPgyy8qzQq4QiMmlbo4WSc/bc=;
        b=L/e7pgEILiyjVuGqBatpNWgdA2j6VCihnfihFatdCHPNmoY4xviCPf/nQm5bMBlzQP
         amlIOx/kyvPnSQj3m3GWhXKXIOA+a/ixQAcJmr78Hq0YtpO6MTDE9lX1FHMNfagK3HZS
         XjSYynqpHruY90Hlo5PWLIx6f3OaLgcF+xp/gx70H19rIuwS8nNLlUni73WYe46gynsG
         GURGyJRD/1DK7xxK8+9xaFuK/UxXPHwEdbr7m0QPU4ZzfG6x2YUMobaPHbjmceMXl+o4
         su3bKwuXugi2Zt041Hk8OVTR0IWnW6yhOqS7WJa0hv89TPcSkQUhXdwGspZn8M5cugwX
         kjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CP130Joo5LnzHA5fd0JPgyy8qzQq4QiMmlbo4WSc/bc=;
        b=Ao77Ee6qN7b0g++EAT7WRT4QoL2td+ssggtDfwdWfgVDV6NKW7TDNmEeIKijGGlpVq
         Yv1m6/lcVg+oFlCDxc6E66G30ltFwBuw/VpjhP/mD6eV1hI7qS/QCpGeQ5nwI7TgCdAi
         9cxrm3UD9G0FFzuc4pFzpX4JsHe2Uh6MQdsKcugNq91D5CF7BHYoIZhf9ye7dudZG+XS
         QZvqe+MhV3nMefSvPxfXeJhWE8IHgR9ZCf1cXsrve/Vm8RcDjZNYEGGy6OrkHXEer4wo
         VVRtn/utfmEZSuTiZvtGdhliLdMjabAfvZLEc40959w0FhG1uEKtkCmdSZal6w5gMpD1
         LnaQ==
X-Gm-Message-State: AOAM5314v9AAxvFuFm9e79xXVD/sJ5MguAGci9FDRLtk+8upYEovtIIp
        bWoi4XH77jwCz7V8PSU5fa2mKg==
X-Google-Smtp-Source: ABdhPJxbU+TPetYDwGr0juHAkGQdM/jc+JJ+Gtz12pEMdxQWIytSegOUq1HgGsra7H1qWC6d1uqoag==
X-Received: by 2002:a17:902:ec81:: with SMTP id x1mr3384394plg.109.1643988276332;
        Fri, 04 Feb 2022 07:24:36 -0800 (PST)
Received: from localhost.localdomain ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id me4sm14237079pjb.26.2022.02.04.07.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 07:24:35 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 RESEND 4/4] coresight: etm3x: Don't trace PID for non-root PID namespace
Date:   Fri,  4 Feb 2022 23:24:03 +0800
Message-Id: <20220204152403.71775-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204152403.71775-1-leo.yan@linaro.org>
References: <20220204152403.71775-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ETMv3 driver enables PID tracing by directly using perf config from
userspace, this means the tracer will capture PID packets from root
namespace but the profiling session runs in non-root PID namespace.
Finally, the recorded packets can mislead perf reporting with the
mismatched PID values.

This patch changes to only enable PID tracing for root PID namespace.
Note, the hardware supports VMID tracing from ETMv3.5, but the driver
never enables VMID trace, this patch doesn't handle VMID trace (bit 30
in ETMCR register) particularly.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index cf64ce73a741..7d413ba8b823 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -340,6 +340,10 @@ static int etm_parse_event_config(struct etm_drvdata *drvdata,
 
 	config->ctrl = attr->config;
 
+	/* Don't trace contextID when runs in non-root PID namespace */
+	if (!task_is_in_init_pid_ns(current))
+		config->ctrl &= ~ETMCR_CTXID_SIZE;
+
 	/*
 	 * Possible to have cores with PTM (supports ret stack) and ETM
 	 * (never has ret stack) on the same SoC. So if we have a request
-- 
2.25.1

