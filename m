Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B35755CC96
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbiF0KyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 06:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbiF0KyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 06:54:12 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62471640E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 03:54:11 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id w24so8872174pjg.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 03:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F9yQ08wbjOQZUv+8jgi3PDPzIspMo8FaCiOBj4xP6E4=;
        b=YQWZ3s7740+dkkYO1J9fZAjwhos1M8HnkAw5WmSibz88i9znYQGE9lGhbIyLldGrBF
         b6rQbIPdNNid4hR13Nus1tUA5LsPVdbwfhuTF9OePGob9EOPHMY1BEu+H6NrNvPBjydk
         XdHYwMQ4mDOkQ0LoULipaUR3rO0NWmGM84UrmPt52V8kzJSW4mn1uo2xK2CdygidPq/2
         k7vieN6Kk82pOx287qKu/mgTDrvkZoKvJyVnVFWd5hd2F77X8gV3NqjaoKDjIw99Wigx
         9BFRzpkg7pehlzTUeBAgFxhSHattWK9WnrQ9lFIpA34jiOz0XPOLTZBP28I+er7M1tt+
         7y/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F9yQ08wbjOQZUv+8jgi3PDPzIspMo8FaCiOBj4xP6E4=;
        b=zLDGNa+tAks1OTl/LByvFFsLAa+rgGAr9i6GUedDryh12Qb3tQCu35dbtweL4P1+sM
         VXmYTxWEfF4RwQYz/xgs67+4+qzoGeqcrrKxMd378bZl0zhq+tASrI1aR63HPzhVd5nT
         XyykCn2LKWhyIZiUra6tDoIvFejPjZNJJh/VYIs+3qQ+Sh/cysdmCMr9sTvP/RCLgnWP
         k0jcUqAeBYKjIvciigj6+9vBrqUIL2AdN4xjxnMTlLK8iWXGBH+EpresHqMgt5I8l4h3
         ucxSxppuKpcIPii7EepsTwBvQM4S0+VcXorWuUN2IS0fGP8yM+5PsmgcMgm7APsP0dpw
         5bzw==
X-Gm-Message-State: AJIora8TLCPd+w7zFJfoGp5Dc49jo2AHm18zk5Lo6J1jHaeFATWx3zK6
        kuc/UVwlSRTTAzCbMbte+KWcoQ==
X-Google-Smtp-Source: AGRyM1sh9jbGVV3U6n1SdSQh42GnhdxVnYgeVUW1Qe46ifBusJqOlDmhmiWkh37cDyaPmeHVL+Qicw==
X-Received: by 2002:a17:90b:3a89:b0:1ec:93d2:f47d with SMTP id om9-20020a17090b3a8900b001ec93d2f47dmr14933479pjb.139.1656327250923;
        Mon, 27 Jun 2022 03:54:10 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id t10-20020a62d14a000000b0051b90ac6c15sm7017777pfl.125.2022.06.27.03.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 03:54:10 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH] sched/topology: Optimized copy default topology in sched_init_numa()
Date:   Mon, 27 Jun 2022 18:53:49 +0800
Message-Id: <20220627105349.80715-1-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The size of struct sched_domain_topology_level is 64 bytes.
For NUMA platforms, almost all are multi-core (enable CONFIG_SCHED_MC),
That is to say, the default_topology array has at least 128 bytes that
need to be copied in sched_init_numa(). For most x86 platforms,
CONFIG_SCHED_SMT will be enabled, so more copies will be required.

And memcpy() will be optimized under different architectures.
Fortunately, for platforms with CONFIG_NUMA enabled,
these optimizations are likely to be used.
So, let's use memcpy to copy default topology in sched_init_numa().

Tests are done in an Intel Xeon(R) Platinum 8260 CPU@2.40GHz machine
with 2 NUMA nodes each of which has 24 cores with SMT2 enabled, so 96
CPUs in total.

Use RDTSC to count time-consuming, and based on 5.19-rc4.

Enable CONFIG_SCHED_SMT && CONFIG_SCHED_CLUSTER && CONFIG_SCHED_MC,
So the default_topology array has 256 bytes that need to be copied
in sched_init_numa().
                     5.19-rc4   5.19-rc4 with patch
average tsc ticks    516.57      85.33   （-83.48%*）

Enable CONFIG_SCHED_MC, So the default_topology array has
128 bytes that need to be copied in sched_init_numa().
                     5.19-rc4   5.19-rc4 with patch
average tsc ticks    65.71       55.00   （-16.30%*）

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
---
 kernel/sched/topology.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 05b6c2ad90b9..c6f497d263cd 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1918,8 +1918,7 @@ void sched_init_numa(int offline_node)
 	/*
 	 * Copy the default topology bits..
 	 */
-	for (i = 0; sched_domain_topology[i].mask; i++)
-		tl[i] = sched_domain_topology[i];
+	memcpy(tl, sched_domain_topology, sizeof(struct sched_domain_topology_level) * i);
 
 	/*
 	 * Add the NUMA identity distance, aka single NODE.
-- 
2.32.0

