Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980AA588AD8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 12:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbiHCK5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 06:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiHCK5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 06:57:49 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBB61A82B;
        Wed,  3 Aug 2022 03:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659524269; x=1691060269;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=p/skRGjQQrnR0mSCoi7h2MYUKGS79ATducaOPWm/cVs=;
  b=zKU+74GrrbF9SfhNIducPUt+1n8nx8aL6oeYePBD6YPUMlYY7YxYyFcY
   b+2lTazXl+5/hNAND/mkbe++Js4RayW1ypmvs4xqkWLTvp2V9B0fuAMnw
   o3l4GZeP8qsBLLH6Q6Ak/8Xg4tPrJb5WmWvVWFTbeJHDKLghzHj2JEd+W
   c=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 03 Aug 2022 03:57:48 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 03:57:48 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 3 Aug 2022 03:57:47 -0700
Received: from [10.216.54.167] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 3 Aug 2022
 03:57:43 -0700
Message-ID: <22aca197-8d18-2c9e-b3c4-f6fdc893ceb1@quicinc.com>
Date:   Wed, 3 Aug 2022 16:27:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH] mm: memblock: avoid to create memmap for memblock nomap
 regions
To:     Mike Rapoport <rppt@kernel.org>,
        Faiyaz Mohammed <quic_faiyazm@quicinc.com>
CC:     <karahmed@amazon.de>, <qperret@google.com>, <robh@kernel.org>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <devicetree@vger.kernel.org>
References: <1649704172-13181-1-git-send-email-quic_faiyazm@quicinc.com>
 <YlW2TO0O8qDHpkGW@kernel.org>
 <7b18bea8-b996-601d-f490-cb8aadfffa1b@quicinc.com>
 <YnQBKPWtPa87y4NA@kernel.org>
 <42f28e7b-c001-7d01-1eb6-fe963491898e@quicinc.com>
 <Ynj+M9cRm6zdCMMi@kernel.org>
Content-Language: en-US
From:   Vijayanand Jitta <quic_vjitta@quicinc.com>
In-Reply-To: <Ynj+M9cRm6zdCMMi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/9/2022 5:12 PM, Mike Rapoport wrote:
> On Mon, May 09, 2022 at 04:37:30PM +0530, Faiyaz Mohammed wrote:
>>
>> On 5/5/2022 10:24 PM, Mike Rapoport wrote:
>>> On Thu, May 05, 2022 at 08:46:15PM +0530, Faiyaz Mohammed wrote:
>>>> On 4/12/2022 10:56 PM, Mike Rapoport wrote:
>>>>> On Tue, Apr 12, 2022 at 12:39:32AM +0530, Faiyaz Mohammed wrote:
>>>>>> This 'commit 86588296acbf ("fdt: Properly handle "no-map" field in the
>>>>>> memory region")' is keeping the no-map regions in memblock.memory with
>>>>>> MEMBLOCK_NOMAP flag set to use no-map memory for EFI using memblock api's,
>>>>>> but during the initialization sparse_init mark all memblock.memory as
>>>>>> present using for_each_mem_pfn_range, which is creating the memmap for
>>>>>> no-map memblock regions. To avoid it skiping the memblock.memory regions
>>>>>> set with MEMBLOCK_NOMAP set and with this change we will be able to save
>>>>>> ~11MB memory for ~612MB carve out.
>>>>> The MEMBLOCK_NOMAP is very fragile and caused a lot of issues already. I
>>>>> really don't like the idea if adding more implicit assumptions about how
>>>>> NOMAP memory may or may not be used in a generic iterator function.
>>>> Sorry for delayed response.
>>>> Yes, it is possible that implicit assumption can create
>>>> misunderstanding. How about adding command line option and control the
>>>> no-map region in fdt.c driver, to decide whether to keep "no-map" region
>>>> with NOMAP flag or remove?. Something like below
>>> I really don't like memblock_remove() for such cases.
>>> Pretending there is a hole when there is an actual DRAM makes things really
>>> hairy when it comes to memory map and page allocator initialization.
>>> You wouldn't want to trade system stability and random memory corruptions
>>> for 11M of "saved" memory.
>>
>> Creating memory map for holes memory is adding 11MB overhead which is
>> huge on low memory target and same time 11MB memory saving is good enough
>> on low memory target.
>>
>> Or we can have separate list of NOMAP like reserved?.
>>
>> Any other suggestion to address this issue?.
> 
> Make your firmware to report the memory that Linux cannot use as a hole,
> i.e. _not_ report it as memory.
>  

Thanks, Mike for the comments.

Few concerns with this approach.

1) One concern is, even if firmware doesn't report these regions as
memory, we would need addresses for these to be part of device tree so
that the clients would be able to get these addresses. Otherwise there
is no way for client to know these addresses.

2) This would also add a dependency on firmware to be able to pass these
regions not as memory, though we know that these regions would be used
by the clients. Isn't it better to have such control within the kernel ?

Let me know your comments on these.

Thanks,
Vijay
>> Thanks and regards,
>> Mohammed Faiyaz
> 
