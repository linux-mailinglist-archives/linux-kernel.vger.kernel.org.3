Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FA65260B9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 13:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379783AbiEMLJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 07:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379766AbiEMLJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:09:08 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7544F26C4DE;
        Fri, 13 May 2022 04:09:07 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id h3so6547255qtn.4;
        Fri, 13 May 2022 04:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7D8erwxOxrNwpL4kTMFZcWrJ5A/nWK5FWS+W1RtdNck=;
        b=PrYGICVhGTuengtryu36R642ZDAMVMtPk+eeETtYf2Cmfiw7mG7AGNsDQziNNnoIjo
         kh0QePFTODZMi99cysCpYNZIPSYqjFjyeNSwfgMtlVQZlXs3kVYlyF64y+jhDP5uO/XU
         XN95A7caOX4ZFmvvQasyvYYnVuvprWRvdPhVyBSWb5h/Kx6N+MJc4MKeGrt5QJbnRbK5
         gHrKUl9rvVPpqkxUDK3PmpXXz7Vxd5rd/4HBlT/2rmGYRxGMx+18ohxiFLx/ptQ5eLK9
         Y3c3QOgxsLZ7+GvAHHVPAfQFyjK5f/MrdTOxcDTQDs5fs0rCq1mmRReqDQ8F06orNO+9
         V/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7D8erwxOxrNwpL4kTMFZcWrJ5A/nWK5FWS+W1RtdNck=;
        b=nxxV0+E3PETpsc2VbU5Yxfse/hObaEGumQFdp5rpa5F7qr8wQAd8gUeWlbYwNEDBDX
         TjshREhw6QyMt/9XxSpY35PVEpJapAxbBhufb/SyaGC1AjH0B+J0LqEPzfL2+Nmm9YET
         t0VnmRn/p5XXIT+nuE5uD7fFEon7l8gRAV3Fo8FOT9fiIiWVstmef5Kjck0wFwlV6UHs
         KGMWu1GlEiqygcevnJ7ONJUBDFN072CkP1g7AzUVUh6Mjc5zzi7UI/bHoK4seYWxrac1
         XBVrD1cxhCIr6FxhMz3tM78VBTW72LWgnrToDh1/N8CSvyDj6XTzT3MIbo83q0Wp8jPf
         aaiw==
X-Gm-Message-State: AOAM532Lbxzv2m4sOSwMTEk+w7fIqkGzbpbyhEtSVTedE9b7I0Xgcoob
        eYOPnBykOHPm89ZUxKaFBlqM4LmGcdv6p/BK
X-Google-Smtp-Source: ABdhPJwCPd/MZyxOTX9dBYJL13str88G6bqD0TbvkdvtpdFYPqLm6Tda1ye9Cbbcr5wt9hwqcIQjNw==
X-Received: by 2002:a05:622a:14c7:b0:2f3:d2ee:a676 with SMTP id u7-20020a05622a14c700b002f3d2eea676mr3926585qtx.604.1652440146548;
        Fri, 13 May 2022 04:09:06 -0700 (PDT)
Received: from MBP.hobot.cc (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with ESMTPSA id b16-20020a05620a04f000b0069fd57d435fsm1127548qkh.101.2022.05.13.04.09.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 May 2022 04:09:06 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        schspa@gmail.com
Subject: [PATCH v5 2/2] cpufreq: make interface functions and lock holding state clear
Date:   Fri, 13 May 2022 19:08:48 +0800
Message-Id: <20220513110848.20204-2-schspa@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220513110848.20204-1-schspa@gmail.com>
References: <20220513110848.20204-1-schspa@gmail.com>
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
index ba73be6f0490..0f0f202f9a05 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1339,12 +1339,12 @@ static int cpufreq_online(unsigned int cpu)
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
@@ -1384,7 +1384,6 @@ static int cpufreq_online(unsigned int cpu)
 		cpumask_copy(policy->related_cpus, policy->cpus);
 	}
 
-	down_write(&policy->rwsem);
 	/*
 	 * affected cpus must always be the one, which are online. We aren't
 	 * managing offline cpus here.
@@ -1536,7 +1535,6 @@ static int cpufreq_online(unsigned int cpu)
 		remove_cpu_dev_symlink(policy, get_cpu_device(j));
 
 	cpumask_clear(policy->cpus);
-	up_write(&policy->rwsem);
 
 out_offline_policy:
 	if (cpufreq_driver->offline)
@@ -1545,6 +1543,7 @@ static int cpufreq_online(unsigned int cpu)
 out_exit_policy:
 	if (cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
+	up_write(&policy->rwsem);
 
 out_free_policy:
 	cpufreq_policy_free(policy);
-- 
2.29.0

