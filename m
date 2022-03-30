Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349954ECDA1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 22:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350885AbiC3UGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 16:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350505AbiC3UGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 16:06:05 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9794ECE6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 13:04:18 -0700 (PDT)
Received: from zn.tnic (p2e55dff8.dip0.t-ipconnect.de [46.85.223.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2675A1EC056A;
        Wed, 30 Mar 2022 22:04:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1648670653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=14EYPGdztPJqqRoOG9Ks/jMWGhMbBnx/Ex8i8iSzzmU=;
        b=JiU0fB19uq4DLzSH887InCKCWAro+gDsfjG8WBGY3i+LnA39T8DOkIGXa2mIa44ti/Gqsc
        Za5GQs/tsQCn8gc9MACNwmcGy0JI7OQ7eEAg7RTfqyrtL5i8h9mni8wVHEx1RLmxAP9NG0
        fyxy+TblcfKVUozPEiSKHoqQkqHc1CM=
Date:   Wed, 30 Mar 2022 22:02:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Mark Gross <mgross@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Johansen <john.johansen@canonical.com>,
        Steve Beattie <sbeattie@ubuntu.com>, kernel@collabora.com,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: Re: [PATCH v2] x86/speculation/srbds: do not try to turn mitigation
 off when not supported
Message-ID: <YkS3OKLS1Cixs9up@zn.tnic>
References: <20220330082026.1549073-1-ricardo.canuelo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220330082026.1549073-1-ricardo.canuelo@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Pawan who's been poking at TSX recently...

On Wed, Mar 30, 2022 at 10:20:26AM +0200, Ricardo Cañuelo wrote:
> When SRBDS is mitigated by TSX OFF, update_srbds_msr will still read and
> write to MSR_IA32_MCU_OPT_CTRL even when that is not supported by the
> microcode.
> 
> Checking for X86_FEATURE_SRBDS_CTRL as a CPU feature available makes more
> sense than checking for SRBDS_MITIGATION_UCODE_NEEDED as the found
> "mitigation".
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> Signed-off-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
> Tested-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
> ---
> Hi all,
> 
> This patch was originally posted here:
> 
> https://lore.kernel.org/all/20200609174313.2600320-1-cascardo@canonical.com/#t
> 
> by Boris, based on the original patch by Cascardo, I didn't make any
> changes to it. I didn't see it merged or discussed further and I can
> still reproduce the issue on a Samsung Galaxy Chromebook 2 (Intel
> Cometlake-U). When booted without the proper CPU u-codes, TSX is
> disabled (so the CPU isn't vulnerable to SRDBS) but this code still
> tries to access an unavailable MSR register so I get these two warning
> messages:
> 
> unchecked MSR access error: RDMSR from 0x123 at rIP: 0xffffffff8203707e (update_srbds_msr+0x2e/0xa0)
> Call Trace:
>  <TASK>
>  check_bugs+0x994/0xa6e
>  ? __get_locked_pte+0x8f/0x100
>  start_kernel+0x630/0x664
>  secondary_startup_64_no_verify+0xd5/0xdb
>  </TASK>
> unchecked MSR access error: WRMSR to 0x123 (tried to write 0x0000000000000001) at rIP: 0xffffffff820370a9 (update_srbds_msr+0x59/0xa0)
> Call Trace:
>  <TASK>
>  check_bugs+0x994/0xa6e
>  ? __get_locked_pte+0x8f/0x100
>  start_kernel+0x630/0x664
>  secondary_startup_64_no_verify+0xd5/0xdb
>  </TASK>
> 
> This patch avoids them.
> 
>  arch/x86/kernel/cpu/bugs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 6296e1ebed1d..9b14cb2ec693 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -443,14 +443,14 @@ void update_srbds_msr(void)
>  	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
>  		return;
>  
> -	if (srbds_mitigation == SRBDS_MITIGATION_UCODE_NEEDED)
> +	if (srbds_mitigation == SRBDS_MITIGATION_UCODE_NEEDED ||
> +	    srbds_mitigation == SRBDS_MITIGATION_TSX_OFF)
>  		return;
>  
>  	rdmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
>  
>  	switch (srbds_mitigation) {
>  	case SRBDS_MITIGATION_OFF:
> -	case SRBDS_MITIGATION_TSX_OFF:
>  		mcu_ctrl |= RNGDS_MITG_DIS;
>  		break;
>  	case SRBDS_MITIGATION_FULL:
> -- 

So I'm not yet 100% sure as to how to model this properly. The fact
is, the CPU is not affected by SRBDS when it is a MDS_NO CPU with TSX
disabled.

So we could also do the below to denote what the situation is and
therefore clear the bug flag for such CPUs.

The thing is: I want this to be as clear as possible because bugs.c is
already a nightmare and just slapping more logic to it without properly
thinking it through is going to be a serious pain to deal with later...

Thx.

---
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 66d3e3b1d24d..9fa7a6ba09c7 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -217,6 +217,7 @@ static __always_inline bool _static_cpu_has(u16 bit)
 #define static_cpu_has_bug(bit)		static_cpu_has((bit))
 #define boot_cpu_has_bug(bit)		cpu_has_bug(&boot_cpu_data, (bit))
 #define boot_cpu_set_bug(bit)		set_cpu_cap(&boot_cpu_data, (bit))
+#define boot_cpu_clear_bug(bit)		clear_cpu_cap(&boot_cpu_data, (bit))
 
 #define MAX_CPU_FEATURES		(NCAPINTS * 32)
 #define cpu_have_feature		boot_cpu_has
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6296e1ebed1d..02fdfe5e2f2a 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -475,8 +475,10 @@ static void __init srbds_select_mitigation(void)
 	 * TSX that are only exposed to SRBDS when TSX is enabled.
 	 */
 	ia32_cap = x86_read_arch_cap_msr();
-	if ((ia32_cap & ARCH_CAP_MDS_NO) && !boot_cpu_has(X86_FEATURE_RTM))
+	if ((ia32_cap & ARCH_CAP_MDS_NO) && !boot_cpu_has(X86_FEATURE_RTM)) {
 		srbds_mitigation = SRBDS_MITIGATION_TSX_OFF;
+		boot_cpu_clear_bug(X86_BUG_SRBDS);
+	}
 	else if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
 		srbds_mitigation = SRBDS_MITIGATION_HYPERVISOR;
 	else if (!boot_cpu_has(X86_FEATURE_SRBDS_CTRL))

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
