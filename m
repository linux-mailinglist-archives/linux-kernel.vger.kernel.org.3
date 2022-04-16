Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB182503527
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 10:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiDPIXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 04:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiDPIXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 04:23:32 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC19186D6
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 01:21:00 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id h15-20020a17090a054f00b001cb7cd2b11dso9962323pjf.5
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 01:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NkEnEm275rngd2/q28+50K50E6AKNzEfiqSNCbtxByY=;
        b=X4a0qG9RrNbZjFEZN5t46zbUOCH17eVAMhpZ0tr6ZGAaTfXrX/nTDlfd48jsHV5gFu
         4S5rpAYkH4wvcHe+cmPjQfp9ruFAHbizDbTVTRS0ugcnPDiiF/L00sSRh/+B3rcTHJV6
         5SdMbyZXLsmTGVzQeyHbMAvczs7jxt99yNoNlAhZX00QrWx/es5lVL8HIAv6muosVnyx
         yCrVFtK6Z/xlqFNvuf5r+8mxW1b0N3e5qBTr1FPrscBNmzxghj9thuDNgtdJrEYHcfGK
         pTUMhgiawWaaFhn5JMRzmq3Q6Qix6BXGjfmE8vbCEZ2ZfgaEhe7rj6SOLYOCjxth3kru
         KOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NkEnEm275rngd2/q28+50K50E6AKNzEfiqSNCbtxByY=;
        b=f10KJOFLP8xnYOW9yBld8y5npJMgbUkRUoqkgyqhgTyjHeDveC8g8wMsypaqSElQV4
         +/cPVym1QnwrLSlWV2GlYTOqGIfp7Zuar3qXPjkVtIYrh+YCfnVvMrBy6OaV0O+DHBCh
         IgAgR/SB/TmnAsUHIwhrmsosHj4a2GOKSG7RT6uJF2whyDP8FKuRKI1tCFhsVsdV2ScN
         QJqTARs1/FrKImE1UXLWy6dPWG8jQkHkhPCKS5UM43PNixCRhwlej0HdshIEN31AGHu5
         Uw09299Hg2HkF298JhNO6hwjGwu+E+9orpvVuTSeI9mNT/b9wCo6jKcW8qDQ+wmn0Nbo
         q/Aw==
X-Gm-Message-State: AOAM533wZJDzu1qaDTlIUQ1m0ks8Bd99gIDuyczS1ShHt82yti6EktOj
        89N6Sig098d3XV0uiWQ2I9/tRnIszx8=
X-Google-Smtp-Source: ABdhPJyr7TDIIEWCtCSk1I1zJdmKezB7gukMosTGjTIL/FGohd9ahqibIETKaltm5fV2skTYkas0UA==
X-Received: by 2002:a17:902:7ec1:b0:156:17a4:a2f8 with SMTP id p1-20020a1709027ec100b0015617a4a2f8mr2710342plb.155.1650097260062;
        Sat, 16 Apr 2022 01:21:00 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h13-20020a056a00230d00b004f427ffd485sm5727146pfh.143.2022.04.16.01.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 01:20:59 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.xiaokai@zte.com.cn
To:     mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de
Cc:     juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        ran.xiaokai@zte.com.cn
Subject: [PATCH] cpu/hotplug: fix panic caused by empty doms_cur[]
Date:   Sat, 16 Apr 2022 08:20:47 +0000
Message-Id: <20220416082047.2553320-1-ran.xiaokai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

steps to reproduce this issue:
on a 8 cpu system:
1. starting kernel using "isolcpus=domain,4-7" cmdline
2. offline all the housekeeping cpu. [0-3]
   now ndoms_cur = 1 and doms_cur[0] will be with a empty cpumask.
3. offline anyone of the non-housekeeping cpu.

kernel panic whth:

Unable to handle kernel paging request at virtual address ffff80001128e9a1

Call trace:
 partition_sched_domains_locked+0x294/0x348
 rebuild_sched_domains_locked+0x3e4/0x750
 rebuild_sched_domains+0x2c/0x48
 cpuset_hotplug_workfn+0x45c/0x800
 process_one_work+0x1c4/0x498
 worker_thread+0x50/0x420
 kthread+0x114/0x150
Code: 9413028b f94037e1 f8605820 8b170017 (f944d2e0)
---[ end trace 81aa4bc5dcb7a4d5 ]---
Kernel panic - not syncing: Fatal exception

fix this whit a non-empty check with doms_cur[i]

Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 kernel/sched/topology.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 05b6c2a..4fa9bdf 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2558,16 +2558,18 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
 		for (j = 0; j < n && !new_topology; j++) {
 			if (cpumask_equal(doms_cur[i], doms_new[j]) &&
 			    dattrs_equal(dattr_cur, i, dattr_new, j)) {
-				struct root_domain *rd;
-
-				/*
-				 * This domain won't be destroyed and as such
-				 * its dl_bw->total_bw needs to be cleared.  It
-				 * will be recomputed in function
-				 * update_tasks_root_domain().
-				 */
-				rd = cpu_rq(cpumask_any(doms_cur[i]))->rd;
-				dl_clear_root_domain(rd);
+				if (!cpumask_empty(doms_cur[i])) {
+					struct root_domain *rd;
+
+					/*
+					 * This domain won't be destroyed and as such
+					 * its dl_bw->total_bw needs to be cleared.  It
+					 * will be recomputed in function
+					 * update_tasks_root_domain().
+					 */
+					rd = cpu_rq(cpumask_any(doms_cur[i]))->rd;
+					dl_clear_root_domain(rd);
+				}
 				goto match1;
 			}
 		}
-- 
2.15.2


