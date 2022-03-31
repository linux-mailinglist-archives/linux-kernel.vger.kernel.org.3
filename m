Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827934ED610
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbiCaIsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbiCaIr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:47:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BF115470B
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648716373; x=1680252373;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=IGYEIDqtBzv8VGesC88J5H0DizbH6fzEQs1AQAbgMVI=;
  b=BFEclP51yI9YkCGOh6plNbJU35/tuxG0ZOSnLb9MA0m6Cbvz88PTobNO
   B4Ol3k/h1BDkz2BMDiI2wWHT4CzRsUd18mL4lmLM42PAzlRJdayaEpB9/
   cyZT2RtoagyHcvQ7X0g2TPkycfuiPr9nBS2jlDGggDlAd+mAy3W1QCxUD
   l9w6Oj7Rj4YwRRtmpUcowyNkTwe+8dEqM7Y7srb9D7jTDquMd3c4WCrAV
   jI4+3RJE1wNrKa0hxMZVLAC0VN/ifIUC39GEh0LRbeSHy3m89k3FTfk79
   LCxy9eKi3Izg1xCfnaCKFa3t1TlmXEOUoiTZKNEkF4nu9M0lBh/JAV98G
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="322942192"
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="322942192"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 01:46:12 -0700
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="503652552"
Received: from mshakoox-mobl1.amr.corp.intel.com (HELO guptapa-desk) ([10.251.2.3])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 01:46:12 -0700
Date:   Thu, 31 Mar 2022 01:46:10 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Mark Gross <mgross@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Johansen <john.johansen@canonical.com>,
        Steve Beattie <sbeattie@ubuntu.com>, kernel@collabora.com
Subject: Re: [PATCH v2] x86/speculation/srbds: do not try to turn mitigation
 off when not supported
Message-ID: <20220331084536.y4sl7qcfzltsnnew@guptapa-desk>
References: <20220330082026.1549073-1-ricardo.canuelo@collabora.com>
 <YkS3OKLS1Cixs9up@zn.tnic>
 <87o81mzhoh.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o81mzhoh.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 09:48:14AM +0200, Ricardo Cañuelo wrote:
>Borislav Petkov <bp@alien8.de> writes:
>> So we could also do the below to denote what the situation is and
>> therefore clear the bug flag for such CPUs.
>>
>> The thing is: I want this to be as clear as possible because bugs.c is
>> already a nightmare and just slapping more logic to it without properly
>> thinking it through is going to be a serious pain to deal with later...
>
>Thanks Boris,
>
>I agree that the more explicit the better, I'll give this a try. I saw
>Pawan's suggestion as well but that one is similar to the originally
>proposed patch in that the logic/checks are split between two functions,
>this solution based on clearing the bug flag seems clearer considering
>the comment just before the code block:
>
>	/*
>	 * Check to see if this is one of the MDS_NO systems supporting
>	 * TSX that are only exposed to SRBDS when TSX is enabled.
>	 */

If we clear the bug flag and not write to the MSR to disable the
microcode mitigation, there will be unnecessary performance loss due to
microcode mitigation. Specifically RDRAND/RDSEED/EGET_KEY will run
slower.

Yes, the logic/checks between two functions is messy.

Does this simplify things a bit?

---
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6296e1ebed1d..0be6c0eabb71 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -431,34 +431,22 @@ static const char * const srbds_strings[] = {
  	[SRBDS_MITIGATION_HYPERVISOR]	= "Unknown: Dependent on hypervisor status",
  };
  
-static bool srbds_off;
+static bool srbds_dis_ucode_mitigation;
  
  void update_srbds_msr(void)
  {
  	u64 mcu_ctrl;
  
-	if (!boot_cpu_has_bug(X86_BUG_SRBDS))
-		return;
-
-	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
-		return;
-
-	if (srbds_mitigation == SRBDS_MITIGATION_UCODE_NEEDED)
+	if (!boot_cpu_has_bug(X86_BUG_SRBDS) ||
+	    !boot_cpu_has(X86_FEATURE_SRBDS_CTRL))
  		return;
  
  	rdmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
  
-	switch (srbds_mitigation) {
-	case SRBDS_MITIGATION_OFF:
-	case SRBDS_MITIGATION_TSX_OFF:
+	if (srbds_dis_ucode_mitigation)
  		mcu_ctrl |= RNGDS_MITG_DIS;
-		break;
-	case SRBDS_MITIGATION_FULL:
+	else
  		mcu_ctrl &= ~RNGDS_MITG_DIS;
-		break;
-	default:
-		break;
-	}
  
  	wrmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
  }
@@ -481,9 +469,13 @@ static void __init srbds_select_mitigation(void)
  		srbds_mitigation = SRBDS_MITIGATION_HYPERVISOR;
  	else if (!boot_cpu_has(X86_FEATURE_SRBDS_CTRL))
  		srbds_mitigation = SRBDS_MITIGATION_UCODE_NEEDED;
-	else if (cpu_mitigations_off() || srbds_off)
+	else if (cpu_mitigations_off())
  		srbds_mitigation = SRBDS_MITIGATION_OFF;
  
+	if (srbds_mitigation == SRBDS_MITIGATION_OFF ||
+	    srbds_mitigation == SRBDS_MITIGATION_TSX_OFF)
+		srbds_dis_ucode_mitigation = true;
+
  	update_srbds_msr();
  	pr_info("%s\n", srbds_strings[srbds_mitigation]);
  }
@@ -496,7 +488,9 @@ static int __init srbds_parse_cmdline(char *str)
  	if (!boot_cpu_has_bug(X86_BUG_SRBDS))
  		return 0;
  
-	srbds_off = !strcmp(str, "off");
+	if (!strcmp(str, "off"))
+		srbds_mitigation = SRBDS_MITIGATION_OFF;
+
  	return 0;
  }
  early_param("srbds", srbds_parse_cmdline);
