Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D355062E9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 05:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244701AbiDSD4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 23:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346696AbiDSD4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 23:56:34 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080BC1C108;
        Mon, 18 Apr 2022 20:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650340430; x=1681876430;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wwVlV46Os/EgjaHAxLPUSBeF8ua2q+Qb6p8RYQe/FoU=;
  b=jvsTG9ae4l9Zyxc6ewUbz8Dacu2WB3DXjmYEblKNmx7VHp3q6dM39kH5
   D9eWBhMpx2mHZT2PmwoVGfasXiP5wgzZLKw41XuKz+ZmLcMqXQXavhNuX
   pkPeiADZ+aCxYcG13CLi6WU5tV3y0z9OV9G/gG4Po+3kIdDvSmNCIW1Dt
   hWPNs7N35pRwPzeVmfxhjSw4OdwvLv2DhHNeSHPlx59hqXIhtPfacCxn9
   XVZ+vRWOevWiFcuAJ+vcfFn84iC88sP8xWWE4qa+vcnP+z/FgqnVzUejC
   pUKh6tevS3tZSqjkoBGqzeb57Fsq2PhzNjbGDv9htCEplRygbiO4Wrrq2
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="250970495"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="250970495"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 20:53:49 -0700
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="657486395"
Received: from chferrer-mobl.amr.corp.intel.com (HELO [10.209.37.31]) ([10.209.37.31])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 20:53:40 -0700
Message-ID: <cd3f1a74-e44d-06bd-7cad-90d98213eb39@linux.intel.com>
Date:   Mon, 18 Apr 2022 20:53:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/4] x86/tdx: Add tdx_mcall_tdreport() API support
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20220415220109.282834-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220415220109.282834-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <eca68f9b522b6586c883ac9765d8a071e803ee3f.camel@intel.com>
 <ce0c1d0b-b60f-79e1-b602-450def91ae77@linux.intel.com>
 <283f3d9ec19597856521e66895348e80ef51f10a.camel@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <283f3d9ec19597856521e66895348e80ef51f10a.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/18/22 8:51 PM, Kai Huang wrote:
>> Users are responsible to allocate aligned data. I don't think we need
>> to add a check for it. If it is unaligned, TDCALL will return error.
> Actually this is the kernel memory, but not user memory.  Otherwise
> virt_to_phys() doesn't make sense.  You copied the user data to kernel memory in
> the last patch.  So whether user memory is aligned doesn't matter, and in last
> patch, you have guaranteed the alignment is met during kernel memory allocation.

I mean't user of this API (not user space). But I agree with your
comments.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
