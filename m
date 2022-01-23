Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88E94974AF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240242AbiAWSnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239900AbiAWSlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:41:53 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABC1C06175D
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:41:50 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d1so13472186plh.10
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6C24rFRm4D9dQifkbAjpKYbgU7hbqSNfEMJXgU+U9KI=;
        b=gYPbDS3xW8Bof6/g8XIUI3VOyuWClFWj+Zb1KxH7n8eeylpaD7S+0cAQt0BGU2As3z
         duZ9/03UsRs07ChTiteduoXTEha9M3JOt6tS2tzofY+aoNv/yDnGgcW162IO7pfl0wRn
         ZdC0c7yMRUF0QVaQPTId/pywxUsN08BWrvHjR6PfR/383ALFfcq0bHBGeuYVyfzZTOTt
         y5IAqKFglXI7xWlG7X5EuweqyLRNOsqcKnZPCn+pO0ZCouINBgits28kN7Bj2Z0Eniua
         b/brsWqVckOYFra9U6GGgIJGIuiycyhOEhIHy1iVyx8K7y1oYTijPy9C6uKNewCLCHDK
         pV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6C24rFRm4D9dQifkbAjpKYbgU7hbqSNfEMJXgU+U9KI=;
        b=YrP5QJJCuKhJ9q0wTofRcoAnOqnGLlN/4v6JywjfFuTtdxSU5QuJacq1QvU7nBxpWG
         72+UpY/kzUhT3NymlDoGZm2Ml4ig2MLURNVJF6TXVsePY8TeW6t9gVAhpWkgVpZjuhzk
         YcqIr4VTfEC/l84FHczzIt7qTf4zN1qj41c63i/BM9LMq0X4SG9/Q+74hFnOHjtTJDx0
         ufOt/cjlVXxbqDRPUR3LAbExdUjrpY8/2M+/MjtFUMy34QE18o47QPzjJ4R6vywBWwOc
         7sWjtNRiOqpoZ5+3ArxtCu3bUDK1CEz7oROka+Sz6apdfnjxyLQq237+8ALO2JJVM2uy
         X82g==
X-Gm-Message-State: AOAM531NLqIs8lSSIyiZagc4yGLGZwllaAlxXbv6idn02tC0DTJkbpYX
        Qapzgg9J4Td/RRo1+HKCCQQ=
X-Google-Smtp-Source: ABdhPJwCUm5LGUQRIavV14WvbHJtSguBHM0RRlDYhBuujEK/erleabWJrnbTCB8LogwV7QJ8p8LuVA==
X-Received: by 2002:a17:90b:4f87:: with SMTP id qe7mr7183731pjb.154.1642963310342;
        Sun, 23 Jan 2022 10:41:50 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id pj7sm1942706pjb.50.2022.01.23.10.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:41:50 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Parth Shah <parth@linux.ibm.com>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Rob Herring <robh@kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Xiongwei Song <sxwjean@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 39/54] arch/powerpc: replace cpumask_weight with cpumask_weight_{eq, ...} where appropriate
Date:   Sun, 23 Jan 2022 10:39:10 -0800
Message-Id: <20220123183925.1052919-40-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PowerPC code uses cpumask_weight() to compare the weight of cpumask
with a given number. We can do it more efficiently with
cpumask_weight_{eq, ...} because conditional cpumask_weight may stop
traversing the cpumask earlier, as soon as condition is met.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/powerpc/kernel/smp.c      | 2 +-
 arch/powerpc/kernel/watchdog.c | 2 +-
 arch/powerpc/xmon/xmon.c       | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index b7fd6a72aa76..8bff748df402 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1656,7 +1656,7 @@ void start_secondary(void *unused)
 		if (has_big_cores)
 			sibling_mask = cpu_smallcore_mask;
 
-		if (cpumask_weight(mask) > cpumask_weight(sibling_mask(cpu)))
+		if (cpumask_weight_gt(mask, cpumask_weight(sibling_mask(cpu))))
 			shared_caches = true;
 	}
 
diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index bfc27496fe7e..62937a077de7 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -483,7 +483,7 @@ static void start_watchdog(void *arg)
 
 	wd_smp_lock(&flags);
 	cpumask_set_cpu(cpu, &wd_cpus_enabled);
-	if (cpumask_weight(&wd_cpus_enabled) == 1) {
+	if (cpumask_weight_eq(&wd_cpus_enabled, 1)) {
 		cpumask_set_cpu(cpu, &wd_smp_cpus_pending);
 		wd_smp_last_reset_tb = get_tb();
 	}
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index fd72753e8ad5..b423812e94e0 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -469,7 +469,7 @@ static bool wait_for_other_cpus(int ncpus)
 
 	/* We wait for 2s, which is a metric "little while" */
 	for (timeout = 20000; timeout != 0; --timeout) {
-		if (cpumask_weight(&cpus_in_xmon) >= ncpus)
+		if (cpumask_weight_ge(&cpus_in_xmon, ncpus))
 			return true;
 		udelay(100);
 		barrier();
@@ -1338,7 +1338,7 @@ static int cpu_cmd(void)
 			case 'S':
 			case 't':
 				cpumask_copy(&xmon_batch_cpus, &cpus_in_xmon);
-				if (cpumask_weight(&xmon_batch_cpus) <= 1) {
+				if (cpumask_weight_le(&xmon_batch_cpus, 1)) {
 					printf("There are no other cpus in xmon\n");
 					break;
 				}
-- 
2.30.2

