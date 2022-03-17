Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A4B4DCF39
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiCQUXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiCQUXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:23:01 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF58E13BAE3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647548504; x=1679084504;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5r+UM7uGE8iSy2g3vezLNOSUEun6kfdmzTbiW3xpeuo=;
  b=A/zpUHFnh3yDslfgo63fvecYvvgDTQFDtApURKOI1WEZxpxvHpRSZent
   6A9RX8xNrdLklKeAY07Gl5LxPtHM9BHZVpkExjufqrv6YmxZSEez+CKKt
   SNQdivLCD4isjEI7ErKv29iKdzRsGW55L04kly2jqiEjOib3xfOkXINWZ
   O6uL5RI24L7flqXRlYLQqw0IhicgJjFu32kAEV2ZyLwAWgCvW7bo3iHNe
   4D+Mv7Lhxmi8pypHfvDLS8BnvFNtLH1dhlVsWJgFcMW2SgwGE6gkfGlhG
   S5x9FMKEtRFg1YSPujNOZ/X7uMvv3ojrnBusZGgz4PFWrOkoSLx3siH1/
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="236919352"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="236919352"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 13:21:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="498972946"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 17 Mar 2022 13:21:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 30489107; Thu, 17 Mar 2022 22:21:55 +0200 (EET)
Date:   Thu, 17 Mar 2022 23:21:55 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Boris Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, dave.hansen@intel.com, mingo@redhat.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        brijesh.singh@amd.com, ak@linux.intel.com, david@redhat.com,
        dan.j.williams@intel.com, wanpengli@tencent.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, jmattson@google.com,
        pbonzini@redhat.com, seanjc@google.com, jpoimboe@redhat.com,
        vkuznets@redhat.com, joro@8bytes.org, thomas.lendacky@amd.com,
        sdeep@vmware.com, x86@kernel.org, knsathya@kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        tony.luck@intel.com
Subject: Re: [PATCHv6 20/30] x86/boot: Add a trampoline for booting APs via
 firmware handoff
Message-ID: <20220317202155.aurobskmy3v57nse@black.fi.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-21-kirill.shutemov@linux.intel.com>
 <3D4C3388-DC6A-41A5-A79F-B23FBFFE4E0F@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D4C3388-DC6A-41A5-A79F-B23FBFFE4E0F@alien8.de>
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 12:44:42PM +0000, Boris Petkov wrote:
> On March 16, 2022 2:08:46 AM UTC, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:
> >diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
> >index 48067af94678..35006e151774 100644
> >--- a/arch/x86/include/asm/apic.h
> >+++ b/arch/x86/include/asm/apic.h
> >@@ -328,6 +328,8 @@ struct apic {
> > 
> > 	/* wakeup_secondary_cpu */
> > 	int	(*wakeup_secondary_cpu)(int apicid, unsigned long start_eip);
> >+	/* wakeup secondary CPU using 64-bit wakeup point */
> >+	int	(*wakeup_secondary_cpu_64)(int apicid, unsigned long start_eip);
> > 
> > 	void	(*inquire_remote_apic)(int apicid);
> > 
> >diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
> >index 331474b150f1..fd6f6e5b755a 100644
> >--- a/arch/x86/include/asm/realmode.h
> >+++ b/arch/x86/include/asm/realmode.h
> >@@ -25,6 +25,7 @@ struct real_mode_header {
> > 	u32	sev_es_trampoline_start;
> > #endif
> > #ifdef CONFIG_X86_64
> >+	u32	trampoline_start64;
> 
> I had already asked about those here: why do you need to add a new u32 here and can't use trampoline_start?
> 
> Ditto for the new function pointer too.
> 
> And yes, sev_es_trampoline_start is superfluous too.

As I said[1], I'm confused by the request. These field initialized at
build time. I don't see how a single field would work.

[1] https://lore.kernel.org/all/20220216141009.ymmjduf5doqnhnqy@black.fi.intel.com/

-- 
 Kirill A. Shutemov
