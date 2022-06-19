Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FCB550A7D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 14:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237060AbiFSMFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 08:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236999AbiFSMFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 08:05:33 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B954910551
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 05:05:31 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id f16so6533372pjj.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 05:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7yHMFqrpDoGhsUBFFuG/t0+9zUYaObGcD9IoHIQWIsE=;
        b=QLyrlDSRfFQAY8o/woQAVrzpPAlujEGqvIF3ZR5UeS3sG0WopkjWZD5U5PqQrA4m/m
         pvTECNJXhCSb2BDedJzI1bLrGZoWEKezmaHns6vuFnQX7k7lGpknWNJvtTR06Lme9zVr
         gE5HriRvNvsLBtIP2jn4JDNSpp0UKK/cnEp+ckeRQtYuE9mHuta995F0FAJg0twhHaCP
         pxxN3qmMfr7Pv3y8tiKAJ1Z/g0cPHuXeXvExWqZ9hKM1YJX6/Fqt8eVEwFZRK9b0TF8F
         XDIJ1Oj+HFHV5zM8U+DKzRO0cX0KmQRx+rdPmsXjbLf5Et6fFkHQsdqRz0nr9rFa1D2U
         t0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7yHMFqrpDoGhsUBFFuG/t0+9zUYaObGcD9IoHIQWIsE=;
        b=Din7PATxVsRHKncHR50R/EebWQIMBLzO3Y/DxeztuB5gLY+nBYLgETw+twEoy4BkCV
         soKv0vdAKHzJnIpgglICjlI2qEwZjAu1LSi4i6H5AndAjH4ggaoPp/4PlXh0M9er50vm
         2750TMUmxdOmov9Sbws514i5frzDxAjkHEAEkegWu78T6w1BKLZjudbUnRVY8k/cqW7U
         ddI7dNJ5a7aZkH0el8YAqG0obnOjnFIesbwYI70WJWBJUjkdVuOotOxEj3K1iZFtoVgP
         2aDyBP+X6iHL3Zvgr7Cbz9rLJ7ffZbyM7UybqP6x0Ftj09jjzj3cCpH3CXC/QN1jE/ZV
         ZlTQ==
X-Gm-Message-State: AJIora+8W/lMwbSWSyIwmtrgrtbT2hFj/CiMPIk8cdPGd8HVviuxzusx
        rnrEZp+EosfnG/lQmp6pseiVLg==
X-Google-Smtp-Source: AGRyM1uKify4SdjsMoflUgI07q1qfvBrR1MF+dO3HxBYZp8wLDO17w5ahoIJFJyART/ASMU+xbEOnA==
X-Received: by 2002:a17:90a:fd13:b0:1ec:7a40:3b5 with SMTP id cv19-20020a17090afd1300b001ec7a4003b5mr12625505pjb.8.1655640331252;
        Sun, 19 Jun 2022 05:05:31 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id cp16-20020a170902e79000b0015e8d4eb1d5sm1594038plb.31.2022.06.19.05.05.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jun 2022 05:05:30 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v4 3/7] sched/fair: avoid double search on same cpu
Date:   Sun, 19 Jun 2022 20:04:47 +0800
Message-Id: <20220619120451.95251-4-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220619120451.95251-1-wuyun.abel@bytedance.com>
References: <20220619120451.95251-1-wuyun.abel@bytedance.com>
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

The prev cpu is checked at the beginning of SIS, and it's unlikely to be
idle before the second check in select_idle_smt(). So we'd better focus
only on its SMT siblings.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 kernel/sched/fair.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e57d7cdf46ce..aba1dad19574 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6290,6 +6290,8 @@ static int select_idle_smt(struct task_struct *p, int target)
 	int cpu;
 
 	for_each_cpu_and(cpu, cpu_smt_mask(target), p->cpus_ptr) {
+		if (cpu == target)
+			continue;
 		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
 			return cpu;
 	}
-- 
2.31.1

