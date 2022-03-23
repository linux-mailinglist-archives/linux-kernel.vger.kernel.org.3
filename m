Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970804E54A8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244950AbiCWO5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244941AbiCWO5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:57:38 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC4B8165C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 07:56:09 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id qa43so3328662ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 07:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ocZ020biSSlMCzLyHzrYyXSRMNycQFiAPnqhwZV8Jo=;
        b=ToXuI8M/+8sDxN7w3MxP2P8OJelARc/TEu7LTms49PxLD3X8ufyrk6AZFIJYptu97f
         t718JP97xCJnh5iU+PKgahb5HYzvQaNodRYaspB53ZW5Szp69qqAYj5u1/WAlEmTky3J
         pu0TJ4VcwtC4yHyk7FCC2Jj0NseTlZevPA7RQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ocZ020biSSlMCzLyHzrYyXSRMNycQFiAPnqhwZV8Jo=;
        b=o+5H46c2LJeKcycfuCqzISBQph0ASsDE4gUiiQZ9RTNCx1Nx8AJ33RCo2Mg98iR2UL
         jmzaipnW4xY8aeF+yKNrYp4nzfbDEs0BUyQWBeSRJle+TTUQ+iKb6eFwPkalHbrCyhDy
         pMqM62coMa3g1ZWNKHy74U+g7AiXz1TjvGts1KMHdJFuzK4O5SY9mPM4GcqmLIyJzfG5
         w86Peg6Xl6Bq/WOx+eeX4HggAzq1M+ZqGBF9NxubvNZZsheqNfJS+OyoA4qLlT+eCWpz
         0vJOpzla7LbmBaSNAJZXJXr2J0LwovALwejwuCT8TQGTRnBh+VDXL2wQ+0ZlILqzbn8g
         tuww==
X-Gm-Message-State: AOAM533wEBicc/zjutKZq4uONW7GsS4IlsblH2iSRh03F+ZJVi+9zEon
        EXYBreSBc6ij4JAcpQmkwvpt2A==
X-Google-Smtp-Source: ABdhPJxCumSHokPvg0VDPchzYbIyB8Shhfo0ruu/8TYZEwJYtl/jJX8JvRe7KF4Av1voNThfaQcD5A==
X-Received: by 2002:a17:907:2d13:b0:6df:a061:8141 with SMTP id gs19-20020a1709072d1300b006dfa0618141mr325151ejc.663.1648047367675;
        Wed, 23 Mar 2022 07:56:07 -0700 (PDT)
Received: from prevas-ravi.tritech.se ([80.208.64.233])
        by smtp.gmail.com with ESMTPSA id p14-20020a05640210ce00b00413211746d4sm77256edu.51.2022.03.23.07.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 07:56:06 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     =?UTF-8?q?Andr=C3=A9=20Pribil?= <a.pribil@beck-ipc.com>,
        Steven Walter <stevenrwalter@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Esben Haabendal <esben@geanix.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Peter Hurley <peter@hurleysoftware.com>,
        linux-rt-users@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] workqueue: allow use of realtime scheduling policies
Date:   Wed, 23 Mar 2022 15:55:59 +0100
Message-Id: <20220323145600.2156689-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220323145600.2156689-1-linux@rasmusvillemoes.dk>
References: <20220323145600.2156689-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for allowing the administrator to set RT scheduling policies,
rather than just tweaking the nice value, of workqueues exposed via
sysfs. Subsystems that currently use, say, system_unbound_wq, can be
updated to create a separate workqueue (possibly depending on a
CONFIG_ knob or boottime parameter).

This patch merely updates the internal interfaces. The next patch will
expose a sysfs knob.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/workqueue.h | 17 +++++++++++++++--
 kernel/workqueue.c        | 20 ++++++++++++++++++--
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 7fee9b6cfede..a69bdd877120 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -131,9 +131,22 @@ struct rcu_work {
  */
 struct workqueue_attrs {
 	/**
-	 * @nice: nice level
+	 * @policy: scheduling policy (SCHED_NORMAL, SCHED_FIFO, SCHED_RR)
 	 */
-	int nice;
+	int policy;
+
+	/**
+	 * @nice: nice level (SCHED_NORMAL)
+	 * @priority: priority (SCHED_FIFO, SCHED_RR)
+	 *
+	 * Letting these two fields occupy the same word simplifies
+	 * copying, hashing and equality testing of struct
+	 * workqueue_attrs.
+	 */
+	union {
+		int nice;
+		int priority;
+	};
 
 	/**
 	 * @cpumask: allowed CPUs
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 33f1106b4f99..9eb2ff7bcc04 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -51,6 +51,7 @@
 #include <linux/sched/isolation.h>
 #include <linux/nmi.h>
 #include <linux/kvm_para.h>
+#include <uapi/linux/sched/types.h>
 
 #include "workqueue_internal.h"
 
@@ -1969,7 +1970,13 @@ static struct worker *create_worker(struct worker_pool *pool)
 	if (IS_ERR(worker->task))
 		goto fail;
 
-	set_user_nice(worker->task, pool->attrs->nice);
+	if (pool->attrs->policy == SCHED_NORMAL) {
+		set_user_nice(worker->task, pool->attrs->nice);
+	} else {
+		struct sched_param sp = { .sched_priority = pool->attrs->priority };
+
+		sched_setscheduler(worker->task, pool->attrs->policy, &sp);
+	}
 	kthread_bind_mask(worker->task, pool->attrs->cpumask);
 
 	/* successful, attach the worker to the pool */
@@ -3402,6 +3409,12 @@ struct workqueue_attrs *alloc_workqueue_attrs(void)
 {
 	struct workqueue_attrs *attrs;
 
+	/*
+	 * A zeroed structure has ->policy==SCHED_NORMAL and
+	 * ->nice==0.
+	 */
+	static_assert(SCHED_NORMAL == 0);
+
 	attrs = kzalloc(sizeof(*attrs), GFP_KERNEL);
 	if (!attrs)
 		goto fail;
@@ -3418,6 +3431,7 @@ struct workqueue_attrs *alloc_workqueue_attrs(void)
 static void copy_workqueue_attrs(struct workqueue_attrs *to,
 				 const struct workqueue_attrs *from)
 {
+	to->policy = from->policy;
 	to->nice = from->nice;
 	cpumask_copy(to->cpumask, from->cpumask);
 	/*
@@ -3433,7 +3447,7 @@ static u32 wqattrs_hash(const struct workqueue_attrs *attrs)
 {
 	u32 hash = 0;
 
-	hash = jhash_1word(attrs->nice, hash);
+	hash = jhash_2words(attrs->policy, attrs->nice, hash);
 	hash = jhash(cpumask_bits(attrs->cpumask),
 		     BITS_TO_LONGS(nr_cpumask_bits) * sizeof(long), hash);
 	return hash;
@@ -3443,6 +3457,8 @@ static u32 wqattrs_hash(const struct workqueue_attrs *attrs)
 static bool wqattrs_equal(const struct workqueue_attrs *a,
 			  const struct workqueue_attrs *b)
 {
+	if (a->policy != b->policy)
+		return false;
 	if (a->nice != b->nice)
 		return false;
 	if (!cpumask_equal(a->cpumask, b->cpumask))
-- 
2.31.1

