Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7964A8D2B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 21:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354031AbiBCUZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 15:25:49 -0500
Received: from mga05.intel.com ([192.55.52.43]:27029 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238135AbiBCUZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 15:25:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643919947; x=1675455947;
  h=message-id:date:mime-version:to:references:from:subject:
   in-reply-to:content-transfer-encoding;
  bh=maUXWdLOoB+ER0fN6/9ymU9n/nzG5qy41XOrszB4bGA=;
  b=LUdiFAl1ix00sNqlsMTpeHvSPAe5n+X77YTyJ0XBV9n2+u74yYpQ+qzY
   CZt1Mpy4Y7LFDQ0TWGB1+no8XQjrUWAVK8UV4OqfOPhnrD0BikV/mcG3G
   8in8wSX3glmoAnpQUHwPReRJx67QeOpcCy0xrxRS5GUInYMSztIMoG3t5
   etOUJayCh8Zv7mSOjb4Wpwac9KQbsEEI8i9CWg14z6aJ1XNMRG+AGaGiY
   ZTdulRSuz4WFNEjTYXz4To0h4Dw1gk7LO2NTYtxkzUH5gPg73vMqSSNdj
   QmffYDYaGPlRHTbgjWG1xcRjnEu3MkFb7nR5PQBuE+3puseU515+NihkB
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="334615061"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="334615061"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 12:25:47 -0800
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="535331874"
Received: from oshoron-mobl.amr.corp.intel.com (HELO [10.209.125.125]) ([10.209.125.125])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 12:25:46 -0800
Message-ID: <e313b068-b5d6-dbc4-9894-02d759d2fe55@intel.com>
Date:   Thu, 3 Feb 2022 12:25:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Babu Moger <babu.moger@amd.com>,
        Jing Liu <jing2.liu@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <20220203194308.2469117-1-jmattson@google.com>
 <20220203194308.2469117-2-jmattson@google.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 2/2] x86/cpufeatures: Add macros for Intel's new fast rep
 string features
In-Reply-To: <20220203194308.2469117-2-jmattson@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/22 11:43, Jim Mattson wrote:
> Even if no one else cares, these features should be exposed to kvm
> guests, and the code for the KVM_GET_SUPPORTED_CPUID ioctl is more
> readable if the bits have corresponding X86_FEATURE macros.

I went digging around KVM_GET_SUPPORTED_CPUID and didn't see any obvious
unreadable things resulting from not having these defines.  Maybe I'm
looking in the wrong spot.  Do you have a slightly more specific pointer?

> +#define X86_FEATURE_FZRM		(12*32+10) /* Fast zero-length REP MOVSB */
> +#define X86_FEATURE_FSRS		(12*32+11) /* Fast short REP STOSB */
> +#define X86_FEATURE_FSRC		(12*32+12) /* Fast short REP {CMPSB,SCASB} */

If the use really is for inside the kernel, maybe we should hide them
from cpuinfo:

#define X86_FEATURE_FSRC		(12*32+12) /* "" Fast short REP {CMPSB,SCASB} */

