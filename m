Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327D75761BB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 14:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbiGOMcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 08:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbiGOMcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 08:32:46 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5997820B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 05:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657888363; x=1689424363;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GawmyZJSRrTWB3vbdXOQvwH/knbkcC1jFst0zBiD7gY=;
  b=IjJ3Az7dM7K8d3o4hEV+dqq0PMVR7UjR+CChko46l+fXZ7JrEWC42SBL
   8fD5LGofbYED6u+vI5t7+hvZ6tPBj+W7kyD5QpJR2y3WgVy38OrHX3zsr
   9rqKtvxu/6o1Wu4HT0qKgHhTVbGkDOiyTeiNfZZNvgJVAN4JYy59qRP3O
   4=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Jul 2022 05:32:43 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 05:32:43 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 15 Jul 2022 05:32:42 -0700
Received: from [10.216.17.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 15 Jul
 2022 05:32:37 -0700
Message-ID: <e681b84a-21cd-28de-754d-0eb30a764343@quicinc.com>
Date:   Fri, 15 Jul 2022 18:02:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] mm: fix use-after free of page_ext after race with
 memory-offline
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <pasha.tatashin@soleen.com>, <sjpark@amazon.de>,
        <sieberf@amazon.com>, <shakeelb@google.com>, <dhowells@redhat.com>,
        <willy@infradead.org>, <mhocko@suse.com>, <vbabka@suse.cz>,
        <david@redhat.com>, <minchan@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>
References: <1657810063-28938-1-git-send-email-quic_charante@quicinc.com>
 <20220714180418.6d546650b3e5ae745f09814d@linux-foundation.org>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <20220714180418.6d546650b3e5ae745f09814d@linux-foundation.org>
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

Thanks Andrew for the review!!

On 7/15/2022 6:34 AM, Andrew Morton wrote:
> On Thu, 14 Jul 2022 20:17:43 +0530 Charan Teja Kalla <quic_charante@quicinc.com> wrote:
> 
>> The below is one path where race between page_ext and  offline of the
>> respective memory blocks will cause use-after-free on the access of
>> page_ext structure.
>>
>> ...
>>
>> --- a/include/linux/page_ext.h
>> +++ b/include/linux/page_ext.h
>> @@ -64,6 +64,25 @@ static inline struct page_ext *page_ext_next(struct page_ext *curr)
>>  	return next;
>>  }
>>  
>> +static inline struct page_ext *get_page_ext(struct page *page)
>> +{
>> +	struct page_ext *page_ext;
>> +
>> +	rcu_read_lock();
> If page_ext.h is to call rcu functions then it will need to include
> appropriate header files.
> 

Will add them!!

>> +	page_ext = lookup_page_ext(page);
>> +	if (!page_ext) {
>> +		rcu_read_unlock();
>> +		return NULL;
>> +	}
>> +
>> +	return page_ext;
>> +}
>> +
>> +static inline void put_page_ext(void)
>> +{
>> +	rcu_read_unlock();
>> +}
> Better names would be page_ext_get() and page_ext_put().  The rest of
> the page_ext API appears to have got this right, so let's not mess that
> up.

I see naming convention is not consistent in page_ext.c. For couple of
them I see page_ext_xxx() and for the rest it is xxx_page_ext(). Sure I
will follow the page_ext_xxx() convention in V2.

> 
> Also, these aren't really get and put functions - page_ext doesn't have
> a refcount.  But I can't immediately think of a name that better
> communicates what we're doing here so I guess get and put will do.
>> And are we able to add some comments here explaining why these
> functions exist and what they do?

Sure will add then in V2.
> 
>>  #else /* !CONFIG_PAGE_EXTENSION */
>>  struct page_ext;
> Are you sure we didn't need CONFIG_PAGE_EXTENSION=n stubs for these two
> functions?

I think it does need. Will add them in v2.

> 
> 
