Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765454C3104
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiBXQKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiBXQJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:09:58 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DE119D612
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 08:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645718958; x=1677254958;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=hSXyiqWghN3a3vEHk/JHoCRVlnWxZMsoPx8wuvixRBk=;
  b=TVSzzxycQ6P3Bvm0P26zbMNqlvlG4PMA6Y15iMK+qnyTsX1Q6vLKnQdE
   BIEtwQNJrxHwPywwgbFhvvd+zZY5NObwTIbHIsMSGMfimRciHZVd6LG+6
   dwn0URJ4LRUFa/nSK1ghJ5kpgm6HQgHYZAgAYS7uwdfvGs3bZoZbcU3Dj
   nW00vUq3i6rHtEjqggXXcpDZJ/bAxv1Rq/wsHAQRN6xxAm1/ie2SQv29u
   bjJ2fCZudRH/6HroUr/CSxDhB8u/yxRL7gdCUqZ5pq9BiNQl88AcXJYqX
   7hwCYFxgvOBWegLi7hqRJT2Q0CMzCOTrEOtxYSzQQrrz91C10l0ldAc8J
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="315491554"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="315491554"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 08:06:32 -0800
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="548807043"
Received: from vpirogov-mobl.amr.corp.intel.com (HELO [10.252.137.68]) ([10.252.137.68])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 08:06:31 -0800
Message-ID: <08891245-7a08-ca57-4ab7-b2fdefacc712@intel.com>
Date:   Thu, 24 Feb 2022 08:06:22 -0800
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
        linux-kernel@vger.kernel.org, David Rientjes <rientjes@google.com>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-2-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 01/30] x86/mm: Fix warning on build with
 X86_MEM_ENCRYPT=y
In-Reply-To: <20220224155630.52734-2-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/22 07:56, Kirill A. Shutemov wrote:
> So far, AMD_MEM_ENCRYPT is the only user of X86_MEM_ENCRYPT. TDX will be
> the second. It will make mem_encrypt.c build without AMD_MEM_ENCRYPT,
> which triggers a warning:
> 
> arch/x86/mm/mem_encrypt.c:69:13: warning: no previous prototype for
> 	function 'mem_encrypt_init' [-Wmissing-prototypes]
> 
> Fix it by moving mem_encrypt_init() declaration outside of #ifdef
> CONFIG_AMD_MEM_ENCRYPT.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: 20f07a044a76 ("x86/sev: Move common memory encryption code to mem_encrypt.c")
> Acked-by: David Rientjes <rientjes@google.com>

Hey Kirill,

The last time you posted this, I ack'd it:

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

but that didn't make it into this version.  It saves me the trouble of
looking through this patch again when I was fine with it last week.

The ack still stands if you're interested in incorporating it. ;)
