Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6F7472C13
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbhLMMNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbhLMMNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:13:52 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B726C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 04:13:52 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id v1so51782054edx.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 04:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JBlM0fJPQdFbfZELyfGYDQMeIzp3LQS6pQHkYWuX8+E=;
        b=dd7hlYP2Clq1AqRb//9vi2Gv0QEIpIvvfOc9+YtILUbE2SbzZJEQh9ItbAZFdJGYta
         QICI6sLf7SLo3L4q++xMdDcSwnQzgK2YiKmKuuC89NHt6+KWmQaotLkWJydNCot8tZrb
         8yao4HIb8kRXQcll9l2Z9ah2lVvUAeUsLFt3pQCNL4scCAusbSM1MxuF3KAT+lKwIytR
         r1oWPyT9DyVR71GioIAtooIYhNCccMtLWfm4hqFVoMocfEw3BfKt1MOP74+VMWjGpluB
         7b77azzx47p+L2DphzEiHlSrjBoztZNWS1BSz4g1vPtfY8vghI1nj0PbGSmEb+NZEPhj
         9XOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JBlM0fJPQdFbfZELyfGYDQMeIzp3LQS6pQHkYWuX8+E=;
        b=RT8lWD1hryZHssm0dcQynXmlSKsXPLdzejL8QoVJDBiJiDFP6nROCQjjfwQVF/QrWl
         qHIw9OyS8sFFZZYoLuShiVmz+s7J7fi2SApsiz3z/5H9xF8YTcB9L0BY6fMQE7KUglCO
         bUgxCANkW3DKn/9To83mDDaGvuoq/p5RHQtVEB7nAot0Sjzlgn6cz3FoECBzn1QvHKdZ
         aYPTUhmCviGOd1GIwElI8FqnPXmGF7A5xMUBrJAVEtoEPxMHUfZAMA/vPUT2yrKnaw//
         OFFc9ZusyPDjZmim67FueNkVxFY/NMvA+aBOG3CVlM5jjuGNCNhieQMetdg745ANkqjd
         5qtg==
X-Gm-Message-State: AOAM531KxKxlMIdMaIPU8eFO9Nb/Vho1nRy6tVeqL0ypbz5KHiMMlcGq
        B9By9Hqs5FXL2HoDpDR0Jtd46w==
X-Google-Smtp-Source: ABdhPJwz5oYW29GAi3U4zyh+V9Z7lEcvYsoaWvpdN0+4MDNP19p4ZNmFHRg0zw6gTZu2cB7ZId4N4w==
X-Received: by 2002:a17:906:9b8f:: with SMTP id dd15mr42691115ejc.480.1639397630513;
        Mon, 13 Dec 2021 04:13:50 -0800 (PST)
Received: from localhost ([104.245.96.202])
        by smtp.gmail.com with ESMTPSA id nd36sm5895826ejc.17.2021.12.13.04.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 04:13:50 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 1/4] coresight: etm4x: Add lock for reading virtual context ID comparator
Date:   Mon, 13 Dec 2021 20:13:20 +0800
Message-Id: <20211213121323.1887180-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213121323.1887180-1-leo.yan@linaro.org>
References: <20211213121323.1887180-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates to the values and the index are protected via the spinlock.
Ensure we use the same lock to read the value safely.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 10ef2a29006e..2f3b4eef8261 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -2111,7 +2111,9 @@ static ssize_t vmid_val_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etmv4_config *config = &drvdata->config;
 
+	spin_lock(&drvdata->spinlock);
 	val = (unsigned long)config->vmid_val[config->vmid_idx];
+	spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
-- 
2.25.1

