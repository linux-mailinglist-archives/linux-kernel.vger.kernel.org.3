Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0414D229A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 21:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350235AbiCHUbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 15:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242939AbiCHUbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:31:11 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2ED44F9DF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 12:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646771414; x=1678307414;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=tGKWH9u7vaGx5Vm0Q4HoWPWbiqIWfp41w0HIJljjg3k=;
  b=Rntq4cO/G2n+QOPKJt/HKcUojQinwX+YU3C3mxuds2ibKbp0Vgrigkqw
   D2WfJTiL35YVOH81gZgSs188msd/S6RJcK+0HLmB3mCiOB4Biw9HR09Lj
   WtBmInvz0ixAHoOfVRu5X/bmCR/iNZB/maUGeEv4J09dnEDzaguE1gu4y
   ndDdwhBPjGZsn9O123JjO2Bhm6OkPAMuxsZSzvHbD8FeECzyugwXvoqZs
   NtofDJ5UhUQldoIINc6rKXDJS67otHGhTMnOFAuLFF68B5l5S/s1D4bBR
   os48fmNMPRwpJ3gVXujMjpe7jRAfdjzJJSXnS1YJ8MMKF0vMoYyiUzId7
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="242247972"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="242247972"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 12:29:55 -0800
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="547394695"
Received: from ntebyanx-mobl7.amr.corp.intel.com (HELO [10.212.224.65]) ([10.212.224.65])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 12:29:53 -0800
Message-ID: <d46eef1d-081e-337c-cc36-a19373be8a1a@intel.com>
Date:   Tue, 8 Mar 2022 12:29:46 -0800
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
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
 <20220302142806.51844-8-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv5 07/30] x86/traps: Add #VE support for TDX guest
In-Reply-To: <20220302142806.51844-8-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/22 06:27, Kirill A. Shutemov wrote:
> Virtualization Exceptions (#VE) are delivered to TDX guests due to
> specific guest actions which may happen in either user space or the
> kernel:
> 
>  * Specific instructions (WBINVD, for example)
>  * Specific MSR accesses
>  * Specific CPUID leaf accesses
>  * Access to specific guest physical addresses
...
>  arch/x86/coco/tdx.c             | 31 +++++++++++++
>  arch/x86/include/asm/idtentry.h |  4 ++
>  arch/x86/include/asm/tdx.h      | 21 +++++++++
>  arch/x86/kernel/idt.c           |  3 ++
>  arch/x86/kernel/traps.c         | 81 +++++++++++++++++++++++++++++++++

I know it took a long time to get here, but it's really, really nice
that this ended up being all done in C without any nastiness in the
kernel to deal with things like NMIs.

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
