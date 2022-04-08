Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997EA4F8D77
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbiDHEjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 00:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbiDHEji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 00:39:38 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948292F3D08
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 21:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=VMFaadv7ujq2jUeu1wP3w1khQ+Jtg60cfctxO+6olWg=; b=CY8ir/U7WvFg8b0jLYtNELcwqj
        CTt4QnTQiCObdGXKrs+7JipEyonsu0At5ngasmvTf9gSeHC/iRpvT7qidmfoMRamBeElOAigkZXnj
        FzfaAE58OReHWHeCZ74srmqlNK+KcIHmFy8ckliCe3wRCKbZ2INzAuqBqFPVPJ4NwwBZme/XHA9Km
        0E9eyKm95pbzQwLeaqOxQqrIlxCEbe4aYmzUEyV0CCpmBwjIEMiOL1LSJv/hNYWhBpmo4L9iIswUQ
        N/wDwuRklsiIX0qYMxVDRDCbEqt23QLUaCeWQJv62tp/6srk3yt6PSRQyNZvuHvfXIzwoZFxZeuBt
        46nYtxzw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncgN8-002mWF-0U; Fri, 08 Apr 2022 04:37:22 +0000
Message-ID: <a44ce850-09fa-31dd-6c75-09e52e630cc6@infradead.org>
Date:   Thu, 7 Apr 2022 21:37:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [kbuild-all] Re: drivers/cxl/pci.c:439:7: warning: Local variable
 'rc' shadows outer variable [shadowVariable]
Content-Language: en-US
To:     "Chen, Rong A" <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <202204021950.bTbpM2Gy-lkp@intel.com>
 <e4d381f0-bafc-771b-7298-cfc6685776f0@infradead.org>
 <810c4865-45c1-ec93-4f72-2086461756c3@intel.com>
 <caf97bb9-78b2-1656-fb7d-96cb783e5662@infradead.org>
 <634e887e-4d22-ea90-0ea3-14b9cad9396b@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <634e887e-4d22-ea90-0ea3-14b9cad9396b@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/7/22 20:34, Chen, Rong A wrote:
> 
> 
> On 4/7/2022 8:11 AM, Randy Dunlap wrote:
>>
>>
>> On 4/6/22 04:17, Chen, Rong A wrote:
>>>
>>>
>>> On 4/4/2022 3:29 AM, Randy Dunlap wrote:
>>>> Hi lkp/ktr,
>>>>
>>>> On 4/2/22 04:26, kernel test robot wrote:
>>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>>>> head:   88e6c0207623874922712e162e25d9dafd39661e
>>>>> commit: 523e594d9cc03db962c741ce02c8a58aab58a123 cxl/pci: Implement wait for media active
>>>>> date:   7 weeks ago
>>>>> compiler: alpha-linux-gcc (GCC) 11.2.0
>>>>>
>>>>> If you fix the issue, kindly add following tag as appropriate
>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>>
>>>>>
>>>>> cppcheck warnings: (new ones prefixed by >>)
>>>>>>> drivers/cxl/pci.c:439:7: warning: Local variable 'rc' shadows outer variable [shadowVariable]
>>>>>        int rc;
>>>>>            ^
>>>>>      drivers/cxl/pci.c:431:6: note: Shadowed declaration
>>>>>       int rc, i;
>>>>>           ^
>>>>>      drivers/cxl/pci.c:439:7: note: Shadow variable
>>>>>        int rc;
>>>>>            ^
>>>>>
>>>>> cppcheck possible warnings: (new ones prefixed by >>, may not real problems)
>>>>>
>>>>>>> drivers/cxl/port.c:63:1: warning: There is an unknown macro here somewhere. Configuration is required. If __stringify is a macro then please configure it. [unknownMacro]
>>>>>      MODULE_ALIAS_CXL(CXL_DEVICE_PORT);
>>>>>      ^
>>>>> -- 
>>>>
>>>> Can you provide a cppcheck config file and command line
>>>> for this, please?
>>>
>>> Hi Randy,
>>>
>>> The below command can show the warning:
>>> $ cppcheck --quiet --enable=style,performance,portability --template=gcc drivers/cxl/port.c
>>> drivers/cxl/port.c:63:1: warning: There is an unknown macro here somewhere. Configuration is required. If __stringify is a macro then please configure it. [unknownMacro]
>>> MODULE_ALIAS_CXL(CXL_DEVICE_PORT);
>>> ^
>>
>> Hm, that still shows me nothing. There must be something else.
>> Maybe it's version-related?  I have:
> 
> Hi Randy,
> 
> I'm using version 2.3:
> 
> $ cppcheck --version
> Cppcheck 2.3
> 
> and I can't see the warning too if using Cppcheck 1.86.
> 
> Best Regards,
> Rong Chen

Hi Rong,

I downloaded version  2.7 and I can see the warnings now.

Thanks!

>>
>> $ cppcheck --version
>> Cppcheck 1.82
>>
>>>
>>> Best Regards,
>>> Rong Chen
>>>
>>>>
>>>> My naive testing does not see any of these warnings --
>>>> although I can easily spot the problems in the source file.
>>>>
>>>> thanks.
>>
>> thanks.
>>

-- 
~Randy
