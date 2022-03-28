Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F264E98AD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 15:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243477AbiC1Nvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 09:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiC1Nvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:51:43 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AFA2F390;
        Mon, 28 Mar 2022 06:50:01 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a16-20020a17090a6d9000b001c7d6c1bb13so10647005pjk.4;
        Mon, 28 Mar 2022 06:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xtFNLVlQMA8W8gjicxShKgjg5KaAgkiFM5gezyxbQpA=;
        b=k01uP0/oFxmzITXyA6+rtr6bRVqlnyS3/W1w/0G1nRbDuPZm/AMWrgVXcb+cFKPmZV
         BePjT6xldkrOFDwSJSZZ0z+K5Ow8PUvCzY7YFB4OrINIF4aVilCwdu3VY1nt8/YFJWNZ
         N/IH9aC6TjWYPok+SOCY0+sctSOOmnvEXHl0SpU4GqbXC7WIDKy6FcfFOSdwJVJyMRpU
         xyIS1MKFqnzEEyuY+XRwSfBl0ZsVd6HYyv+j2uhfE3FvyDaVLeG5KeW7mHSzZZ12D4Tz
         ZiLdcAxSIkN3kZqrjXVy9dwcV70r3SXaYm0MUJiQtdLhTAAhPcAy7wsZVAj4XmbFCeKq
         5lDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xtFNLVlQMA8W8gjicxShKgjg5KaAgkiFM5gezyxbQpA=;
        b=URDUT4trT8urvBIi5uYZUPMUPUWqeKXo7QFea75b0YSFGnSDMmu7ODrjqud7tEOe0T
         ckfp2sMJ7tMIb5JUZeEh3KXKEGagogDsoJRrZCPh0hrP4A3e8/YuG6K/frfPpAaAh5lg
         rDVli5ipSw/0XYaZGsEbAGq0E+lGoVODcxq+uVtk2z9wC6MJIohX0kDQ6hRMlGPTjyAU
         9f/79rJcpOu5FziMiq7BV/X+vZlC5FlySAd3sRRPWYZQPxmzENKx0fT0OhevE6M1R8h9
         wsI02rqrZ+jgK/GHwZSq2DgELxjgSBSTiHkmv8ugBhQTGFPmmR935kIJjEfFpeR8/rDi
         azdQ==
X-Gm-Message-State: AOAM531FIg3La50f0zgjgFHMeAaEpIIIs9pD6BFF3VFKJX8Al7ypRDv/
        4WoZxM3foGr6X1sdbl7a6AM=
X-Google-Smtp-Source: ABdhPJyYYGj445KyqY172ZmIEsXCgJwhZyrBEfnCMtwf9ZK7TNqNVQhJyD9l3N8JjzGEo3LAegDGHw==
X-Received: by 2002:a17:90a:da02:b0:1bf:3919:f2a with SMTP id e2-20020a17090ada0200b001bf39190f2amr41346443pjv.208.1648475400417;
        Mon, 28 Mar 2022 06:50:00 -0700 (PDT)
Received: from localhost.localdomain ([103.149.162.115])
        by smtp.gmail.com with ESMTPSA id j7-20020a17090a31c700b001c6dbb70c94sm22527552pjf.18.2022.03.28.06.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 06:49:59 -0700 (PDT)
From:   Dongli Si <kvmx86@gmail.com>
X-Google-Original-From: Dongli Si <sidongli1997@gmail.com>
To:     peterz@infradead.org, joro@8bytes.org
Cc:     liam.merwick@oracle.com, kim.phillips@amd.com, mingo@kernel.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5] perf/x86/amd: Don't touch the Host-only bit inside the guest hypervisor
Date:   Mon, 28 Mar 2022 21:48:29 +0800
Message-Id: <20220328134829.2292928-1-sidongli1997@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dongli Si <sidongli1997@gmail.com>

With nested virtualization on AMD Milan, if "perf record" is run in an
L1 hypervisor with an L2 guest, the following warning is emitted in
the L1 guest.

[] unchecked MSR access error: WRMSR to 0xc0010200 (tried to write 0x0000020000510076)
at rIP: 0xffffffff81003a50 (x86_pmu_enable_all+0x60/0x100)
[] Call Trace:
[]  <IRQ>
[]  ? x86_pmu_enable+0x146/0x300
[]  __perf_install_in_context+0x150/0x170

The AMD64_EVENTSEL_HOSTONLY bit is defined and used on the host (L0),
while the L1 hypervisor Performance Monitor Unit should avoid such use.

Fixes: 1018faa6cf23 ("perf/x86/kvm: Fix Host-Only/Guest-Only counting with SVM disabled")
Signed-off-by: Dongli Si <sidongli1997@gmail.com>
Tested-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
---
v5: Add a wee comment to clarifies things and improve code
v4: https://lore.kernel.org/all/20220320002106.1800166-1-sidongli1997@gmail.com/
v3: https://lore.kernel.org/all/20220314042254.1487836-1-sidongli1997@gmail.com/
v2: https://lore.kernel.org/all/20220310183404.1291725-1-sidongli1997@gmail.com/
v1: https://lore.kernel.org/all/20220227132640.3-1-sidongli1997@gmail.com/

 arch/x86/events/amd/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 9687a8aef01c..5a1657c684f0 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -8,6 +8,7 @@
 #include <linux/jiffies.h>
 #include <asm/apicdef.h>
 #include <asm/nmi.h>
+#include <asm/hypervisor.h>
 
 #include "../perf_event.h"
 
@@ -1023,10 +1024,16 @@ __init int amd_pmu_init(void)
 	return 0;
 }
 
+/*
+ * Set the Host-only bit when virtualization is enabled on the Host Hypervisor
+ */
 void amd_pmu_enable_virt(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
+	if (!hypervisor_is_type(X86_HYPER_NATIVE))
+		return;
+
 	cpuc->perf_ctr_virt_mask = 0;
 
 	/* Reload all events */
@@ -1035,10 +1042,16 @@ void amd_pmu_enable_virt(void)
 }
 EXPORT_SYMBOL_GPL(amd_pmu_enable_virt);
 
+/*
+ * Mask the Host-only bit when virtualization is disabled on the Host Hypervisor
+ */
 void amd_pmu_disable_virt(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
+	if (!hypervisor_is_type(X86_HYPER_NATIVE))
+		return;
+
 	/*
 	 * We only mask out the Host-only bit so that host-only counting works
 	 * when SVM is disabled. If someone sets up a guest-only counter when
-- 
2.32.0

