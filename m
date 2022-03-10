Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EF64D51D6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243861AbiCJSel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 13:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiCJSej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 13:34:39 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57817199E3F;
        Thu, 10 Mar 2022 10:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646937218; x=1678473218;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=8Lw2BWPVb1z8nKpn6dQJVwnTHIrdBGKEtC3fuN8BH0o=;
  b=PX9pRdBhi71S37XR3hWTBPSyGNWEQk7pyti99z+KbCdp26EcWlgjqtW+
   Wx7mnOYAX5Oe3qwBCk+hHqdWMmnxJYNwc410jl3exsetIQCcPg1Y+Aid6
   1yP519Mt579qRxlHH+7Mw1AjkutXv/2vxbhhR8CMYPnF4flTqrP23QozZ
   Fd1rAn4zhvmJua6grWNVqrdCyOvkI/RPZ2HPN8Y+qbDxOgNt0IjEdhCWS
   Aep1cONQtwifsynEPAVvwuitmTlULCAjPLVl8M2HahU9EaXcfpy8lT51Z
   avLSCcHDLI/3F7nFrVoAxOf0dC1MPWbn+RI4bSyJeYbxXCw7l0R6I6P5P
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="341761846"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="341761846"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 10:33:32 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="514101756"
Received: from hhuan26-mobl1.amr.corp.intel.com (HELO hhuan26-mobl1.mshome.net) ([10.255.37.63])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 10 Mar 2022 10:33:29 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        "Jarkko Sakkinen" <jarkko@kernel.org>
Cc:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Zhang, Cathy" <cathy.zhang@intel.com>,
        "Xing, Cedric" <cedric.xing@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "Shanahan, Mark" <mark.shanahan@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 16/32] x86/sgx: Support restricting of enclave page
 permissions
References: <cover.1644274683.git.reinette.chatre@intel.com> <4ce06608b5351f65f4e6bc6fc87c88a71215a2e7.1644274683.git.reinette.chatre@intel.com> <YhLhoMFPyOFZ2fsX@iki.fi> <DM8PR11MB55917F499CDF4CC7D426B0A7F63C9@DM8PR11MB5591.namprd11.prod.outlook.com> <YimWaAqEnXHbLdjh@iki.fi>
Date:   Thu, 10 Mar 2022 12:33:20 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel Corp
Message-ID: <op.1itu5vkewjvjmi@hhuan26-mobl1.mshome.net>
In-Reply-To: <YimWaAqEnXHbLdjh@iki.fi>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko

I have some trouble understanding the sequences below.

On Thu, 10 Mar 2022 00:10:48 -0600, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> On Wed, Feb 23, 2022 at 07:21:50PM +0000, Dhanraj, Vijay wrote:
>> Hi All,
>>
>> Regarding the recent update of splitting the page permissions change
>> request into two IOCTLS (RELAX and RESTRICT), can we combine them into
>> one? That is, revert to how it was done in the v1 version?
>>
>> Why? Currently in Gramine (a library OS for unmodified applications,
>> https://gramineproject.io/) with the new proposed change, one needs to
>> store the page permission for each page or range of pages. And for every
>> request of `mmap` or `mprotect`, Gramine would have to do a lookup of  
>> the
>> page permissions for the request range and then call the respective  
>> IOCTL
>> either RESTRICT or RELAX. This seems a little overwhelming.
>>
>> Request: Instead, can we do `MODPE`,  call `RESTRICT` IOCTL, and then do
>> an `EACCEPT` irrespective of RELAX or RESTRICT page permission request?
>> With this approach, we can avoid storing  page permissions and simplify
>> the implementation.
>>
>> I understand RESTRICT IOCTL would do a `MODPR` and trigger `ETRACK`  
>> flows
>> to do TLB shootdowns which might not be needed for RELAX IOCTL but I am
>> not sure what will be the performance impact. Is there any data point to
>> see the performance impact?
>>
>> Thanks,
>> -Vijay
>
> This should get better in the next versuin. "relax" is gone. And for
> dynamic EAUG'd pages only VMA and EPCM permissions matter, i.e.
> internal vm_max_prot_bits is set to RWX.
>
> I patched the existing series eno
>
> For Enarx I'm using the following patterns.
>
> Shim mmap() handler:
> 1. Ask host for mmap() syscall.
> 2. Construct secinfo matching the protection bits.
> 3. For each page in the address range: EACCEPTCOPY with a
>    zero page.

For EACCEPTCOPY to work, I believe PTE.RW is required for the target page.  
So this only works for mmap(..., RW) or mmap(...,RWX).

So that gives you pages with RW/RWX.

To change permissions of any of those pages from RW/RWX to R/RX , you need  
call ENCLAVE_RESTRICT_PERMISSIONS ioctl with R or with PROT_NONE. you  
can't just do EMODPE.

so for RW->R, you either:

1)EMODPR(EPCM.NONE)
2)EACCEPT(EPCM.NONE)
3)EMODPE(R) -- not sure this would work as spec says EMODPE requires "Read  
access permitted by enclave"

or:

1)EMODPR(EPCM.PROT_R)
2)EACCEPT(EPCM.PROT_R)


> Shim mprotect() handler:
> 1. Ask host for mprotect() syscall.
> 2. For each page in the address range: EACCEPT with PROT_NONE
>    secinfo and EMODPE with the secinfo having the prot bits.

EACCEPT requires PTE.R. And EAUG'd pages will always initialized with  
EPCM.RW,
so EACCEPT(EPCM.PROT_NONE) will fail with SGX_PAGE_ATTRIBUTES_MISMATCH.


> Backend mprotect() handler:
> 1. Invoke ENCLAVE_RESTRICT_PERMISSIONS ioctl for the address
>    range with PROT_NONE.
> 2. Invoke real mprotect() syscall.
>
Note #1 can only be done after EACCEPT. MODPR is not allowed for pending  
pages.

> Not super-complicated.
>
> That is the safest way to changes permissions i.e. use EMODPR only to  
> reset
> the permissions, and EMODPE as EMODP. Then the page is always either
> inaccessible completely or with the correct permissions.
>
> Any other ways to use EMODPR are a bit questionable. That's why I tend to
> think that it would be better to kernel provide only limited version of  
> it
> to reset the permissions. Most of the other use will be most likely
> mis-use. IMHO there is only one legit pattern to use it, i.e. "least
> racy" pattern.
>

I don't see it as "racy" if you copy some data into RW page and reduce it  
to R.
 From kernel point of view the only diff is EMODPR(NONE) vs EMODPR(R).

It's more efficient to do just EMODPR(R) than EMODPR(NONE)+ EMODPE(R).


Thanks
Haitao
