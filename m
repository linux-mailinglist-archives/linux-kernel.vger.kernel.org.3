Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F1757D0BA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiGUQI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGUQIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:08:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2B91CB35
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658419703; x=1689955703;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iLYpl+fVYVmkfr9E9caHMjCAGbV8hRO/IPyAJkxWSV0=;
  b=DZK7GCFQtLpmP1f/6fdHX9svw2hqdZ9CdI6Sa/uKDifGkIOZXd7YOF1h
   dYbH9zL1/zVmXG06UHXf+qz/9WeWI8gNTa+Bo1lHfWfpqO3El+soDXgWH
   gpQbnnpJimRjG7sKdpONYOclQRB2fur54D3UYEfpeuvbeZkP8PMOeagxJ
   gg9bYtEHKe8G9VtTwf5ZOkvPQGw2cT6xKXTFI6yeJOz6naRpSEUUQMUd9
   xMdknmtC6XbOVifguGujnwZ91+1nD6r2/WqnX/Qp3sNyb5r621uaxG+M6
   wnEXdamU7cx2qMT5CBjK0oouMQVLNGOfXHTkcf01M2NPAgpF8cw7Swgl7
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="287843033"
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="287843033"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 09:08:21 -0700
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="573800883"
Received: from vasantgx-mobl.amr.corp.intel.com (HELO [10.212.244.191]) ([10.212.244.191])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 09:08:16 -0700
Message-ID: <d3808510-9974-258e-0c7b-9a76e0868d48@intel.com>
Date:   Thu, 21 Jul 2022 09:08:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v8 5/5] x86/tdx: Add Quote generation support
Content-Language: en-US
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220609025220.2615197-6-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220609025220.2615197-6-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/22 19:52, Kuppuswamy Sathyanarayanan wrote:
> For shared buffer allocation, alternatives like using the DMA API is
> also considered. Although it simpler to use, it is not preferred because
> dma_alloc_*() APIs require a valid bus device as argument, which would
> need converting the attestation driver into a platform device driver.
> This is unnecessary, and since the attestation driver does not do real
> DMA, there is no need to use real DMA APIs.

Let's actually try to walk through the requirements for the memory
allocation here.

 1. The guest kernel needs to allocate some guest physical memory
    for the attestation data buffer
 2. The guest physical memory must be mapped by the guest so that
    it can be read/written.
 3. The guest mapping must be a "TDX Shared" mapping.  Since all
    guest physical memory is "TDX Private" by default, something
    must convert the memory from Private->Shared.
 4. If there are alias mappings with "TDX Private" page table
    permissions, those mappings must never be used while the page is
    in its shared state.
    4a. load_unaligned_zeropad() must be prevented from being used
	on the page immediately preceding a Private alias to a Shared
 	page.
 5. Actions that increasingly fracture the direct map must be avoided.
    Attestation may happen many times and repeated allocations that
    fracture the direct map have performance consequences.
 6. A softer requirement: presuming that bounce buffers won't be used
    for TDX devices *forever*, it would be nice to use a mechanism that
    will continue to work on systems that don't have swiotlb on.

I think we've talked about three different solutions:

== vmalloc() ==

So, let's say we used a relatively plain vmalloc().  That's great for
#1->#3 as long as the vmalloc() mapping gets the "TDX Shared" bit set
properly on its PTEs.  But, it falls over for *either* #4 or #5.  If it
leaves the direct map alone, it's exposed to load_unaligned_zeropad().
If it unmaps the memory from the direct map, it runs afoul of #5.

== order-1 + vmap() ==

Let's now consider a vmalloc() variant: allocate a bunch of order-1
pages and vmap() page[1], leaving page[0] as a guard page against
load_unaligned_zeropad() on the direct map.  That works, but it's an
annoying amount of code.

== swiotlb pages ==

Using the swiotlb bounce buffer pages is the other proposed option.
They already have a working kernel mapping and have already been
converted.  They are mitigated against load_unaligned_zeropad().  They
do cause direct map fracturing, but only once since they're allocated
statically.  They don't increasingly degrade things.  It's a one-time
cost.  Their interaction with #6 is not great.

Did I miss anything?  Does that accurately capture where we are?
