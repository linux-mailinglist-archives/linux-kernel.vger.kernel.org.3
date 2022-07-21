Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AC557D20A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbiGUQyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiGUQyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:54:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEB78BAA5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658422491; x=1689958491;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hL+J5JjvVKr6ukjI38R7LPtkPgTUZUt7lBMJtyofLVc=;
  b=UREeurL3qXBJjVVZ4Ub8CoyaSTfvmWZlDp/wlePbIHXXPiU9uxs/IPEv
   +68OHzJ2MjI84s5xzBkyhdLfx4FVVptP66TclsXYAcwl1UBxqQNXSRFmC
   yY0QIOLEobDSPALFblkP0fQTUyui3szTzm3YQdR34yrWxXkBz2xvFrmPy
   N7QmET/AqWt4lu7+V/2OLzQYT2ifQX/BZvFZ2Lg+bbIxfSLKCJEZIYRWc
   TDuX0sIGnicl3bimf1FL2GrK3BcBiokrFuDc1Mtp+EOZvJF9NR0TV18pD
   /c7J+tF0M9WAyGM+3u6yGTlofig4wd/QNBPXZkG+WaG9J0DmYHQ28XKYm
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="348802926"
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="348802926"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 09:54:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="598531758"
Received: from sattaran-mobl1.amr.corp.intel.com (HELO [10.212.246.186]) ([10.212.246.186])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 09:54:51 -0700
Message-ID: <e280aaf4-57da-6453-c31c-6996dc85219c@linux.intel.com>
Date:   Thu, 21 Jul 2022 09:54:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v8 5/5] x86/tdx: Add Quote generation support
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
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
 <d3808510-9974-258e-0c7b-9a76e0868d48@intel.com>
 <f043d9f5-8f89-4ef3-2ce1-75665122bb3a@linux.intel.com>
 <214e24f0-5236-be8d-024a-da48737d854a@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <214e24f0-5236-be8d-024a-da48737d854a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/22 9:49 AM, Dave Hansen wrote:
> On 7/21/22 09:42, Sathyanarayanan Kuppuswamy wrote:
>> On 7/21/22 9:08 AM, Dave Hansen wrote:
>>> On 6/8/22 19:52, Kuppuswamy Sathyanarayanan wrote:
>>>> For shared buffer allocation, alternatives like using the DMA API is
>>>> also considered. Although it simpler to use, it is not preferred because
>>>> dma_alloc_*() APIs require a valid bus device as argument, which would
>>>> need converting the attestation driver into a platform device driver.
>>>> This is unnecessary, and since the attestation driver does not do real
>>>> DMA, there is no need to use real DMA APIs.
>>> Let's actually try to walk through the requirements for the memory
>>> allocation here.
>>>
>>>  1. The guest kernel needs to allocate some guest physical memory
>>>     for the attestation data buffer
>> Physically contiguous memory.
> 
> Remind me how large the quote structures are.

It depends on the attestation service. In addition to TDREPORT (1K size),
during quote generation, additional data can be included in the signed
quote. So the spec allows variable length. User agent will communicate with
attestation service to identify the appropriate buffer length. Our test
uses 8K buffers.

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
