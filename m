Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2861451917A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 00:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243769AbiECWeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 18:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243721AbiECWdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 18:33:54 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442D263F6
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 15:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651617020; x=1683153020;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=KRGplk1PXSs6YCwoA2AQza8ZMubL668imWRZfi8qVho=;
  b=UIWrMQvxhi5QUAJrK85tejeWyz2TlVXmr6/nIC10pLGoGMSVw8FYIatL
   es14Cx7FFJtMeDq0lUw1zHL1DanDwSCiB6Lj3aM/0RRYi5exb0YD7QvKX
   xIp0deb3aE06NKPXJPeRNymsftTufSBitY9LEIPGNAhXW4dsh7avQLi34
   s6H0rfjUOyc8EJS1KuavVpRbYCJuU6cHUTvS6deNr5QsPAo5mXmRKiNQ6
   5029qVJB8MFPcQ2cQKS7vRai259rjBsGIP6yBAez6j0X4UAFQZCMvR8+z
   7MWAD8PDvZVLmFky+ISjlshjG5dVuYPia7SVv8ibcXKwpy6zU4sLwVw6/
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="267202029"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="267202029"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 15:30:19 -0700
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="734120737"
Received: from gxu1-mobl3.amr.corp.intel.com (HELO [10.212.251.19]) ([10.212.251.19])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 15:30:19 -0700
Message-ID: <4497f49a-0581-822b-6b00-8ad2a6e108d2@linux.intel.com>
Date:   Tue, 3 May 2022 15:30:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v5 3/3] x86/tdx: Add Quote generation support
Content-Language: en-US
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Kai Huang <kai.huang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220501183500.2242828-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220501183500.2242828-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <243e918c523320ba3d216cbe22d24fe5ce33f370.camel@intel.com>
 <20220503012721.ok7fbvxmnvsr6qny@box.shutemov.name>
 <58d07b2d-cef5-17ed-9c57-e12fe5665e04@intel.com>
 <cc8d777a-3f09-f439-69ac-2d4d4cd5fca9@linux.intel.com>
In-Reply-To: <cc8d777a-3f09-f439-69ac-2d4d4cd5fca9@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/3/22 3:28 PM, Sathyanarayanan Kuppuswamy wrote:
> 
> 
> On 5/3/22 3:24 PM, Dave Hansen wrote:
>> On 5/2/22 18:27, Kirill A. Shutemov wrote:
>>>> Again, Dave and Andi already commented you should use vmap() to 
>>>> avoid breaking
>>>> up the direct-mapping.  Please use vmap() instead.
>>>>
>>>> https://lore.kernel.org/all/ce0feeec-a949-35f8-3010-b0d69acbbc2e@linux.intel.com/ 
>>>>
>>>>
>>>> Will review the rest later.
>>> I would rather convert it to use DMA API for memory allocation. It will
>>> tap into swiotlb buffer that already converted and there's no need to
>>> touch direct mapping. Both allocation and freeing such memory is cheaper
>>> because of that.
>>
>> Sathya, I don't quite understand why you are so forcefully declining to
>> incorporate review feedback on this point.  I gave very specific
>> feedback about the kind of mapping you need and that you should avoid
>> fragmenting the direct map if at all possible.
>>
>> Why is this code still fragmenting the direct map?
> 
> I have already implemented it and testing it now.

I mean, I have already implemented the vmap based solution.

> 
> In this discussion, we are comparing the use of DMA API for memory
> allocation vs vmap/sharing it in driver itself.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
