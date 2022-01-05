Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79FA6484C2F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 02:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236937AbiAEBie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 20:38:34 -0500
Received: from mga11.intel.com ([192.55.52.93]:39442 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236930AbiAEBid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 20:38:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641346713; x=1672882713;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=WESM8KYl6Yxtdjs5iQp3yyevvQtAz+bck3jGbnqBcrw=;
  b=TQ5Z+16N9PD5jANaFhaaTMzxgIUHr8udqRIt/EjC8Lys8uECwVz+EdUH
   DvcXW/r+UTvuLBvhD/olm4nvhrfGCRHLa03HE5wmiRfr6iOzickssGBTK
   cKvokSVuzwIZNwf5PCSgGZF7kYEs27TcNTM+gDyH6xkB34p7lEuyjynC0
   ng3BXdG8+DpaMvr/dbKP9ht8BQv37oJNtVxC7ugpqtSy0sovrXqOEV21M
   EAVTR9iwWFEc2PWO7uwhovcrjtb+RdbhUTl3o75mbwR7gxwlvc0tMfDHT
   sd8f09G8t27MWRLxfUvfMbrb2xjgZ+vPFC8QhuPbEiGGiS4fRXn4oNvrr
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="239886478"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="239886478"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 17:38:28 -0800
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="556361948"
Received: from mncallah-mobl.amr.corp.intel.com (HELO [10.209.35.108]) ([10.209.35.108])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 17:38:27 -0800
Subject: Re: [PATCH 19/26] x86/tdx: Make pages shared in ioremap()
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, tglx@linutronix.de,
        mingo@redhat.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <33914dc1-37e8-f0bb-6468-71c3b5f4169d@amd.com>
 <20220103141705.6hqflhwykqmtfim6@black.fi.intel.com>
 <YdMIWAT42el4D6wJ@zn.tnic>
 <20220103151516.pfcz2pap5l7r2rzv@box.shutemov.name>
 <b4b54116-1cd7-468a-0889-d497268cbfb2@intel.com>
 <20220103181059.ui5eloufw5gsojcb@box.shutemov.name>
 <20220104191424.oly2gqm4ltzj5wo3@box.shutemov.name>
 <0e0c38e2-67ad-1f51-c44b-d3c3d505e40a@intel.com>
 <20220105003108.mr7zyd5oyaaxmnmv@box.shutemov.name>
 <50dfa0db-fcd1-3c54-d982-237d2c9df431@intel.com>
 <20220105005720.zdtgwenqwqmuyxvi@box.shutemov.name>
From:   Dave Hansen <dave.hansen@intel.com>
Message-ID: <4dc7d5e6-5b35-31ae-b5e9-7c77ed42383b@intel.com>
Date:   Tue, 4 Jan 2022 17:38:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220105005720.zdtgwenqwqmuyxvi@box.shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/22 4:57 PM, Kirill A. Shutemov wrote:
>> My read of STRICT_MM_TYPECHECKS was that "typedef unsigned long
>> pgprot_t" produces better code, but "typedef struct { unsigned long
>> pgprot; } pgprot_t;" produces better type checking.
> Apart from pgprot_t, __pgprot() and pgrot_val() helpers are defined
> differently depending on STRICT_MM_TYPECHECKS.
> 
>> I just compiled these patches on sparc with no issues.
> Hm. I can't see how
> 
> #define pgprot_val(x)	(x)
> 
> can work to access value for the pgprot_t defined as a struct.

Oh, I must just be compiling with the strict type checks on all the
time.  I do really wonder if these are useful these days or if the hacks
were for ancient compilers.

In any case, this would be pretty easy to fix by just removing the
!STRICT_MM_TYPECHECKS pgprot_val() and defning the STRICT_MM_TYPECHECKS
universally.

