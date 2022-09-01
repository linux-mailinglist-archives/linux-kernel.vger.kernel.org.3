Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21035A9842
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbiIANNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbiIANMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:12:25 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346DC10F1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 06:11:34 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id w88-20020a17090a6be100b001fbb0f0b013so2491425pjj.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 06:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=zDuc296oUyLkm2+WK0v0ZsSxZqcMqtpAHljnuoWPZ4o=;
        b=Fq6DJ47R4GHej7ps6IcYw6+Yc5tbxEqldlwHumSb3bJNoJqqoB3xUPnxNxOZ2JPS/f
         8I/ZMazCmftLVX+Radj8EKMmCdtI5ntRgY0cDcaPMg2KyvFAhKpDS+XPQPQoS4/k5MR4
         ECAE1RmqDFadD5lhSyqqTWk222TZJusVmu+WnpaoI/4NWDuMXLFQIxDXfSojd9p/DO+D
         pAVXBVi2Zz27vWffJdn9uoz/rBoi7Aq047tjpGvJdbpcXKc/34DzcBx8AHhPDoqdmhrs
         Ua4Hgw51HLx7fom9cR9TJm44YPVvtaH3dLm/Lp9GCi+7dmpMMkj4h+wQtefkwu4oMYRM
         XOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=zDuc296oUyLkm2+WK0v0ZsSxZqcMqtpAHljnuoWPZ4o=;
        b=zZZkugeggKHzOg9ZAmtpmwaTSsp/8okBixg9eSqZRbMATuusZNZEd139LmBNs3jQrz
         qWtPrdk5G45ztZ9moCODTCloUkJl9+rOfbBaSRUXP6bkNQknsAVprE73DKSjwQa90qR5
         0hlQiL5h2NZwWBpiLbDGsqP9WXC+LCU2rdKWbHSYwNMKc+he4+J3sPRHQWoX3Rlfi7As
         FPpRgUPVL8LhRBf6etU0HThsbQ+tk07SKRYXuqpnT48H2l0/KRyRJd/7uJi9hGj/UwJa
         t6W0zvaAMq7dJKhzc3F3np+IGa/ty1iOEicI1ody80k6IA6xCWvQZtCUgwVrnoKYgkZJ
         ivrw==
X-Gm-Message-State: ACgBeo3J3WznQAJ4gR2tb3eGp2pdzNpTY4BNJLgpQIOxVP4i+ddWJh+C
        aDecgHl+nrdjP6NS/CJkX62bSw==
X-Google-Smtp-Source: AA6agR5oK3YFVNiNSBrXbGWKPKraFcrmGQAv1VfRIpzfDpZwHHtJPoj/J/2LWkSVF4WgTOtY1oaIYA==
X-Received: by 2002:a17:902:ea0e:b0:16f:11bf:efe5 with SMTP id s14-20020a170902ea0e00b0016f11bfefe5mr31220478plg.57.1662037893749;
        Thu, 01 Sep 2022 06:11:33 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.252])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d50400b00175111a277dsm6221156plg.185.2022.09.01.06.11.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2022 06:11:33 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH v2 2/5] sched/fair: avoid double search on same cpu
Date:   Thu,  1 Sep 2022 21:11:04 +0800
Message-Id: <20220901131107.71785-2-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220901131107.71785-1-wuyun.abel@bytedance.com>
References: <20220901131107.71785-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The prev cpu is checked at the beginning of SIS, and it's unlikely
to be idle before the second check in select_idle_smt(). So we'd
better focus on its SMT siblings.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
Reviewed-by: Josh Don <joshdon@google.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9657c7de5f57..1ad79aaaaf93 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6355,6 +6355,8 @@ static int select_idle_smt(struct task_struct *p, int target)
 	int cpu;
 
 	for_each_cpu_and(cpu, cpu_smt_mask(target), p->cpus_ptr) {
+		if (cpu == target)
+			continue;
 		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
 			return cpu;
 	}
-- 
2.31.1

