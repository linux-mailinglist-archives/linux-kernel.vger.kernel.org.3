Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA99A4A9BE8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359693AbiBDPYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbiBDPYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:24:30 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36987C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 07:24:30 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id s6so5389644plg.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 07:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4/q5CQ3/q+2EJBhXdOxiiNn1t4GGrRS1OQ5Mkhf3Sec=;
        b=C5DCpREMlr88/fQU73s5wGn0GGcqkJJL31Xyv/kKL/IgA4KcFNddOz+ZuVlvL7O5VQ
         V+CqjAPPP6J5XvAoD9yi63Bq/ObHpUVSJm/2jMiFFSF0INWY/ePh4sHgUzpeLlEGbw71
         bKoRSRle8ruV4QdF0bAdTRTYow4z4Yw+8cWF1MkobFg3jbs1Wb2DeUzWxx3KWX+aH48b
         a+Chi9XM8igLqLv6gRa8gW3bjLkB0ePtQG5CRESTLFoiQ+hxCD67L17pbzcnqsMi1KHK
         ghDYmPZYgqZABx6Yi6Qa4DUf6/9GpniToBuuInQnhAJsn/4J1L8FaRaQZinevEbHC5J3
         684g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4/q5CQ3/q+2EJBhXdOxiiNn1t4GGrRS1OQ5Mkhf3Sec=;
        b=7EblWRVn8FV+Pr/d95/rFrLB9ByGnXQ+JxEXnODRhqoUYv+BHbi8xSiS934nT/DhvN
         79ch4h1SNo+JOrX5n54QvO+8bn2sK/INGIj40VoqZax1xx9UgRbXwoA4cEpbrwQHFOd1
         oFfjZOdJA4aAaj2WpvWlPvpSqvYbCmDP7gsJjtSpSXzp3OOTbHC59HNsDWM0A5TvOiZ7
         vCR2Y8W+OXvnUOlEgrPECY3qdxTNdvWxEXNcRU0k1S5kNV9jCGE85bXxIOFdRlBUP0fu
         KfvtMCRbOGE2Nx2EGkyqgxqoPHTdAln7/pz2bTwLOekaY8ilPwCGjdkXix6Thxeyn7lU
         Emhg==
X-Gm-Message-State: AOAM533lH3bXL33AxOz3aqZhosk09L4O2E0aV1wv4lR+GU4JEZktbGEb
        D1KrytCaezdfqet5CfjOwO101w==
X-Google-Smtp-Source: ABdhPJw6LeGmJXDi9zLXZTklPRv2RbP51RpKUOJu3zoaiPjk/3n6c0kFXnwZysSKkOOnpiLJ0OSkzA==
X-Received: by 2002:a17:90b:3b52:: with SMTP id ot18mr3730813pjb.34.1643988269617;
        Fri, 04 Feb 2022 07:24:29 -0800 (PST)
Received: from localhost.localdomain ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id me4sm14237079pjb.26.2022.02.04.07.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 07:24:29 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 RESEND 2/4] coresight: etm4x: Don't use virtual contextID for non-root PID namespace
Date:   Fri,  4 Feb 2022 23:24:01 +0800
Message-Id: <20220204152403.71775-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204152403.71775-1-leo.yan@linaro.org>
References: <20220204152403.71775-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As commented in the function ctxid_pid_store(), it can cause the PID
values mismatching between context ID tracing and PID allocated in a
non-root namespace.

For this reason, when a process runs in non-root PID namespace, the
driver doesn't allow PID tracing and returns failure when access
contextID related sysfs nodes.

VMID works for virtual contextID when the kernel runs in EL2 mode with
VHE; on the other hand, the driver doesn't prevent users from accessing
it when programs run in the non-root namespace.  Thus this can lead
to same issues with contextID described above.

This patch imposes the checking on VMID related sysfs knobs and returns
failure if current process runs in non-root PID namespace.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../coresight/coresight-etm4x-sysfs.c         | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 2f3b4eef8261..a00c0d1bbd85 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -2111,6 +2111,13 @@ static ssize_t vmid_val_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etmv4_config *config = &drvdata->config;
 
+	/*
+	 * Don't use virtual contextID tracing if coming from a PID namespace.
+	 * See comment in ctxid_pid_store().
+	 */
+	if (!task_is_in_init_pid_ns(current))
+		return -EINVAL;
+
 	spin_lock(&drvdata->spinlock);
 	val = (unsigned long)config->vmid_val[config->vmid_idx];
 	spin_unlock(&drvdata->spinlock);
@@ -2125,6 +2132,13 @@ static ssize_t vmid_val_store(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etmv4_config *config = &drvdata->config;
 
+	/*
+	 * Don't use virtual contextID tracing if coming from a PID namespace.
+	 * See comment in ctxid_pid_store().
+	 */
+	if (!task_is_in_init_pid_ns(current))
+		return -EINVAL;
+
 	/*
 	 * only implemented when vmid tracing is enabled, i.e. at least one
 	 * vmid comparator is implemented and at least 8 bit vmid size
@@ -2148,6 +2162,13 @@ static ssize_t vmid_masks_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etmv4_config *config = &drvdata->config;
 
+	/*
+	 * Don't use virtual contextID tracing if coming from a PID namespace.
+	 * See comment in ctxid_pid_store().
+	 */
+	if (!task_is_in_init_pid_ns(current))
+		return -EINVAL;
+
 	spin_lock(&drvdata->spinlock);
 	val1 = config->vmid_mask0;
 	val2 = config->vmid_mask1;
@@ -2165,6 +2186,13 @@ static ssize_t vmid_masks_store(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 	int nr_inputs;
 
+	/*
+	 * Don't use virtual contextID tracing if coming from a PID namespace.
+	 * See comment in ctxid_pid_store().
+	 */
+	if (!task_is_in_init_pid_ns(current))
+		return -EINVAL;
+
 	/*
 	 * only implemented when vmid tracing is enabled, i.e. at least one
 	 * vmid comparator is implemented and at least 8 bit vmid size
-- 
2.25.1

