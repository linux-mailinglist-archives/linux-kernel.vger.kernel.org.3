Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26BC5484BD3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 01:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbiAEAnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 19:43:14 -0500
Received: from mga14.intel.com ([192.55.52.115]:45242 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232884AbiAEAnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 19:43:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641343393; x=1672879393;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=MpCEBVcUt3q1JbwjRMgMygRha3aI3StRnlj8zP5uAKo=;
  b=ecZ2bJew75EqPoHPlU4rv7r2Ww1n3LESb6qq1N5DheJ3Wbsgifk0IcvV
   ITIddcfk2I7vin14mxXQbN8Wp96Iy+TAhI6fPUVIBwHuqTqvSQysesPr5
   zl3WOfS5T/EsaDx3yFsM5Il5RdAOiceTivTecZcnhVlB7lMg2xfNa69EG
   6ZHcmXr+ucCvOGWabu5hbFCmrqW/HhijH87yMRKZCaMmuiSRykTKHMHLa
   6dN0ftf0JksAY8XJjf2Q9HZ+6KwPH/HyIhj8zm++DiHWhLF4uIzwEpyth
   WbPDcNsy0JEQ8XMthr9fkmPJXhDEmmbPUg4L/322tNvcp0ep4IYBd69qh
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242545407"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="242545407"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 16:43:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="556351348"
Received: from mncallah-mobl.amr.corp.intel.com (HELO [10.209.35.108]) ([10.209.35.108])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 16:43:12 -0800
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
References: <YcTlhp1PUfrMOelI@zn.tnic>
 <20211224110300.7zj3nc5nbbv7jobp@black.fi.intel.com>
 <33914dc1-37e8-f0bb-6468-71c3b5f4169d@amd.com>
 <20220103141705.6hqflhwykqmtfim6@black.fi.intel.com>
 <YdMIWAT42el4D6wJ@zn.tnic>
 <20220103151516.pfcz2pap5l7r2rzv@box.shutemov.name>
 <b4b54116-1cd7-468a-0889-d497268cbfb2@intel.com>
 <20220103181059.ui5eloufw5gsojcb@box.shutemov.name>
 <20220104191424.oly2gqm4ltzj5wo3@box.shutemov.name>
 <0e0c38e2-67ad-1f51-c44b-d3c3d505e40a@intel.com>
 <20220105003108.mr7zyd5oyaaxmnmv@box.shutemov.name>
From:   Dave Hansen <dave.hansen@intel.com>
Message-ID: <50dfa0db-fcd1-3c54-d982-237d2c9df431@intel.com>
Date:   Tue, 4 Jan 2022 16:43:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220105003108.mr7zyd5oyaaxmnmv@box.shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/22 4:31 PM, Kirill A. Shutemov wrote:
> On Tue, Jan 04, 2022 at 12:36:06PM -0800, Dave Hansen wrote:
>> @@ -57,7 +58,6 @@ typedef struct { unsigned long iopte; }
>>  typedef struct { unsigned long pmd; } pmd_t;
>>  typedef struct { unsigned long pgd; } pgd_t;
>>  typedef struct { unsigned long ctxd; } ctxd_t;
>> -typedef struct { unsigned long pgprot; } pgprot_t;
>>  typedef struct { unsigned long iopgprot; } iopgprot_t;
>>  
>>  #define pte_val(x)	((x).pte)
>> @@ -85,7 +85,6 @@ typedef unsigned long iopte_t;
>>  typedef unsigned long pmd_t;
>>  typedef unsigned long pgd_t;
>>  typedef unsigned long ctxd_t;
>> -typedef unsigned long pgprot_t;
>>  typedef unsigned long iopgprot_t;
>>  
>>  #define pte_val(x)	(x)
> 
> Any arch that use STRICT_MM_TYPECHECKS hacks will get broken if compiled
> without the define (as sparc by default).

My read of STRICT_MM_TYPECHECKS was that "typedef unsigned long
pgprot_t" produces better code, but "typedef struct { unsigned long
pgprot; } pgprot_t;" produces better type checking.

I just compiled these patches on sparc with no issues.

...
> Is it the way to go we want?

I _think_ this was all a result of some review feedback from Tom
Lendacky about where the encryption-modifying pgprot helpers got placed
in the code.  I don't feel strongly about it, but I'm not quite sure
that this is worth the trouble.

I'd be curious what Tom thinks now that he's gotten a peek at what it's
going to take to address his concerns.
