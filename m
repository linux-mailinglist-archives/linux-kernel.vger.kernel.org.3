Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB1F468B7A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 15:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbhLEOyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 09:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbhLEOyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 09:54:50 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFE0C061714
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 06:51:22 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id h24so5854801pjq.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 06:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TIZ1ekHamWsBpzx/c4rlzvRLrR0WcD4jTfep7Z0JpMg=;
        b=QDKpb2AU6Lu0PXY1xs9kgtm19LM/i5PF/nec/ihFtCbDaXPEgScrYCRZXt4d6HdrD6
         Cuwr62idNZcMkMKQFCPzSVHRKJx8PlTpFuxU10OMtShYcCiovPtC16YkFKOd2zoaI7Ea
         rqiLZC1n08U4FoqhCzpsJ008nQOXyxuhgg2PKDm/ZJvRika6I+Q+TU/43dgLcLoEgmeV
         861hb6jst0VVelVV4xipGCJ5uEb/tXF2OhLyPCqzEsWQwY86Q0BigMsr7fuIZT+xstw6
         //ec5ZoaBVQNMHPu+/1mk6bK6x7JkErjVB0DxzPImdZ9taBfMUDnIAD20wFASG9UeJ1r
         oZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TIZ1ekHamWsBpzx/c4rlzvRLrR0WcD4jTfep7Z0JpMg=;
        b=WWToTN6fhJ6E0f1hEsO+/8sGrRFVM5gHaSb62eqCxZYJu0ftIrdVtLsXtSnLiIZBGV
         mp4iLvtcCuCENoy+Edd+w4ZwpDfVUBmDx7yXlSEQ+lVligLZwiY7tc5dWVJbF9cNrK4A
         mRBjXZq0fTSa9Zl1lvKWsZw0V3gKKSQrSkj9UlJE9gKARVX05Eh6xaHUO8jK2NigeyZx
         7eLCvIX4R1T8REQqqcKqdQF+2dMF8GVffKlSUD3sz+YLhjS9UJDqpXAx2w+5ZR90FebG
         QSfExp55j1YV5v53epi81aRIbYO2vYuSRw7NAChTW8tvWIN4hxgIdJzD3gzGo/ONwG0P
         gSTg==
X-Gm-Message-State: AOAM533bxU0/wFyU3HD7JFJ6Q3Wu8123LRMqLtn2/ie7yC/wTNiVbWIH
        q0q3SfkNSnSqL2C4T/lJZ+LDiw==
X-Google-Smtp-Source: ABdhPJwbtYvyednOqDHit4yIYRavSWV2oodDpZmOZnha4ZDGgas38FxP9ERRJu8LnK4qX8faP9/2ag==
X-Received: by 2002:a17:902:b20b:b0:141:a92c:a958 with SMTP id t11-20020a170902b20b00b00141a92ca958mr37475204plr.24.1638715882411;
        Sun, 05 Dec 2021 06:51:22 -0800 (PST)
Received: from localhost ([2602:feda:ddb:5fe8:b1a8:1b20:fbe9:2696])
        by smtp.gmail.com with ESMTPSA id y28sm9218195pfa.208.2021.12.05.06.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 06:51:22 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
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
Subject: [PATCH v1 2/7] coresight: etm3x: Use task_is_in_root_ns() to check PID namespace
Date:   Sun,  5 Dec 2021 22:51:00 +0800
Message-Id: <20211205145105.57824-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211205145105.57824-1-leo.yan@linaro.org>
References: <20211205145105.57824-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses helper task_is_in_root_ns() to replace open code for
checking if a task is in root PID namespace.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm3x-sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index e8c7649f123e..baba16ad9bb1 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -1030,7 +1030,7 @@ static ssize_t ctxid_pid_show(struct device *dev,
 	 * Don't use contextID tracing if coming from a PID namespace.  See
 	 * comment in ctxid_pid_store().
 	 */
-	if (task_active_pid_ns(current) != &init_pid_ns)
+	if (!task_is_in_root_ns(current))
 		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
@@ -1058,7 +1058,7 @@ static ssize_t ctxid_pid_store(struct device *dev,
 	 * As such refuse to use the feature if @current is not in the initial
 	 * PID namespace.
 	 */
-	if (task_active_pid_ns(current) != &init_pid_ns)
+	if (!task_is_in_root_ns(current))
 		return -EINVAL;
 
 	ret = kstrtoul(buf, 16, &pid);
@@ -1084,7 +1084,7 @@ static ssize_t ctxid_mask_show(struct device *dev,
 	 * Don't use contextID tracing if coming from a PID namespace.  See
 	 * comment in ctxid_pid_store().
 	 */
-	if (task_active_pid_ns(current) != &init_pid_ns)
+	if (!task_is_in_root_ns(current))
 		return -EINVAL;
 
 	val = config->ctxid_mask;
@@ -1104,7 +1104,7 @@ static ssize_t ctxid_mask_store(struct device *dev,
 	 * Don't use contextID tracing if coming from a PID namespace.  See
 	 * comment in ctxid_pid_store().
 	 */
-	if (task_active_pid_ns(current) != &init_pid_ns)
+	if (!task_is_in_root_ns(current))
 		return -EINVAL;
 
 	ret = kstrtoul(buf, 16, &val);
-- 
2.25.1

