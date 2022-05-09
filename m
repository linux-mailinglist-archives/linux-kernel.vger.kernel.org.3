Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F5251FAF8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbiEILMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbiEILL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:11:59 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E442F248DF;
        Mon,  9 May 2022 04:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652094483; x=1683630483;
  h=from:subject:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ssJA0bmg+brCtOxTLgOXtS/A0e6y0MYbmQsr/HcpEoA=;
  b=coPSt3RwOOmYm0VDHhudfoZK34WpVKQz67wjCvXB5SUGW34qO9Btzgn5
   VQtVFkhpF9nbwSrzptOxWj+dEhcv5gHMzI8+0wh4fKA1GwpZ8HsZcwPN2
   K9UVNrnez8Q+PYCl+Kny2LgyTcaLd0VtQ3mVfYo0MS5XAqFdQtf/Rq5aW
   Q=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 09 May 2022 04:08:01 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 04:08:00 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 9 May 2022 04:08:00 -0700
Received: from [10.216.4.129] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 9 May 2022
 04:07:56 -0700
From:   Faiyaz Mohammed <quic_faiyazm@quicinc.com>
Subject: Re: [PATCH] mm: memblock: avoid to create memmap for memblock nomap
 regions
To:     Mike Rapoport <rppt@kernel.org>
CC:     <quic_vjitta@quicinc.com>, <karahmed@amazon.de>,
        <qperret@google.com>, <robh@kernel.org>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <devicetree@vger.kernel.org>
References: <1649704172-13181-1-git-send-email-quic_faiyazm@quicinc.com>
 <YlW2TO0O8qDHpkGW@kernel.org>
 <7b18bea8-b996-601d-f490-cb8aadfffa1b@quicinc.com>
 <YnQBKPWtPa87y4NA@kernel.org>
Message-ID: <42f28e7b-c001-7d01-1eb6-fe963491898e@quicinc.com>
Date:   Mon, 9 May 2022 16:37:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YnQBKPWtPa87y4NA@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/5/2022 10:24 PM, Mike Rapoport wrote:
> On Thu, May 05, 2022 at 08:46:15PM +0530, Faiyaz Mohammed wrote:
>> On 4/12/2022 10:56 PM, Mike Rapoport wrote:
>>> On Tue, Apr 12, 2022 at 12:39:32AM +0530, Faiyaz Mohammed wrote:
>>>> This 'commit 86588296acbf ("fdt: Properly handle "no-map" field in the
>>>> memory region")' is keeping the no-map regions in memblock.memory with
>>>> MEMBLOCK_NOMAP flag set to use no-map memory for EFI using memblock api's,
>>>> but during the initialization sparse_init mark all memblock.memory as
>>>> present using for_each_mem_pfn_range, which is creating the memmap for
>>>> no-map memblock regions. To avoid it skiping the memblock.memory regions
>>>> set with MEMBLOCK_NOMAP set and with this change we will be able to save
>>>> ~11MB memory for ~612MB carve out.
>>> The MEMBLOCK_NOMAP is very fragile and caused a lot of issues already. I
>>> really don't like the idea if adding more implicit assumptions about how
>>> NOMAP memory may or may not be used in a generic iterator function.
>> Sorry for delayed response.
>> Yes, it is possible that implicit assumption can create
>> misunderstanding. How about adding command line option and control the
>> no-map region in fdt.c driver, to decide whether to keep "no-map" region
>> with NOMAP flag or remove?. Something like below
> I really don't like memblock_remove() for such cases.
> Pretending there is a hole when there is an actual DRAM makes things really
> hairy when it comes to memory map and page allocator initialization.
> You wouldn't want to trade system stability and random memory corruptions
> for 11M of "saved" memory.
Creating memory map for holes memory is adding 11MB overhead which is
huge on low

memory target and same time 11MB memory saving is good enough on low
memory target.

Or we can have separate list of NOMAP like reserved?.

Any other suggestion to address this issue?.

Thanks and regards,
Mohammed Faiyaz
