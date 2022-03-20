Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61AA94E1923
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 01:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244445AbiCTAYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 20:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236078AbiCTAYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 20:24:33 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD8F396B1;
        Sat, 19 Mar 2022 17:23:11 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t22so9917712plo.0;
        Sat, 19 Mar 2022 17:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aCcXyGBeuBGRSClxBYmQz/kYFQduE8YzmbZ0WJ5dI9k=;
        b=hzuliQ2jyHeHq4tWhRO155WxnV56qXgAKOlM3KbxLfGAVyHXbZfS51P4zyc7S6FOOt
         GJAJdgGpHr+b1FWy2JbLshI7FydKMwaSWWhQHVI7lzXnMuMtl9DPj+8LCRn5m7SsHD+a
         /bN0d+tLPWTcqnvo+iKLAKqcu4nDl3LMWHWZIdWUPvAnrwoMQ90aky4CTpB8zH7tHagC
         zzQdpJXS7ExGrsM/umFW5iwllEKyEz9ggTXf5ulxnWGSqQCjVsQd1iwsYp1ukQav3uEt
         oyhXizGO4vTLCF5LQE2Noq8jH6hgUn4/Hg8Iik1EiumumY2hl1iuEWDBFtuz3nL8tuIG
         uMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aCcXyGBeuBGRSClxBYmQz/kYFQduE8YzmbZ0WJ5dI9k=;
        b=3eox22ZtKUQ5T2OjLBEg+I0Qmg+HutaXpWeFAf+U4ifhxli/8q3Zc1YJslw10ubaU3
         HGjnnNrZiTitoDoy+DvsP2UnP1QW9ZPS40Wujxv9D2HTILXL58S9eagLjeaW1trNfatH
         gh/ktnRtXotB+HoaHJM5ctBS30tp59hOQdPOBtkUCg9cbSnTstaEqpbX6ehKgN5ZSu2Q
         wFugleUeT76NGyWzeFsiWFPU8BCoTKkAdJ0GdrepSOjc/yPKUjvz5MTUnbl3dQ9SnlcP
         m/VRf3Xi5xVUiR0YVadIYHZ7ElikCJegAMhk7a8All1JdRa3DbnGSmMFcUmgBBeVk5BQ
         z8Fw==
X-Gm-Message-State: AOAM530QepDITvuZ+lO2RTHYqB8TyFPMAKZT5zEUPyinWDonI/XMcMaq
        3JBFBi67L4LQxhcaZlm3xRZy9yPF5zfhLg==
X-Google-Smtp-Source: ABdhPJxngVVNgBsxeComoTsrpmNgd25f8wVVhAvOUOP66P5uYwokYda9lGwczTrIpDmehHxhfvs7pQ==
X-Received: by 2002:a17:902:ecd0:b0:151:e180:56fb with SMTP id a16-20020a170902ecd000b00151e18056fbmr6202953plh.131.1647735788613;
        Sat, 19 Mar 2022 17:23:08 -0700 (PDT)
Received: from localhost.localdomain ([103.149.162.114])
        by smtp.gmail.com with ESMTPSA id z16-20020a056a00241000b004f3a647ae89sm14442652pfh.174.2022.03.19.17.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 17:23:08 -0700 (PDT)
From:   Dongli Si <kvmx86@gmail.com>
X-Google-Original-From: Dongli Si <sidongli1997@gmail.com>
To:     peterz@infradead.org, joerg.roedel@amd.com
Cc:     liam.merwick@oracle.com, kim.phillips@amd.com, mingo@kernel.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] perf/x86/amd: Don't touch the Host-only bit inside the guest hypervisor
Date:   Sun, 20 Mar 2022 08:21:06 +0800
Message-Id: <20220320002106.1800166-1-sidongli1997@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
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
v4: Remove my run_as_host function for better descriptive.
v3: https://lore.kernel.org/all/20220314042254.1487836-1-sidongli1997@gmail.com/
v2: https://lore.kernel.org/all/20220310183404.1291725-1-sidongli1997@gmail.com/
v1: https://lore.kernel.org/all/20220227132640.3-1-sidongli1997@gmail.com/

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
