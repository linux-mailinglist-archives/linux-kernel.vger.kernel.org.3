Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814C14C5B55
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 14:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbiB0N32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 08:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiB0N31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 08:29:27 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594DB50E2F;
        Sun, 27 Feb 2022 05:28:51 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id z2so8564865plg.8;
        Sun, 27 Feb 2022 05:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YytAN5dKnBXABN9R6VMCMuydpIbYgYlScavYReEx7ew=;
        b=m5LTy1SWMU7o9xBWDSw5yii9D4bIsK9xxH44qyPuW2hxB/brLo+o2SFKdfq124Ex8u
         o2RhtUvaf+kInfg0mNINzIHIN7dcNl3ugsWdCBciJuV4onXPSYPuyxuy6rR6pAAhR6Os
         N2wFzC44FGjqpbOhOkWPeCh9KtI1OdMC6DjHJb8oFmKk04+wuGCAewxO0V3N/ykxBmqO
         2UkOlWz9lFVQs8PQfw4CysNaqVRcMol9NQXJt3p3oG9ObPj49jTPhxby/POm4MVJec2S
         /8RL/hxtQO8MAvMYBhxyN8XJ6HmmDET8dhSmVjYcCekRivvTxpPloF5VtYZuM6hYsBfn
         kQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YytAN5dKnBXABN9R6VMCMuydpIbYgYlScavYReEx7ew=;
        b=JxKa2FoMB2I4TKU+BqTqHF1NUbItwgenI6FOzr1TCD9T5mgSUWddjOz8nQz0vXgvm+
         o3Mw410HMcRqjDxqpzGbOYxENtiXe4DvmYWfb1BMThoAxYpmewHpsNGCD/08QH9g3gLG
         Jm1ZYaueHU2Xe32EATLw1G0JWIid7B581d4QMP/J+4JbbGd99up4YTsQDk5nKdrP+fVC
         5HjL+7SU9cRqPnWRft5L9EdCfsTicPzHYJApSFLA75QEcWzSKH68Sgz/TAx3LOOdcIRk
         YlOuLeqiyf/T/Lb3UMFS6+a39VYrVNN/LI3S6BlmfF643KnH7lKew5XKxSjnoBEJDmLl
         W6Ig==
X-Gm-Message-State: AOAM5338MUImUKaem4n//lm4HP+iig1ANOA+5p1khV1s6yFECe2IOWhW
        gXm10uFBOnzMKHwjDW/17oM=
X-Google-Smtp-Source: ABdhPJzqAGdVLaYORwo2L8nu+5XmBGueeIjEI5BAm2IeN4ma+tG+jN7uf9Aoj9Ztd8ug8bHCLkL2CA==
X-Received: by 2002:a17:902:ce08:b0:14f:85c1:773e with SMTP id k8-20020a170902ce0800b0014f85c1773emr15690425plg.99.1645968530920;
        Sun, 27 Feb 2022 05:28:50 -0800 (PST)
Received: from localhost.localdomain ([103.149.162.113])
        by smtp.gmail.com with ESMTPSA id x3-20020a17090ad68300b001b8bcd47c35sm14532651pju.6.2022.02.27.05.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 05:28:50 -0800 (PST)
From:   Dongli Si <kvmx86@gmail.com>
X-Google-Original-From: Dongli Si <sidongli1997@gmail.com>
To:     peterz@infradead.org, joerg.roedel@amd.com
Cc:     liam.merwick@oracle.com, kim.phillips@amd.com, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf/x86/amd: Don't touch the Host-only bit inside the guest hypervisor
Date:   Sun, 27 Feb 2022 21:26:40 +0800
Message-Id: <20220227132640.3-1-sidongli1997@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dongli Si <sidongli1997@gmail.com>

When using nested virtualization and if use "perf record" in an AMD Rome
and Milan guest hypervisor (L1), dmesg report an error message like this:

[ ] unchecked MSR access error: WRMSR to 0xc0010200 (tried to write 0x0000020000510076) at rIP: 0xffffffff81003a50 (x86_pmu_enable_all+0x60/0x100)

The AMD64_EVENTSEL_HOSTONLY bit is defined and used on the host, while
the guest hypervisor (L1) performance monitor unit should avoid such use.

Fixes: 1018faa6cf23 ("perf/x86/kvm: Fix Host-Only/Guest-Only counting with SVM disabled")
Signed-off-by: Dongli Si <sidongli1997@gmail.com>
---
 arch/x86/events/amd/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 9687a8aef01c..3fafd1e46ada 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -8,6 +8,7 @@
 #include <linux/jiffies.h>
 #include <asm/apicdef.h>
 #include <asm/nmi.h>
+#include <asm/hypervisor.h>
 
 #include "../perf_event.h"
 
@@ -1027,7 +1028,8 @@ void amd_pmu_enable_virt(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	cpuc->perf_ctr_virt_mask = 0;
+	if (hypervisor_is_type(X86_HYPER_NATIVE))
+		cpuc->perf_ctr_virt_mask = 0;
 
 	/* Reload all events */
 	amd_pmu_disable_all();
-- 
2.32.0

