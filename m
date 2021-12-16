Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA650476D5F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 10:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbhLPJ1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 04:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhLPJ1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 04:27:49 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1883C061574;
        Thu, 16 Dec 2021 01:27:48 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1639646865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AMcBcK0fSES8a2feq6hmlRsAzsjFuSG9kfngRo8vQQk=;
        b=tLICPkxhdckGSORNMD6NAe/A+sVjfFxM09a8a66Xcd0oiFqTahcMg0pnn1TU4lg4VDtib4
        DC+J81dNTyFJ8R3oN0GUoEpMRGdxH8Nt9yV3vxBVAetjSvKklCxwX65agp7CUu9XfsiVOw
        tUMaUGO+Lwx0jEbiAhz+prmpH9VKkuQ=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     song@kernel.org, pmenzel@molgen.mpg.de, williams@redhat.com,
        masahiroy@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-raid@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH v2] lib/raid6: Reduce high latency by using migrate instead of preempt
Date:   Thu, 16 Dec 2021 17:26:51 +0800
Message-Id: <20211216092651.18878-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found an abnormally high latency when executing modprobe raid6_pq, the
latency is greater than 1.2s when CONFIG_PREEMPT_VOLUNTARY=y, greater than
67ms when CONFIG_PREEMPT=y, and greater than 16ms when CONFIG_PREEMPT_RT=y.

This is caused by ksoftirqd fail to scheduled due to disable preemption,
this time is too long and unreasonable.

Reduce high latency by using migrate_disabl()/emigrate_enable() instead of
preempt_disable()/preempt_enable().

How to reproduce:
 - Install cyclictest
     sudo apt install rt-tests
 - Run cyclictest example in one terminal
     sudo cyclictest -S -p 95 -d 0 -i 1000 -D 24h -m
 - Modprobe raid6_pq in another terminal
      sudo modprobe raid6_pq

This patch beneficial for CONFIG_PREEMPT=y and CONFIG_PREEMPT_RT=y, but
no effect for CONFIG_PREEMPT_VOLUNTARY=y.

Fixes: fe5cbc6e06c7 ("md/raid6 algorithms: delta syndrome functions")
Fixes: cc4589ebfae6 ("Rename raid6 files now they're in a 'raid6' directory.")
Link: https://lore.kernel.org/linux-raid/b06c5e3ef3413f12a2c2b2a241005af9@linux.dev/T/#t
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

