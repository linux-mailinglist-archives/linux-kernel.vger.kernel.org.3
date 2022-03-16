Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30294DBAA7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 23:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiCPW0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 18:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiCPWZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 18:25:55 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EBD13F6F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 15:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647469480; x=1679005480;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=CN4kdw8a8eYpZqmzoyPxliTpn4ALgKMRxd4cGyS56hA=;
  b=mde8A+NMeGDUhpI5wn4mMidJgQhUXzhuyVAMoL24Y4B+7/tiHERP6BaK
   d5YjNUdNzbxLGxEJOalBUgxFh0VyHz9I3N2BbcFHFpvwuD87alvZ5qvWQ
   6u75su+ld/4gL7qZmVeZMEPEAleLZbR4vXJeKouhOCY3UmCpXSDyMDu2H
   Q+ofecqMXgmgVC92+ry3F3DqL06uwSm0ma2FoR8IlkxKra2zii9jwHuZa
   lcl9r67WG5x4a0RKMBwJmAxIYy/G00NypvDEI14JfAfwWRFWvab9NGI57
   3OLo+dGvAWhYTVV1X004eBPzzCUaUT4WUtflebGbwlxqhXgnnmhN/K8yj
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="244178934"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="244178934"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 15:24:39 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="783636069"
Received: from pwblakex-mobl1.amr.corp.intel.com (HELO [10.212.129.47]) ([10.212.129.47])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 15:24:38 -0700
Message-ID: <4fc89d6e-438e-6cb5-5c0b-44b709bd7a51@intel.com>
Date:   Wed, 16 Mar 2022 15:24:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-28-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv6 27/30] x86/kvm: Make SWIOTLB buffer shared for TD guest
In-Reply-To: <20220316020856.24435-28-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/22 19:08, Kirill A. Shutemov wrote:
> Intel TDX doesn't allow VMM to directly access guest private memory.
> Any memory that is required for communication with the VMM must be
> shared explicitly. The same rule applies for any DMA to and from the
> TDX guest. All DMA pages have to be marked as shared pages. A generic way
> to achieve this without any changes to device drivers is to use the
> SWIOTLB framework.
> 
> Make SWIOTLB buffer shared by generalizing mem_encrypt_init() to cover
> TDX.

This could have saved me a trip to the console if it would have also said:

	Stop selecting DYNAMIC_PHYSICAL_MASK directly.  It will get set
	indirectly by selcting X86_MEM_ENCRYPT.

It's probably also worth noting:

	mem_encrypt_init() is currently under an AMD-specific #ifdef.  	
	Move it to a more generic area of the header.

The other adorable thing about this patch:

>  arch/x86/Kconfig                   | 2 +-
>  arch/x86/coco/core.c               | 1 +
>  arch/x86/include/asm/mem_encrypt.h | 6 +++---
>  arch/x86/mm/mem_encrypt.c          | 9 ++++++++-
>  4 files changed, 13 insertions(+), 5 deletions(-)

Is that it superficially has *zero* to do with SWIOTLB, also known as
the declared Subject.  It almost looks like this patch found a smaller
and weaker patch, beat it up, and stole its Subject.

I'd be fine with an "x86/mm" tag on this too.  I'm not sure what makes
it truly KVM-specific.

Can you send a revision with something a bit more descriptive, please?
