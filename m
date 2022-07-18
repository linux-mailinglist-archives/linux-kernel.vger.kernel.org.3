Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF51757836A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbiGRNPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234674AbiGRNP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:15:29 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387376316
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658150128; x=1689686128;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WuwN+DpRDQCRT2t6w+txR2Q5PHcMEbq4bLidubJqWvc=;
  b=RAYKAHSwRILwNfFi/hGuhtbuHe+AvKuB6jXhgPfZ9O8j0/b19yq8hNi0
   3kSOKz6/lWzvTwg42J0wYxbK64wo3g8HDSXFabn1gbPUhith9jHy21efJ
   x/uEQ/KZMsAzzPTk0/jmVjvgumXWORCnOFPwQZOcA1zBCLBTDY5gxFadl
   s=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 18 Jul 2022 06:15:27 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 06:15:27 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 18 Jul 2022 06:15:27 -0700
Received: from [10.216.50.214] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 18 Jul
 2022 06:15:22 -0700
Message-ID: <dcb828a4-b836-37b3-5a53-cf54e681d1c1@quicinc.com>
Date:   Mon, 18 Jul 2022 18:45:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] mm: fix use-after free of page_ext after race with
 memory-offline
Content-Language: en-US
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     <akpm@linux-foundation.org>, <pasha.tatashin@soleen.com>,
        <sjpark@amazon.de>, <sieberf@amazon.com>, <shakeelb@google.com>,
        <dhowells@redhat.com>, <willy@infradead.org>, <mhocko@suse.com>,
        <vbabka@suse.cz>, <david@redhat.com>, <minchan@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <1657810063-28938-1-git-send-email-quic_charante@quicinc.com>
 <20220718061120.GA8922@hu-pkondeti-hyd.qualcomm.com>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <20220718061120.GA8922@hu-pkondeti-hyd.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
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

Thanks Pavan for the comments!!

On 7/18/2022 11:41 AM, Pavan Kondeti wrote:
>> diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
>> index fabb2e1..df5d353 100644
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
>> +
> Would it be a harm if we make lookup_page_ext() completely a private function?
> Or is there any codepath that have the benefit of calling lookup_page_ext()
> without going through get_page_ext()? If that is the case, we should add
> RCU lockdep check inside lookup_page_ext() to make sure that this function is
> called with RCUs.

IIUC, the synchronization is really not needed in all the paths of
accessing the page_ext thus hiding the lookup_page_ext and forcing the
users to always rely on get and put functions doesn't seem correct to me.

Some example code paths where you don't need the synchronization while
accessing the page_ext are:
1) In migration (where we also migrate the page_owner information), we
take the extra refcount on the source and destination pages and then
start the migration. This extra refcount makes the test_pages_isolated()
function to fail thus retry the offline operation.

2) In free_pages_prepare(), we do reset the page_owner(through page_ext)
which again doesn't need the protection to access because the page is
already freeing (through only one path).

Thus I don't find the need of rcu lockdep check in the lookup_page_ext.

Any other paths that I am missing to add protection while page_ext
access, please let me know.

Thanks,
Charan

