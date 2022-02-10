Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7BF4B1A3E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346190AbiBKAPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:15:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346226AbiBKAPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:15:47 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69100558A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:15:47 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id m185so9505727iof.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PIovVUUoTXrNkGptnZalq8qTG6elYmmkmcndd2InBI8=;
        b=pcjmfLwAiS/XGbn7H5lJSwo1VmJtz/MoynS0X5Dcg+dWgAtP50rspk13S0E5pJvDty
         S6taB1oBu2sz0cRmYD0OrRjqt2eHBVSewuL1cld2PkhQsvFtl9InCW6guWZsBAakxHMk
         QeAHrP+IGJZPPsIbTyETpTaKJMX41JIs46ZQl2s+qGfwWzoybsFUJSxmhqN/EcMYGjqu
         aLAgKKOq45uiO1viWnPybbeWGhqL5zctU9mMIOJebmWir+BUuJeDQnU4GPsD0okN+NS4
         pJvRQWhfbiVaTp3GfeFPrI0rEQUVFFs+HDyaa7lPxlLEpozQBg6i1VzRnx8jLoMxeYZM
         MW4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PIovVUUoTXrNkGptnZalq8qTG6elYmmkmcndd2InBI8=;
        b=3vjumhYVGVtilNlI4+zJxUPjYiRsBlKN96h4xGO6ppEU1RzI+rRZHfphT/+avqYkrl
         xIqMjopNy1qmA12IVoY5nZv4JHG0VyqAZCfQsNWxe7i50ONM3AqZdepINVgSM4Vfev6P
         KiIsp/qbSu9PR5NNiggAFm7QxpPphPcgLxB9y1dlxWUQVRvfqQO2YzsPNpDoKF56YOns
         SzyCHRyL70dq4z8ByIU8qaOcEdSNEL76gfE1UzH0Uvblo/CppY6CNpZJ8qrtm37ZFOwi
         qd/mKLzZWF/+oeBIWfOwQZBi4TRW+BIOT1j8MiUBbnqYVVR3ZKUm/c/tB4nibIk9i7UK
         SEWA==
X-Gm-Message-State: AOAM530Y03xfWyagsvEuP4Id80ip+3t8/WC+1tLNs8/0CPS6WCUSrxOI
        rYBsVDYpTkO/YmSqcSAc9Ig=
X-Google-Smtp-Source: ABdhPJxRcsurSAFIVa51O5zD9bcY1kB5OJeXxGfVrQ9MyMfVmVSnWSLVAohEIbusFvdw1qpbmH+QRA==
X-Received: by 2002:a05:6638:d0c:: with SMTP id q12mr5411794jaj.310.1644538546802;
        Thu, 10 Feb 2022 16:15:46 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id h3sm12329728ioe.19.2022.02.10.16.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 16:15:46 -0800 (PST)
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
Subject: [PATCH 38/49] arch/powerpc: replace cpumask_weight with cpumask_weight_{eq, ...} where appropriate
Date:   Thu, 10 Feb 2022 14:49:22 -0800
Message-Id: <20220210224933.379149-39-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220210224933.379149-1-yury.norov@gmail.com>
References: <20220210224933.379149-1-yury.norov@gmail.com>
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

PowerPC code uses cpumask_weight() to compare the weight of cpumask with
a given number. We can do it more efficiently with cpumask_weight_{eq, ...}
because conditional cpumask_weight may stop traversing the cpumask earlier,
as soon as condition is (or can't be)  met.

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
2.32.0

