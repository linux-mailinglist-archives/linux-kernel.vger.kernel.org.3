Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDC846CF12
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 09:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244845AbhLHIhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 03:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244826AbhLHIhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 03:37:04 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828E4C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 00:33:32 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id y12so5639309eda.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 00:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nFpFNbcBX+lPeRGnonpR3BH6HPTPVDEm6tJ4QkqNbVo=;
        b=fyG2uCc9nPoybzx4IqY3kG3z4y/lzE2jNZjrff8vePl8GWtgZSaNMC65PLruzfzUFf
         dnAryvQpAWnYYa+ME9rtNg1BTldjtTWg8VMYpcbot++nJgPC/ZvNC6kvI9qPx5jokeor
         FLe6DmMQqJ6Xdfyq3TIhyZprBoXpZvj3lBY/aE6+D94wICjzXxClnejSEVcBq/MV9IzW
         HrGn3gPWi+N9sN8OZXa3LEvuAMppB3NSf2FAbkU2AzptV5XKKGctLZSdg2jCAIt+V7jH
         6fHxN+eiDJ/z+RtnCyZ2TsqW3jbM4KHQCxYjmcLv5BGrsVHdBbRouve9mNV6lsfHWB21
         WaGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nFpFNbcBX+lPeRGnonpR3BH6HPTPVDEm6tJ4QkqNbVo=;
        b=51XOGPxdBnM0zldZGJHPZi9EwaBR5yXBhIEw796fbO3nh+uBwmo0qUvf3KAKetuH99
         FqBD544MiFsh6NB0jiN9fgyb24Sj9aLFmlAA8U/e86bpzhc74ZUO8xHi4kFjjYJb49S8
         fPmhRfoSJsUPRlKUB1BuMfWr3ut0MuY+ZenQfCcenERirnxnrDJE80Xmf8TYoqlLaqto
         Za7yweL8RjIG4ru/JrAQDF+w4wqBGevFYDKE9bO6/CCf7iwyZBKuHN0kyjijo5on4f2d
         ygnAM2Z9/SrsrGCCN9FczAVPuixz2sz/4A9ZHV9fNqCT4+d0c/JuzYJukSDDeaURfp+R
         ZQMQ==
X-Gm-Message-State: AOAM532U7zJw+3IpOAR7phMPOv8Kl9ppKnMF2BHWZ1w6OP/u8EoSeMG6
        10JVccd69b8/P7+lHBg/YEceuA==
X-Google-Smtp-Source: ABdhPJwjB4j2qwDPyk+4ObiPFmUCJJ3bfOq7wkfrgeKtjhkWvjp7+SQ4o/Bu5lKqkBurHaCAuz088g==
X-Received: by 2002:a17:907:7e91:: with SMTP id qb17mr5835776ejc.449.1638952410925;
        Wed, 08 Dec 2021 00:33:30 -0800 (PST)
Received: from localhost ([104.245.96.202])
        by smtp.gmail.com with ESMTPSA id d10sm1089074eja.4.2021.12.08.00.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 00:33:30 -0800 (PST)
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
Subject: [PATCH v2 2/7] coresight: etm3x: Use task_is_in_init_pid_ns()
Date:   Wed,  8 Dec 2021 16:33:15 +0800
Message-Id: <20211208083320.472503-3-leo.yan@linaro.org>
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

