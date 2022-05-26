Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F4016534E99
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239704AbiEZLwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242594AbiEZLvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:51:40 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DF1D028E
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:51:36 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id c14so1519713pfn.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SuD+IeYmhbuPPKbQaLeWJifIw5WrOViKtE4MNYTGhEc=;
        b=MJJd8mcwXvIYK+3ZoefV3P1LDFLFmU/DxrSHxJ8Vka7Kv6sxUV8BnlK+0vXwRxHixY
         tNBrQt9GXuWP8kXRPSHXCv6ojYuE8EV0NU05t4AK2TH0Xj/6/zPOR9OfDlX/5uP5ANB2
         RmtnwdCPsKZAPGd0uY8O+QTFOYriS/QSf+0EUW2rAxuJzYcRx+DmKDSXggFk4puyrJ+s
         JHcylp38zsVwVlNXaARQe6evH15qH0AkCuKcBLyFVlw1oowL4MePCxaxQIoC1NbcNeRd
         aZUNGKNpirsCqabwjXStlm53jUOOI0DTTtG8Ewl9YaUlHMXCyGXE9T6i3en2Vufvac4w
         4KjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SuD+IeYmhbuPPKbQaLeWJifIw5WrOViKtE4MNYTGhEc=;
        b=l+it0zY3uDpWc00z0kyLwEZ4awaoo4lT+GSUL7CeJ3IUdE6ZTCJELj8FSr02CU2tCI
         DkDmemrlMFwfbYE9d9vzcyvtu085R5bqKxhMmgPpbIzYH2Lf9Q0sZgt45vgFg2Lt/oPk
         Y8hbMDSfVDvY5bs9L+EW/IVYEEpL2YwkVzjF+TsAN+fvDh2sfrDHNN/vGvz0hmXhZhAo
         4h7UfLkkOeXyEuCKlcmL//brelnFojph7IgFREzXqJQNWnwGhwrBV20BXcRFJSQ4mCML
         kZQzE0ANyblx5QkCQmUSdMgoSSPWO4LQoEc9+cHhHrOXv469VPZydhxHJkQX6tOi97e1
         bCRQ==
X-Gm-Message-State: AOAM5331u7Z3LiCGQ0KQnhBjRqEaZ/RyvlDNJVNhYfrnpC5iGJz9A/NP
        SkCsPC/Eea0knJ2A4V/PtS7cdg==
X-Google-Smtp-Source: ABdhPJy+86/Oq5RBDJQwemDyFUTj+4rVrb8/nToo3syC1YcNDL0LwghNJ1zctJtPfY9rpOGF2aVx1g==
X-Received: by 2002:a63:8ac1:0:b0:3fa:d86b:c76d with SMTP id y184-20020a638ac1000000b003fad86bc76dmr7334098pgd.418.1653565895674;
        Thu, 26 May 2022 04:51:35 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id b11-20020aa7810b000000b0050dc762814bsm1317345pfi.37.2022.05.26.04.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:51:35 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] cpufreq: Drop unnecessary cpus locking from store()
Date:   Thu, 26 May 2022 17:21:21 +0530
Message-Id: <0a6620ff5a330126b21d00244d4fad62cff4f230.1653565641.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1653565641.git.viresh.kumar@linaro.org>
References: <cover.1653565641.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change was introduced long back by:

commit 4f750c930822 ("cpufreq: Synchronize the cpufreq store_*() routines with CPU hotplug")

Since then, both cpufreq and hotplug core have been reworked and have
much better locking in place. The race mentioned in commit 4f750c930822
isn't possible anymore.

Drop the unnecessary locking.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 53d163a84e06..bb237d1ce5e7 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -973,21 +973,10 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
 	if (!fattr->store)
 		return -EIO;
 
-	/*
-	 * cpus_read_trylock() is used here to work around a circular lock
-	 * dependency problem with respect to the cpufreq_register_driver().
-	 */
-	if (!cpus_read_trylock())
-		return -EBUSY;
-
-	if (cpu_online(policy->cpu)) {
-		down_write(&policy->rwsem);
-		if (likely(!policy_is_inactive(policy)))
-			ret = fattr->store(policy, buf, count);
-		up_write(&policy->rwsem);
-	}
-
-	cpus_read_unlock();
+	down_write(&policy->rwsem);
+	if (likely(!policy_is_inactive(policy)))
+		ret = fattr->store(policy, buf, count);
+	up_write(&policy->rwsem);
 
 	return ret;
 }
-- 
2.31.1.272.g89b43f80a514

