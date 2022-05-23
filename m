Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D607530823
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 05:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355560AbiEWDmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 23:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiEWDmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 23:42:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96FF65BE
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 20:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653277319; x=1684813319;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=76Qk2oih8B68VE+5PinLAlDWDoPji4lqY6DmpLzJF6U=;
  b=bFQYy73E27R4eJmdItA2bV2lgN5IXgqbUcWcaRj22HASrEfXXp3XHGVY
   wQQ5DI+c0GW5i3VJxfwRPznxcBjsoSenvEMZGKan62Xuf0o3ZcBqH1yf0
   bYQ2jTmGWS1cWyclRbTTlBl/xnfBI8LtOvB4AOZtxKZGzpoLftOxppRTZ
   ZTzPnq2ytbitSDChPu14rItGTSHDqwi+mlIt9lepUAgHjR/3vhQOqqQ7d
   aY0Pgk0JsYQhCTEf7InNUcLbUBuI9KqTxCk3NH9pcP76WXfMl/DVF1VVi
   oPkny01rFI/5Wzksx/kIPo9Dzh6oGKjj72VmVdYdE4sVlCHYnuWV9kbrY
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10355"; a="260694840"
X-IronPort-AV: E=Sophos;i="5.91,245,1647327600"; 
   d="scan'208";a="260694840"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2022 20:41:51 -0700
X-IronPort-AV: E=Sophos;i="5.91,245,1647327600"; 
   d="scan'208";a="702787358"
Received: from jkrier-mobl1.amr.corp.intel.com (HELO [10.209.22.220]) ([10.209.22.220])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2022 20:41:49 -0700
Message-ID: <f8984572-b7c4-2ef6-9a26-ed68c992502d@linux.intel.com>
Date:   Sun, 22 May 2022 20:41:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH v6 1/5] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220512221952.3647598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220512221952.3647598-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <1292fe3206bef08304dc1bfe3185a9e6cec690fd.camel@intel.com>
 <aa8d221c-049c-24da-dc41-6d6572e29afb@linux.intel.com>
 <a4b2571d29accce04f0bd5308e31e557a8034caa.camel@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <a4b2571d29accce04f0bd5308e31e557a8034caa.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/22/22 7:52 PM, Kai Huang wrote:
> On Tue, 2022-05-17 at 07:54 -0700, Sathyanarayanan Kuppuswamy wrote:
>>>> +struct tdx_report_req {
>>>> +	union {
>>>> +		__u8 reportdata[TDX_REPORTDATA_LEN];
>>>> +		__u8 tdreport[TDX_REPORT_LEN];
>>>> +	};
>>>> +};
>>>
>>> As a userspace ABI, one concern is this doesn't provide any space for future
>>> extension.  But probably it's OK since I don't see any possible additional
>>> input
>>> for now.  And although TDREPORT may have additional information in future
>>> generation of TDX but the spec says the size is 1024 so perhaps this won't
>>> change even in the future.
>>>
>>> Anyway will leave to others.
>>
>> IMO, if the spec changes in future we can revisit it.
> 
> I don't think the problem is how to revisit _this_ ABI.  The problem is, once it
> is introduced, you cannot break the ABI for the compatibility of supporting the
> userspace software written for old platforms.  So basically you cannot just
> increase the TDX_REPORT_LEN to a larger value.  This means if we have a larger
> than 1024B TDREPORT in future, the old userspace TD attestation software which
> uses this ABI will not work anymore on the new platforms.
> 
> If we need to make sure this ABI work for _ANY_ TDX platforms, I think we either
> need to make sure TDREPORT will always be 1024B for _ANY_ TDX platforms, or we
> need to have a flexible ABI which doesn't assume TDREPORT size.
> 
> For instance, we might need another IOCTL (or other interfaces such as /sysfs)
> to query the TDREPORT size, and make this IOCTL like below:
> 
> 	struct tdx_report_req {
> 		__u8 reportdata[TDX_REPORTDATA_LEN];
> 		__u8 reserved[...];
> 		__u8 tdreport[0];
> 	};
> 
> The actual TDREPORT buffer size is allocated by userspace after it queries the
> TDREPORT size.

I don't want to over design it just based on the assumption that length
will change in the future. I don't see any statement in spec supporting
the possibility of length changes. IMO, since the possibility is very
small, we don't need to overthink about it.

@maintainers, please let me know if you think otherwise.
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
