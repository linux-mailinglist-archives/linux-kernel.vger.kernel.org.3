Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F884B3277
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 02:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiBLBmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 20:42:46 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiBLBmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 20:42:45 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB170CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 17:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644630163; x=1676166163;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vr8BX9zwH8t7epr7XY4gDoHgAlCCPcFGmmdYH7b8KyY=;
  b=WqNfq2Oos0oFyY5MfxbV33qctUHd/tV1mMfKu0AbAn7p+zfPqBouvQtU
   26t0NvQxSt54Gj2NlEXgoahgNzVNjG+f+0/N7jRxe/5dxuHvr8sH301VW
   wDmIgOO81k7WRigdvGQd/o1bNSkamxjQC8eJFyAY5+4edyhHzXdOVmZZS
   pAoQ9uknQMdOAuMmiRHvGxj35MTESazlmJoxHecI74Di5n5/puCtPyssR
   q4ynrDEskyXORHIfy3NTcEgzZzxQjCy8mxGVCYMN0Pr4jYzZqQ49EoP8P
   raiEYyfkXDItFo3hKjYELjDtYspFygL2PnkQS6pmPyygvHwUvx+V/ly8N
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="250049424"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="250049424"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 17:42:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="602531314"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 11 Feb 2022 17:42:37 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id C13DF366; Sat, 12 Feb 2022 03:42:52 +0200 (EET)
Date:   Sat, 12 Feb 2022 04:42:52 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCHv2 04/29] x86/traps: Add #VE support for TDX guest
Message-ID: <20220212014252.un2hajlml7t46p6s@black.fi.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-5-kirill.shutemov@linux.intel.com>
 <877daez4em.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877daez4em.ffs@tglx>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 10:02:41PM +0100, Thomas Gleixner wrote:
> > +/*
> > + * Virtualization Exceptions (#VE) are delivered to TDX guests due to
> > + * specific guest actions which may happen in either user space or the
> > + * kernel:
> > + *
> > + *  * Specific instructions (WBINVD, for example)
> > + *  * Specific MSR accesses
> > + *  * Specific CPUID leaf accesses
> > + *  * Access to unmapped pages (EPT violation)
> > + *
> > + * In the settings that Linux will run in, virtualization exceptions are
> > + * never generated on accesses to normal, TD-private memory that has been
> > + * accepted.
> > + *
> > + * Syscall entry code has a critical window where the kernel stack is not
> > + * yet set up. Any exception in this window leads to hard to debug issues
> > + * and can be exploited for privilege escalation. Exceptions in the NMI
> > + * entry code also cause issues. Returning from the exception handler with
> > + * IRET will re-enable NMIs and nested NMI will corrupt the NMI stack.
> > + *
> > + * For these reasons, the kernel avoids #VEs during the syscall gap and
> > + * the NMI entry code. Entry code paths do not access TD-shared memory,
> > + * MMIO regions, use #VE triggering MSRs, instructions, or CPUID leaves
> > + * that might generate #VE.
> 
> How is that enforced or validated? What checks for a violation of that
> assumption?

Hm. I think we would have to rely on code audit for it.

Entry code has no #VE inducing things: no port I/O, CPUID, HLT,
MONITOR/MWAIT, WBINVD/INVD, HLT, VMCALL.

There's single MSR read for MSR_GS_BASE paranoid_entry(), but it doesn't
trigger #VE either.

Other possible source of #VE is shared memory. If somebody tricks kernel
to access shared memory from entry code we have a bigger problem to deal
with than #VE in syscall gap.

Or do you have something more strict than code audit in mind? I don't see
it.

-- 
 Kirill A. Shutemov
