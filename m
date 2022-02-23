Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456CC4C1791
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242394AbiBWPqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbiBWPqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:46:45 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA944C115A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 07:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645631177; x=1677167177;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n+AaNSi+E86k3W5X45dTnONsiOQ/fEBTJQ6TkbylKz4=;
  b=nEPoCIx/Ea3AFzbV8hkkj+YPXue0gAm8Zs8QpdcQGpjMxfx38mMifzBm
   bF25m/d8jw3L3pVgX+09zT1SG/u3c5J4ecAv6umVQ1yLNyVQN+wP6eNuz
   bYKZwyGtQIK7P7AwQ3Gl8ZehdgTuiEadXiAsotDdnZSvuZphdlV/Oc3lH
   qb1qpmHS5amRBldr5AXZjrlkJYYD7lJmsTiIQHyTFBJ/xFd+B41zb63Fm
   eri4VTfWAaJdZSSqLy4I26tRbRXZaMB+47Uu6SbjEBKFeJQhcc8iLRBEE
   8VHhkZolfdN9Cm5+LX22gdyLEwgFLTXspPrgBJ4rmA1jN7qv6euDVsOUu
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="239383729"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="239383729"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 07:46:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="491238662"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 23 Feb 2022 07:46:10 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 9566E94; Wed, 23 Feb 2022 17:46:27 +0200 (EET)
Date:   Wed, 23 Feb 2022 18:46:27 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, Wei Liu <wei.liu@kernel.org>,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jmattson@google.com, seanjc@google.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: Re: [PATCH 1/4] x86/hyperv: Add missing ARCH_HAS_CC_PLATFORM
 dependency
Message-ID: <20220223154627.mssem3vgqdw6eecn@black.fi.intel.com>
References: <20220222185740.26228-1-kirill.shutemov@linux.intel.com>
 <20220222185740.26228-2-kirill.shutemov@linux.intel.com>
 <YhVCoveTwsDZXE5G@zn.tnic>
 <4769a3c0-449b-184a-5c61-a0e155f9c5b4@gmail.com>
 <YhYPPHKZFsGzaI2U@zn.tnic>
 <bcdbd534-a077-3bb3-3d37-c9eb2a048854@gmail.com>
 <YhYS00FywnE8g4Um@zn.tnic>
 <b172898d-0464-054a-9182-1110297f3629@gmail.com>
 <20220223114724.4luaemfi3tyedlvh@black.fi.intel.com>
 <a34587e5-a144-c4a5-56f0-235da22ebce5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a34587e5-a144-c4a5-56f0-235da22ebce5@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 10:09:19PM +0800, Tianyu Lan wrote:
> 
> 
> On 2/23/2022 7:47 PM, Kirill A. Shutemov wrote:
> > On Wed, Feb 23, 2022 at 07:02:49PM +0800, Tianyu Lan wrote:
> > > On 2/23/2022 6:56 PM, Borislav Petkov wrote:
> > > > On Wed, Feb 23, 2022 at 06:43:40PM +0800, Tianyu Lan wrote:
> > > > > Hyper-V code check cpuid during runtime and there is no Hyper-V
> > > > > isolation VM option.
> > > > 
> > > > So how does "Current Hyper-V Isolation VM requires AMD_MEM_ENCRYPT" work
> > > > exactly?
> > > > 
> > > > Please explain in detail and not in piecemeal sentences.
> > > > 
> > > The kernel in the image needs to select AMD_MEM_ENCRYPT option
> > > otherwise the kernel can't boot up due to missing SEV support and
> > > sev_es_ghcb_hv_call() always return error.
> > 
> > If kernel boots under SEV, doesn't it mean we have 'sme_me_mask'
> > initialized? If it is non zero hv_is_isolation_supported() check in
> > cc_platform_has() has zero effect as it checked after 'sme_me_mask'.
> > 
> > I still have no idea what is going on.
> > 
> > How SEV related to HyperV isolation? How detection happens? Could you
> > give full picture?
> > 
> 
> Hi Kriil:
>      Current Hyper-V Isolation VM is unenlightened VM design. Hyper-V hides
> SEV capability from Linux guest and expose Hyper-V cpuid to show Hyper-V
> isolation VM capability. So sme_me_mask is zero in this case because SEV
> capability cpuid returns not-support.
>      Hyper-V Isolation VM code uses some SEV API sev_es_ghcb_hv_call() to
> share code and so it's necessary to select AMD_MEM_ENCRYPT option for
> Hyper-V Isolation VM.

Borislav, let's drop 1/4 and fold following fixup in 3/4.

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index c1c0123859b9..f9df31421d8c 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -345,7 +345,8 @@ static void __init ms_hyperv_init_platform(void)
 		 */
 		swiotlb_force = SWIOTLB_FORCE;
 #endif
-		if (hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE)
+		if (hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE &&
+		    IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
 			cc_set_vendor(CC_VENDOR_HYPERV);
 	}
 
-- 
 Kirill A. Shutemov
