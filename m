Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BFA4ED437
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 08:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbiCaGzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 02:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbiCaGzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 02:55:40 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB17AE56
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 23:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648709633; x=1680245633;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=WB64PwkyHlQUKysJVCgvUlIvhHf1QUAGXu7mKFwUKzM=;
  b=IKDWBKoM9xSH9A3e1CEU+QLL82wEbu9JjMuG2tqzggZ9Jc0oL6P94QJO
   G8PCwJdhAd/35aR2tmDddIAMI0sJ24cxQ9T4Y1akDVhOtxgL7ix1dyrLD
   plckn0krr+s04aEH/aAk80ccGb7UzS3VDDvXMpETn7I8OzKZDzVDK/z1I
   N+2PzmKeVNfXUlmsOb3vkZMgaVavzPjoT5DWZnaUQ4I5/8P+sU57bdHCt
   hRsVBP77EUBoatE3Vs71G5ZTKX98LGH7EIS3C2I5Npq6yk0GXb5mWNutN
   DXRqEABBDnM/sFIaCkys5Vc+S+qgUeqh0xn5kxYtaBts16BvF25UQIgnu
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="320431804"
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="320431804"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 23:53:52 -0700
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="650163722"
Received: from obbruno-mobl.amr.corp.intel.com (HELO guptapa-desk) ([10.252.136.207])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 23:53:52 -0700
Date:   Wed, 30 Mar 2022 23:53:50 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Mark Gross <mgross@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Johansen <john.johansen@canonical.com>,
        Steve Beattie <sbeattie@ubuntu.com>, kernel@collabora.com
Subject: Re: [PATCH v2] x86/speculation/srbds: do not try to turn mitigation
 off when not supported
Message-ID: <20220331065350.nuii3ue4fagdsp52@guptapa-desk>
References: <20220330082026.1549073-1-ricardo.canuelo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220330082026.1549073-1-ricardo.canuelo@collabora.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 10:20:26AM +0200, Ricardo Cañuelo wrote:
>When SRBDS is mitigated by TSX OFF, update_srbds_msr will still read and
>write to MSR_IA32_MCU_OPT_CTRL even when that is not supported by the
>microcode.
>
>Checking for X86_FEATURE_SRBDS_CTRL as a CPU feature available makes more
>sense than checking for SRBDS_MITIGATION_UCODE_NEEDED as the found
>"mitigation".
>
>Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
>Signed-off-by: Borislav Petkov <bp@alien8.de>
>Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
>Tested-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
>---
>Hi all,
>
>This patch was originally posted here:
>
>https://lore.kernel.org/all/20200609174313.2600320-1-cascardo@canonical.com/#t
>
>by Boris, based on the original patch by Cascardo, I didn't make any
>changes to it. I didn't see it merged or discussed further and I can
>still reproduce the issue on a Samsung Galaxy Chromebook 2 (Intel
>Cometlake-U). When booted without the proper CPU u-codes, TSX is
>disabled (so the CPU isn't vulnerable to SRDBS) but this code still
>tries to access an unavailable MSR register so I get these two warning
>messages:
>
>unchecked MSR access error: RDMSR from 0x123 at rIP: 0xffffffff8203707e (update_srbds_msr+0x2e/0xa0)
>Call Trace:
> <TASK>
> check_bugs+0x994/0xa6e
> ? __get_locked_pte+0x8f/0x100
> start_kernel+0x630/0x664
> secondary_startup_64_no_verify+0xd5/0xdb
> </TASK>
>unchecked MSR access error: WRMSR to 0x123 (tried to write 0x0000000000000001) at rIP: 0xffffffff820370a9 (update_srbds_msr+0x59/0xa0)
>Call Trace:
> <TASK>
> check_bugs+0x994/0xa6e
> ? __get_locked_pte+0x8f/0x100
> start_kernel+0x630/0x664
> secondary_startup_64_no_verify+0xd5/0xdb
> </TASK>
>
>This patch avoids them.
>
> arch/x86/kernel/cpu/bugs.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
>index 6296e1ebed1d..9b14cb2ec693 100644
>--- a/arch/x86/kernel/cpu/bugs.c
>+++ b/arch/x86/kernel/cpu/bugs.c
>@@ -443,14 +443,14 @@ void update_srbds_msr(void)
> 	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
> 		return;
>
>-	if (srbds_mitigation == SRBDS_MITIGATION_UCODE_NEEDED)
>+	if (srbds_mitigation == SRBDS_MITIGATION_UCODE_NEEDED ||
>+	    srbds_mitigation == SRBDS_MITIGATION_TSX_OFF)
> 		return;

Returning for TSX OFF case doesn't seem right. System is mitigated
already and there is no need to incur performance loss due to microcode
mitigation. So we need to write to the MSR for TSX OFF case to disable
the microcode mitigation.

IIUC root of the issue is the logic in srbds_select_mitigation() that
gives precedence to TSX_OFF over UCODE_NEEDED:

   srbds_select_mitigation()
   {
   [...]
   	if ((ia32_cap & ARCH_CAP_MDS_NO) && !boot_cpu_has(X86_FEATURE_RTM))
   		srbds_mitigation = SRBDS_MITIGATION_TSX_OFF;
   	else if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
   		srbds_mitigation = SRBDS_MITIGATION_HYPERVISOR;
   	else if (!boot_cpu_has(X86_FEATURE_SRBDS_CTRL))
   		srbds_mitigation = SRBDS_MITIGATION_UCODE_NEEDED;
   	else if (cpu_mitigations_off() || srbds_off)
		srbds_mitigation = SRBDS_MITIGATION_OFF;

If we don't want to touch this logic, below can be a simple fix:

---
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6296e1ebed1d..575817163354 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -437,7 +437,8 @@ void update_srbds_msr(void)
  {
  	u64 mcu_ctrl;
  
-	if (!boot_cpu_has_bug(X86_BUG_SRBDS))
+	if (!boot_cpu_has_bug(X86_BUG_SRBDS) ||
+	    !boot_cpu_has(X86_FEATURE_SRBDS_CTRL))
  		return;
  
  	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))

---
Thanks,
Pawan
