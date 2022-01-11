Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E296148B241
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 17:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350030AbiAKQdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 11:33:32 -0500
Received: from mga11.intel.com ([192.55.52.93]:12994 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343735AbiAKQdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 11:33:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641918811; x=1673454811;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=pFrxbthNUIXN142lm0j6TDOPsOgNWXA1pnnJt+0zDGc=;
  b=B9X/v/HAqnE9BuXXkVqKW8nE//AwnRO4gHYC+jiJ3EM0wuJASBPTuxZo
   Xxmve6ThX77uoCzCO/ITmzsYcwEWFfaW+tLuFP9BVGVgKDIy/8Jj6oXe/
   nPm70UCqUS+AepMl8GItoy20G6ePJ+QEzOd+AZNodojVll8rG3+jzF8Q6
   v2YrxGh/xiYeKEPSnnU+lHQrGolVYy8JbavmoLLAKAZUFQh4ax2yp77q+
   Pmk0xgl4BWGA3aA36QswXNULNWBvo4raBtMCEHlrgvLZr2Xwu5iPCeUSG
   KSKh8uPaf4rbiUL3YyYZ9qerKprnb3HkPbK/5AU13STQIM9QADq7+RmLj
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="241079869"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="241079869"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 08:33:30 -0800
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="528802719"
Received: from hhuan26-mobl1.amr.corp.intel.com (HELO hhuan26-mobl1.mshome.net) ([10.255.38.99])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 11 Jan 2022 08:33:27 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     linux-sgx@vger.kernel.org, "Jarkko Sakkinen" <jarkko@kernel.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Kristen Carlson Accardi" <kristen@linux.intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] x86/sgx: Add accounting for tracking overcommit
References: <20220107181618.6597-1-kristen@linux.intel.com>
 <20220107181618.6597-2-kristen@linux.intel.com>
 <171631a9-aaec-f590-3377-29c13fc6041e@intel.com>
 <3b169fde457f28e086c49c8a3b8d81ac539cfb59.camel@linux.intel.com>
 <op.1ft4sin7wjvjmi@hhuan26-mobl1.mshome.net>
 <bc370c39-d8c1-9371-2345-cf255ced9a1b@intel.com>
Date:   Tue, 11 Jan 2022 10:33:26 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel Corp
Message-ID: <op.1fuaql06wjvjmi@hhuan26-mobl1.mshome.net>
In-Reply-To: <bc370c39-d8c1-9371-2345-cf255ced9a1b@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 09:43:35 -0600, Dave Hansen <dave.hansen@intel.com>  
wrote:

> On 1/11/22 06:20, Haitao Huang wrote:
>> If the system has a ton of RAM but limited EPC, I think it makes sense  
>> to allow more EPC swapping, can we do min(0.5*RAM, 2*EPC)?
>> I suppose if the system is used for heavy enclave load, user would be  
>> willing to at least use half of RAM.
>
> If I have 100GB of RAM and 100MB of EPC, can I really *meaningfully* run  
> 50GB of enclaves?  In that case, if everything was swapped out evenly, I  
> would only have a 499/500 chance that a given page reference would fault.
>

The formula will cap swapping at 2*EPC so only 200MB swapped out.  So the  
miss is at most 1/3.
The original hard coded cap 1.5*EPC may still consume too much RAM if  
RAM<1.5*EPC.

> This isn't about a "heavy enclave load".  If there is *that* much  
> swapped-out enclave memory, will an enclave even make meaningful forward  
> progress?

 
