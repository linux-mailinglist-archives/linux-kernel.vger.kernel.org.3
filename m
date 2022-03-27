Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6DF4E8750
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 12:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbiC0K6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 06:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiC0K6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 06:58:48 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AEC14005;
        Sun, 27 Mar 2022 03:57:10 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y10so6790609pfa.7;
        Sun, 27 Mar 2022 03:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1XT1FrlGmon0DFNlYVn7OAZK6ulKbjCHvVpH7G7GUv0=;
        b=QEiEudtv92/Epjsjy1naHCTUNZO57Bd6BKRKeofiIlgY+dlb/0gdpmSepnHCXeWiTh
         uVeolrI/8N1ytLd7Wrs2shGZuRIsXmuMIJZnDxIFbW/LwR51hI15f0X+f8wWMmslePvd
         0tPX4OnfrJE1bkRpPhU6aFdbmKpsYBMo13VoP4tZzDHWbTQdPwlIz2JTNWgZuhpyvP4D
         QLBpQ7l3b7Pzon8z2cxyzniVkYq1OA9bY25smEtlfWF+vl7AeoxPEnS5kxRTZD95Hb6Q
         D/C51uNBtkPUDwYnYz7mM3KWxLrHc50+CrXfMakhgqxOSYxRTd1q8JWCW7GKG/7fkxQn
         Sutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1XT1FrlGmon0DFNlYVn7OAZK6ulKbjCHvVpH7G7GUv0=;
        b=GXVcqAyfabIoEoQF2Z8HcjDX/A9RfCFn7RPvD3ODixHm+uy2dgaUHNmlzkjFekrJfd
         mL+XKW5wIWEnjM2vyyNSn7Ljk2icbZlJZOknFw8AwkksOeAbRQhJk02NN7bfOXC9xmv8
         0j3Sx/nmhF8/UCdzQMesAo6vVu8xFhsz7UA8yPyRSiVDB9X4UosLkSToei0+LmNyKsoN
         Rr5UdLXwLJ2iFfiCQaiYOANscZP2bPVkKt6i0jMJciz991m/UF+7/aJJgOi6Ij+lBJoD
         GlLfMHbEZRIJjWHYeb2TNOJAlE9owzXusDe8rtbIdSQ+Wi/CjsJjdiuH4ZxX0Z4VDEa2
         JPPw==
X-Gm-Message-State: AOAM533ATyUfWSjOfAxB3pjifEiM+gUFy5cT51zAiH8bQKUTx87LaHPz
        /stKDxk2H4oMjqTYLiAkY6mFItwXR6amMA==
X-Google-Smtp-Source: ABdhPJyGEYmWGYF8xqjmfUcyemd1rRbLVWX9N8JeXJR0mutQ2Yy2jPaPNoHgb5jjMOQWiyosMMnUTw==
X-Received: by 2002:a05:6a02:105:b0:381:fd01:330f with SMTP id bg5-20020a056a02010500b00381fd01330fmr6245968pgb.483.1648378629527;
        Sun, 27 Mar 2022 03:57:09 -0700 (PDT)
Received: from localhost.localdomain ([103.149.162.115])
        by smtp.gmail.com with ESMTPSA id l2-20020a637c42000000b003644cfa0dd1sm9747261pgn.79.2022.03.27.03.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 03:57:09 -0700 (PDT)
From:   Dongli Si <kvmx86@gmail.com>
X-Google-Original-From: Dongli Si <sidongli1997@gmail.com>
To:     peterz@infradead.org
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, jolsa@kernel.org,
        joro@8bytes.org, kim.phillips@amd.com, kvmx86@gmail.com,
        liam.merwick@oracle.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mingo@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
        x86@kernel.org
Subject: Re: [PATCH v4] perf/x86/amd: Don't touch the Host-only bit inside the guest hypervisor
Date:   Sun, 27 Mar 2022 18:56:03 +0800
Message-Id: <20220327105603.2141333-1-sidongli1997@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220324104217.GE8939@worktop.programming.kicks-ass.net>
References: <20220324104217.GE8939@worktop.programming.kicks-ass.net>
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

On 24/03/2022 10:42, Peter Zijlstra wrote:
> So I had to go and read the original commit to figure out wth this code
> is supposed to be doing. I'm thinking this all can use a wee comment.

Hi Peter, I will add a wee comment to clarifies things.

> Also, the above is very ambiguous as to what it does. Specifically if we
> don't set perf_ctr_virt_mask, then what is the actual value (yes, I
> know, but its not very clear is it). Also, if we don't in fact change
> perf_ctr_virt_mask then these following two lines:
> 
> >  
> >  	/* Reload all events */
> >  	amd_pmu_disable_all();
> 	amd_pmu_enable_all(0);
> 
> are somewhat completely pointless, no?

Thank you for pointing out the problem with my patch.

> So can we please get a patch that clarifies things instead of making
> things even more obscure?

The following is an improved patch, is it good?

Regards,
Dongli

---
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

