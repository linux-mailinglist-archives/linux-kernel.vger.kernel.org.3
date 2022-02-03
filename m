Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4170C4A9149
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 00:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356058AbiBCXsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 18:48:08 -0500
Received: from mga04.intel.com ([192.55.52.120]:52190 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234998AbiBCXsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 18:48:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643932086; x=1675468086;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FA+eUTNMfQj6CeukMqMo7uCnbpv5Uf+A8lETa5AJF68=;
  b=hk6CwcxVlkJXGzbg9T6kE1YMNmgW3yg5HAnHDaLkR4p6rscFGhNYaw1W
   VSL2gt6KWXxNZgw2GbpLKkuVaBkNNmtfoSIFPWaol4wiAIIEGkh7U73Ie
   GelFOF3TINX+dGXM01vqI6LSyxVROforiykf66OcbuZySdu2HPhuRnrTv
   1/PgkAsGGM+qpR6nnfolnsnnhL47MZUspJ2xd+IOgdEq8ja53/aY9RzeZ
   ++ODqrevE3Kycbbz0PYI9ym0Bg7jmT04A+8mPz/OmopKSlStanB0YmA80
   hokVZ6WXc6GdoovIOQTISjlIaVoIHOdusVlWJ7Y9RTPMfH6Gk4+K71XtF
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="247111128"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="247111128"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 15:48:06 -0800
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="524123973"
Received: from amedin3x-mobl2.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.251.128.120])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 15:48:01 -0800
Date:   Fri, 4 Feb 2022 12:47:58 +1300
From:   Kai Huang <kai.huang@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@intel.com>, <luto@kernel.org>,
        <peterz@infradead.org>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <aarcange@redhat.com>, <ak@linux.intel.com>,
        <dan.j.williams@intel.com>, <david@redhat.com>, <hpa@zytor.com>,
        <jgross@suse.com>, <jmattson@google.com>, <joro@8bytes.org>,
        <jpoimboe@redhat.com>, <knsathya@kernel.org>,
        <pbonzini@redhat.com>, <sdeep@vmware.com>, <seanjc@google.com>,
        <tony.luck@intel.com>, <vkuznets@redhat.com>,
        <wanpengli@tencent.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Kai Huang <kai.huang@linux.intel.com>
Subject: Re: [PATCHv2 03/29] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
Message-Id: <20220204124758.07875c8f1c0b76a89a2d159e@intel.com>
In-Reply-To: <20220203144403.ytyw5vcv4gshxyhn@black.fi.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
        <20220124150215.36893-4-kirill.shutemov@linux.intel.com>
        <87a6faz7cs.ffs@tglx>
        <20220202025519.csymm7r23b3ltpia@black.fi.intel.com>
        <20220202235910.c512857813ea5b14aa73267f@intel.com>
        <20220203144403.ytyw5vcv4gshxyhn@black.fi.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > 	/*
> > 	 * SEAMCALL instruction is essentially a VMExit from VMX root
> > 	 * mode to SEAM VMX root mode.  VMfailInvalid (CF=1) indicates
> > 	 * that the targeted SEAM firmware is not loaded or disabled,
> > 	 * or P-SEAMLDR is busy with another SEAMCALL.  %rax is not
> > 	 * changed in this case.
> > 	 *
> > 	 * Set %rax to VMFAILINVALID for VMfailInvalid.  This value
> > 	 * will never be used as actual SEAMCALL error code.
> > 	 */
> > 	jnb     .Lno_vmfailinvalid
> > 	mov     $(VMFAILINVALID), %rax
> > 	jmp     .Lno_output_struct
> > 
> > .Lno_vmfailinvalid:
> 
> Okay, I will add it under .if \host.
> 
> But maybe use JNC instead of JNB? Since we check for CF flag,
> Jump-if-Not-Carry sounds more reasonable than Jump-if-Not-Below.
> Not-Below of what?

Fine with JNC :)
