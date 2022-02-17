Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3453E4BA4BE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242713AbiBQPpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:45:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242696AbiBQPop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:44:45 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824742B1025
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:44:31 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d187so5254753pfa.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RKkQi9dMA8sF35J+wiDdn1p2PDGkj85iaPf+444HF4E=;
        b=E0gO/iytRoHMUaWWM1mxd8l8f0NtDzy9w0nEZLnf7yorta0WAiPMdLmM7Wv9YOfoo/
         k0oC/D0/DjZY4dStf+gorxnkSjtbyiPi4vOEdCzVEjGxlEwDbS5NIq+rP7EiGnPFATuK
         fNCyEaulD7GXYGC9LC6obH6sCG6wUZXsUR6JspdSH0uke1guQiM3brqeYOWDkbF76zWW
         ECO7+Cs4N+cbHSEjW8BtRRtD+juobpxS3/zcQ7nH9atKRl40ax49KMMX+xhSvLmkuZ4H
         Gv4q46pVtm2ZL0opphURbIpB6bzs1l561oNKFtf1H7M7Scdn68MWNRAwZZYctatcUe1J
         Ubyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RKkQi9dMA8sF35J+wiDdn1p2PDGkj85iaPf+444HF4E=;
        b=HzChMkCiVPEhx0rSsQdRamIMwqUpEMa+Ud7aC0t6vM8PPO2fIetQaxoVFpf7T0WpXv
         C8NhTjYZxXVPoztytkv7eXJbEewxms71pZUeSa5GA2/p0NO9rgOEhhHQybbt+ztOMaMa
         ORozOoou+q+q593AWq7oFa8AkHCjJszbvWlU9ntAw5jxMwEZoWMhiwtJHJ+cpJ1oQMJs
         2P4bYGtXiQH4Wx7UcykydoJJ5hTio5LV8Vx5/+8RZHUbB91BFLFh+32CQ63aLL65EU0U
         l1vTzNizwmsRGQNnb43U6UTAxuv1iR+ClEguO7kCmsXk6iOisQYkemMj4DaCDOht7zpP
         5Y6w==
X-Gm-Message-State: AOAM53257O6YEWLa5gp6mW11EI9OdXC26EH6TWkd0eIZ8ktxgeqpv654
        i+6fTU44ZHafOJShwVQUyL+8Hg==
X-Google-Smtp-Source: ABdhPJzUYvCnnJhJgaMqTONin63sSutNin9KcezQzLFNRjL19K1ZsgzeT6dAFZv8BWgHEpmCx1rwxg==
X-Received: by 2002:a05:6a02:184:b0:373:a24e:5ab with SMTP id bj4-20020a056a02018400b00373a24e05abmr2895106pgb.400.1645112671092;
        Thu, 17 Feb 2022 07:44:31 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id s6sm24108pfk.86.2022.02.17.07.44.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Feb 2022 07:44:30 -0800 (PST)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/5] sched/fair: filter out overloaded cpus in sis
Date:   Thu, 17 Feb 2022 23:44:00 +0800
Message-Id: <20220217154403.6497-5-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220217154403.6497-1-wuyun.abel@bytedance.com>
References: <20220217154403.6497-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip overloaded cpus in SIS if any. This improves idle
cpu searching, especially under the SIS_PROP constrain
that search depth is limited.

The mask of overloaded cpus might not be quite accurate
since it is generally updated at tick granule, but the
overloaded cpus are unlikely to go into idle shortly.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 kernel/sched/fair.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c83c0864e429..1d8f396e6f41 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6273,6 +6273,9 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
+	if (atomic_read(&sd->shared->nr_overloaded))
+		cpumask_andnot(cpus, cpus, sdo_mask(sd->shared));
+
 	if (sched_feat(SIS_PROP) && !has_idle_core) {
 		u64 avg_cost, avg_idle, span_avg;
 		unsigned long now = jiffies;
-- 
2.11.0

