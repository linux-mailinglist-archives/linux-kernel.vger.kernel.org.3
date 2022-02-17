Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98F74BA4BD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242705AbiBQPov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:44:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiBQPok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:44:40 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FDE2B2FCC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:44:26 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id i10so4918971plr.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pcumJNf5Ae0cpSONOSikL4F3HHoR7gzQ3j0ko1H1EYA=;
        b=xLqXVTBfwLXvvTwxShJClcJY4H8/n4Dqn/yUpBEFJAPWMFjImM+6x+J+4mkmQeqt+7
         h7mp1wbiJl7SpeCswHgbeBkTtiao16nAFFdBKb5sYqs04D27N0wnSvqCG0lEnHW7qjMj
         qIkPaIxZS3cTaL+U8TlPKtfoz2N2mi0lc9u2iwfebOcTbK4n3nm+BiS3MwbkzQBEDPq/
         AKTVSSXHd9HBZ1UXqLy4f1qs4y81wC/05kXptRdBgQuiorpMSunM6yBfu1TX1ue7uNJ2
         MdwGaQ4ULsA4EciMsYHnUOYT6GlSXiELVdPGMaQQ7jgJJBXQe67mxgYdVscdCWnZ6JIq
         Zf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pcumJNf5Ae0cpSONOSikL4F3HHoR7gzQ3j0ko1H1EYA=;
        b=m6nSVJS26FCvOUS1eO+/XnYGW+8Qs0fJd2UnQGMpq6OZYcI3Cz+cK3tYIljVy57h59
         Rkpkz5LPIyASfZ0HkZrP0s/YeDm6iO+n7dRNHPgsAutyQtK7AJaT5TMELdhKdUEkwbOI
         DtUFBgKGO4Qn65GRHhZqwc+7Gl630+4ikl4SO6BCZoACubO/SqvN7QwRIKIPdlYW+Jgs
         n3qa9xU2zbDc+Ff6t3XtObhgvTEamBSesuWtkR7chRkv5YfUe31LTH76rOVgC6leaJFi
         jq13ukpMSEi3bAhW0YgIxkV1K8pbVKFSz41HIc97jY6nM3BN11sCUJdNpK31eQkGsJR9
         QOSg==
X-Gm-Message-State: AOAM533o4xHFPBeO+yFVGZH7O34uVQ+q6p96b3fDa3jurm8EAGMNLAN6
        83g9Jqhq7X0k8DuHUPNG3hpWAA==
X-Google-Smtp-Source: ABdhPJwn0A6Ux0vWlggtaXcNdCJX/IVUFtMdq4N4cAnTHmRnk7Job/RoN/HtukkC3LnXh5iniu1cBA==
X-Received: by 2002:a17:903:110d:b0:14d:85b2:4b36 with SMTP id n13-20020a170903110d00b0014d85b24b36mr3327997plh.75.1645112666141;
        Thu, 17 Feb 2022 07:44:26 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id s6sm24108pfk.86.2022.02.17.07.44.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Feb 2022 07:44:23 -0800 (PST)
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
Subject: [RFC PATCH 3/5] sched/fair: add stats for sched-idle balancing
Date:   Thu, 17 Feb 2022 23:43:59 +0800
Message-Id: <20220217154403.6497-4-wuyun.abel@bytedance.com>
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

To better understand the behavior of sched-idle balancing, add
some statistics like other load balancing mechanisms did.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 include/linux/sched/topology.h | 5 +++++
 kernel/sched/fair.c            | 6 +++++-
 kernel/sched/stats.c           | 5 +++--
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 03c9c81dc886..4259963d3e5e 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -150,6 +150,11 @@ struct sched_domain {
 	unsigned int ttwu_wake_remote;
 	unsigned int ttwu_move_affine;
 	unsigned int ttwu_move_balance;
+
+	/* sched-idle balancing */
+	unsigned int sib_peeked;
+	unsigned int sib_pulled;
+	unsigned int sib_failed;
 #endif
 #ifdef CONFIG_SCHED_DEBUG
 	char *name;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 070a6fb1d2bf..c83c0864e429 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10330,8 +10330,10 @@ static void sched_idle_balance(struct rq *dst_rq)
 		if (cpu == dst_cpu)
 			continue;
 
-		if (!cfs_rq_overloaded(rq))
+		if (!cfs_rq_overloaded(rq)) {
+			schedstat_inc(sd->sib_peeked);
 			continue;
+		}
 
 		rq_lock_irqsave(rq, &rf);
 
@@ -10375,10 +10377,12 @@ static void sched_idle_balance(struct rq *dst_rq)
 		if (p) {
 			attach_one_task(dst_rq, p);
 			local_irq_restore(rf.flags);
+			schedstat_inc(sd->sib_pulled);
 			return;
 		}
 
 		local_irq_restore(rf.flags);
+		schedstat_inc(sd->sib_failed);
 	}
 }
 
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 07dde2928c79..3ee476c72806 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -164,12 +164,13 @@ static int show_schedstat(struct seq_file *seq, void *v)
 				    sd->lb_nobusyg[itype]);
 			}
 			seq_printf(seq,
-				   " %u %u %u %u %u %u %u %u %u %u %u %u\n",
+				   " %u %u %u %u %u %u %u %u %u %u %u %u %u %u %u\n",
 			    sd->alb_count, sd->alb_failed, sd->alb_pushed,
 			    sd->sbe_count, sd->sbe_balanced, sd->sbe_pushed,
 			    sd->sbf_count, sd->sbf_balanced, sd->sbf_pushed,
 			    sd->ttwu_wake_remote, sd->ttwu_move_affine,
-			    sd->ttwu_move_balance);
+			    sd->ttwu_move_balance, sd->sib_peeked,
+			    sd->sib_pulled, sd->sib_failed);
 		}
 		rcu_read_unlock();
 #endif
-- 
2.11.0

