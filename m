Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58EDC472C15
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhLMMN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236566AbhLMMNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:13:55 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C844FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 04:13:54 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id y12so50579676eda.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 04:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4/q5CQ3/q+2EJBhXdOxiiNn1t4GGrRS1OQ5Mkhf3Sec=;
        b=FQOiwxWIa/V50ZOvIdGrxTMDpMzUJYTDnJDsBkBrsHoCMvjGB3JGMyk2jz0ZhXKQQV
         P10aOa+Fd3f0lB2j4MAI924aBw3zStw8fq1rOvxuIHgQ+3LHMroZZe0QL/eAzbPtP6cM
         Py5peunGY3HKzWu8JFSe9Jf64cg24VZLyM39StxAr+lvo7RL8tR9TDD+cFO67mJ81IOC
         TuZLaIbncZ40e+u4rpBAO8dYHzJfNUraSjcpxrbs3KGkbNENZshyn1ulLZTf5dPLhMDh
         SUSbVCpTixyLr3V1bL3fVjDXi8L5ElPpfB4pd5+EsUOMRjmCrqbe1/1S4q+d51LfUejw
         3oTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4/q5CQ3/q+2EJBhXdOxiiNn1t4GGrRS1OQ5Mkhf3Sec=;
        b=EikP5lBU2Xx60AvjNDe2F5l9FOuBs1Z7joP2Flw+32weLDIKO7DO73croLNRRZvJ7q
         CM2dDtHJTiNJVynvuanoFJ/nFtFdgY43E3xbKW++Z3Wb4HyuVBk/CW6wuWo6PdfaF5mq
         NyRyyH2VQUS2SLHAhMsejqnkYlfsjHX9b1J30RMcRXeXmhHqx3YubPSkTMxI5yYfvT8V
         QF55Vh/cXqqg/py5IGgkd8BlTTQ7GNQEc+88UPuqkTAafQUi8W3Bc4404m+ZMH0GphKt
         2flcp1OQddFd5e23FhjW4XJLElYuLYJYESpllzwYAuZW3bWQiqfOsWjVWM3z8Czg71lN
         HUzw==
X-Gm-Message-State: AOAM5314PGe1jxZii+4FjWg2MTgeHzQn6Y0p+Z1Ot4CVToQDzPZTELTo
        Z3qFidyY2nd0VPPmPTUDlZxsQA==
X-Google-Smtp-Source: ABdhPJwpHCWcd1fqcvPvzOIn657fLFck/7Gj6sLy9umteOuFTthGsPkU/q9M/IcZwJZKz36vOlBQgQ==
X-Received: by 2002:aa7:d794:: with SMTP id s20mr62400515edq.305.1639397633225;
        Mon, 13 Dec 2021 04:13:53 -0800 (PST)
Received: from localhost ([104.245.96.202])
        by smtp.gmail.com with ESMTPSA id r3sm5803128ejr.79.2021.12.13.04.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 04:13:52 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 2/4] coresight: etm4x: Don't use virtual contextID for non-root PID namespace
Date:   Mon, 13 Dec 2021 20:13:21 +0800
Message-Id: <20211213121323.1887180-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213121323.1887180-1-leo.yan@linaro.org>
References: <20211213121323.1887180-1-leo.yan@linaro.org>
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

