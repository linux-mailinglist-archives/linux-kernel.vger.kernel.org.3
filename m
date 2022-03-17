Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75864DCF32
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiCQUVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbiCQUVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:21:35 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BF411D7B2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647548418; x=1679084418;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=Mba6ta1EoHObOAj5Feslq0rb37eP/AFas+biwgDwPFw=;
  b=Nz3qWsTJ7ohSjAk/HK4N/7S8B9ZpWKIGI958yxDSsaQSKhM9dF8X/n5C
   ohAERJoULVILQj60TSiSZVkOO4Er57bbNU7jPIHfZKZ28EX/lnwJOdfhI
   pNbtxfAESMkHp4eau7YUAQukq9esxaMloY5TJ4HyGxZ0iYkmXtbjih7FI
   l2OMsjgypXE20z5MvfLG5OCx5if4HM4w2dX9ujOFcJB7y+czl5sYaL7Q3
   tawwpJdBPdQ/vjjm57sP/KD8kO+GuW2hVrzy7YwT2z4JbgWXBryFV/sRt
   oh6Lqxi5s3zdmuEmRInMu3WK97RjxNZaC93lLlDFaybj97dOilaoV1hfh
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="343409951"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="343409951"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 13:20:18 -0700
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="516911394"
Received: from dstanfie-mobl2.amr.corp.intel.com (HELO [10.212.178.19]) ([10.212.178.19])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 13:20:16 -0700
Message-ID: <c3b640aa-05a1-7706-0c0f-b3f75eee58c6@intel.com>
Date:   Thu, 17 Mar 2022 13:20:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@redhat.com, bp@alien8.de, luto@kernel.org,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        david@redhat.com, hpa@zytor.com, jgross@suse.com,
        jmattson@google.com, joro@8bytes.org, jpoimboe@redhat.com,
        knsathya@kernel.org, pbonzini@redhat.com, sdeep@vmware.com,
        seanjc@google.com, tony.luck@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, thomas.lendacky@amd.com,
        brijesh.singh@amd.com, x86@kernel.org, linux-kernel@vger.kernel.org
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-16-kirill.shutemov@linux.intel.com>
 <87czik22wk.ffs@tglx> <20220317201054.5wdykfru5hhvukvd@black.fi.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv6 15/30] x86/boot: Port I/O: allow to hook up alternative
 helpers
In-Reply-To: <20220317201054.5wdykfru5hhvukvd@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/22 13:10, Kirill A. Shutemov wrote:
>> Hmm?
> This kind of initializations are problematic. They generate run-time
> relacations that kernel cannot handle in the boot stub. Linker complains
> about this:
> 
> 	ld.lld: error: Unexpected run-time relocations (.rela) detected!
> 
> I will leave it as is, unless you have better ideas.

Right now you've got:

	#define inb pio_ops.inb

You keep the preprocessor away from things like

	foo.inb = bar;

with:

	#define inb(x) pio_ops.inb(x)
