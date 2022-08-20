Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B6E59ACAB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 10:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344605AbiHTIjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 04:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiHTIjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 04:39:16 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADE927B0F
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 01:39:14 -0700 (PDT)
Received: from zn.tnic (p200300ea971b9849329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:9849:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2A5E61EC0657;
        Sat, 20 Aug 2022 10:39:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660984749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TD86MjNzNK/6ONxM4dB6JHGrVjxPZZILCR5gKUKE7pM=;
        b=hNu7J36bytXQs7ZS+C9/PTH/fI17VsllEYVpvHmn0jY+W0vw3WHrqorUSwSzpVgrNEZmjx
        HnnQQd9pd6cXXY8Ht3Tj6CyIzAlhwLVn2QKzlQuiessE2vm44iSBYLX7jrqcIsX99Sw9w1
        oCSJHlY6kYq6vJM0Fn+l5DiIMy4PypA=
Date:   Sat, 20 Aug 2022 10:39:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc:     ssengar@microsoft.com, mikelley@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, peterz@infradead.org, tim.c.chen@linux.intel.com,
        will@kernel.org, song.bao.hua@hisilicon.com,
        suravee.suthikulpanit@amd.com, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/cacheinfo: Add a cpu_llc_shared_mask() UP variant
Message-ID: <YwCdp+g5fsKpV7T6@zn.tnic>
References: <1660148115-302-1-git-send-email-ssengar@linux.microsoft.com>
 <Yv1ELaWHbRfvdt/p@zn.tnic>
 <20220818045225.GA9054@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <Yv4pOz01nAkafiwd@zn.tnic>
 <20220818122925.GA8507@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <Yv/FXcOkB0BpUkVn@zn.tnic>
 <20220819174659.GA16818@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220819174659.GA16818@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 10:46:59AM -0700, Saurabh Singh Sengar wrote:
> Yes, this patch fixes this segfault.

Thx!

---
From: Borislav Petkov <bp@suse.de>

On a CONFIG_SMP=n kernel, the LLC shared mask is 0, which prevents
__cache_amd_cpumap_setup() from doing the L3 masks setup, and more
specifically from setting up the shared_cpu_map and shared_cpu_list
files in sysfs, leading to lscpu from util-linux getting confused and
segfaulting.

Add a cpu_llc_shared_mask() UP variant which returns a mask with a
single bit set, i.e., for CPU0.

Fixes: 2b83809a5e6d ("x86/cpu/amd: Derive L3 shared_cpu_map from cpu_llc_shared_mask")
Reported-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/1660148115-302-1-git-send-email-ssengar@linux.microsoft.com
---
 arch/x86/include/asm/smp.h | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 81a0211a372d..a73bced40e24 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -21,16 +21,6 @@ DECLARE_PER_CPU_READ_MOSTLY(u16, cpu_llc_id);
 DECLARE_PER_CPU_READ_MOSTLY(u16, cpu_l2c_id);
 DECLARE_PER_CPU_READ_MOSTLY(int, cpu_number);
 
-static inline struct cpumask *cpu_llc_shared_mask(int cpu)
-{
-	return per_cpu(cpu_llc_shared_map, cpu);
-}
-
-static inline struct cpumask *cpu_l2c_shared_mask(int cpu)
-{
-	return per_cpu(cpu_l2c_shared_map, cpu);
-}
-
 DECLARE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_cpu_to_apicid);
 DECLARE_EARLY_PER_CPU_READ_MOSTLY(u32, x86_cpu_to_acpiid);
 DECLARE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_bios_cpu_apicid);
@@ -172,6 +162,16 @@ extern int safe_smp_processor_id(void);
 # define safe_smp_processor_id()	smp_processor_id()
 #endif
 
+static inline struct cpumask *cpu_llc_shared_mask(int cpu)
+{
+	return per_cpu(cpu_llc_shared_map, cpu);
+}
+
+static inline struct cpumask *cpu_l2c_shared_mask(int cpu)
+{
+	return per_cpu(cpu_l2c_shared_map, cpu);
+}
+
 #else /* !CONFIG_SMP */
 #define wbinvd_on_cpu(cpu)     wbinvd()
 static inline int wbinvd_on_all_cpus(void)
@@ -179,6 +179,11 @@ static inline int wbinvd_on_all_cpus(void)
 	wbinvd();
 	return 0;
 }
+
+static inline struct cpumask *cpu_llc_shared_mask(int cpu)
+{
+	return (struct cpumask *)cpumask_of(0);
+}
 #endif /* CONFIG_SMP */
 
 extern unsigned disabled_cpus;
-- 
2.35.1

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
