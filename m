Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E51050A2F3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389586AbiDUOrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389582AbiDUOrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:47:14 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C8742488;
        Thu, 21 Apr 2022 07:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650552263; x=1682088263;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8nROONmBaEtt0RwaLOJXl6s8nLCzEBixvAjQNvvsvHE=;
  b=EhghRW3dbujf4YwyJxcd+vYecJ+iRh/2lYh8rOhnWI2yTiYzPks8CLMN
   ApzHq1gU1N1qw1zMBFgQCDlyigtzQff33e4S7HWcyX2lO8BUM3h0cHV5Z
   88Ct1XLEtShImi7aqpArkcJ4AEuEWBedickrOfW0EeafkNZscxqO6YeZz
   AX3dhhiw+clEkZMSK8XSDkNGItCNZXFCHSScr5KfMHTWNv3xBa7OaDzgQ
   XuYjciPrxvWZtx1gBido3j3E96VtPQ1Q0rcqk17cWJR/AETLwur544QTk
   1FP+l4awRPY9ksTsgfymhMxBWf9aoXmlMHbuvW0Wg7keeztNWWJnmY10o
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="263216560"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="263216560"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 07:44:20 -0700
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="511093185"
Received: from testes-mobl1.amr.corp.intel.com (HELO [10.212.210.35]) ([10.212.210.35])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 07:44:19 -0700
Message-ID: <70436892-0b4f-30c5-051b-2c86f7387101@linux.intel.com>
Date:   Thu, 21 Apr 2022 07:44:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v3 4/4] platform/x86: intel_tdx_attest: Add TDX Guest
 attestation interface driver
Content-Language: en-US
To:     Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20220415220109.282834-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220415220109.282834-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220420012032.GA2224031@ls.amr.corp.intel.com>
 <dd4a2b16-397e-8866-0fd5-b5c5dfd453ab@linux.intel.com>
 <20220421070444.GB1423762@private.email.ne.jp>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220421070444.GB1423762@private.email.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/22 12:04 AM, Isaku Yamahata wrote:
> On Tue, Apr 19, 2022 at 06:26:43PM -0700,
> Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> 
>> On 4/19/22 6:20 PM, Isaku Yamahata wrote:
>>> If timeout occurs, the state of adev->tdquote_buf is unknown.  It's not safe
>>> to continue to using adev->tdquote_buf.  VMM would continue to processing
>>> getquote request with this buffer.  What if TDX_CMD_GEN_QUOTE is issued again,
>>> and tdquote_buf is re-used?
>>
>> This part is not clearly discussed in the specification. May be spec
>> should define some reasonable timeout and teardown details.
>>
>> Regarding not using this buffer again, what happens if we de-allocate
>> it on timeout and the host still updates it?
> 
> Until GET_QUOTE_IN_FLIGHT is cleared, the shared page is owned by VMM, TD
> attestation driver shouldn't reuse/free the pages.
> 
> In the case of this driver, I think of two options
> - don't timeout. wait for interrupt to arrive and check the shared GPA state.
> - allow timeout. When the next request comes, check the shared GPA state.
>    If it's still GET_QUOTE_IN_FLIGHT, return EBUSY.

Out of the above two options, I think option 1 is better. It is simpler
to serialize them using mutex compared to checking the shared buffer of
previous request.

> 
> It's possible for VMM to keep the shared GPA forever maliciously(DoS) or
> unintentionally due to bug.  TD can't do much about it.

I will add a note about it in commit log.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
