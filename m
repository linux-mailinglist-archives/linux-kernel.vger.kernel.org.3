Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEEB481616
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 19:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhL2Smn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 13:42:43 -0500
Received: from mga18.intel.com ([134.134.136.126]:51990 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229794AbhL2Sml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 13:42:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640803361; x=1672339361;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=HtUeiy02ABlEF24PLl2F9uXiUeIwk1cDherhU2kTHNg=;
  b=OV6I3889QDNLEcTOgYdKlInIXN8yMgAZSuOmBxSwa9p1+fcSYA8elvpq
   AHSIL1VJhG0SH54j26hj+TRLdsZuzpIRnlox8Qqc9GEUyngErt7P8oRVg
   ORrczwpPa4y/w/i1F5pulG9LH8VbZXRozI1OEHAQoWnSeCujTrm+cxhJp
   BVive/6pfdRZdaKf/43I7vQ7SWs1i1ZqsxG8b1PAwbbF+2W0h3wmPIDv6
   Q2SpMWy4TlUS1CIEBb7VPFXFk9u9Jduz/hThBRw8zSaNRt91m1iwXYN/t
   OHL+HRw98R8oTu+OokcM1zjodpr+vckQDrYaiO4UhyfKTt6TaaJoUTf+e
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="228383747"
X-IronPort-AV: E=Sophos;i="5.88,246,1635231600"; 
   d="scan'208";a="228383747"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 10:42:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,246,1635231600"; 
   d="scan'208";a="486675554"
Received: from shahniha-mobl.amr.corp.intel.com (HELO [10.209.54.244]) ([10.209.54.244])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 10:42:40 -0800
Subject: Re: [PATCH 04/26] x86/traps: Add #VE support for TDX guest
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, luto@kernel.org,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        david@redhat.com, hpa@zytor.com, jgross@suse.com,
        jmattson@google.com, joro@8bytes.org, jpoimboe@redhat.com,
        knsathya@kernel.org, pbonzini@redhat.com, sdeep@vmware.com,
        seanjc@google.com, tony.luck@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-5-kirill.shutemov@linux.intel.com>
 <YcTR5HnkHi7CjVyx@zn.tnic>
 <20211228233112.cpycmdv55edxhvbv@black.fi.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Message-ID: <2d65ef4f-acc9-4cd1-ca39-c1f57a5cd821@intel.com>
Date:   Wed, 29 Dec 2021 10:42:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211228233112.cpycmdv55edxhvbv@black.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/21 3:31 PM, Kirill A. Shutemov wrote:
> On Thu, Dec 23, 2021 at 08:45:40PM +0100, Borislav Petkov wrote:
>> What happens if the NMI handler triggers a #VE after all? Or where is it
>> enforced that TDX guests should set panic_on_oops?
> Kernel will handle the #VE normally inside NMI handler. (We tested it once
> again, just in case.)
> 
> The critical part is that #VE must not be triggered in NMI entry code,
> before kernel is ready to handle nested NMIs. 
> 
> #VE cannot possibly happen there: no #VE-inducing instructions, code and
> data are in guest private memory.
...
> The situation is similar to NMIs vs. breakpoints.

Or page faults for that matter.

Page faults are architecturally permitted to occur in the NMI entry
path.  But, there's no facility to handle them.  The kernel (mostly
easily) avoids doing things that might cause page faults in the NMI
entry path.

The same goes for #VE's in the same path.  A guest is written to avoid
#VE in the NMI entry.  If they happen in that path, there's a bug somewhere.

I wouldn't go as far as to say "#VE cannot possibly happen there (NMI
entry code)".  They *CAN* happen there, but the kernel is doing
everything it can to avoid them.
