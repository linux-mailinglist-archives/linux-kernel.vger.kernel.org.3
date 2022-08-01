Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29735586B83
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 15:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbiHANCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 09:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbiHANB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:01:57 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989F8205D5
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 06:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659358914; x=1690894914;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mxuFY55kREA83okL1GF6GyBWBMStJ9QziVd69vrKeV4=;
  b=Dqi0zT5Oxb2PiLNXt2HeBbWuYXgNiCOdFSoXiNrNTWmqVOeoBQjUAD3c
   R9glp90mhwG0QWRGSsIX4rWcA+VJ5BzQTYQ9fAyv3mkyAaF2a8yzS8EUT
   z4m7amwEbKayrMTUXq3AeOmlPLRxwg1aBk1+c71lZ4zHQXD9Bn7yqFVYs
   E=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 01 Aug 2022 06:01:54 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 06:01:53 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 1 Aug 2022 06:01:53 -0700
Received: from [10.216.43.100] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 1 Aug 2022
 06:01:48 -0700
Message-ID: <54e4ce7d-7cbd-480c-28ba-cba684341b37@quicinc.com>
Date:   Mon, 1 Aug 2022 18:31:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V2] mm: fix use-after free of page_ext after race with
 memory-offline
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
CC:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <quic_pkondeti@quicinc.com>, <pasha.tatashin@soleen.com>,
        <sjpark@amazon.de>, <sieberf@amazon.com>, <shakeelb@google.com>,
        <dhowells@redhat.com>, <willy@infradead.org>, <minchan@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <1658931303-17024-1-git-send-email-quic_charante@quicinc.com>
 <YuKfQoOHG1celfBK@dhcp22.suse.cz>
 <6b646ff2-b6f6-052e-f3f4-3bf05243f049@quicinc.com>
 <YueObAiml8c74DLV@dhcp22.suse.cz>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <YueObAiml8c74DLV@dhcp22.suse.cz>
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

Thanks Michal !!

On 8/1/2022 1:57 PM, Michal Hocko wrote:
>> Currently not all the places where page_ext is being used is put under
>> the rcu_lock. I just used rcu lock in the places where it is possible to
>> have the use-after-free of page_ext. You recommend to use rcu lock while
>> using with page_ext in all the places?
> Yes. Using locking inconsistently just begs for future problems. There
> should be a very good reason to use lockless approach in some paths and
> that would be where the locking overhead is not really acceptable or
> when the locking cannot be used for other reasons.
> 
> RCU read lock is essentially zero overhead so the only reason would be
> that the critical section would require to sleep. Is any of that the
> case?
> 
> If there is a real need to have a lockless variant then I would propose
> to add __page_ext_get/put which would be lockless and clearly documented
> under which contexts it can be used and enfore those condictions (e.g.
> reference count assumption).
> 

Let me try to use a single interface here.

>> The roll back operation in the online_page_ext(), where we free the
>> allocated page_ext's, will not have the PAGE_EXT_INVALID flag thus
>> WARN() may not work here. no?
> Wouldn't ms->page_ext be NULL in that case?
I don't think that ms->page_ext would be NULL here.
online_page_ext():
  (a) for (pfn = start; !fail && pfn < end; pfn += PAGES_PER_SECTION)
     fail = init_section_page_ext():
	   ms->page_ext = (void *)base - page_ext_size * pfn;

  //If fail = -ERROR in the middle, roll back operation.
  (b) for (pfn = start; pfn < end; pfn += PAGES_PER_SECTION)
       __free_page_ext();

   Here (b) can be called on the sections without PAGE_EXT_INVALID with
ms->page_ext != NULL.

Thanks,
Charan




