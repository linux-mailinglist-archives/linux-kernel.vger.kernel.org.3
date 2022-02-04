Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D514A4A9BE7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 16:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359677AbiBDPY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 10:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238436AbiBDPY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:24:26 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF29DC061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 07:24:26 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id z5so5405304plg.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 07:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JBlM0fJPQdFbfZELyfGYDQMeIzp3LQS6pQHkYWuX8+E=;
        b=X9dUcNLOw092RvHVzkfzPS1gNBOrhNzF4xP71iXtrHvkaRqW2nTuThJXpAcz9y5B21
         KoV9pnCaOh6YgT4o7+Hk2oENdB/GVyt6M6ugQWjUaLweghTWLCEv+i9+sBROt0qDm3wi
         poTuVRo4c0uG35TNM6PRmkT7dbUapI1Gn4N57UgrgD9yVv32iU/SljKcpp7QSoSnNtfu
         pXgtq+gWqvrWtfloS0/DLtPmN3qC3EbgWwh3jgLie39wUsb6Yc2Ion/ziNS6P5ANwE/c
         IBAr5gY4ZnFwRzxzbgKniEs+mPRr+T6M26MnrCGOJ2swBPjo6j1gSK4nvi1w56MKIdu/
         Z92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JBlM0fJPQdFbfZELyfGYDQMeIzp3LQS6pQHkYWuX8+E=;
        b=G9ZSB+oEc23/BYJ5KPp9/4t7n04qGNAMRP8YLJpxoRrwfyibhNeeABBKVCUXUtggOa
         kS+5Dtds2sg55D2JSPwIoH2JKL0cYV4X6W2C/EAXrUoZt/Em2wccUKZYCngBbtk+qLDb
         cbxN6uQ9Nx6mY+AogXxcXEOUo/iNB3cP4afS/gYBMLCFYUGV4hrc2lvS85ohs4oYoFv9
         eaNynhFjCxQ3fI4NVrOg1erRoG8Uhl0uqcw5vlYW/MdfdT3yTT5F4TuVa/J9SFpx3S/R
         dMzwW0SrLINo1GiFYEL31euQXzDNOd4FmwbykANcVx3CmlkzN70Exr2ZZDuL+RYySLyn
         A05w==
X-Gm-Message-State: AOAM53148oXKxc85tGkoexiqm5rV/SA9Isfbwl+q03+PWCz2n24PuPeP
        3YKUsbiLHNI2qO/gEIDg2KMGpw==
X-Google-Smtp-Source: ABdhPJyIBnN4dkIRd9M9D8tgwp/n04tEKjszNC29r+PG9jVXxmyMTXPE0hth4JQKWyim1uTygPiS8w==
X-Received: by 2002:a17:902:7893:: with SMTP id q19mr3768988pll.9.1643988266284;
        Fri, 04 Feb 2022 07:24:26 -0800 (PST)
Received: from localhost.localdomain ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id me4sm14237079pjb.26.2022.02.04.07.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 07:24:25 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 RESEND 1/4] coresight: etm4x: Add lock for reading virtual context ID comparator
Date:   Fri,  4 Feb 2022 23:24:00 +0800
Message-Id: <20220204152403.71775-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204152403.71775-1-leo.yan@linaro.org>
References: <20220204152403.71775-1-leo.yan@linaro.org>
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

