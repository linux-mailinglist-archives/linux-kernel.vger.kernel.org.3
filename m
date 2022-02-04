Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0814A9A51
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359040AbiBDNvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359038AbiBDNvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:51:20 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513EAC06173D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 05:51:20 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id c9so5180261plg.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 05:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gYlHTKZwf3eLsDFK6/setIM6v4QyZpE5drcppDSgIrA=;
        b=pC1m2fQqzS3hTahuKDM+7c0QgFbpmg/lU10YDP/xIO9xlFrADUvnPyylLcudQm3HwS
         Mzkkzt+rfEVA3WC0spzFoQljr9eb513PHecSpght3nP9WlMtWD82drPNmjTwj2mvE4Hw
         dda8ht3nPEpJgAN2CREnIOfJRLXHjHbQeB2ZhAblgc8q7hxEozF3onzdmNId7clG2bjG
         ZEcuTQGcQ4c13Pw562dtlPFppp2B2IJWZZ37JZn5MAfn6uEuGdVTV77pnXlo4nMI3f7Z
         5DK0AovtSLJeoY5vHqtvQx1s9VVbD+XNEoRLYXqeTTG7T9xy4bGxsPnJg085fug37uZQ
         5CBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gYlHTKZwf3eLsDFK6/setIM6v4QyZpE5drcppDSgIrA=;
        b=oAYqKXVpi6ULAlBptybGVwdy8CwtzW1KM7Z8uX9aJMHLfnMXr3GIA4nBZcHmtWLC9u
         iuAyvVKlfKGKEuVjHSvs83eTTIjJwQ1mjU4hYXlUUMV0uCHgsARTuG8OnjeE1HJVf/0X
         KvduiST16KEOtvXvmWWIWLxQcLAHpNhdGmhIbz5R8QQ0fKMEMheRy0xFQObSqdfVU2kZ
         L5xjgDHXugDx3/m6Y46ubSsU0bGNj2W3ciIAdXCzbkrGNtewH2pcGPwSjMqa6opm07Vi
         v5O4CsBwbWFVK9BwOV0CuKGQqMCXAf0qN5jM36xHppZshpFLFTWQIW/cWBvEQFp3eTjY
         fXuA==
X-Gm-Message-State: AOAM531iBFpPm7gaZMHeyFv52B/XYHIaPgGkrsjmH3Kzzuh7EOkK5dt9
        xYUkjI7cYFbas0M9n8HoCcvPTg==
X-Google-Smtp-Source: ABdhPJy/zWH1p1cq5ydscrQgno2r1v4rJtuFkahMNvFLmLQ8bff4NDmYnoTUSpUlIlE29DeDFErTXQ==
X-Received: by 2002:a17:90a:f485:: with SMTP id bx5mr3247440pjb.46.1643982679691;
        Fri, 04 Feb 2022 05:51:19 -0800 (PST)
Received: from localhost.localdomain ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id 13sm2668131pfm.161.2022.02.04.05.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 05:51:19 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Balbir Singh <bsingharora@gmail.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, codalist@coda.cs.cmu.edu,
        linux-audit@redhat.com
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 2/5] coresight: etm4x: Use task_is_in_init_pid_ns()
Date:   Fri,  4 Feb 2022 21:50:48 +0800
Message-Id: <20220204135051.60639-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204135051.60639-1-leo.yan@linaro.org>
References: <20220204135051.60639-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces open code with task_is_in_init_pid_ns() to check if
a task is in root PID namespace.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Acked-by: Balbir Singh <bsingharora@gmail.com>
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

