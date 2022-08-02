Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F07B5874F4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 03:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbiHBBIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 21:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbiHBBIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 21:08:45 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245A223BDE
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 18:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659402523; x=1690938523;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lLmzdO6QBOEsPInkr3MZEKTGv2QJNZTXmUOhJU63rs0=;
  b=eMQYRO5+HeqQfX4Oxcv72uSSEZRK4elLoySmtvpeH5s/X71gqnrosJ94
   9KIC63BLHU30OBmuEW1xksgAlpfd9+vR4h6YwN1Jg9EvsgSf4YmvIYfa4
   +E79rYudiZaYLToNMatvM49u6Mg+PkLqqMRP8pZldXLEXLPBZ62yO3OsY
   4=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Aug 2022 18:08:42 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 18:08:42 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 1 Aug 2022 18:08:42 -0700
Received: from [10.232.65.248] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 1 Aug 2022
 18:08:39 -0700
Message-ID: <01b70c1c-b274-7e8f-cdfd-cea020f7279b@quicinc.com>
Date:   Tue, 2 Aug 2022 09:08:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.3
Subject: Re: [PATCH v3] mm/page_owner.c: add llseek for page_owner
To:     Souptick Joarder <jrdr.linux@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>, <vbabka@kernel.org>,
        "Minchan Kim" <minchan@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
References: <20220729004920.8544-1-quic_yingangl@quicinc.com>
 <CAFqt6zaAFONhDtWcwBbTVM5LkT4v0uM0wLiAnVGpzNydHp_S0Q@mail.gmail.com>
Content-Language: en-US
From:   Kassey Li <quic_yingangl@quicinc.com>
In-Reply-To: <CAFqt6zaAFONhDtWcwBbTVM5LkT4v0uM0wLiAnVGpzNydHp_S0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/30/2022 10:28 AM, Souptick Joarder wrote:
> On Fri, Jul 29, 2022 at 6:19 AM Kassey Li <quic_yingangl@quicinc.com> wrote:
>>
>> There is usage to dump a given cma region page_owner
>> instead of all page's.
>>
>> This change allows to specify a ppos as start_pfn
>> by fseek.
>>
>> Any invalid ppos will be skipped, so it did not
>> broken the origin dump feature.
>>
> 
> I think a Suggested-by tag needs to be added.
   re-send it again. please help to review, thanks.
> 
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
>>                  return -EINVAL;
>>
>>          page = NULL;
>> -       pfn = min_low_pfn + *ppos;
>>
>> +       pfn = *ppos;
>>          /* Find a valid PFN or the start of a MAX_ORDER_NR_PAGES area */
>>          while (!pfn_valid(pfn) && (pfn & (MAX_ORDER_NR_PAGES - 1)) != 0)
>>                  pfn++;
>> @@ -561,7 +561,7 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>>                          continue;
>>
>>                  /* Record the next PFN to read in the file offset */
>> -               *ppos = (pfn - min_low_pfn) + 1;
>> +               *ppos = pfn + 1;
>>
>>                  return print_page_owner(buf, count, pfn, page,
>>                                  page_owner, handle);
>> @@ -570,6 +570,21 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>>          return 0;
>>   }
>>
>> +static loff_t llseek_page_owner(struct file *file, loff_t offset, int whence)
>> +{
>> +       loff_t retval = 0;
>> +       switch (whence) {
>> +               case SEEK_CUR:
>> +               case SEEK_SET:
>> +                       file->f_pos = offset;
>> +                       break;
>> +               default:
>> +                       retval = -ENXIO;
>> +       }
>> +
>> +       return retval;
>> +}
>> +
>>   static void init_pages_in_zone(pg_data_t *pgdat, struct zone *zone)
>>   {
>>          unsigned long pfn = zone->zone_start_pfn;
>> @@ -660,6 +675,7 @@ static void init_early_allocated_pages(void)
>>
>>   static const struct file_operations proc_page_owner_operations = {
>>          .read           = read_page_owner,
>> +       .llseek         = llseek_page_owner,
>>   };
>>
>>   static int __init pageowner_init(void)
>> --
>> 2.17.1
>>
>>
