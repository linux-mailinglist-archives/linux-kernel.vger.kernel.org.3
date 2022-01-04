Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFAA4843B2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbiADOuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:50:09 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35142 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbiADOuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:50:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15532B81646
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 14:50:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7925C36AE9;
        Tue,  4 Jan 2022 14:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641307801;
        bh=5Wg5M9I3hKWSbc7MWsUiph0hQbWiXIBYvfHiAxqg/tg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EmucEgPMFjGrZvjt8jSq9mirg0iMoD6i6fSiSIPVlmI2yUcKM1XADHOZxv9ikKkr/
         S/GC9o0Vd0ESzb+k2c3h4X/fceu65IWNNVZzeBfLh5VJQfEQtgHxiPuvbGc6dhd+SV
         FVRwx71UvAFXUrBa05SUDo0PgSEidsmKFnFGvxVcseUYiBHFfQFw6LixQr6u/XHC3E
         875vaJ6qhDePDtba6f+tOH04Z4oYpkB3ttTv4ECutJgUEnt0mQBw9psVnPRq+nlQTP
         OmvG/t0+8PpWGh1iQSuPhYd/ZI27JVW5VWw0q+p/+d3D45dDc0pO1HR6Z+cXluctZW
         UurQTJpWAblww==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nitesh Lal <nilal@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz <nsaenzju@redhat.com>,
        Christoph Lameter <cl@gentwo.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 3/8] net: Decouple HK_FLAG_WQ and HK_FLAG_DOMAIN cpumask fetch
Date:   Tue,  4 Jan 2022 15:49:39 +0100
Message-Id: <20220104144944.1278663-4-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220104144944.1278663-1-frederic@kernel.org>
References: <20220104144944.1278663-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prepare for supporting each feature of the housekeeping cpumask
toward cpuset, prepare each of the HK_FLAG_* entries to move to their
own cpumask with enforcing to fetch them individually. The new
constraint is that multiple HK_FLAG_* entries can't be mixed together
anymore in a single call to housekeeping cpumask().

This will later allow, for example, to runtime modify the cpulist passed
through "isolcpus=", "nohz_full=" and "rcu_nocbs=" kernel boot
parameters.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Nitesh Lal <nilal@redhat.com>
Cc: Nicolas Saenz <nsaenzju@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Christoph Lameter <cl@gentwo.de>
Cc: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>
Cc: Alex Belits <abelits@marvell.com>
---
 net/core/net-sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 9c01c642cf9e..57181577f273 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -831,7 +831,7 @@ static ssize_t store_rps_map(struct netdev_rx_queue *queue,
 {
 	struct rps_map *old_map, *map;
 	cpumask_var_t mask;
-	int err, cpu, i, hk_flags;
+	int err, cpu, i;
 	static DEFINE_MUTEX(rps_map_mutex);
 
 	if (!capable(CAP_NET_ADMIN))
@@ -847,8 +847,8 @@ static ssize_t store_rps_map(struct netdev_rx_queue *queue,
 	}
 
 	if (!cpumask_empty(mask)) {
-		hk_flags = HK_FLAG_DOMAIN | HK_FLAG_WQ;
-		cpumask_and(mask, mask, housekeeping_cpumask(hk_flags));
+		cpumask_and(mask, mask, housekeeping_cpumask(HK_FLAG_DOMAIN));
+		cpumask_and(mask, mask, housekeeping_cpumask(HK_FLAG_WQ));
 		if (cpumask_empty(mask)) {
 			free_cpumask_var(mask);
 			return -EINVAL;
-- 
2.25.1

