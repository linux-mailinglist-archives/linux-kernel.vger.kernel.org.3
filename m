Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6BA520156
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238552AbiEIPrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238415AbiEIPrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:47:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDC6167C6
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 08:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652110987; x=1683646987;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F07pa9D+FBqxW75bj3/sUmJoTeJzP7PbSvZK6FEkXfE=;
  b=C9quxwEMtO56JXBUEpbPdXNRz0atiZRXtwb1NoNGCL3m1YVA7m1w4oDM
   vGVKHG2SpBUl6y7APedHRtTzVGFN2LiUvXs7by6Vs1Sws2T2+PmOpkvQ5
   pSjedKdSu3KuacXIa1A0h6qlm9+eRaqcpHvXB/AQyVcAqbBtGnr0cCY7X
   Hbqzgs+xfTM0/PJBGM1rJJx2R8zlPQ6CEpXbU43GVLGvtQ/79z25xZk4D
   E294KCe3ORbTACmROzgL/YYG5GfUSqcyfPnBYN7BLALp3mvcsMfjGLFiy
   xPZWBht3rVQ5oMX70B8MN7ax1vOxdcWpY3uFm36OBr7RCHMqTen9j0Pbc
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="256623358"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="256623358"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 08:43:07 -0700
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="669379347"
Received: from smveseck-mobl2.amr.corp.intel.com (HELO [10.251.26.62]) ([10.251.26.62])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 08:43:05 -0700
Message-ID: <09b28e14-cb55-6945-bc03-7554e5e6ae61@linux.intel.com>
Date:   Mon, 9 May 2022 08:43:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v5 3/3] x86/tdx: Add Quote generation support
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Kai Huang <kai.huang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <40ccd0f0-35a1-5aa7-9e51-25ab196d79e5@linux.intel.com>
 <2ed5c9cc316950a5a47ee714715b7980f358a140.camel@intel.com>
 <ab17102c-0cb7-87d3-3494-969866d64573@linux.intel.com>
 <d53696f85ada39a91a3685c61d177c582810772e.camel@intel.com>
 <d63d2774-c44d-27da-74b6-550935a196fd@intel.com>
 <dca06ffa36abe9989f0a7abaeafc83c1a7250651.camel@intel.com>
 <20220507004236.5p5dyksftge7wwr3@black.fi.intel.com>
 <45d184273f1950320843f6696eb3071f7d354fd3.camel@intel.com>
 <20220509120927.7rg6v5pyc3f4pxsh@box.shutemov.name>
 <4506e2c2-af4b-623d-5618-48269e65c295@intel.com>
 <20220509153534.i6v4xcb2g24ia2i4@black.fi.intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220509153534.i6v4xcb2g24ia2i4@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/9/22 8:35 AM, Kirill A. Shutemov wrote:
> On Mon, May 09, 2022 at 07:14:20AM -0700, Dave Hansen wrote:
>> On 5/9/22 05:09, Kirill A. Shutemov wrote:
>>> Private->Shared conversion is destructive. You have to split SEPT, flush
>>> TLB. Backward conversion even more costly.
>>>
>>> Rule of thumb is avoid conversion where possible. DMA API is there for
>>> you.
>>
>> Kirill, I understand that the DMA API is a quick fix today.  But is it
>> _really_ the right long-term interface?
> 
> Yes, I think so.
> 
>> There will surely come a time when TDX I/O devices won't be using fixed
>> bounce buffers.  What will the quote generation code do then?  How will
>> we know to come back around and fix this up?
> 
> VirtIO will not go away with TDX I/O in picture. TDX I/O will be addition
> to existing stuff, not replacement.
> 
> And we have hooks in place to accommodate this: force_dma_unencrypted()
> will return false for devices capable of TDX I/O. While the rest of
> devices, including VirtIO and attestation, keep using existing paths with
> swiotlb.
> 
>> Does SEV or the s390 ultravisor need anything like this?
> 
> At quick glance sev-guest.c uses set_memory_decrypted()/encrypted() for
> allocation and freeing shared memory. I consider it inferior to using DMA
> API.

Following is the link for the SEV attestation driver. It does seem to
use alloc_pages() and set_memory_*() calls.

https://lore.kernel.org/lkml/20220307215344.2799259-1-brijesh.singh@amd.com/

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
