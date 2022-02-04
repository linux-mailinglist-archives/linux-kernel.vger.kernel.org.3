Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5D24A9A50
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359025AbiBDNvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359024AbiBDNvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:51:15 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0AEC061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 05:51:15 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id e28so5161417pfj.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 05:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ond/4ABfTjnzyDWR3gs46S4b6+8tS7qKpB/Y7mDbdaU=;
        b=wmlsCgXM1ZaxWZmmTNRiTDHSrz4QZlpOzZcHzw4wQJiCEZCQAFYI8HJqRGCtWiyhW5
         A6RdVRtdiDEoKdYM5Sop7Q2XFzudD/dkrNdDU2rPne5G+FoBWunbKI5WkgjDbHZgsgPg
         slaahwwbp5z0P1jkNYAz8ukILBZ6mD+OwGKo2xDeSis+I39UgyeucUSK7LuBZYjhu+wP
         Sfz5xV4T0dF/fqK/mJ/TfKm7yzf5/EQes4xKNNMNQNT+1CiAnBzqKz6Bax9uWY/2Ehlz
         EXVuhXuXUTZC8c0wzkDmoYJOZykctJNjVnnyXYOIdmTnbTA1keOgnEWuW00zyLhaXwyB
         svoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ond/4ABfTjnzyDWR3gs46S4b6+8tS7qKpB/Y7mDbdaU=;
        b=6BBzRf+fr5pw2mXWpDFQHbPmKP4ZFtHK/y/FFgh6Sdf5yqlwgijhWziItdoug61nsg
         sFYlZQymOktl2o8ymxgG1Lvo7rAdKrmbpY1NRJ+q0cMZrIxB3XSTPI7bglsjCEL7PDpB
         2ADi3yShl5K6vCU0Jf50CRn5of33dxWa/nAFBQqTDrd9v4X9bfFgVNUjz4joxWanqgV2
         AkO2clX4+aAO2AEmJrqlazBVv+yU6U/MHLrdWML2isvFpz+SnzbcnoNWVm/qJ9KPyyWL
         9G/OaWiTo2s2ikYQBNIBlfRfR4fEWxqvUykFyB2zwz4RHcbAjF14iayGYRkelW+woimp
         AI4A==
X-Gm-Message-State: AOAM533t2Jlq9wPufy+2tD+F8FiHNOBmVgoq3InrzO+Po7fsWouZW/JO
        Ltt+ZUO896/+EWT6XFv2M4CuUg==
X-Google-Smtp-Source: ABdhPJwuvtNdZ9Ta6hHt9CUE+CDUNaZXCQXeOpieEryVkd24lqRO4trnQ3j/8j76oVJ/K1+jjs/4xw==
X-Received: by 2002:a05:6a00:804:: with SMTP id m4mr3169177pfk.45.1643982674946;
        Fri, 04 Feb 2022 05:51:14 -0800 (PST)
Received: from localhost.localdomain ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id 13sm2668131pfm.161.2022.02.04.05.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 05:51:14 -0800 (PST)
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
Subject: [PATCH v4 1/5] coresight: etm3x: Use task_is_in_init_pid_ns()
Date:   Fri,  4 Feb 2022 21:50:47 +0800
Message-Id: <20220204135051.60639-2-leo.yan@linaro.org>
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
 drivers/hwtracing/coresight/coresight-etm3x-sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index e8c7649f123e..ff76cb56b727 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -1030,7 +1030,7 @@ static ssize_t ctxid_pid_show(struct device *dev,
 	 * Don't use contextID tracing if coming from a PID namespace.  See
 	 * comment in ctxid_pid_store().
 	 */
-	if (task_active_pid_ns(current) != &init_pid_ns)
+	if (!task_is_in_init_pid_ns(current))
 		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
@@ -1058,7 +1058,7 @@ static ssize_t ctxid_pid_store(struct device *dev,
 	 * As such refuse to use the feature if @current is not in the initial
 	 * PID namespace.
 	 */
-	if (task_active_pid_ns(current) != &init_pid_ns)
+	if (!task_is_in_init_pid_ns(current))
 		return -EINVAL;
 
 	ret = kstrtoul(buf, 16, &pid);
@@ -1084,7 +1084,7 @@ static ssize_t ctxid_mask_show(struct device *dev,
 	 * Don't use contextID tracing if coming from a PID namespace.  See
 	 * comment in ctxid_pid_store().
 	 */
-	if (task_active_pid_ns(current) != &init_pid_ns)
+	if (!task_is_in_init_pid_ns(current))
 		return -EINVAL;
 
 	val = config->ctxid_mask;
@@ -1104,7 +1104,7 @@ static ssize_t ctxid_mask_store(struct device *dev,
 	 * Don't use contextID tracing if coming from a PID namespace.  See
 	 * comment in ctxid_pid_store().
 	 */
-	if (task_active_pid_ns(current) != &init_pid_ns)
+	if (!task_is_in_init_pid_ns(current))
 		return -EINVAL;
 
 	ret = kstrtoul(buf, 16, &val);
-- 
2.25.1

