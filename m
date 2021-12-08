Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30EC46CF14
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 09:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244934AbhLHIhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 03:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244877AbhLHIhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 03:37:06 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C8EC0617A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 00:33:35 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id l25so5664158eda.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 00:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=syFihbslZjHwDTq+JkTCaQ6HIW4tudCEAOhWOsBW3f8=;
        b=FIcHYQplia/uHOPYAfm7N4eTvgq4ZpEMly4CQ2o0QB93pCqBsp+PSLAfFRfUDZnr3d
         MVR+UGxBOo8yJC1+svs7NhIjnCKAh7zb3bNifNkQMEK0r5f8e4YkobRfY62ijRcn/pZM
         4A4cuMgB/V0bZLEf4NPKIrZaenwkaBKW+tLpJGMnq2kf/VeM4qg9N9PFTChUHiz2GnUY
         9LWFIUa+BvjfShAdss2LJxz6+R3B82S8nFqn+mVpe/RKju8AEjKG7ViBK4MpZ2eiqfTw
         w30Wtv2qlMPm7e2YizgaBP/mHGY0IpAGRqVXFjB865p54jcxfIBpxefgck3adHPeoG+I
         FB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=syFihbslZjHwDTq+JkTCaQ6HIW4tudCEAOhWOsBW3f8=;
        b=rAYdJE30l17St0z1EvkLN0yhMX3ZeuieCXh3DE6uknREc01kurC3QfaxjO2p2D45HL
         3MEu3eB8MAXdwyowsQWf90qs10vo3LGiR2HDKwum1uJARWtnXsEims22mhk1CaIG+9dj
         ubPaVjX++dhB5qDjbEPs2ePU2Mg0f3mJ594/iGAhlBs5CHnyBI2mZY9C6J5a0ljB3i5C
         Kd551SkrAKS8mXdzCX2lDChzcxZG2kzm1eFUvMq9x5r/lD796RaL0sH3FweoHhMiiu4C
         HrksuEainx0xwyzhyWRnjSpVI2GrqBcf2ht8CFzC/pfAB3Jn88k2tFRs2IAT/eAn341z
         1flQ==
X-Gm-Message-State: AOAM532rLUMHQa7Dr0zrse+3JLxpsSCIuPvrwZMxdoP3S8dcxjuUbN0E
        3WVa3taFhcQ9RGUnt8ZRv3RnTg==
X-Google-Smtp-Source: ABdhPJwbn0b/epdtBx4MFnKaeNyNgHRZAK/UbmJSYo1onUQVReJD7IxMwNpCQLIpnZb6sOh1Sxmpew==
X-Received: by 2002:a05:6402:2744:: with SMTP id z4mr17639355edd.310.1638952413660;
        Wed, 08 Dec 2021 00:33:33 -0800 (PST)
Received: from localhost ([104.245.96.202])
        by smtp.gmail.com with ESMTPSA id hs8sm1077396ejc.53.2021.12.08.00.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 00:33:33 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Balbir Singh <bsingharora@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, codalist@coda.cs.cmu.edu,
        linux-audit@redhat.com
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 3/7] coresight: etm4x: Use task_is_in_init_pid_ns()
Date:   Wed,  8 Dec 2021 16:33:16 +0800
Message-Id: <20211208083320.472503-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208083320.472503-1-leo.yan@linaro.org>
References: <20211208083320.472503-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces open code with task_is_in_init_pid_ns() to check if
a task is in root PID namespace.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index a0640fa5c55b..10ef2a29006e 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -1890,7 +1890,7 @@ static ssize_t ctxid_pid_show(struct device *dev,
 	 * Don't use contextID tracing if coming from a PID namespace.  See
 	 * comment in ctxid_pid_store().
 	 */
-	if (task_active_pid_ns(current) != &init_pid_ns)
+	if (!task_is_in_init_pid_ns(current))
 		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
@@ -1918,7 +1918,7 @@ static ssize_t ctxid_pid_store(struct device *dev,
 	 * As such refuse to use the feature if @current is not in the initial
 	 * PID namespace.
 	 */
-	if (task_active_pid_ns(current) != &init_pid_ns)
+	if (!task_is_in_init_pid_ns(current))
 		return -EINVAL;
 
 	/*
@@ -1951,7 +1951,7 @@ static ssize_t ctxid_masks_show(struct device *dev,
 	 * Don't use contextID tracing if coming from a PID namespace.  See
 	 * comment in ctxid_pid_store().
 	 */
-	if (task_active_pid_ns(current) != &init_pid_ns)
+	if (!task_is_in_init_pid_ns(current))
 		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
@@ -1975,7 +1975,7 @@ static ssize_t ctxid_masks_store(struct device *dev,
 	 * Don't use contextID tracing if coming from a PID namespace.  See
 	 * comment in ctxid_pid_store().
 	 */
-	if (task_active_pid_ns(current) != &init_pid_ns)
+	if (!task_is_in_init_pid_ns(current))
 		return -EINVAL;
 
 	/*
-- 
2.25.1

