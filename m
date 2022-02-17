Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46754BA452
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242470AbiBQP0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:26:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239847AbiBQP0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:26:19 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1A22B164D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645111565; x=1676647565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x5XPHyGUD1XNLXBguPnbw5xge7vRbeImiSy3wX7y/7A=;
  b=nKl8Ff6F0I09g0SV9Mf5xP2JrrrZ7ehe60mH3l9DeufTKFbiJbl7paAz
   e7gkcMATDssObGsGLYVDf/F3lRpTZbeBsSkxTmEAzg+ldWVKi0hsS6rf8
   u9jHk1L1CLwpUrGJy60NobAp6t4asOdAHFbVCSPpOCF/oRw8d/Ao7y6Y0
   oa3HbWcD3GB+b0huxMeDEORmu7mPvUzkAPtN3HEV+0TSPWvOrbm90YsHs
   p1qjvMLQkjg4pjmlGzXvDaLac+LeBp3Hk5ezxM0aMTV/AgbC4ZCpzMmi8
   wYfB/gGGr+lS15p0oCgbvxo3jpWSNbfAGtD2tuBUg3J0OpC2nlqgF2rPq
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="251095489"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="251095489"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 07:26:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="545659946"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 17 Feb 2022 07:25:58 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 0FAD1166; Thu, 17 Feb 2022 17:26:13 +0200 (EET)
Date:   Thu, 17 Feb 2022 18:26:13 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Sean Christopherson <seanjc@google.com>,
        Kai Huang <kai.huang@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@intel.com, luto@kernel.org,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        david@redhat.com, hpa@zytor.com, jgross@suse.com,
        jmattson@google.com, joro@8bytes.org, jpoimboe@redhat.com,
        knsathya@kernel.org, pbonzini@redhat.com, sdeep@vmware.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCHv2 00/29] TDX Guest: TDX core support
Message-ID: <20220217152613.chm4zh7564ddzijq@black.fi.intel.com>
References: <20220210003033.e57c2925b69bab5cfabf7292@intel.com>
 <YgOoId+vyd1VhIqQ@zn.tnic>
 <20220210004831.03dea501738bee060003d040@intel.com>
 <YgOr6tZjsooJgAi9@zn.tnic>
 <YgPwwI2+16/7jQC4@google.com>
 <YgQR/S67Fqz9PanR@zn.tnic>
 <YgQfGKXOemtXnFau@google.com>
 <YgQl6Uk9rONgv9+F@zn.tnic>
 <20220216154809.w27bt6oi3ql4ssip@black.fi.intel.com>
 <Yg5nh1RknPRwIrb8@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yg5nh1RknPRwIrb8@zn.tnic>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 04:19:35PM +0100, Borislav Petkov wrote:
> On Wed, Feb 16, 2022 at 06:48:09PM +0300, Kirill A. Shutemov wrote:
> > So, any conclusion?
> 
> Lemme type the whole thing here again so that we have it all summed up
> in one place - I think we all agree by now:
> 
> - confidential computing guest stuff: arch/x86/coco/{sev,tdx}
> - generic host virtualization stuff: arch/x86/virt/
> - coco host stuff: arch/x86/virt/vmx/{tdx,vmx}.c and arch/x86/virt/svm/sev*.c
> 
> New stuff goes to the new paths - i.e., TDX guest, host, etc - old stuff
> - AMD SEV/SNP will get moved gradually so that development doesn't get
> disrupted. Or we can do a flag day, right before -rc1 or so, and move it
> all so in one go. We'll see.

Okay, so on TDX guest side I would have

arch/x86/kernel/tdx.c => arch/x86/coco/tdx.c
arch/x86/kernel/tdcall.S => arch/x86/coco/tdcall.S
arch/x86/kernel/tdxcall.S => arch/x86/virt/tdxcall.S

The last one going to be used by TDX host as well to define SEMACALL
helper.

Looks good?

-- 
 Kirill A. Shutemov
