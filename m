Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9823B58216D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiG0Hox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiG0Hot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:44:49 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E481239BAA
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658907889; x=1690443889;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JkXNBVQ34XbPCOUb4W4Vewblc1+/qdZAow6n6y3UxjU=;
  b=DIbn3Gug80u/JrGDaiY9VkYrT6D0enIGB8oefJ1nWz24yBbpDkXj9xG9
   2TF5ULJ3ZR/eHaIN8AiVydg4IwUQclZRTwNP1whPwQGyD++UbVhkOVjGY
   WZruPZqebaFbqU5dDwcnK6PE3WpDUWeOmbKE7aT9aHPUvPSkfD3l9jphR
   s=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 27 Jul 2022 00:44:49 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 00:44:48 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Jul 2022 00:44:48 -0700
Received: from [10.232.65.248] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 27 Jul
 2022 00:44:45 -0700
Message-ID: <b2814a36-4021-b2a4-52db-6ac707d32835@quicinc.com>
Date:   Wed, 27 Jul 2022 15:44:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH] mm/page_owner.c: allow page_owner with given
 start_pfn/count
Content-Language: en-US
To:     "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <minchan@kernel.org>,
        <iamjoonsoo.kim@lge.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <quic_guptap@quicinc.com>
References: <20220722150810.27740-1-quic_yingangl@quicinc.com>
 <YtrEXB6o+VROImdg@casper.infradead.org>
 <e518246c-4ffa-14af-e568-798572f75bee@quicinc.com>
 <ce6f3bcf-fe77-d042-4517-dd09d090b70b@kernel.org>
From:   Kassey Li <quic_yingangl@quicinc.com>
In-Reply-To: <ce6f3bcf-fe77-d042-4517-dd09d090b70b@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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



On 7/26/2022 10:03 PM, Vlastimil Babka (SUSE) wrote:
> On 7/25/22 10:39, Kassey Li wrote:
>> hi, Matthew:
>>      sorry for the delay, I just started to learn how to upstream patch, and
>> setup my Thunderbird with plain text only.
>>      you are right, two users will cause problem here.
>>      the uses case is dump CMA area to understand the page usage in a given
>> cma pool. 2nd, dump whole memory page owner is very time cost, mostly our
>> android device has 8G memory now.
>>      I will research and check again, if you have more idea on this , please
>> kindly to share.
> 
> You could try employing lseek() to specify the start pfn, and as for end
> pfn, the process can just stop reading and close when it has seen enough?

lseek is a good idea.
read_page_owner start with below
	pfn = min_low_pfn + *ppos;
so we need to export the min_low_pfn to user then decide the ppos to seek.
(my_cma.base_pfn - min_low_pfn) is the ppos we want to set.

is there concern to export min_low_pfn  ?
or use a mutex lock for my previous debugfs version patch ?

> 
>> BR
>> Kassey
>>
>> On 7/22/2022 11:38 PM, Matthew Wilcox wrote:
>>> On Fri, Jul 22, 2022 at 11:08:10PM +0800, Kassey Li wrote:
>>>> by default, page_owner iterates all page from min_low_pfn to
>>>> max_pfn, this cost too much time if we want an alternative pfn range.
>>>>
>>>> with this patch it allows user to set pfn range to dump the page_onwer.
>>>
>>> This is a really bad UI.  If two users try to do different ranges at the
>>> same time, it'll go wrong.  What use cases are you actually trying to
>>> solve?
>>
> 
