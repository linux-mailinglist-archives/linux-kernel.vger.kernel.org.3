Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE597472C17
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236629AbhLMMOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236620AbhLMMOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:14:01 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE5CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 04:14:00 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id g14so50546336edb.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 04:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CP130Joo5LnzHA5fd0JPgyy8qzQq4QiMmlbo4WSc/bc=;
        b=PSS1H3WXFIMfkQxsIWTWwPkYK0wcqIk2+76oPkMNGMZ0qSS0iW+g1XjW6KXrKR+L62
         VZEOcDtuRohjJWGX17jBc1X1QFF5D6QVXy/07L0sCzejVVBUVGun7Rdp3RacKI13kR+G
         lnFNiTYewYD7lmVCYatZZ2L7DrabtOQEcTGNOeVyK1b3JHPBeBBD5Qqsb3I3H0eVDNfW
         nHM6svD7D9x/YbKj3k4Yi9DfY+ceccgIxldW8uXVMXTfC3lKetcPIu8unIGmQo70yGvX
         it9eh/YrirQGva1/nfhawMjYtC5hJ2btu4n/JGYDt9CK30DoC8JabmNh9qmyfMpoXleB
         g3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CP130Joo5LnzHA5fd0JPgyy8qzQq4QiMmlbo4WSc/bc=;
        b=mVW3KOOzSSPdX4DbR4yHh4LUYEMEePDFOkzYLzcPMfMqRYYfvwRbFcgLhgdE1txXZV
         /sEyX4A7Q3iUM6wq3eRB/dpkvMnIjC+FeexfzmF172mw4tIwZIBl1zZ6RvRWP2OoofoQ
         fP13IxYbEWobOxjkzyXIjr6PnTM3WpK5pvsT7dhHWslz64Dg5nGHVxbKX8eKEENUWkrO
         9Mgd+frmSgitKHnwJSR596SFSGWv1LlCjEXjdPaKg1uByCcu7bbt2Np2q5VJdWukyI/c
         8LuRCyAvKTQ+287zd2L1EAzSvxvlZGvAICp1sJl1Pnn9epM8YSHzzwkIFgUtCOfgqFLW
         K1Uw==
X-Gm-Message-State: AOAM531M9Yo6G2juAB7ETLzUwe7MtKwP7HVzBvdc88VgjFtqg71t1Zci
        gvJua8sNg4a19Lid9zKVwGEF4g==
X-Google-Smtp-Source: ABdhPJzEjrG8YHO4P2YfYwddzrc1l59/YSf3cTyU7Z/e8XhYhxdxpkf6MgfH65sMs/AbT7XDZH+LtA==
X-Received: by 2002:a17:907:3c6:: with SMTP id su6mr46285599ejb.255.1639397638590;
        Mon, 13 Dec 2021 04:13:58 -0800 (PST)
Received: from localhost ([104.245.96.202])
        by smtp.gmail.com with ESMTPSA id d19sm6273171edt.34.2021.12.13.04.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 04:13:58 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 4/4] coresight: etm3x: Don't trace PID for non-root PID namespace
Date:   Mon, 13 Dec 2021 20:13:23 +0800
Message-Id: <20211213121323.1887180-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213121323.1887180-1-leo.yan@linaro.org>
References: <20211213121323.1887180-1-leo.yan@linaro.org>
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

