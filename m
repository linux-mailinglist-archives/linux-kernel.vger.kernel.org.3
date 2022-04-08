Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848994F8E0E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbiDHDgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 23:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbiDHDgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 23:36:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F27C1DAF80
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 20:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649388862; x=1680924862;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=aSyvIypGGicAMNQ8lFC8djATk8FWKxMAmHnCSBLhX+Q=;
  b=Qo6ivHLl04vwx3D+kZG1kU/dU4LbHaOz9OX8uWVme3QuUrkPmGz6Mn0n
   uWQXo76csytpvZPIe5mSiZ6Wq4wMiX+/CLbU+eGDldf+xxRrBqJarpISG
   TiP0YZuUMNU5M8P/nI6bpLKkmad5RcUYE/Radeg/PaKOokCu37mWEnWVP
   wQaBNKDRcZm1v/6Vg4y9Z8eAt8IfNX6NPSA3cwB7LN1AXLykgI2AhE6mA
   gCDAaZsYBU3Zfe10PjOXHu3TNHornbVs2/VMFK3zMx+zYxn4db8J0eAk5
   siXNMQ4dDBDBtw2/xZIE2pFS6Y/ty2diWcipq2S6OAGHdZcAqT2O5/YQI
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="261192700"
X-IronPort-AV: E=Sophos;i="5.90,243,1643702400"; 
   d="scan'208";a="261192700"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 20:34:21 -0700
X-IronPort-AV: E=Sophos;i="5.90,243,1643702400"; 
   d="scan'208";a="659327943"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.28.94]) ([10.255.28.94])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2022 20:34:19 -0700
Subject: Re: [kbuild-all] Re: drivers/cxl/pci.c:439:7: warning: Local variable
 'rc' shadows outer variable [shadowVariable]
To:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <202204021950.bTbpM2Gy-lkp@intel.com>
 <e4d381f0-bafc-771b-7298-cfc6685776f0@infradead.org>
 <810c4865-45c1-ec93-4f72-2086461756c3@intel.com>
 <caf97bb9-78b2-1656-fb7d-96cb783e5662@infradead.org>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <634e887e-4d22-ea90-0ea3-14b9cad9396b@intel.com>
Date:   Fri, 8 Apr 2022 11:34:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <caf97bb9-78b2-1656-fb7d-96cb783e5662@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/7/2022 8:11 AM, Randy Dunlap wrote:
> 
> 
> On 4/6/22 04:17, Chen, Rong A wrote:
>>
>>
>> On 4/4/2022 3:29 AM, Randy Dunlap wrote:
>>> Hi lkp/ktr,
>>>
>>> On 4/2/22 04:26, kernel test robot wrote:
>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>>> head:   88e6c0207623874922712e162e25d9dafd39661e
>>>> commit: 523e594d9cc03db962c741ce02c8a58aab58a123 cxl/pci: Implement wait for media active
>>>> date:   7 weeks ago
>>>> compiler: alpha-linux-gcc (GCC) 11.2.0
>>>>
>>>> If you fix the issue, kindly add following tag as appropriate
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>
>>>>
>>>> cppcheck warnings: (new ones prefixed by >>)
>>>>>> drivers/cxl/pci.c:439:7: warning: Local variable 'rc' shadows outer variable [shadowVariable]
>>>>        int rc;
>>>>            ^
>>>>      drivers/cxl/pci.c:431:6: note: Shadowed declaration
>>>>       int rc, i;
>>>>           ^
>>>>      drivers/cxl/pci.c:439:7: note: Shadow variable
>>>>        int rc;
>>>>            ^
>>>>
>>>> cppcheck possible warnings: (new ones prefixed by >>, may not real problems)
>>>>
>>>>>> drivers/cxl/port.c:63:1: warning: There is an unknown macro here somewhere. Configuration is required. If __stringify is a macro then please configure it. [unknownMacro]
>>>>      MODULE_ALIAS_CXL(CXL_DEVICE_PORT);
>>>>      ^
>>>> -- 
>>>
>>> Can you provide a cppcheck config file and command line
>>> for this, please?
>>
>> Hi Randy,
>>
>> The below command can show the warning:
>> $ cppcheck --quiet --enable=style,performance,portability --template=gcc drivers/cxl/port.c
>> drivers/cxl/port.c:63:1: warning: There is an unknown macro here somewhere. Configuration is required. If __stringify is a macro then please configure it. [unknownMacro]
>> MODULE_ALIAS_CXL(CXL_DEVICE_PORT);
>> ^
> 
> Hm, that still shows me nothing. There must be something else.
> Maybe it's version-related?  I have:

Hi Randy,

I'm using version 2.3:

$ cppcheck --version
Cppcheck 2.3

and I can't see the warning too if using Cppcheck 1.86.

Best Regards,
Rong Chen

> 
> $ cppcheck --version
> Cppcheck 1.82
> 
>>
>> Best Regards,
>> Rong Chen
>>
>>>
>>> My naive testing does not see any of these warnings --
>>> although I can easily spot the problems in the source file.
>>>
>>> thanks.
> 
> thanks.
> 
