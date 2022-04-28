Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EFD513B24
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 19:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350660AbiD1SAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345831AbiD1SAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:00:47 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD44E546B2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 10:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651168652; x=1682704652;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UANH5L4pvwVt63Zr5jntGtwe30JNjvf8yv0PHx1/Iy0=;
  b=nhy4Tg5LvCfXpkRo0j0whUhWPuYZ/OlfKCKfJnotG+7JFilE4RicJNhZ
   cSWsyaRWVlH3S7Gu4XwNEeIPBfj3E0t9VOj91vuIqysqaN3AwdVBnmNa1
   NznKln6Me7lhM0Kt02t4AQonqW5CqFBVuoKhYRW9gKvDOOKDBftGg2SBA
   MXwUXlHwv/T8frCBxwQqAnwqBtmNnezvSXRoXYwQRXXr8okiXCzpkD5Cm
   b6GbqIsWDQNsyFJxXUp1tjgHbR9IoAfXbrZ41kd6K6YmQLcr94eHAQ0Fj
   wg9EiWpi0y1SEHOQQENgsSeB3LNP5nIqxnIbtdrgvYpF1iz81HTpQj4po
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="326863649"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="326863649"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 10:57:32 -0700
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="661910702"
Received: from rbopardi-mobl.amr.corp.intel.com (HELO [10.251.19.231]) ([10.251.19.231])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 10:57:30 -0700
Message-ID: <9f644128-da30-a85d-1a4e-ea7ff06aec67@linux.intel.com>
Date:   Thu, 28 Apr 2022 10:57:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v4 2/3] x86/tdx: Add TDX Guest event notify interrupt
 support
Content-Language: en-US
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>, linux-kernel@vger.kernel.org
References: <20220422233418.1203092-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220422233418.1203092-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YmrTyPtrIBNM0ICk@fedora>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <YmrTyPtrIBNM0ICk@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/28/22 10:50 AM, Wander Lairson Costa wrote:
> On Fri, Apr 22, 2022 at 04:34:17PM -0700, Kuppuswamy Sathyanarayanan wrote:
> 
> [snip]
> 
>>   
>> +/*
>> + * tdx_hcall_set_notify_intr() - Setup Event Notify Interrupt Vector.
>> + *
>> + * @vector        : Vector address to be used for notification.
>> + *
>> + * return 0 on success or failure error number.
>> + */
>> +static long tdx_hcall_set_notify_intr(u8 vector)
>> +{
>> +	u64 ret;
>> +
>> +	/* Minimum vector value allowed is 32 */
>> +	if (vector < 32)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * Register callback vector address with VMM. More details
>> +	 * about the ABI can be found in TDX Guest-Host-Communication
>> +	 * Interface (GHCI), sec titled
>> +	 * "TDG.VP.VMCALL<SetupEventNotifyInterrupt>".
>> +	 */
>> +	ret = _tdx_hypercall(TDVMCALL_SETUP_NOTIFY_INTR, vector, 0, 0, 0);
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
> 
> Just "return _tdx_hypercall(TDVMCALL_SETUP_NOTIFY_INTR, vector, 0, 0, 0);" does the job, doesn't it?
> And we can remove the declaration of ret.

Makes sense. I will remove it.

> 
> [snip]
> 
>>   
>> +#ifdef CONFIG_INTEL_TDX_GUEST
> 
> Just for consistency, can we change to "#if IS_ENABLED(CONFIG_INTEL_TDX_GUEST)"?

Ok. I will change it in next version.

> 
>> +DECLARE_IDTENTRY_SYSVEC(TDX_GUEST_EVENT_NOTIFY_VECTOR,	sysvec_tdx_event_notify);
>> +#endif
>> +
> 
> [snip]
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
