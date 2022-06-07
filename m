Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD94F542293
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350006AbiFHByM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1584664AbiFGXs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:48:29 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B25048989D;
        Tue,  7 Jun 2022 15:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=0YiMkBagw10WMJGuNob9S5dY4o5Fq5z46VhZ483pA3A=; b=sCSF0zEDHJ1FuAcGsEAIZaTXYd
        fNmlETUv1/cYtfUE3DNw/KfFCn2nGzCNmDNdQQ9HlYu2CtB6I1TGW9jCVycqcuLYGKpW05N/4jw+l
        upDe9ygg/ws6o5RUvqaxgw+q1JTYJk1FAV40lw4+6DXhPlKwwVBwiaUOFrGzfnBrChJipc//5Egia
        tnVA0Wx3TYkzrT4rqu1M6hmTwPBYzvS2A0Cy0rSBu7uRwAAYHLckPQLY7sSG2ZqBhIwS0HJoXwUwE
        esPvo7cdxnKvslmhZI+QDa8WNx7ka15Pz2C3NBMm82ud+evXBSGsuouRH4qoXcQjsyQLtVwrvhr0t
        JYAPPybQ==;
Received: from [179.110.79.194] (helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1nyhdV-00DgtH-7s; Wed, 08 Jun 2022 00:25:18 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael.j.wysocki@intel.com, kernel@gpiccoli.net,
        kernel-dev@igalia.com,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Len Brown <lenb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: [PATCH] ACPI: processor/idle: Annotate more functions to live in cpuidle section
Date:   Tue,  7 Jun 2022 19:24:58 -0300
Message-Id: <20220607222458.1864805-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 6727ad9e206c ("nmi_backtrace: generate one-line reports for idle cpus")
introduced a new text section called cpuidle; with that, we have a mechanism
to add idling functions in such section and skip them from nmi_backtrace
output, since they're useless and potentially flooding for such report.

Happens that inlining might cause some real idle functions to end-up
outside of such section; this is currently the case of ACPI processor_idle
driver; the functions acpi_idle_enter_* do inline acpi_idle_do_entry(),
hence they stay out of the cpuidle section.
Fix that by marking such functions to also live in the cpuidle section.

Fixes: 6727ad9e206c ("nmi_backtrace: generate one-line reports for idle cpus")
Cc: Len Brown <lenb@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---

Hi folks, this was tested on top of v5.19-rc1, with sysrq-l.

An alternative for this approach would be to mark acpi_idle_do_entry()
as noinline, but I'd risk to say that's a bit worse performance-wise.
Let me know your preference, I can rework the patch if you prefer =)

Thanks in advance for reviews,


Guilherme


 drivers/acpi/processor_idle.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 6a5572a1a80c..13200969ccf3 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -607,7 +607,7 @@ static DEFINE_RAW_SPINLOCK(c3_lock);
  * @cx: Target state context
  * @index: index of target state
  */
-static int acpi_idle_enter_bm(struct cpuidle_driver *drv,
+static int __cpuidle acpi_idle_enter_bm(struct cpuidle_driver *drv,
 			       struct acpi_processor *pr,
 			       struct acpi_processor_cx *cx,
 			       int index)
@@ -664,7 +664,7 @@ static int acpi_idle_enter_bm(struct cpuidle_driver *drv,
 	return index;
 }
 
-static int acpi_idle_enter(struct cpuidle_device *dev,
+static int __cpuidle acpi_idle_enter(struct cpuidle_device *dev,
 			   struct cpuidle_driver *drv, int index)
 {
 	struct acpi_processor_cx *cx = per_cpu(acpi_cstate[index], dev->cpu);
@@ -693,7 +693,7 @@ static int acpi_idle_enter(struct cpuidle_device *dev,
 	return index;
 }
 
-static int acpi_idle_enter_s2idle(struct cpuidle_device *dev,
+static int __cpuidle acpi_idle_enter_s2idle(struct cpuidle_device *dev,
 				  struct cpuidle_driver *drv, int index)
 {
 	struct acpi_processor_cx *cx = per_cpu(acpi_cstate[index], dev->cpu);
-- 
2.36.0

