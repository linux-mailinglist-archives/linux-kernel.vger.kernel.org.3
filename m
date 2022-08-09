Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB3758D213
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 04:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbiHICsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 22:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiHICsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 22:48:35 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21FBDEA0
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 19:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1660013314; x=1691549314;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KGV0qPEQUODCcxLBnZ5PYXu2dwSdV+gOuAGKS5zZIKg=;
  b=WI0TIm/PTZNr27sVn4GVOE5UpQ8ahFmf9cUV+2JFWWcohuOiIsudNMI9
   beunJRr1WDkJJG5VrwTEWufLCDR2W+hv6j81dwQ8rY0aZBk6p4vobL/Ao
   75S/S5JYdyJwLyXLj6mV8mkOFHDi2BEH81Pz0lts6hrmW9zChFo/4Q7fR
   8=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 08 Aug 2022 19:48:34 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 19:48:34 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 8 Aug 2022 19:48:33 -0700
Received: from [10.232.65.248] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 8 Aug 2022
 19:48:32 -0700
Message-ID: <015e0b6d-6085-3a3a-f292-4219cafb7049@quicinc.com>
Date:   Tue, 9 Aug 2022 10:48:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH v4] mm/page_owner.c: add llseek for page_owner
To:     "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
        <akpm@linux-foundation.org>
CC:     <minchan@kernel.org>, <iamjoonsoo.kim@lge.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20220808073606.29666-1-quic_yingangl@quicinc.com>
 <fc1094f4-bf62-9e9d-1473-5b2595830b60@kernel.org>
Content-Language: en-US
From:   Kassey Li <quic_yingangl@quicinc.com>
In-Reply-To: <fc1094f4-bf62-9e9d-1473-5b2595830b60@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/8/2022 11:33 PM, Vlastimil Babka (SUSE) wrote:
> On 8/8/22 09:36, Kassey Li wrote:
>> There is usage to dump a given cma region page_owner
>> instead of all page's.
>>
>> This change allows to specify a ppos as start_pfn
>> by fseek.
>>
>> Any invalid ppos will be skipped, so it did not
>> broken the origin dump feature.
>>
>> Suggested-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> 
> Thanks, but please change it to Vlastimil Babka <vbabka@suse.cz>
> It was some mistake between me and thunderbird that it was sent from @k.o.
   Ok, will change it.
> 
>> Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
>> ---
>>   mm/page_owner.c | 20 ++++++++++++++++++--
>>   1 file changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/page_owner.c b/mm/page_owner.c
>> index e4c6f3f1695b..231b1877af99 100644
>> --- a/mm/page_owner.c
>> +++ b/mm/page_owner.c
>> @@ -497,8 +497,8 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>>   		return -EINVAL;
>>   
>>   	page = NULL;
>> -	pfn = min_low_pfn + *ppos;
>>   
>> +	pfn = *ppos;
> 
> Maybe we could still optimize the typical case a bit such that when it's 0,
> we skip to min_low_pfn immediately.
> 
>>   	/* Find a valid PFN or the start of a MAX_ORDER_NR_PAGES area */
>>   	while (!pfn_valid(pfn) && (pfn & (MAX_ORDER_NR_PAGES - 1)) != 0)
>>   		pfn++;
>> @@ -561,7 +561,7 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>>   			continue;
>>   
>>   		/* Record the next PFN to read in the file offset */
>> -		*ppos = (pfn - min_low_pfn) + 1;
>> +		*ppos = pfn + 1;
>>   
>>   		return print_page_owner(buf, count, pfn, page,
>>   				page_owner, handle);
>> @@ -570,6 +570,21 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>>   	return 0;
>>   }
>>   
>> +static loff_t llseek_page_owner(struct file *file, loff_t offset, int whence)
>> +{
>> +	loff_t retval = 0;
>> +	switch (whence) {
>> +		case SEEK_CUR:
> 
> It's not correct for SEEK_CUR to behave like this, no?
> Can we perhaps reuse the existing mem_lseek() ?  
   agree.
> 
> Also we should update Documentation/mm/page_owner.rst to document the lseek
> support and that it works with a pfn.
   will do this in v5 patch set.
> 
> Thanks!
> 
>> +		case SEEK_SET:
>> +			file->f_pos = offset;
>> +			break;
>> +		default:
>> +			retval = -ENXIO;
>> +	}
>> +
>> +	return retval;
>> +}
>> +
>>   static void init_pages_in_zone(pg_data_t *pgdat, struct zone *zone)
>>   {
>>   	unsigned long pfn = zone->zone_start_pfn;
>> @@ -660,6 +675,7 @@ static void init_early_allocated_pages(void)
>>   
>>   static const struct file_operations proc_page_owner_operations = {
>>   	.read		= read_page_owner,
>> +	.llseek 	= llseek_page_owner,
>>   };
>>   
>>   static int __init pageowner_init(void)
> 
