Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E9A5B02C4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiIGLUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiIGLU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:20:27 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A8F83BC0
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 04:20:26 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id iw17so7543928plb.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 04:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=75oh6xQWlTnSSymHGyItVY3zWSzkWl5meciwNnzeuy0=;
        b=PdxzqPPzNxrao+KcCVwt2ythahQZX8MMyQBWw2fuFSGEHMrh6N/zQO/9BwzPDL6cQ5
         fcSu/krE12h5g7NkLUoQnzrIrPFOzyVjYTce5N4zhFJ7zUgcbd22dO/x0W69vsmb0yiq
         vN3kn6NjF5Qm460FtxPADuHzw5e7pnOBOlakfT+xXDR54tp59bcYDYLPa3S06q1XXoVi
         uZnnirxkh+tklpOVjtip5mu1eR92LpsXkF3IYzWfQJQVTJ1pnpPf7HJa1BMhnvRtJ5ni
         gw4oc1LzlPuS3NyO197z6LhaG5A7wE/rh19p2yUYsNdsuH8mmKa5wl/moNchiSwEnbiS
         kdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=75oh6xQWlTnSSymHGyItVY3zWSzkWl5meciwNnzeuy0=;
        b=RuVFr7inTJfYCbVIz9CZxd+yO5RMq4XNs+wxLCnDo2+2CWU046m1iHKSIKDZodJpT2
         ttdRhZ2jIULv0muhErkEIfz+JNs0EislSylbXbUHO/xzGCKWiOQwEiQlwM1c9RdZdbG3
         bVUotLDo+IzjAh7rAu2RfRAK/2t8IU9UkvxkpQ+WuEFN1r2QweN60Luze33poawQaeL5
         +0beNABGYaTiR5aWZfegoqllFKmJEDk+u9KHaho6apVp6uKf+gQKLblV1temWwdyuBxd
         YA7L3iG69XgTyo54pKyjXMGVKZJerCHr1DhSb/A0/UQhyy+uCGxCOITOeyY/83scgbIU
         LeRA==
X-Gm-Message-State: ACgBeo2o2YyATKv+ROPqWwfLFnHlK+cJqaQGyw5tVD2hkm4trIDqwmit
        TJ/e6lUyw230dWHWWgsL40f5VA==
X-Google-Smtp-Source: AA6agR4GX94IaU6dQoeitqb7LX4chBXmrXy90EVoZ0eQdBctRNpyeB6hnT7s/7zVCpyVOHFUH6Xg8Q==
X-Received: by 2002:a17:902:bc84:b0:174:505b:2d67 with SMTP id bb4-20020a170902bc8400b00174505b2d67mr3393134plb.33.1662549625548;
        Wed, 07 Sep 2022 04:20:25 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id d12-20020a63f24c000000b0042ba0a822cbsm10334731pgk.8.2022.09.07.04.20.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Sep 2022 04:20:25 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH v4 2/5] sched/fair: Avoid double search on same cpu
Date:   Wed,  7 Sep 2022 19:19:57 +0800
Message-Id: <20220907112000.1854-3-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220907112000.1854-1-wuyun.abel@bytedance.com>
References: <20220907112000.1854-1-wuyun.abel@bytedance.com>
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
2.37.3

