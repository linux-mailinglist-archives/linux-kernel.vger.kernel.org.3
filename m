Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0669524ED6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354731AbiELNw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354722AbiELNws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:52:48 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4E66541F;
        Thu, 12 May 2022 06:52:47 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id 185so4627717qke.7;
        Thu, 12 May 2022 06:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EntzcyMJqmyoVwB2wFomh4Orbg1WQwtLfJblu/8zhGs=;
        b=SUc7k2sPrY6R3kV27omjPGQxBeNTkELcBzbTdTAtrEDCXV3NlJvvfIKu/5Hic7Xd4E
         rwv62gGkHlV4LUeq0pD16Wgi3qqe2nO3WLcmEnVRg680ZEL64VwRTzM5jYd4t7w+ruFF
         zbPQysckaTyoENbAf2HJp9/eHw0UPwWQvX2IflxfXtmNVqfSVZ3COKfO/wi2+7OMxuva
         bF5kiFUwhysPKcEHgphPmCf+Ok0p5RF6180iGE3+bOsx9vB27EjIcGFPfNaTeViAA3OF
         IjSWkUpSoJmLWheYkCA8GVGeYlNAQB8H8oERZA6lwtPRr9IO5WkdBPZNyz38Gd8kEMWA
         rrfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EntzcyMJqmyoVwB2wFomh4Orbg1WQwtLfJblu/8zhGs=;
        b=Gdz4GXA9soUWZlaiESJv5g1AFkr+Bu4s/7VwGqIeDA83PimUe8w4sT2SW5pwI8sapq
         WkF91VqiecV+qAnI409U/3luH+QY/OQZ3rOABQCVd7p1iJ0wN5bALK8O28Uj5lcYahA1
         jAwdDu3F5nyppAyu7cmpDErcdg0aFtPT8cLn27v00pMXdyAyMVjq2b3Ck3SHex6avMBp
         1xe1vb7vj7Ot6vVUJ1muzDPLRJFEG+Ogdf5nlH/Wjb26u/zzl4rKilZ2RCttgFzI13Wz
         O7/bQFwwuyyWU2EV9jvkLr8r6H1GRMGuwwUU5nmEtytIFjyY26dyRw5nF3JKjjFOxYYg
         jmcQ==
X-Gm-Message-State: AOAM531bTC05PciEceJ2pgE3RG3XFxnC6fA8qNTFWUBr1dUuyFhqnwST
        UDpqkKW1wVOjXKLU3JU2LIkE1SrcaX/kmWkF
X-Google-Smtp-Source: ABdhPJyWjQ589PYbNcdgdqT2LVWIuiQFWeroqxIVMiytvY7GX6A58YzaHho5Vo1MvGtx+4zLvGoNug==
X-Received: by 2002:a37:63cc:0:b0:6a0:c68b:b06d with SMTP id x195-20020a3763cc000000b006a0c68bb06dmr8741580qkb.90.1652363567040;
        Thu, 12 May 2022 06:52:47 -0700 (PDT)
Received: from MBP.hobot.cc (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id r204-20020a37a8d5000000b0069fc13ce1e8sm2885591qke.25.2022.05.12.06.52.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 May 2022 06:52:46 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        schspa@gmail.com
Subject: [PATCH v4 2/2] cpufreq: make interface functions and lock holding state clear
Date:   Thu, 12 May 2022 21:52:31 +0800
Message-Id: <20220512135231.10076-2-schspa@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220512135231.10076-1-schspa@gmail.com>
References: <20220512135231.10076-1-schspa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpufreq_offline() calls offline() and exit() under the policy rwsem
But they are called outside the rwsem in cpufreq_online().

This patch move the offline(), exit(), online(), init() to be inside
of policy rwsem to achieve a clear lock relationship.

All the init() online() implement only initialize policy object without
holding this lock and won't call cpufreq APIs need to hold this lock.

Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 drivers/cpufreq/cpufreq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 35dffd738580..f242d5488364 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1343,12 +1343,12 @@ static int cpufreq_online(unsigned int cpu)
 		down_write(&policy->rwsem);
 		policy->cpu = cpu;
 		policy->governor = NULL;
-		up_write(&policy->rwsem);
 	} else {
 		new_policy = true;
 		policy = cpufreq_policy_alloc(cpu);
 		if (!policy)
 			return -ENOMEM;
+		down_write(&policy->rwsem);
 	}
 
 	if (!new_policy && cpufreq_driver->online) {
@@ -1388,7 +1388,6 @@ static int cpufreq_online(unsigned int cpu)
 		cpumask_copy(policy->related_cpus, policy->cpus);
 	}
 
-	down_write(&policy->rwsem);
 	/*
 	 * affected cpus must always be the one, which are online. We aren't
 	 * managing offline cpus here.
@@ -1540,7 +1539,6 @@ static int cpufreq_online(unsigned int cpu)
 		remove_cpu_dev_symlink(policy, get_cpu_device(j));
 
 	cpumask_clear(policy->cpus);
-	up_write(&policy->rwsem);
 
 out_offline_policy:
 	if (cpufreq_driver->offline)
@@ -1549,6 +1547,7 @@ static int cpufreq_online(unsigned int cpu)
 out_exit_policy:
 	if (cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
+	up_write(&policy->rwsem);
 
 out_free_policy:
 	cpufreq_policy_free(policy);
-- 
2.29.0

