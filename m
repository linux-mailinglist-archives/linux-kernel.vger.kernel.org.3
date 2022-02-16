Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA614B8CEF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbiBPPyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:54:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiBPPyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:54:20 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B042944E9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 07:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645026848; x=1676562848;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=neS35sHyxRlh4Jho4hsIICF3KtedGOUD+wQQGFKgvB4=;
  b=OkKDTSV0muIOKbvwFW+k8lUQBxMx5BVznOfLiNhIU3xVDcFTn/3uFNRl
   mKafsRjGS7Wn3NDweI1nHZrkt3Qh6fClVeL4flWQlHM/e2IfO6+5eoSp8
   0SX56mN+Y6Jrnv3ngG5mJamYHAdB5JmNeVgd/lj0JeGv3wPxYlXonJRu3
   +fYMCPrFstgD5FAUTcJgs1GxttCBRu7CuhqdEFXQvIbX3NrcKtjQta/Dr
   ncxGT2o/x78CR18apEaoq+pFJUYuP8jfb0r8L8yeq08xoUACQkpyRpCcN
   1oIF9nCn6EMaOsb6DyS09pxKKZRiZa37q5rp123Ac+ZhAbuhtIE8B1Pju
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="249478559"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="249478559"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 07:48:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="636556360"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 16 Feb 2022 07:47:53 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 52C9D37E; Wed, 16 Feb 2022 17:48:09 +0200 (EET)
Date:   Wed, 16 Feb 2022 18:48:09 +0300
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
Message-ID: <20220216154809.w27bt6oi3ql4ssip@black.fi.intel.com>
References: <20220209235613.652f5720cd196331d7a220ec@intel.com>
 <YgOgog9Pb886lfsv@zn.tnic>
 <20220210003033.e57c2925b69bab5cfabf7292@intel.com>
 <YgOoId+vyd1VhIqQ@zn.tnic>
 <20220210004831.03dea501738bee060003d040@intel.com>
 <YgOr6tZjsooJgAi9@zn.tnic>
 <YgPwwI2+16/7jQC4@google.com>
 <YgQR/S67Fqz9PanR@zn.tnic>
 <YgQfGKXOemtXnFau@google.com>
 <YgQl6Uk9rONgv9+F@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgQl6Uk9rONgv9+F@zn.tnic>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 09:36:57PM +0100, Borislav Petkov wrote:
> + SEV guys. You can scroll upthread to read up on the context.
> 
> On Wed, Feb 09, 2022 at 08:07:52PM +0000, Sean Christopherson wrote:
> > Don't forget :-)
> > 
> >   arch/x86/kernel/kvm.c - KVM guest stuff
> 
> I knew I'd miss something, ofc.
> 
> > No objection to omitting "coco".  Though what about using "vmx" and "svm" instead
> > of "tdx" and "sev".
> 
> I'm not dead-set on this but ...
> 
> > We lose the more explicit tie to coco, but it would mirror the
> > sub-directories in arch/x86/kvm/
> 
> ... having them too close in naming to the non-coco stuff, might cause
> confusion when looking at:
> 
> arch/x86/kvm/vmx/vmx.c
> 
> vs
> 
> arch/x86/virt/vmx/vmx.c
> 
> Instead of having
> 
> arch/x86/kvm/vmx/vmx.c
> 
> and
> 
> arch/x86/virt/tdx/vmx.c
> 
> That second version differs just the right amount. :-)
> 
> > and would avoid a mess in the scenario where tdx
> > or sev needs to share code with the non-coco side, e.g. I'm guessing TDX will need
> > to do VMXON.
> > 
> >   arch/x86/virt/vmx/
> >   	tdx.c
> > 	vmx.c
> > 
> >   arch/x86/virt/svm/
> >   	sev.c
> > 	sev-es.c
> > 	sev-snp.c
> >   	svm.c
> 
> That will probably be two files too: sev.c and svm.c
> 
> But let's see what the other folks think first...

So, any conclusion?

I want to understand where to land TDX guest code and host-guest shared TDX code.
Host-guest shared code doesn't seem to fit anywhere nicely.

Or should I leave it under arch/x86/kernel until decision is made?

-- 
 Kirill A. Shutemov
