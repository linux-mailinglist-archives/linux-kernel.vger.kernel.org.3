Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E57473B37
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 04:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbhLNDAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 22:00:39 -0500
Received: from out1.migadu.com ([91.121.223.63]:43363 "EHLO out1.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232118AbhLNDAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 22:00:38 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1639450836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1vndxrNGB+WzR5xqhu3RD4FILb9wlm0/q3X11bIWkos=;
        b=aa5DItfFUBXVg9oWFUceXio6WJYRTdCp2svDEOuCREFZahU78m7Ni49GUe517XJG8iNF6p
        CkQqp6aO3v9SijZOvk9bTe+45OO9GsIlJsMGho7VVTG0GF/SmAF/nRW7vl02Tq9AHVHXox
        PKdi5l/jt7auqt1VpD4pxIcMOpf1otQ=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     stockhausen@collogia.de, neilb@suse.de
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] lib/raid6: fix abnormally high latency
Date:   Tue, 14 Dec 2021 10:59:46 +0800
Message-Id: <20211214025946.15980-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: yajun.deng@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found an abnormally high latency when executing modprobe raid6_pq, the
latency is greater than 1.2s when CONFIG_PREEMPT_VOLUNTARY=y, greater than
67ms when CONFIG_PREEMPT=y, and greater than 16ms when CONFIG_PREEMPT_RT=y.
This is caused by disable the preemption, this time is too long and
unreasonable. We just need to disable migration. so used migrate_disable()/
migrate_enable() instead of preempt_disable()/preempt_enable(). This is
beneficial for CONFIG_PREEMPT=y or CONFIG_PREEMPT_RT=y, but no effect for
CONFIG_PREEMPT_VOLUNTARY=y.

Fixes: fe5cbc6e06c7 ("md/raid6 algorithms: delta syndrome functions")
Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 lib/raid6/algos.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/raid6/algos.c b/lib/raid6/algos.c
index 6d5e5000fdd7..21611d05c34c 100644
--- a/lib/raid6/algos.c
+++ b/lib/raid6/algos.c
@@ -162,7 +162,7 @@ static inline const struct raid6_calls *raid6_choose_gen(
 
 			perf = 0;
 
-			preempt_disable();
+			migrate_disable();
 			j0 = jiffies;
 			while ((j1 = jiffies) == j0)
 				cpu_relax();
@@ -171,7 +171,7 @@ static inline const struct raid6_calls *raid6_choose_gen(
 				(*algo)->gen_syndrome(disks, PAGE_SIZE, *dptrs);
 				perf++;
 			}
-			preempt_enable();
+			migrate_enable();
 
 			if (perf > bestgenperf) {
 				bestgenperf = perf;
@@ -186,7 +186,7 @@ static inline const struct raid6_calls *raid6_choose_gen(
 
 			perf = 0;
 
-			preempt_disable();
+			migrate_disable();
 			j0 = jiffies;
 			while ((j1 = jiffies) == j0)
 				cpu_relax();
@@ -196,7 +196,7 @@ static inline const struct raid6_calls *raid6_choose_gen(
 						      PAGE_SIZE, *dptrs);
 				perf++;
 			}
-			preempt_enable();
+			migrate_enable();
 
 			if (best == *algo)
 				bestxorperf = perf;
-- 
2.32.0

