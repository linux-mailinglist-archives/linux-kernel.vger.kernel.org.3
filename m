Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491E959B77D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 04:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbiHVCQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 22:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiHVCQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 22:16:16 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E8522B00
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 19:16:09 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y15so5045101pfr.9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 19:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=gsR63uXiD4J4dRjeMZsAaLt2fDvFcRZsnDNlGseIAjE=;
        b=Pk0rIhqwd8AcUkq5KmJe9mjrUF6uNVfJWfjWUkbfwuQIGmV+U3/UFgPVoh1gYGq+bd
         lbCSRPMb+1x0M86+ymqwzFqN8nb+l68wSITrsmEixSWhlHgDZLB/R0svIyy5MO54R6Ym
         PwVfSVkrB8SoRCQ7vzL1LQZzM9iHBwApzh6vrmeiZsltT6ynaL3sdrb1ZhJGPhmFyOD3
         4s2db1YqPkPeaWJ6qcSkXxuYfgRl3Eokk297cD1GGHz/Q5l5MVSGxbVpp3c4meit/hP+
         bSsrrIKUfzH3yc9hotWq9Z7duppQSn0jH3GGkXZbsN3yxozQbvoh5tqw/X+vXNhleLsl
         cX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=gsR63uXiD4J4dRjeMZsAaLt2fDvFcRZsnDNlGseIAjE=;
        b=HOHcPCk4ASOtghHeID7Onllfy2UXYmYiS7ExjKij6GSBU+H4cK3DYzht9dKrOUrREy
         +gmiF8xqJQIia3KZLyCfElryBVBVPGbX+par2yJJZE5iGZefgcPryLUKgStxQQWYky3Q
         TAOzkD57sbXwHk1fl5Oeg+XQ87RMIEfrzojp7gA84yS3CJqcFW2BGFcoemn9nJBwqX+H
         FXu9ZHIgBhQ1+8T9CC0e+WoispqEyPTfIIo+6GOZNhMA9mAP6ntmDw2Qh4b0x1ZTCD36
         p1fLPBHVN3g9x0huuYa0wp5l97BR+oJ/zkLMvhs/bbz9VcmJPwgXHq6TC0uY0sP14kTp
         Q54w==
X-Gm-Message-State: ACgBeo2idlwXL+UOwDH/hQ6U1tyHhEhqbjhNRe84mU6LpMF2AN+vZxoN
        Vv7satEu20mADWevzrtpTl8G39mY1Q==
X-Google-Smtp-Source: AA6agR796+xdB/mm2oEQUhLS61HVQaOmFzmcD/yNrFj1veXL2aZ9RxDMlPamwMMKooh9so1wCzMtIA==
X-Received: by 2002:a63:4b62:0:b0:421:8c8b:163c with SMTP id k34-20020a634b62000000b004218c8b163cmr14624442pgl.182.1661134569229;
        Sun, 21 Aug 2022 19:16:09 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79723000000b005321340753fsm7312139pfg.103.2022.08.21.19.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 19:16:08 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [RFC 05/10] perf/arm-dsu: Make dsu_pmu_cpu_teardown() parallel
Date:   Mon, 22 Aug 2022 10:15:15 +0800
Message-Id: <20220822021520.6996-6-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220822021520.6996-1-kernelfans@gmail.com>
References: <20220822021520.6996-1-kernelfans@gmail.com>
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

In the case of kexec quick reboot, dsu_pmu_cpu_teardown() confronts
parallel and lock are needed to protect the contest on a dsu_pmu.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
To: linux-kernel@vger.kernel.org
---
 drivers/perf/arm_dsu_pmu.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index a36698a90d2f..aa9f4393ff0c 100644
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -833,16 +833,23 @@ static int dsu_pmu_cpu_teardown(unsigned int cpu, struct hlist_node *node)
 	struct dsu_pmu *dsu_pmu = hlist_entry_safe(node, struct dsu_pmu,
 						   cpuhp_node);
 
-	if (!cpumask_test_and_clear_cpu(cpu, &dsu_pmu->active_cpu))
+	raw_spin_lock(&dsu_pmu->pmu_lock);
+	if (!cpumask_test_and_clear_cpu(cpu, &dsu_pmu->active_cpu)) {
+		raw_spin_unlock(&dsu_pmu->pmu_lock);
 		return 0;
+	}
 
 	dst = dsu_pmu_get_online_cpu_any_but(dsu_pmu, cpu);
 	/* If there are no active CPUs in the DSU, leave IRQ disabled */
-	if (dst >= nr_cpu_ids)
+	if (dst >= nr_cpu_ids) {
+		raw_spin_unlock(&dsu_pmu->pmu_lock);
 		return 0;
+	}
 
-	perf_pmu_migrate_context(&dsu_pmu->pmu, cpu, dst);
+	/* dst should not be in dying mask. So after setting, blocking parallel */
 	dsu_pmu_set_active_cpu(dst, dsu_pmu);
+	raw_spin_unlock(&dsu_pmu->pmu_lock);
+	perf_pmu_migrate_context(&dsu_pmu->pmu, cpu, dst);
 
 	return 0;
 }
@@ -858,6 +865,7 @@ static int __init dsu_pmu_init(void)
 	if (ret < 0)
 		return ret;
 	dsu_pmu_cpuhp_state = ret;
+	cpuhp_set_step_parallel(ret);
 	return platform_driver_register(&dsu_pmu_driver);
 }
 
-- 
2.31.1

