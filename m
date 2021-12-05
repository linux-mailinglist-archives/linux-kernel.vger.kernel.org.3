Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A55468B7D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 15:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbhLEOzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 09:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbhLEOyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 09:54:54 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70490C061354
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 06:51:27 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id f125so8062236pgc.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 06:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r7FuDJBkqmbrNZ8AuyY2ToeqGTn3J1mJtK8z1ItIbdE=;
        b=QHCE7EcZHC03zy6MaqNqCBN+Fpm5uAGmWmVntGtp7U5n/wHjBc1F3Kdy8R5DdkiE6C
         CQQk3ZM5MTTKy0JcD6PEeBIml/H2OvjS1+XE7GeIX4nSPB+wH6DbJa5EN7/rSbhr8huE
         UHqFfcSu5fcVNqcxHbhD+z4rM3rUqKWbdIkOskuZOwi/gIOTZiDI+kT+wSq+lTHFcfzd
         1v2/rTkuvQ7MBlcI3hEeye+s911D7DZq8FWScsalbNbWTbefEE0ebKEpw22Vn0eYAE2S
         jKIXPSXFADD5/RyLiApLFsI5CUfRYg7XX03NJYFL5WrukGmxvCtyU/83iSsJVFHH2siu
         JfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r7FuDJBkqmbrNZ8AuyY2ToeqGTn3J1mJtK8z1ItIbdE=;
        b=qYP4Md/Nir+YwJrgVUO0vV3FPTDbleovy8ivYBIruM2RGnRmXtnT9RmNps0jjjxnBM
         CpxAgDHzbV1iCKExW43B0tqEgfXleMwG3ax3NkGa4ErrPtavn2/51OMKtl/XJ3Sa69gi
         YzhiIAguauLZTAXZ/yj8Kcl4sqKppTfOY42R/8O0EhBwCN9yO4R86NkNakVoup3d7H8w
         BphLrtcNi46cJ9bay7Cd8nRF+p/dNXIbGicbWtPYPFCihwAS7fDxWjDq/Qg4GDO2Ro3U
         GNtaL9j9gqTH2V+bLPnH588kWCTWFfoDKs0vBVvDjozQ0ZEvFHZot0N33nCMvudH/ptI
         fb7w==
X-Gm-Message-State: AOAM531e8io7w6OXf7fxbCMCiFWqJiRKmqpSv2WZbY1kk8E8sIqU0tKK
        kuD0RgCBP4Sz3tGzx/ECl9vkVg==
X-Google-Smtp-Source: ABdhPJzUBAAPjj8z3sKrvIM+BkzPaczsu+Op3D9PsW9q5fj4Q5p9j0lxy8voeiQ//58dzghyGllY9g==
X-Received: by 2002:a05:6a00:124a:b0:4a4:cfd2:b40f with SMTP id u10-20020a056a00124a00b004a4cfd2b40fmr31149267pfi.57.1638715886771;
        Sun, 05 Dec 2021 06:51:26 -0800 (PST)
Received: from localhost ([2602:feda:dd5:6b5b:660b:141b:4f83:cd75])
        by smtp.gmail.com with ESMTPSA id f5sm7548675pju.15.2021.12.05.06.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 06:51:26 -0800 (PST)
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
Subject: [PATCH v1 3/7] coresight: etm4x: Use task_is_in_root_ns() to check PID namespace
Date:   Sun,  5 Dec 2021 22:51:01 +0800
Message-Id: <20211205145105.57824-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211205145105.57824-1-leo.yan@linaro.org>
References: <20211205145105.57824-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid open code, this patch uses the helper task_is_in_root_ns() to
check if a task is in root PID namespace.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index a0640fa5c55b..cd87ad8456d7 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -1890,7 +1890,7 @@ static ssize_t ctxid_pid_show(struct device *dev,
 	 * Don't use contextID tracing if coming from a PID namespace.  See
 	 * comment in ctxid_pid_store().
 	 */
-	if (task_active_pid_ns(current) != &init_pid_ns)
+	if (!task_is_in_root_ns(current))
 		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
@@ -1918,7 +1918,7 @@ static ssize_t ctxid_pid_store(struct device *dev,
 	 * As such refuse to use the feature if @current is not in the initial
 	 * PID namespace.
 	 */
-	if (task_active_pid_ns(current) != &init_pid_ns)
+	if (!task_is_in_root_ns(current))
 		return -EINVAL;
 
 	/*
@@ -1951,7 +1951,7 @@ static ssize_t ctxid_masks_show(struct device *dev,
 	 * Don't use contextID tracing if coming from a PID namespace.  See
 	 * comment in ctxid_pid_store().
 	 */
-	if (task_active_pid_ns(current) != &init_pid_ns)
+	if (!task_is_in_root_ns(current))
 		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
@@ -1975,7 +1975,7 @@ static ssize_t ctxid_masks_store(struct device *dev,
 	 * Don't use contextID tracing if coming from a PID namespace.  See
 	 * comment in ctxid_pid_store().
 	 */
-	if (task_active_pid_ns(current) != &init_pid_ns)
+	if (!task_is_in_root_ns(current))
 		return -EINVAL;
 
 	/*
-- 
2.25.1

