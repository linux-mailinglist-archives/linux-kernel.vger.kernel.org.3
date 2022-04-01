Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091674EF8E4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 19:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349970AbiDAR0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 13:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344008AbiDAR0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 13:26:31 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625C11B8FF0;
        Fri,  1 Apr 2022 10:24:41 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KVRqr0ZQbz9sRy;
        Fri,  1 Apr 2022 19:24:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4qjzDkK5GQhv; Fri,  1 Apr 2022 19:24:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KVRqq6mdHz9sRx;
        Fri,  1 Apr 2022 19:24:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D64128B87E;
        Fri,  1 Apr 2022 19:24:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id fvM4XEFXo0GL; Fri,  1 Apr 2022 19:24:39 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.82])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8931B8B879;
        Fri,  1 Apr 2022 19:24:39 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 231HOSh9665353
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 1 Apr 2022 19:24:28 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 231HOS1i665352;
        Fri, 1 Apr 2022 19:24:28 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-pm@vger.kernel.org
Subject: [PATCH] cpufreq: Prepare cleanup of powerpc's asm/prom.h
Date:   Fri,  1 Apr 2022 19:24:28 +0200
Message-Id: <4cb0c4573cce165657ad1f7275c4b3852cbcd115.1648833416.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1648833867; l=2544; s=20211009; h=from:subject:message-id; bh=6HFH5vctb4CM6TLdbxSxVP3cPSYLITg6N2oWHo7zycc=; b=0BIt3RnuB6YZdFU81km55wIzh5IeKiTLNExtM96tTDNPAiacFInZhJksD8Sq0ZMwePxp99ntZew9 Hm4h1wLFBvHEscGH+LPDl3CXVt+ySx0rXVo7e8M5zhqzah87dCkJ
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

powerpc's asm/prom.h brings some headers that it doesn't
need itself.

In order to clean it up, first add missing headers in
users of asm/prom.h

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/cpufreq/pasemi-cpufreq.c      | 1 -
 drivers/cpufreq/pmac32-cpufreq.c      | 2 +-
 drivers/cpufreq/pmac64-cpufreq.c      | 2 +-
 drivers/cpufreq/ppc_cbe_cpufreq.c     | 1 -
 drivers/cpufreq/ppc_cbe_cpufreq_pmi.c | 2 +-
 5 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
index 815645170c4d..039a66bbe1be 100644
--- a/drivers/cpufreq/pasemi-cpufreq.c
+++ b/drivers/cpufreq/pasemi-cpufreq.c
@@ -18,7 +18,6 @@
 
 #include <asm/hw_irq.h>
 #include <asm/io.h>
-#include <asm/prom.h>
 #include <asm/time.h>
 #include <asm/smp.h>
 
diff --git a/drivers/cpufreq/pmac32-cpufreq.c b/drivers/cpufreq/pmac32-cpufreq.c
index 4f20c6a9108d..20f64a8b0a35 100644
--- a/drivers/cpufreq/pmac32-cpufreq.c
+++ b/drivers/cpufreq/pmac32-cpufreq.c
@@ -24,7 +24,7 @@
 #include <linux/device.h>
 #include <linux/hardirq.h>
 #include <linux/of_device.h>
-#include <asm/prom.h>
+
 #include <asm/machdep.h>
 #include <asm/irq.h>
 #include <asm/pmac_feature.h>
diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpufreq.c
index d7542a106e6b..ba9c31d98bd6 100644
--- a/drivers/cpufreq/pmac64-cpufreq.c
+++ b/drivers/cpufreq/pmac64-cpufreq.c
@@ -22,7 +22,7 @@
 #include <linux/completion.h>
 #include <linux/mutex.h>
 #include <linux/of_device.h>
-#include <asm/prom.h>
+
 #include <asm/machdep.h>
 #include <asm/irq.h>
 #include <asm/sections.h>
diff --git a/drivers/cpufreq/ppc_cbe_cpufreq.c b/drivers/cpufreq/ppc_cbe_cpufreq.c
index c58abb4cca3a..e3313ce63b38 100644
--- a/drivers/cpufreq/ppc_cbe_cpufreq.c
+++ b/drivers/cpufreq/ppc_cbe_cpufreq.c
@@ -12,7 +12,6 @@
 #include <linux/of_platform.h>
 
 #include <asm/machdep.h>
-#include <asm/prom.h>
 #include <asm/cell-regs.h>
 
 #include "ppc_cbe_cpufreq.h"
diff --git a/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c b/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
index 037fe23bc6ed..4fba3637b115 100644
--- a/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
+++ b/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
@@ -13,9 +13,9 @@
 #include <linux/init.h>
 #include <linux/of_platform.h>
 #include <linux/pm_qos.h>
+#include <linux/slab.h>
 
 #include <asm/processor.h>
-#include <asm/prom.h>
 #include <asm/pmi.h>
 #include <asm/cell-regs.h>
 
-- 
2.35.1

