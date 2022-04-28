Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA2F513B5C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242900AbiD1SWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240415AbiD1SWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:22:15 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B18BB929
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 11:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651169940; x=1682705940;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6p/dHl9Cf849qgHD7L5ZaDHSWxOk12FYJiktOzYqmyU=;
  b=gS9lLFWRRfR6ydvp1rrrtgsK2HXxlYkYrIGDS+0uLLXb2Biz8wu+C+T7
   /9BN3uta374uLi+ir25dwJuq6LR7+2Pu2LwVy2zELj+n0BeHxkvHySWxe
   8moyUK/h++9IauJZrXA6zGOBJ2F6h8zkvkr7d2Shlp4pg7WmkiUv5mExx
   h9BT8Cncq94B1tRLe/r/xwO/9RFcm7PjR1eC/XxGx6Xa98c4lGDSy/O90
   4iZumGDZogUP6tAjoaGMTEtqYj5qwSPd2uastlBe9ZlHwLSrcIwCeF6AQ
   v/EaM3uGqBxwZMy3dF8EG5PLQOKy3cP5YP8CisEcozKi5rSJsTQWaxpQY
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="253762932"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="253762932"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 11:19:00 -0700
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="661917534"
Received: from rbopardi-mobl.amr.corp.intel.com (HELO [10.251.19.231]) ([10.251.19.231])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 11:18:59 -0700
Message-ID: <4a24261c-a745-bd47-9d90-eb444f3b6399@linux.intel.com>
Date:   Thu, 28 Apr 2022 11:18:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v4 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Wander Lairson Costa <wander@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>, linux-kernel@vger.kernel.org
References: <20220422233418.1203092-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220422233418.1203092-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YmrSqEBHXZvWs4a0@fedora>
 <c771664d-893b-a41e-079f-74673517b3bb@linux.intel.com>
 <9a484750-cf67-289c-78d1-2e1b764441e8@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <9a484750-cf67-289c-78d1-2e1b764441e8@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/28/22 11:04 AM, Dave Hansen wrote:
> On 4/28/22 10:56, Sathyanarayanan Kuppuswamy wrote:
>> On 4/28/22 10:45 AM, Wander Lairson Costa wrote:
>>> On Fri, Apr 22, 2022 at 04:34:16PM -0700, Kuppuswamy Sathyanarayanan
>>> wrote:
>>>> +static long tdx_get_tdreport(void __user *argp)
>>>> +{
>>>> +    void *report_buf = NULL, *tdreport_buf = NULL;
>>>> +    long ret = 0, err;
>>>> +
>>>> +    /* Allocate space for report data */
>>>> +    report_buf = kmalloc(TDX_REPORT_DATA_LEN, GFP_KERNEL);
>>>> +    if (!report_buf)
>>>> +        return -ENOMEM;
>>>> +
>>>> +    /*
>>>> +     * Allocate space for TDREPORT buffer (1024-byte aligned).
>>>> +     * Full page alignment is more than enough.
>>>> +     */
>>>> +    tdreport_buf = (void *)get_zeroed_page(GFP_KERNEL);
>>>
>>> Maybe we should add BUILD_BUG_ON(TDX_TDREPORT_LEN > PAGE_SIZE)
>>
>> Currently, it is a constant value < PAGE_SIZE. But I can add the
>> BUILD_BUG_ON check for it.
> 
> That's kinda silly.  If it might ever be bigger than a page, you just do:
> 
> 	tdreport_buf = alloc_pages();
> 
> But, seriously, TDX_TDREPORT_LEN is part of the ABI and can't change.
> kmalloc() would work too since TDX_TDREPORT_LEN is a power of 2.


Agree. For our current requirement, kmalloc will just work fine. If the
length changes in the future, I can start using alloc_pages.

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
