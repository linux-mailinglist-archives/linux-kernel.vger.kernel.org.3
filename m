Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4360F53549D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245557AbiEZUjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbiEZUjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:39:41 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E860F4A91F
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653597580; x=1685133580;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kR26q/3oLEaaK5OFUbPNoh2OJvAlC5sl0FyJbKaokew=;
  b=Q6s0RLvpFSfn09tcTLKUhibaEW//204bAS+KtF5bi4TtY4BP5c+6PK05
   H7qFec2NRA6UCjbdsSDNvtM3UsF2jYA/1LyZ2R/MVO5bam+NHSllORShL
   vvkwasUEujDIvyAVQEpmMc5eK0n2o44AgufV6aUVNBDBxL1XUQzzRlOZr
   m5/dDBaLxK+gYEGvjyxDgrM6DHATX+GM3ifrRkEIdw8Hy+dazpW0fJ5hR
   ZaxhctzwkWyQ1A2ERgYC8Ztg9+OrWnfoKqnmRdzFaSUN2IYXphLRGa4Ft
   69+7PGc7zMVbOdPadxmVJelTchtE7zSNGFVAnz44iDx70IW8L4GPG4yft
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="274285704"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="274285704"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 13:39:40 -0700
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="643060892"
Received: from tjeziers-mobl1.amr.corp.intel.com (HELO [10.251.23.34]) ([10.251.23.34])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 13:39:39 -0700
Message-ID: <bb94beeb-061d-c795-7ed6-3c9d2c73191c@intel.com>
Date:   Thu, 26 May 2022 13:39:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCHv3 3/3] x86/tdx: Handle load_unaligned_zeropad() page-cross
 to a shared page
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org, ak@linux.intel.com,
        dan.j.williams@intel.com, david@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org
References: <20220524221012.62332-1-kirill.shutemov@linux.intel.com>
 <20220524221012.62332-4-kirill.shutemov@linux.intel.com>
 <6350b927-4b3f-6f43-aa62-f8db19fa8d5b@intel.com>
 <20220526203619.gpyyl67ygk622e5g@black.fi.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220526203619.gpyyl67ygk622e5g@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/22 13:36, Kirill A. Shutemov wrote:
> On Thu, May 26, 2022 at 09:20:56AM -0700, Dave Hansen wrote:
>> On 5/24/22 15:10, Kirill A. Shutemov wrote:
>>> +	/*
>>> +	 * MMIO accesses suppose to be naturally aligned and therefore never
>>> +	 * cross a page boundary. Seeing unaligned accesses indicates a bug or
>>> +	 * load_unaligned_zeropad() that steps into unmapped shared page.
>> Wait a sec though...
>>
>> We've been talking all along about how MMIO accesses are in some cases
>> just plain old compiler-generated memory accesses.  It's *probably* bad
>> code that does this, but it's not necessarily a bug.
> Compiler-generated memory accesses tend to be aligned too. You need to do
> something make them unalinged, like __packed or pointer trickery.

I totally agree.  But, the point is that __packed or pointer trickery is
goofy, but it's not necessarily a bug.  This might crash the kernel on
goofy stuff, not bugs.
