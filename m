Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7064A99A3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346976AbiBDNFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244168AbiBDNE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:04:56 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5841DC06173D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 05:04:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CDB36CE223A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 13:04:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 549D5C340E9;
        Fri,  4 Feb 2022 13:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643979893;
        bh=roMSEXVnB5ySGkuuG1Fwml7ufF9ojMdhUUb6lYN0gfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lErtWkU7KMs353928ImNR0/+JPuIjlfRnkooMJrn3B27b/1CaAm+8Q74rxCl0I3Z9
         BpbGwix7v8K48WZ18XSn3DDJC45toW62tet4yjwVUNsbLq0nLa1KyvCSPPYB3CpT/9
         /9ea/Tm0l2GlB4pnkJ9CCzKvJC2V8M1s1dylsEICGcQApowqnvbNV8N4pGI6Ao8zvM
         iNG+6UJulIYtqpZoor9hqll9i4OdDAtj1F+j8BEM31NGBLluDXn1vzIacQyZ8Tdgum
         cHkme4Y/0u2oOrr7PtxCpw+UsV22fiW0AKJoeJL1vLgMj6xwA7aUsedaj9gGG/USdW
         0aVxIGiBBfH9A==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nitesh Lal <nilal@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Nicolas Saenz <nsaenzju@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>
Subject: [PATCH 3/8] net: Decouple HK_FLAG_WQ and HK_FLAG_DOMAIN cpumask fetch
Date:   Fri,  4 Feb 2022 14:04:28 +0100
Message-Id: <20220204130433.488085-4-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204130433.488085-1-frederic@kernel.org>
References: <20220204130433.488085-1-frederic@kernel.org>
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

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Phil Auld <pauld@redhat.com>
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
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Paul E. McKenney  <paulmck@kernel.org>
---
 net/core/net-sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 53ea262ecafd..ed8da7b8d35b 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -823,7 +823,7 @@ static ssize_t store_rps_map(struct netdev_rx_queue *queue,
 {
 	struct rps_map *old_map, *map;
 	cpumask_var_t mask;
-	int err, cpu, i, hk_flags;
+	int err, cpu, i;
 	static DEFINE_MUTEX(rps_map_mutex);
 
 	if (!capable(CAP_NET_ADMIN))
@@ -839,8 +839,8 @@ static ssize_t store_rps_map(struct netdev_rx_queue *queue,
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

