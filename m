Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDE550A365
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389668AbiDUO4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244846AbiDUO4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:56:41 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6F265F2;
        Thu, 21 Apr 2022 07:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650552831; x=1682088831;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q334Y3bRjAYyNyCQa2C9eINciS6WLB37pPfz+kWVNHo=;
  b=b1CCgIxvMs2VCkD+bzfH3ZrydR91lzq7x1sGdje83uRyvrc4Q3XVZGt1
   SZL/d3XJnV3nO641++RfF5+M5LX44nqvyWqL0Vky46QcbfNth0GAiDcon
   DmQF2u/OHTKF97UZqElSTDuAoEhAEhHgDYRvIVaXfENmEAhwfW+3y7uMz
   drJB8FzEg/lFb84o8L5tKGKjTCOIHVBzE9/Cr7uoA6dUCDK08O9aUHo07
   2IfIwE2QAiYHAtBgJnECoiRrzwEqvjn6eqj2ZScCOwBV0eFbwiHo8XQEr
   fJEd/5iMKD1N6kzO75Fb4S47KJwEBn474Gi3M9K59/KkrLG5YL8KaLktH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="350810848"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="350810848"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 07:53:41 -0700
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="511098190"
Received: from testes-mobl1.amr.corp.intel.com (HELO [10.212.210.35]) ([10.212.210.35])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 07:53:40 -0700
Message-ID: <a2c2b7f5-0af0-18a3-062b-c6c9f78daaad@linux.intel.com>
Date:   Thu, 21 Apr 2022 07:53:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v3 4/4] platform/x86: intel_tdx_attest: Add TDX Guest
 attestation interface driver
Content-Language: en-US
To:     Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     Kai Huang <kai.huang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20220415220109.282834-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220415220109.282834-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <b209ee09b74394ab7aed85e0244e2191ee3d4171.camel@intel.com>
 <e0e2e399-2cac-cf75-2a64-9d017e6d7189@linux.intel.com>
 <420a4d689f73f9f7dc1ef71c61da75b7c9777a3f.camel@intel.com>
 <1e184b44-8024-b8ae-98a8-cf2b6f78df61@linux.intel.com>
 <20220421065707.GA1423762@private.email.ne.jp>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220421065707.GA1423762@private.email.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/20/22 11:57 PM, Isaku Yamahata wrote:
> On Wed, Apr 20, 2022 at 07:42:06PM -0700,
> Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> 
>>
>>
>> On 4/20/22 5:11 PM, Kai Huang wrote:
>>> On Wed, 2022-04-20 at 16:45 -0700, Sathyanarayanan Kuppuswamy wrote:
>>>> If we want to support multiple GetQuote requests in parallel, then we
>>>> need some way to uniquely identify the GetQuote requests. So that when
>>>> we get completion notification, we can understand which request is
>>>> completed. This part is not mentioned/discussed in ABI spec. So we want
>>>> to serialize the requests for now.
>>>>
>>>
>>> Yes it's unfortunate that this part (whether concurrent GetQuote requests are
>>> supported by TDX architecture) is not explicitly mentioned in GHCI spec.  I am
>>> fine with only supporting GetQuote requests one by one.  AFAICT there's no
>>> request to support concurrent GetQuote requests anyway.  What concerns me is
>>> exactly how explain this.
>>>
>>> As I said, we have GET_QUOTE_IN_FLIGHT flag now.  Theoretically, you can queue
>>> multiple GetQuote requests, and when you receive the interrupt, you check which
>>> buffer has GET_QUOTE_IN_FLIGHT cleared.  That buffer is the one with Quote
>>> ready.  However I am not 100% sure whether above will always work.  Interrupt
>>> can get lost when there are multiple Quotes ready in multiple buffer in very
>>> short time period, etc?  Perhaps Isaku can provide more input here.
>>
>> Either supported or not, it should be mentioned in the GHCI spec. Currently,
>> there are no details related to it. If it is supported, the specification
>> should include the protocol to use.
>>
>> I will check with Isaku about it.
> 
> The spec says that TD can call multiple GetQuote requests in parallel.

Sorry, I missed the above content. Thanks for pointing out.

> 
>    TDG.VP.VMCALL<GetQuote> API allows one TD to issue multiple requests. It's
>    implementation specific that how many concurrent requests are allowed. The TD
>    should be able to handle TDG.VP.VMCALL_RETRY if it chooses to issue multiple
>    requests simultaneously

Do you know why we should handle VMCALL_RETRY case? IIUC, as per
above spec, if each request we send uses different GPA buffer, then we
should not even worry about checking for IN_FLIGHT status. right?

> 
> As Kai said, there is no requirement for multiple GetQuote in parallel, it's
> okay to support only single request at the same time.

For now I will leave it as single request at a time.

> 
> While the status is GET_QUOTE_IN_FLIGHT, VMM owns the shared GPA.  The
> attestation driver should wait for GET_QUOTE_IN_FLIGHT to be cleared before
> sending next request.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
