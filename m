Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C482A57D22E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 19:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiGUREy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 13:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiGUREw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 13:04:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3621E691FD
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 10:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658423091; x=1689959091;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0PJdUtRNz1ps3/mVqAp7w0q1s+ILafhchr3FLLZ7DE4=;
  b=echIodlm+yfJpPV9ay+7OTriM8kZmiXZt3qef5OxQscrQ+jxoPiQj/n0
   N7aUZbpzNmVrZum6HZJ6jkWw3df4VbwLC/ckn+55G/Jmq0oxXK90bMyUD
   Rl5FpAYIFfJfV3i7xa0dHG4lkWHAMhW2z+OzWPfwZKpUW2V1eWvwNoizD
   Wut6PJacNg2FEowArxPQH2XH8zztgOmjH8vJWVrDHddjYcGtKc97UyTdm
   KM0JkSVdogDjLl/7PmG4I0EwWZO3OAZ+WKXio8Jpj+IUm4pvav4UWhTV4
   XrryIJUOdO2bmBRbfbnkgxDuXIABykb/ZBIauMSkLQi9a32O5M9Qw+MIp
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="287859859"
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="287859859"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 10:02:06 -0700
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="573820533"
Received: from vasantgx-mobl.amr.corp.intel.com (HELO [10.212.244.191]) ([10.212.244.191])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 10:02:05 -0700
Message-ID: <a65473db-b307-c076-6d2f-8f2084d81eb5@intel.com>
Date:   Thu, 21 Jul 2022 10:02:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v8 5/5] x86/tdx: Add Quote generation support
Content-Language: en-US
To:     Sathyanarayanan Kuppuswamy 
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
 <d3808510-9974-258e-0c7b-9a76e0868d48@intel.com>
 <f043d9f5-8f89-4ef3-2ce1-75665122bb3a@linux.intel.com>
 <214e24f0-5236-be8d-024a-da48737d854a@intel.com>
 <e280aaf4-57da-6453-c31c-6996dc85219c@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <e280aaf4-57da-6453-c31c-6996dc85219c@linux.intel.com>
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

On 7/21/22 09:54, Sathyanarayanan Kuppuswamy wrote:
> 
> On 7/21/22 9:49 AM, Dave Hansen wrote:
>> On 7/21/22 09:42, Sathyanarayanan Kuppuswamy wrote:
>>> On 7/21/22 9:08 AM, Dave Hansen wrote:
>>>> On 6/8/22 19:52, Kuppuswamy Sathyanarayanan wrote:
>>>>> For shared buffer allocation, alternatives like using the DMA API is
>>>>> also considered. Although it simpler to use, it is not preferred because
>>>>> dma_alloc_*() APIs require a valid bus device as argument, which would
>>>>> need converting the attestation driver into a platform device driver.
>>>>> This is unnecessary, and since the attestation driver does not do real
>>>>> DMA, there is no need to use real DMA APIs.
>>>> Let's actually try to walk through the requirements for the memory
>>>> allocation here.
>>>>
>>>>  1. The guest kernel needs to allocate some guest physical memory
>>>>     for the attestation data buffer
>>> Physically contiguous memory.
>> Remind me how large the quote structures are.
> It depends on the attestation service. In addition to TDREPORT (1K size),
> during quote generation, additional data can be included in the signed
> quote. So the spec allows variable length. User agent will communicate with
> attestation service to identify the appropriate buffer length. Our test
> uses 8K buffers

What is this "additional data"?  Is that "REPORTDATA" from the TDX
module spec?

	"Additional REPORTDATA, a 64-byte value, is provided by the
	guest TD to be included in the TDG.MR.REPORT."


